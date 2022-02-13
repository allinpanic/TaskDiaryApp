//
//  TasksModel.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/12/22.
//

import Foundation

protocol TaskModelProtocol: AnyObject {
  func getTasks()
  func generateDaysInMonth(for baseDate: Date) -> [Day]
  func numberOfWeeksInBaseDate(baseDate: Date) -> Int
}

final class TasksModel: TaskModelProtocol {

  var tasks: [Task]?
  var dayTasks: [Task]?
  private let calendar = Calendar.current
  private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d"
      return dateFormatter
    }()
//  private var numberOfWeeksInBaseDate: Int {
//    calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
//  }

  private func parseJson(json: Data) -> [Task]? {
    let decoder = JSONDecoder()

    guard let items =  try? decoder.decode(Tasks.self, from: json) else {return nil}
    print(items.items[0].dateStart)
    return items.items
  }

  func getTasks() {
    guard let jsondata = json.data(using: .utf8) else {return}

    guard let tasks = parseJson(json: jsondata) else {return}
    self.tasks = tasks
  }

  func getTasks(forDate date: Date) -> [Task] {
    var dayTasks: [Task] = []
    let dayStart = Calendar.current.startOfDay(for: date)

    var components = DateComponents()
    components.day = 1
    components.second = -1

    guard let dayEnd = Calendar.current.date(byAdding: components, to: dayStart) else {return []}

    let dayStartTime = dayStart.timeIntervalSince1970
    let dayEndTime = dayEnd.timeIntervalSince1970

    guard let tasks = tasks else {
      return []
    }

    for task in tasks {
      if task.dateStart >= dayStartTime && task.dateFinish <= dayEndTime {
        dayTasks.append(task)
      }
    }

    return dayTasks
  }

// MARK: - Calendar functions

  func numberOfWeeksInBaseDate(baseDate: Date) -> Int {
    return calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
  }

  private func getMonth(for baseDate: Date) throws -> Month {
    let baseDateMonth = calendar.dateComponents([.year, .month], from: baseDate)
    print("baseDate month - \(baseDateMonth)")
    guard
      let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
      let firstDayOfMonth = calendar.date(from: baseDateMonth)
    else {
      throw CalendarDataError.metadataGeneration
    }

    let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
    print("firstDayOf month = \(firstDayOfMonth)")
    print("first weekday - \(firstDayWeekday)")

    return Month(
      numberOfDays: numberOfDaysInMonth,
      firstDay: firstDayOfMonth,
      firstDayWeekday: firstDayWeekday)
  }

  func generateDaysInMonth(for baseDate: Date) -> [Day] {
    guard let metadata = try? getMonth(for: baseDate) else {
      fatalError("An error occurred when generating the metadata for \(baseDate)")
    }

    let numberOfDaysInMonth = metadata.numberOfDays
    let offsetInInitialRow = metadata.firstDayWeekday
    print(metadata.firstDayWeekday)
    let firstDayOfMonth = metadata.firstDay

    var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map { day in
      let isWithinDisplayedMonth = day >= offsetInInitialRow
      let dayOffset = isWithinDisplayedMonth ?
      day - offsetInInitialRow :
      -(offsetInInitialRow - day)

      return generateDay(offsetBy: dayOffset, for: firstDayOfMonth, isWithinDisplayedMonth: isWithinDisplayedMonth)
    }

    days += generateStartOfNextMonth(using: firstDayOfMonth)

    return days
  }

  // сгенерировать конкретный день
  private func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
    let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate

    return Day(
      date: date,
      number: dateFormatter.string(from: date),
      tasks: nil,
//      isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
      isWithinDisplayedMonth: isWithinDisplayedMonth
    )
  }

  private func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
    guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                             to: firstDayOfDisplayedMonth)
    else { return [] }

    let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth) + 1
    guard additionalDays > 0 else { return [] }

    let days: [Day] = (1...additionalDays).map {
      generateDay(offsetBy: $0, for: lastDayInMonth, isWithinDisplayedMonth: false)
    }

    return days
  }

  enum CalendarDataError: Error {
    case metadataGeneration
  }
}
