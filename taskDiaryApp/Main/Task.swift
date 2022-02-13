//
//  Task.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import Foundation

class Tasks: Codable {
  let items: [Task]
}

class Task: Codable {
  var id: Int
  var dateStart: Double
  var dateFinish: Double
  var name: String
  var description: String

  init(id: Int, dateStart: Double, dateFinish: Double, name: String, description: String) {
    self.id = id
    self.dateStart = dateStart
    self.dateFinish = dateFinish
    self.name = name
    self.description = description
  }

  enum CodingKeys: String, CodingKey {
    case dateStart = "date_start"
    case dateFinish = "date_finish"
    case id
    case name
    case description
  }
}
