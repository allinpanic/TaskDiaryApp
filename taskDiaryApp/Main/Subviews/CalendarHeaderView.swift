//
//  CalendarHeaderView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class CalendarHeaderView: UICollectionReusableView {

  var date: Date! {
    didSet {
      print("got date")
    }
  }

  private var monthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Month 2021"
    label.font = .systemFont(ofSize: 20, weight: .medium)
    label.textColor = UIColor(named: "AccentColor")
    return label
  }()

//  private var yearLabel: UILabel = {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = "2021"
//    label.font = .systemFont(ofSize: 16, weight: .semibold)
//    label.textColor = UIColor(named: "AccentColor")
//    return label
//  }()

  private var leftButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("before", for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    return button
  }()

  private var rightButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("next", for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
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
//    addSubview(yearLabel)
    addSubview(leftButton)
    addSubview(rightButton)

    NSLayoutConstraint.activate([
      monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      leftButton.heightAnchor.constraint(equalToConstant: 20),
      leftButton.widthAnchor.constraint(equalToConstant: 50),

      rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      rightButton.heightAnchor.constraint(equalToConstant: 20),
      rightButton.widthAnchor.constraint(equalToConstant: 50)
    ])
  }

}
