//
//  Task.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import Foundation
import RealmSwift

class Tasks: Codable {
  let items: [Task]
}

class Task: Object, Codable {
  @Persisted var id: Int = 0
  @Persisted var dateStart: Double = 0
  @Persisted var dateFinish: Double = 0
  @Persisted var name: String = ""
  @Persisted var desc: String = ""

  override static func primaryKey() -> String? {
      return "id"
    }

  convenience init(id: Int, dateStart: Double, dateFinish: Double, name: String, description: String) {
    self.init()

    self.id = id
    self.dateStart = dateStart
    self.dateFinish = dateFinish
    self.name = name
    self.desc = description
  }

  enum CodingKeys: String, CodingKey {
    case dateStart = "date_start"
    case dateFinish = "date_finish"
    case id
    case name
    case desc = "description"
  }
}
