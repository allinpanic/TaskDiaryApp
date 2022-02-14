//
//  AddTaskView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/13/22.
//

import UIKit

// MARK: - AddTaskViewDelegate

protocol AddTaskViewDelegate: AnyObject {
  func saveTask(_ addTaskView: AddTaskView, name: String, startTime: Date, endTime: Date, description: String)
  func presentAlert(_ addTaskView: AddTaskView, title: String, message: String)
}

// MARK: - AddTaskView

final class AddTaskView: UIView {

  weak var delegate: AddTaskViewDelegate?

  // MARK: - Private properties

  private var nameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "My task"
    textField.borderStyle = .roundedRect
    return textField
  }()

  private var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.text = "Name"
    return label
  }()

  private var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.text = "Date"
    return label
  }()

  private var startTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.text = "Start time"
    return label
  }()

  private var endTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.text = "End time"
    label.sizeToFit()
    return label
  }()

  private var datePickerView: UIDatePicker = {
    let picker = UIDatePicker()
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.datePickerMode = .date
    picker.locale = Locale(identifier: "ru_Ru")
    return picker
  }()

  private var startTimePicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.datePickerMode = .time
    return picker
  }()

  private var endTimePicker: UIDatePicker = {
    let picker = UIDatePicker()
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.datePickerMode = .time
    picker.locale = .current
    return picker
  }()

  private var descriptionTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Add your description here"
    textField.borderStyle = .roundedRect
    return textField
  }()

  private lazy var saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Save Task", for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white

    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - setupLayout

  private func setupLayout() {
    addSubview(nameLabel)
    addSubview(nameTextField)
    addSubview(dateLabel)
    addSubview(datePickerView)
    addSubview(startTimeLabel)
    addSubview(startTimePicker)
    addSubview(endTimeLabel)
    addSubview(endTimePicker)
    addSubview(descriptionTextField)
    addSubview(saveButton)

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
      nameLabel.widthAnchor.constraint(equalToConstant: 90),

      nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
      nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
      dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

      datePickerView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
      datePickerView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
      datePickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      startTimeLabel.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 16),
      startTimeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

      startTimePicker.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor),
      startTimePicker.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: 10),
      startTimePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      endTimeLabel.topAnchor.constraint(equalTo: startTimePicker.bottomAnchor, constant: 16),
      endTimeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

      endTimePicker.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor),
      endTimePicker.leadingAnchor.constraint(equalTo: endTimeLabel.trailingAnchor, constant: 10),
      endTimePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      descriptionTextField.topAnchor.constraint(equalTo: endTimePicker.bottomAnchor, constant: 25),
      descriptionTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      descriptionTextField.heightAnchor.constraint(equalToConstant: 100),

      saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      saveButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  // MARK: - Save button pressed

  @objc private func saveButtonPressed() {
    guard let name = nameTextField.text,
          let description = descriptionTextField.text
    else { return }

    if name.isEmpty || description.isEmpty {
      delegate?.presentAlert(self, title: "Empty field", message: "Fill name or description")
    } else {
      let day = datePickerView.date
      let startTime = startTimePicker.date
      let endTime = endTimePicker.date

//      let startHour = Calendar.current.component(.hour, from: startTime)
//      let startMinutes = Calendar.current.component(.minute, from: startTime)
//      let endHour = Calendar.current.component(.hour, from: endTime)
//      let endMinutes = Calendar.current.component(.minute, from: endTime)
//
//      guard let startDate = Calendar.current.date(bySettingHour: startHour,
//                                                  minute: startMinutes,
//                                                  second: 0, of: day) else { return }
//      guard let endDate = Calendar.current.date(bySettingHour: endHour,
//                                                minute: endMinutes,
//                                                second: 0, of: day) else { return }

      guard let startDate = makeDate(day: day, time: startTime),
            let endDate = makeDate(day: day, time: endTime) else { return }

      if endTime <= startTime {
        delegate?.presentAlert(self, title: "Wrong time", message: "Change time interval")
      } else {
        delegate?.saveTask(self, name: name, startTime: startDate, endTime: endDate, description: description)
      }
    }
  }

  private func makeDate(day: Date, time: Date) -> Date? {
    let hour = Calendar.current.component(.hour, from: time)
    let minutes = Calendar.current.component(.minute, from: time)

    return Calendar.current.date(bySettingHour: hour, minute: minutes, second: 0, of: day)
  }
}
