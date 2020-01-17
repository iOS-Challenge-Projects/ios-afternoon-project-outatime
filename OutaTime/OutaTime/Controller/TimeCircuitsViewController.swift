//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by FGT MAC on 1/16/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {

    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var lastDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        return formatter
    }
    
    var currentSpeed: Int = 0
    
    var stopDate: Date?
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the current date
        presentLabel?.text = dateFormatter.string(from: NSDate() as Date)
        
        //Set speed
        speedLabel.text = "\(String(describing: currentSpeed)) MPH"
        
        lastDepartedLabel.text = "--- -- ----"
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func travelBackButton(_ sender: UIButton) {
        startTimer()
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            self.updateSpeed()
        }
    }
    
//    func cancelTimer() {
//        timer!.invalidate()
//        timer = nil
//    }
    
    
    func reset() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateSpeed() {

        if currentSpeed != 88 {
            currentSpeed += 1
            speedLabel.text = "\(String(describing: currentSpeed)) MPH"
        }else if currentSpeed == 88 {
            lastDepartedLabel.text = presentLabel.text
            presentLabel.text = destinationLabel.text
            currentSpeed = 0
            speedLabel.text = "\(String(describing: currentSpeed)) MPH"
            reset()
            showAlert()

            //Create an alert
        }
    }
    
    func showAlert()  {
        
        if let currenTime = presentLabel.text {
        
        let alert = UIAlertController(title: "Time Travel Successful", message: "You're new date is \(currenTime).", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         if segue.identifier == "ModalDestinationDatePickerSegue" {
             
             guard let DatepickerVC = segue.destination as? DatePickerViewController else { return }
             
             //By setting the delegate in the segue we will be trgerring the destinationDateWasChosen method when the user tap the done button
             DatepickerVC.delegate = self
         }
     }

}


//MARK: - Delegate method
extension TimeCircuitsViewController: DatePickerDelegate {
    
    func destinationDateWasChosen(date: Date) {
//        print( "From Delegate \(date)")
        //Set the picked date as the current value for the label
        destinationLabel.text = dateFormatter.string(from: date)
    }
    
    
}
