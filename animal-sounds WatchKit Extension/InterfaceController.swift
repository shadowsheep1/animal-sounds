//
//  InterfaceController.swift
//  animal-sounds WatchKit Extension
//
//  Created by Fabio Bombardi on 21/02/21.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    private var animals = ["Gatto"]
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        setupTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    private func setupTable() {
        tableView.setNumberOfRows(animals.count, withRowType: "AnimalRow")
        
        for i in animals.indices {
            if let row = tableView.rowController(at: i) as? AnimalRow {
                row.animalName.setText(animals[i])
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("selected item at \(rowIndex)")
    }
    
}
