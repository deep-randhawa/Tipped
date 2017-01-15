//
//  ViewController.swift
//  Tipped
//
//  Created by Deep S Randhawa on 1/11/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let MOST_RECENT_TIME_USED_STR = "MRB_dateTime"
    let MOST_RECENT_BILL_AMOUNT = "MRB_billAmount"
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tipTotalView: UIView!
    @IBOutlet weak var billSegmentView: UIView!
    
    let numberFormatter = NumberFormatter.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setting up formatter
        numberFormatter.locale = NSLocale.current
        numberFormatter.numberStyle = .currency
    
        
        tipTotalView.frame.origin.y = CGFloat(1000)
        billSegmentView.frame.origin.y = CGFloat(180)
        
        var mrb_billAmount = UserDefaults.standard.double(forKey: MOST_RECENT_BILL_AMOUNT)
        let mrb_dateTime = UserDefaults.standard.data(forKey: MOST_RECENT_TIME_USED_STR) as? NSDate ?? nil
        
        if (mrb_dateTime != nil && (mrb_dateTime?.timeIntervalSinceNow)! * -1 > 5) {
            mrb_billAmount = 0.00
        }
        billField.text = mrb_billAmount == 0 ? "" : String.init(format: "%.2f", mrb_billAmount)
        syncTipTotalFields()
        completeTipTotalAnimation()
        
        billField.becomeFirstResponder();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        // view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        syncTipTotalFields()
        completeTipTotalAnimation()
    }
    
    func completeTipTotalAnimation() {
        if (billField.text == "") {
            UIView.animate(withDuration: 0.5, animations: {
                self.tipTotalView.frame.origin.y = CGFloat(500)
                self.billSegmentView.frame.origin.y = CGFloat(180)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.tipTotalView.frame.origin.y = CGFloat(272)
                self.billSegmentView.frame.origin.y = CGFloat(65)
            })
        }
    }
    
    func syncTipTotalFields() {
        let tipPercentages = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipSegmentedControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = numberFormatter.string(from: NSNumber(value: tip))
        totalLabel.text = numberFormatter.string(from: NSNumber(value: total))
        
        UserDefaults.standard.setValue(bill, forKey: MOST_RECENT_BILL_AMOUNT)
        UserDefaults.standard.setValue(NSDate(), forKey: MOST_RECENT_TIME_USED_STR)
        UserDefaults.standard.synchronize()
    }
}

