//
//  ViewController.swift
//  QuickBuy
//
//  Created by Thomas Karg on 30.10.16.
//  Copyright © 2016 Thomas KArg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var selectDateButton: DropDownButton!
    @IBOutlet weak var datePicker: UIPickerView!
    
    var shortAdds: [[String:String]] = [
        [
            "price": "0.99€",
            "category": "AppStore"
        ],
        [
            "price": "1.10€",
            "category": "Coffee"
        ],
        [
            "price": "3.80€",
            "category": "Lunch"
        ],
        [
            "price": "3.30€",
            "category": "Bus"
        ],
        [
            "price": "1.20€",
            "category": "Drinking"
        ],
        [
            "price": "1.50€",
            "category": "Cookies"
        ],
        [
            "price": "2.00€",
            "category": "Newspaper"
        ],
        [
            "price": "1.40€",
            "category": "Breakfast"
        ]
    ]
    
    struct DateTexts {
        let date: NSDate
        let datetext: String
        
        init(date: NSDate, datetext: String){
            self.date = date
            self.datetext = datetext
        }
    }
    
    var thisDate = NSDate()
    
    var pickerDataSource = [DateTexts(date: NSDate(), datetext: "Today")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.dataSource = self;
        self.datePicker.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
        createButtons()
        setDate()
        selectDateButton.setTitle(self.pickerDataSource[0].datetext, forState: .Normal)
        self.view.bringSubviewToFront(datePickerView)
 
    }
    
    func createButtons(){
        
        var i = 0
        var x: CGFloat = 18
        var y: CGFloat = 375
        
        for item in shortAdds {
            let box:ShortAddButton = ShortAddButton(frame: CGRectMake(x, y, 111, 48), labelMsg1:  item["price"]!, labelMsg2: item["category"]!)
            box.tag = i
            box.addTarget(self, action: #selector(ViewController.boxButtonReleased(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            box.addTarget(self, action: #selector(ViewController.boxButtonPressed(_:)), forControlEvents: UIControlEvents.TouchDown)
            self.view.addSubview(box)
            
            i += 1
            x = x + 114
            let rest = i % 3
            if rest == 0 {
                x = 18
                y = y + 105
            }
            
        }
    }
    
    func setDate() {
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        var dateToAdd: DateTexts
        
        for i in 1...7 {
            let daysToRemove = -i
            let newDateComponents = NSDateComponents()
            newDateComponents.day = daysToRemove
            let calculatedDate = NSCalendar.currentCalendar().dateByAddingComponents(newDateComponents, toDate: currentDate, options: NSCalendarOptions.init(rawValue: 0))
            if i==1 {
                dateToAdd = DateTexts(date: calculatedDate!, datetext: "Yesterday")
            } else {
                let convertedDate = dateFormatter.stringFromDate(calculatedDate!)
                dateToAdd = DateTexts(date: calculatedDate!, datetext: convertedDate)
                
            }
        pickerDataSource.append(dateToAdd)
        }
    }
    
    func boxButtonPressed(sender:ShortAddButton!) {
        
        sender.setTextColor(UIColor.lightGrayColor())
    }
    
    func boxButtonReleased(sender:ShortAddButton!) {
        
        sender.setTextColor(UIColor(red:0.14, green:0.62, blue:0.52, alpha:1.0))
        priceLabel.text = sender.label1.text
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row].datetext
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectDateButton.setTitle(self.pickerDataSource[row].datetext, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectDate(sender: AnyObject) {
        datePickerView.hidden = false
    }

    @IBAction func closeDatePicker(sender: AnyObject) {
        datePickerView.hidden = true
    }
}

