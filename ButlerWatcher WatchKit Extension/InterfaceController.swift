//
//  InterfaceController.swift
//  ButlerWatcher WatchKit Extension
//
//  Created by Brian on 10/5/15.
//  Copyright © 2015 Cloudbees. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var slider: WKInterfaceSlider!
    
    @IBOutlet var button: WKInterfaceButton!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        var pickerItems: [WKPickerItem] = []
        for i in 1...10 {
            let item = WKPickerItem()
            item.title = "Picker item \(i)"
            pickerItems.append(item)
        }
        self.picker.setItems(pickerItems)
    }

    @IBAction func showAlertPressed() {
    
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
