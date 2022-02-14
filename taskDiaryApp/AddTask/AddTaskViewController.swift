//
//  AddTaskViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/13/22.
//

import UIKit

final class AddTaskViewController: UIViewController {

  var contentView: AddTaskView!

  var addTaskModel: AddTaskModelProtocol!

  override func loadView() {
    super.loadView()

    view = contentView
  }
  override func viewDidLoad() {
    super.viewDidLoad()

    contentView.delegate = self
  }
}

extension AddTaskViewController: AddTaskViewDelegate {
  func presentAlert(_ addTaskView: AddTaskView, title: String, message: String) {
    let alertvc = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertvc.addAction(action)
    present(alertvc, animated: true, completion: nil)
  }

  func saveTask(_ addTaskView: AddTaskView, name: String, startTime: Date, endTime: Date, description: String) {
    print("delegate go to model")
    addTaskModel.saveTask(name: name, startTime: startTime, endTime: endTime, description: description)

    navigationController?.popViewController(animated: true)
  }
}
