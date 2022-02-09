//
//  Task.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import Foundation

class Task {
  var time: String
  var name: String

  init(time: String, name: String) {
    self.time = time
    self.name = name
  }
}

class Day {
  var date: Date
  var number: String

  var tasks: [Task]?
  var hasTasks: Bool { guard let tasks = tasks,
                             !tasks.isEmpty else { return true }
    return false
  }

  var isSelected: Bool
  var isWithinDisplayedMonth: Bool

  init(date: Date, number: String, tasks: [Task]?, isSelected: Bool = false, isWithinDisplayedMonth: Bool) {
    self.date = date
    self.number = number
    self.tasks = tasks
    self.isSelected = isSelected
    self.isWithinDisplayedMonth = isWithinDisplayedMonth
  }
}

struct Constants {
  static let hours = ["7.00 - 8.00",
                      "9.00 - 10.00",
                      "10.00 - 11.00",
                      "11.00 - 12.00",
                      "12.00 - 13.00",
                      "13.00 - 14.00",
                      "14.00 - 15.00",
                      "15.00 - 16.00",
                      "16.00 - 17.00",
                      "17.00 - 18.00",
                      "18.00 - 19.00",
                      "19.00 - 20.00",
                      "21.00 - 22.00"]
}

struct Month {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}
