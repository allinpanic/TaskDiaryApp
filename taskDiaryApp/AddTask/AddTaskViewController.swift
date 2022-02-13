//
//  AddTaskViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/13/22.
//

import UIKit

final class AddTaskViewController: UIViewController {

  private var contentView: AddTaskView = {
    let view = AddTaskView()
    return view
  }()

  override func loadView() {
    super.loadView()

    view = contentView   
  }
  override func viewDidLoad() {
    super.viewDidLoad()

  }
}
