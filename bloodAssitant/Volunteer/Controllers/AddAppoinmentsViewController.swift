//
//  AddAppoinmentsViewController.swift
//  bloodAssitant
//
//  Created by Nilaykumar Jha on 2018-12-03.
//  Copyright © 2018 Abhishekkumar Israni. All rights reserved.
//

import UIKit

class AddAppointmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private var datePicker : UIDatePicker?
    private var picker: UIPickerView?

    @IBOutlet weak var hospitalpickerField: UITextField!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        SharedValues.hospitalNames = SharedValues.getNames(collection: SharedValues.hospitals)
        super.viewDidLoad()
        self.initDatePicker()
        self.initPriorityPicker()
        if self.appointment == nil {
            self.appointment = VolunteerAppointments()
        }
    }

    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var appointmentDate: UITextField!
    var appointment: VolunteerAppointments?
    
    @IBAction func saveClicked(_ sender: Any) {
    }
    
    // code for date picker
    private func initDatePicker() {
        // code for toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // add done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dueDateDoneTapped))
        
        toolbar.setItems([doneButton], animated: true)
        
        //add toolbar to date picker
        self.appointmentDate.inputAccessoryView = toolbar
        
        // code to handle the duedate date input
        self.datePicker =  UIDatePicker()
        self.datePicker?.datePickerMode = .dateAndTime
        
        // set datepicker as input control
        self.appointmentDate.inputView = self.datePicker
    }
    
    @objc private func dueDateDoneTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        self.appointmentDate.text = dateFormatter.string(from: (self.datePicker?.date)!)
        appointment?.date = self.appointmentDate.text
        view.endEditing(true)
    }

    // code for priority picker
    private func initPriorityPicker() {
        // code for toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // add done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(priorityPickerDoneTapped))
        toolbar.setItems([doneButton], animated: true)
        
        
        // code to handle priority input
        self.picker = UIPickerView()
        self.picker?.delegate = self
        self.picker?.dataSource = self
        self.hospitalpickerField.inputView = self.picker
        self.hospitalpickerField.inputAccessoryView = toolbar
    }
    
    @objc private func priorityPickerDoneTapped() {
        self.hospitalpickerField.text = self.appointment?.hospital_name!
        self.appointment?.hospital_id = SharedValues.getItemId(name: self.hospitalpickerField.text!, collection: SharedValues.hospitals)
        
        view.endEditing(true)
    }
    
    // code for custom picker to take input the priority
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SharedValues.hospitalNames.count
    }
    
    // returns the selected input and sets it into the textfield
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.appointment?.hospital_name =  SharedValues.hospitalNames[row]
    }
    
    // set the appereance of the "lables" on the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SharedValues.hospitalNames[row]
    }

}
