//
//  CalendarHeaderView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

protocol CalendarHeaderViewDelegate: AnyObject {
  func gotoNextMonth(_ headerView: CalendarHeaderView)
  func gotoPreviousMonth(_ headerView: CalendarHeaderView)
}

final class CalendarHeaderView: UICollectionReusableView {

  var date: Date! {
    didSet {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM yyyy"
      let monthYear = dateFormatter.string(for: date)
      monthLabel.text = monthYear
    }
  }

  weak var delegate: CalendarHeaderViewDelegate?

  private var monthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Month 2021"
    label.font = .systemFont(ofSize: 20, weight: .medium)
    label.textColor = UIColor(named: "AccentColor")
    return label
  }()

  private lazy var leftButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setTitle("previous", for: .normal)
    button.setImage(UIImage(named: "left"), for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    button.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)
    return button
  }()

  private lazy var rightButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setTitle("next", for: .normal)
    button.setImage(UIImage(named: "right"), for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    button.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
    return button
  }()

  override init(frame: CGRect) {
      super.init(frame: frame)

      setupLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

  private func setupLayout() {
    addSubview(monthLabel)
    addSubview(leftButton)
    addSubview(rightButton)

    NSLayoutConstraint.activate([
      monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      leftButton.heightAnchor.constraint(equalToConstant: 20),
      leftButton.widthAnchor.constraint(equalToConstant: 20),

      rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      rightButton.heightAnchor.constraint(equalToConstant: 20),
      rightButton.widthAnchor.constraint(equalToConstant: 20)
    ])
  }

  @objc private func leftButtonPressed() {
    delegate?.gotoPreviousMonth(self)
    // reload table view
  }

  @objc private func rightButtonPressed() {
    delegate?.gotoNextMonth(self)
    // reload table view
  }
}
