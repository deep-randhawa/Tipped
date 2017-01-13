//
//  ViewController.swift
//  Tipped
//
//  Created by Deep S Randhawa on 1/11/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tipTotalView: UIView!
    @IBOutlet weak var billSegmentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.becomeFirstResponder();
        tipTotalView.frame.origin.y = CGFloat(1000)
        billSegmentView.frame.origin.y = CGFloat(180)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        if (billField.text == "") {
            UIView.animate(withDuration: 0.5, animations: {
                self.tipTotalView.frame.origin.y = CGFloat(1000)
                self.billSegmentView.frame.origin.y = CGFloat(180)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.tipTotalView.frame.origin.y = CGFloat(272)
                self.billSegmentView.frame.origin.y = CGFloat(65)
            })
        }
        let tipPercentages = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipSegmentedControl.selectedSegmentIndex]
        let total = bill + tip
    
        tipLabel.text = String.init(format: "$%.2f", tip)
        totalLabel.text = String.init(format: "$%.2f", total)
    }
}

