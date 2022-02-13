//
//  DetailTaskViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/8/22.
//

import UIKit

final class DetailTaskViewController: UIViewController {
  private var task: Task

  lazy var contentView: TaskDetailView = {
    let view = TaskDetailView()
    view.task = task
    return view
  }()

  init(task: Task) {
    self.task = task

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView()

    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.prefersLargeTitles = true
    title = task.name
    navigationController?.navigationBar.largeTitleTextAttributes = [ .foregroundColor: UIColor.white ]
    navigationController?.navigationBar.backgroundColor = UIColor(named: "TaskColor")
  }
}
