//
//  AddTaskModel.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/14/22.
//
// swiftlint:disable force_try

import Foundation
import RealmSwift

protocol AddTaskModelProtocol: AnyObject {
  func saveTask(name: String, startTime: Date, endTime: Date, description: String)
}

final class AddTaskModel: AddTaskModelProtocol {
  func saveTask(name: String, startTime: Date, endTime: Date, description: String) {
    let realm = try! Realm()

    guard let count = realm.objects(Task.self).sorted(byKeyPath: "id").last?.id else { return }

    try! realm.write({
      let task = Task(id: count + 1,
                      dateStart: startTime.timeIntervalSince1970,
                      dateFinish: endTime.timeIntervalSince1970,
                      name: name,
                      description: description)
      realm.add(task, update: .all)
    })
    print("saving task")
  }
}
