//
//  Day.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/13/22.
//

import Foundation

public class Day {
  var date: Date
  var number: String

  var tasks: [Task]?
  var hasTasks: Bool { guard let tasks = tasks,
                             !tasks.isEmpty else { return true }
    return false
  }

  var isWithinDisplayedMonth: Bool

  init(date: Date, number: String, tasks: [Task]?, isWithinDisplayedMonth: Bool) {
    self.date = date
    self.number = number
    self.tasks = tasks
    self.isWithinDisplayedMonth = isWithinDisplayedMonth
  }
}

struct Month {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}
