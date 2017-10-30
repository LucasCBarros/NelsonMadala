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
    
    let time = Array(0...240)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
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

