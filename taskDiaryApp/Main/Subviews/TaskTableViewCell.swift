//
//  TaskTableViewCell.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
  var task: Task? {
    didSet {
      guard let task = task else { return }

      taskInfoView.task = task
      taskInfoView.isHidden = false
    }
  }

  var hour: String! {
    didSet {
      hourLabel.text = hour
//      hourLabel.sizeToFit()
    }
  }

  private var hourLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .light)
    label.textColor = .lightGray
    return label
  }()

  private var taskInfoView: TaskInfoView = {
    let view = TaskInfoView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isHidden = true
    view.backgroundColor = UIColor(named: "TaskColor")?.withAlphaComponent(0.2)
    view.layer.cornerRadius = 12
//    view.clipsToBounds
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

  private func setupLayout() {
    contentView.addSubview(hourLabel)
    contentView.addSubview(taskInfoView)

    NSLayoutConstraint.activate([
      hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      hourLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

      taskInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      taskInfoView.leadingAnchor.constraint(equalTo: hourLabel.trailingAnchor, constant: 10),
      taskInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
      taskInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
  }
}
