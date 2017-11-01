//
//  ViewController.swift
//  NelsonMandala
//
//  Created by Mauricio Lorenzetti on 09/10/17.
//  Copyright © 2017 Mauricio Lorenzetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var hiddenLabel: UILabel!
    
    let time = Array(1...60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        
        hiddenLabel.isHidden = true
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.hiddenGesture(_: )))
        tapGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(tapGesture)
        
        //self.view
    
    }
    
    @objc func hiddenGesture(_ gesture: UILongPressGestureRecognizer){
        hiddenLabel.isHidden = false
        let completed = UserDefaults.standard.integer(forKey: "completed")
        let questionAnswerPositive = UserDefaults.standard.integer(forKey: "questionAnswer")
        let lookAtDeviceCount = UserDefaults.standard.integer(forKey: "lookAtDeviceCount")
        hiddenLabel.text = "Completed: \(completed) / Questions answerd positive \(questionAnswerPositive) / Look at device count \(lookAtDeviceCount)"
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BeginMandala",
            let mandalaViewController = segue.destination as? MandalaViewController {
                mandalaViewController.totalTime = TimeInterval(time[pickerView.selectedRow(inComponent: 0)] * 60)
        }
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: time[row])
    }
}

