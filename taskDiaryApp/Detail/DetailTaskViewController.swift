//
//  DetailTaskViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/8/22.
//

import UIKit

final class DetailTaskViewController: UIViewController {
  private var task: Task {
    didSet {
      print("task set")
//      nameLabel.text = task.name
//      dateLabel.text = "9 february 2022"
//      timeLabel.text = "10:00 - 11:00"
//      descriptionTextView.text = "fvbksjlkjbngk dvblbdkjbngklbm dhvbkzhldfn kdjfbvkjdf sjfbvkjdfv jvbfkjvnlkfd jkfbvkjdfb jxfbjfb kjbkjfb jblnblkn"
      // convert start date and end date to time interval and to string
      // convert it to date dd-mm-yyyy
      // description
    }
  }

  private var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 25, weight: .medium)
    label.textColor = .darkGray
    return label
  }()

  private var timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 25, weight: .medium)
    label.textColor = .darkGray
    return label
  }()

  private var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 25, weight: .medium)
    label.textColor = .darkGray
    return label
  }()

  private var descriptionTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .systemFont(ofSize: 20, weight: .light)
    return textView
  }()

  init(task: Task) {
    self.task = task

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()
    view.backgroundColor = .lightGray

    navigationController?.navigationBar.prefersLargeTitles = true
    title = task.name
//    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//    navigationController?.navigationBar.backgroundColor = UIColor(named: "AccentColor")

    nameLabel.text = task.name
    dateLabel.text = "9 february 2022"
    timeLabel.text = "10:00 - 11:00"
    descriptionTextView.text = "fvbksjlkjbngk dvblbdkjbngklbm dhvbkzhldfn kdjfbvkjdf sjfbvkjdfv jvbfkjvnlkfd jkfbvkjdfb jxfbjfb kjbkjfb jblnblkn"
  }

  private func setupLayout() {
    view.addSubview(nameLabel)
    view.addSubview(timeLabel)
    view.addSubview(dateLabel)
    view.addSubview(descriptionTextView)

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

      timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
      timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 16),

      dateLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
      dateLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16),

      descriptionTextView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
      descriptionTextView.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
      descriptionTextView.heightAnchor.constraint(equalToConstant: 300),
      descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)

    ])
  }
}
