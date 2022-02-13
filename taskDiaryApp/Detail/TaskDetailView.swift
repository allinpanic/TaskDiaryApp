//
//  TaskDetailView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/13/22.
//

import UIKit

class TaskDetailView: UIView {
  var task: Task! {
    didSet {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      let startTime = dateFormatter.string(from: Date(timeIntervalSince1970: task.dateStart))
      let finishTime = dateFormatter.string(from: Date(timeIntervalSince1970: task.dateFinish))

      dateFormatter.dateStyle = .medium
      let taskDate = dateFormatter.string(from: Date(timeIntervalSince1970: task.dateStart))

      nameLabel.text = task.name
      dateLabel.text = taskDate
      timeLabel.text = startTime + " - " + finishTime
      descriptionTextView.text = task.description
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

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayout() {
    addSubview(nameLabel)
    addSubview(timeLabel)
    addSubview(dateLabel)
    addSubview(descriptionTextView)

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),

      timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
      timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 16),

      dateLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

      descriptionTextView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
      descriptionTextView.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
      descriptionTextView.heightAnchor.constraint(equalToConstant: 200),
      descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
  }
}
