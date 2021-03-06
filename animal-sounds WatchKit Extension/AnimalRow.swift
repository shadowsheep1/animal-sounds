//
//  AnimalRow.swift
//  animal-sounds WatchKit Extension
//
//  Created by Fabio Bombardi on 21/02/21.
//

import WatchKit

class AnimalRow: NSObject {
    var animalKey: String = ""
    
    @IBOutlet weak var animalName: WKInterfaceLabel!
    @IBOutlet weak var animalImage: WKInterfaceImage!
}
