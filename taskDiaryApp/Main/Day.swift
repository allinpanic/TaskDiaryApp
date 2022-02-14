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
  var isWithinDisplayedMonth: Bool

  init(date: Date, number: String, isWithinDisplayedMonth: Bool) {
    self.date = date
    self.number = number
    self.isWithinDisplayedMonth = isWithinDisplayedMonth
  }
}

struct Month {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}
