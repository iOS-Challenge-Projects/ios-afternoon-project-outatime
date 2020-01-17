//
//  DatePickerViewController.swift
//  OutaTime
//
//  Created by FGT MAC on 1/16/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

//MARK: - Delegate
protocol DatePickerDelegate {
    
    func destinationDateWasChosen(date: Date)
}


//MARK: - ViewController

import UIKit

class DatePickerViewController: UIViewController {
    
    var delegate: DatePickerDelegate?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        //dismiss modal
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        //passing date to method
        delegate?.destinationDateWasChosen(date: datePicker.date)
//        print("From Modal \(datePicker.date)")
        //dismiss modal
        dismiss(animated: true, completion: nil)
        
    }
    
}
