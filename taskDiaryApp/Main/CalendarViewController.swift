//
//  ViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class CalendarViewController: UIViewController {

  private lazy var contentView: TaskListView = {
    let view = TaskListView()
    view.calendarCollectionView.delegate = self
    view.calendarCollectionView.dataSource = self
    view.taskListTableView.delegate = self
    view.taskListTableView.dataSource = self
    return view
  }()

  private let calendar = Calendar.current
  private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d"
      return dateFormatter
    }()
  private var selectedDate: Date = Date() // {
  var selectedIndexPath : IndexPath? 
//    didSet {
//      contentView.calendarCollectionView.reloadData()
//    }
//  }
//  private let selectedDateChanged: ((Date) -> Void) = {_ in}
  private var baseDate: Date = Date() {
    didSet {
      days = generateDaysInMonth(for: baseDate)
      contentView.calendarCollectionView.reloadData()
    }
  }
  private lazy var days = generateDaysInMonth(for: baseDate)
  private var numberOfWeeksInBaseDate: Int {
    calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
  }

  override func loadView() {
    super.loadView()

    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    print("base date - \(baseDate)")
    view.backgroundColor = .white
  }

}

extension CalendarViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // return 31

    return days.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell",
                                                        for: indexPath) as? CalendarDayCollectionViewCell
    else { return UICollectionViewCell() }

    cell.day = days[indexPath.row]

    if let selected = selectedIndexPath, selected == indexPath {
      cell.updateSelectionView(isSelected: true)
    } else {
      cell.updateSelectionView(isSelected: false)
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "header",
                                                                       for: indexPath) as? CalendarHeaderView
    else { return UICollectionReusableView() }
    header.date = Date()

    return header
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("date selected")

    let day = days[indexPath.row]
    selectedDate = day.date

    var cellsToReload = [indexPath]
    if let selected = selectedIndexPath {
      cellsToReload.append(selected)
    }
    selectedIndexPath = indexPath
    collectionView.reloadItems(at: cellsToReload)
  }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.hours.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell",
                                                   for: indexPath) as? TaskTableViewCell
    else { return UITableViewCell()}

    cell.hour = Constants.hours[indexPath.row]
    if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 6 {
      cell.task = Task(time: "10.00-12.00", name: "My Task")
    } else {
      cell.task = nil
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell

    if let task = cell?.task {
      print("go to detail view")
      let dateilViewController = DetailTaskViewController(task: task)
      navigationController?.pushViewController(dateilViewController, animated: true)
    } else {
      print("no task")
    }

  }
}

// MARK: - Day Generation
private extension CalendarViewController {
  // получить данные о месяце из начальной даты
  func getMonth(for baseDate: Date) throws -> Month {
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

  enum CalendarDataError: Error {
    case metadataGeneration
  }

  // сгенерировать дни месяца
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
  func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
    let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate

    return Day(
      date: date,
      number: dateFormatter.string(from: date),
      tasks: nil,
      isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
      isWithinDisplayedMonth: isWithinDisplayedMonth
    )
  }

  func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
    guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                             to: firstDayOfDisplayedMonth)
    else { return [] }

    let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
    guard additionalDays > 0 else { return [] }

    let days: [Day] = (1...additionalDays).map {
      generateDay(offsetBy: $0, for: lastDayInMonth, isWithinDisplayedMonth: false)
    }

    return days
  }

}
