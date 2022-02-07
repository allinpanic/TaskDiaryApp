//
//  TaskListView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class TaskListView: UIView {

  var calendarCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width/7 - 10,
                             height: UIScreen.main.bounds.width/7 - 10)
    layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "dayCell")
    collectionView.register(CalendarHeaderView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "header")
    collectionView.backgroundColor = .white
    return collectionView
  }()

  var taskListTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
    tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "taskCell")
    tableView.backgroundColor = .darkGray
    return tableView
  }()

  override init(frame: CGRect) {
      super.init(frame: frame)

      setupLayout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

  private func setupLayout() {
    addSubview(calendarCollectionView)
    addSubview(taskListTableView)

    NSLayoutConstraint.activate([
      calendarCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      calendarCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      calendarCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      calendarCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),

      taskListTableView.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor),
      taskListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      taskListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      taskListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

    ])
  }

}
