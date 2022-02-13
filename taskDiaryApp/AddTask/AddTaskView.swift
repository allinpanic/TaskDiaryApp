//
//  AddTaskView.swift
//  taskDiaryApp
//
//  Created by Rodianov on 2/13/22.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {
  func saveTask(name: String, startTime: Date, endTime: Date, description: String)
}

final class AddTaskView: UIView {

  weak var delegate: AddTaskViewDelegate?

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

      saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      saveButton.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  @objc private func saveButtonPressed() {
    print("save button pressed")

//    delegate?.saveTask(name: String, startTime: Date, endTime: Date, description: String)
  }
}
