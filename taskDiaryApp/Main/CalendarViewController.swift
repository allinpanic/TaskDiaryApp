//
//  ViewController.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/7/22.
//

import UIKit

final class CalendarViewController: UIViewController {

  let model = TasksModel()

  lazy var contentView: CalendarView = {
    let view = CalendarView()
    view.calendarCollectionView.delegate = self
    view.calendarCollectionView.dataSource = self
    view.taskListTableView.delegate = self
    view.taskListTableView.dataSource = self
    return view
  }()

  private var selectedIndexPath: IndexPath?
  private var baseDate: Date = Date() {
    didSet {
      days = model.generateDaysInMonth(for: baseDate)
      contentView.calendarCollectionView.reloadData()
    }
  }

  private lazy var days = model.generateDaysInMonth(for: baseDate)
  private var dayTasks: [Task] = []

  override func loadView() {
    super.loadView()

    view = contentView

    model.getTasks()
  }

  // MARK: - ViewDidLoad

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    title = "Календарь"
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.backgroundColor = .white
  }
}

// MARK: - CollectionView DataSource, Delegate

extension CalendarViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return days.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell",
                                                        for: indexPath) as? CalendarDayCollectionViewCell
    else { return UICollectionViewCell() }

    cell.day = days[indexPath.row]

    if let selected = selectedIndexPath, selected == indexPath {
      cell.updateSelectionView(isSelected: true)
    } else {
      cell.updateSelectionView(isSelected: false)
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "header",
                                                                       for: indexPath) as? CalendarHeaderView
    else { return UICollectionReusableView() }
    header.date = baseDate
    header.delegate = self

    return header
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let day = days[indexPath.row]

    var cellsToReload = [indexPath]
    if let selected = selectedIndexPath {
      cellsToReload.append(selected)
    }
    selectedIndexPath = indexPath
    collectionView.reloadItems(at: cellsToReload)

    let tasks = model.getTasks(forDate: day.date)
    dayTasks = tasks
    contentView.taskListTableView.reloadData()
  }
}

// MARK: - TableView DataSource, Delegate

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.hours.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell",
                                                   for: indexPath) as? TaskTableViewCell
    else { return UITableViewCell()}

    let hour = Constants.hours[indexPath.row]

    cell.hour = hour
    cell.task = nil

    if !dayTasks.isEmpty {
      let hourPrefix = hour.prefix(2)

      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH"

      for task in dayTasks {
        let taskString = dateFormatter.string(from: Date(timeIntervalSince1970: task.dateStart))
        if hourPrefix == taskString {
          print(taskString)
          cell.task = task
        }
      }
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell

    if let task = cell?.task {
      let dateilViewController = DetailTaskViewController(task: task)
      navigationController?.pushViewController(dateilViewController, animated: true)
    }
  }
}

// MARK: - CalendarHeaderViewDelegate

extension CalendarViewController: CalendarHeaderViewDelegate {
  func gotoNextMonth(_ headerView: CalendarHeaderView) {
    guard let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: baseDate) else {return}
    baseDate = nextMonthDate
  }

  func gotoPreviousMonth(_ headerView: CalendarHeaderView) {
    guard let previousMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: baseDate) else {return}
    baseDate = previousMonthDate
  }
}
