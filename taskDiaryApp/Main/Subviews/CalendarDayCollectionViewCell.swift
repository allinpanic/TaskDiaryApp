//
//  CalendarDayCollectionViewCell.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/8/22.
//

import UIKit

class CalendarDayCollectionViewCell: UICollectionViewCell {

  var day: Day? {
    didSet {
      guard let day = day else { return }

      numberLabel.text = day.number
    }
  }

  func updateSelectionView(isSelected: Bool) {
    guard let day = day else {
      return
    }

    if isSelected {
      if day.isWithinDisplayedMonth {
        numberLabel.textColor = .white
        selectionBackgroundView.isHidden = false
      } else {
        selectionBackgroundView.isHidden = true
        numberLabel.textColor = .darkGray
      }
    } else {
      selectionBackgroundView.isHidden = true
      if day.isWithinDisplayedMonth {
        numberLabel.textColor = .darkGray
      } else {
        numberLabel.textColor = .lightGray
      }

    }
  }

//  var isCellSelected: Bool? {
//    didSet {
//      guard let isCellSelected = isSelected,
//            let day = day
//      else { return }
//      if isSelected {
//        if day.isWithinDisplayedMonth {
//          numberLabel.textColor = .white
//          selectionBackgroundView.isHidden = false
//        }
//      } else {
//        if day.isWithinDisplayedMonth {
//          numberLabel.textColor = .darkGray
//        } else {
//          numberLabel.textColor = .lightGray
//        }
//        selectionBackgroundView.isHidden = true
//      }
//
//    }
//  }

  private lazy var selectionBackgroundView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 12
    view.clipsToBounds = true
    view.backgroundColor = UIColor(named: "AccentColor")
    return view
  }()

  private lazy var numberLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.textColor = .darkGray
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
    addSubview(selectionBackgroundView)
    addSubview(numberLabel)

    NSLayoutConstraint.activate([
      selectionBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
      selectionBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
      selectionBackgroundView.heightAnchor.constraint(equalTo: heightAnchor),
      selectionBackgroundView.widthAnchor.constraint(equalTo: widthAnchor),

      numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
