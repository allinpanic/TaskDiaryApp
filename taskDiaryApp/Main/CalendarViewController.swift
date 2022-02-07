//
//  ViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class CalendarViewController: UIViewController {

  private lazy var contentView: TaskListView = {
    let view = TaskListView()
    view.calendarCollectionView.delegate = self
    view.calendarCollectionView.dataSource = self
    view.taskListTableView.delegate = self
    view.taskListTableView.dataSource = self
    return view
  }()

  override func loadView() {
    super.loadView()

    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
  }

}

extension CalendarViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 31
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath)
    cell.backgroundColor = .cyan.withAlphaComponent(0.1)
    cell.layer.cornerRadius = 12
    cell.clipsToBounds = true
    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "header",
                                                                       for: indexPath) as? CalendarHeaderView
    else { return UICollectionReusableView() }
    header.date = Date()

    return header
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("date selected")
//    contentView.taskListTableView.reloadData()

//    let cell = collectionView.cellForItem(at: indexPath)
//    cell?.backgroundColor = .magenta.withAlphaComponent(0.2)
  }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.hours.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell",
                                                   for: indexPath) as? TaskTableViewCell
    else { return UITableViewCell()}

    cell.hour = Constants.hours[indexPath.row]
    if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 6 {
      cell.task = Task(time: "10.00-12.00", name: "My Task")
    } else {
      cell.task = nil
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell

    if cell?.task != nil {
      print("go to detail view")
    } else {
      print("no task")
    }

  }
}
