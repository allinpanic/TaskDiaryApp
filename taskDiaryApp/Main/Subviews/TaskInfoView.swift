//
//  TaskInfoView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class TaskInfoView: UIView {
  var task: Task! {
    didSet {
      timeLabel.text = makeTimeIntervalString(startTime: task.dateStart,
                                              finishTime: task.dateFinish)
      timeLabel.sizeToFit()
      nameLabel.text = task.name
      nameLabel.sizeToFit()
    }
  }

  private let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    return label
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayout() {
    addSubview(timeLabel)
    addSubview(nameLabel)

    NSLayoutConstraint.activate([
      timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

      nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 16)
    ])
  }

  private func makeTimeIntervalString(startTime: Double, finishTime: Double) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = "HH:mm"
    let start = dateFormatter.string(from: Date(timeIntervalSince1970: startTime))
    let finish = dateFormatter.string(from: Date(timeIntervalSince1970: finishTime))
    return start + " - " + finish
  }
}
