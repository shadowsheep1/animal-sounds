//
//  InterfaceController.swift
//  animal-sounds WatchKit Extension
//
//  Created by Fabio Bombardi on 21/02/21.
//

import WatchKit
import AVFoundation


class InterfaceController: WKInterfaceController {
    var player = AVAudioPlayer()
    
    private var animalsKeys = [
        "cat",
        "dog",
        "cow",
        "sheep",
        "horse",
        "goose",
        "hen",
        "elephant",
        "crocodile",
        "bee",
        "mouse",
        "deer",
        "lion",
        "peacock",
        "wolf"
    ]
    
    private var animals: Dictionary<String, String> {
        var animals = Dictionary<String, String>()
        for animalKey in animalsKeys {
            animals[animalKey] = NSLocalizedString(animalKey, comment: "")
        }
        return animals
    }
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        setupTable()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    private func setupTable() {
        tableView.setNumberOfRows(animals.count, withRowType: "AnimalRow")
        
        var i = 0
        for k in animals.keys.shuffled() {
            if let row = tableView.rowController(at: i) as? AnimalRow {
                row.animalKey = k
                row.animalName.setText(animals[k])
                row.animalImage.setImageNamed(k)
            }
            i += 1
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("selected item at \(rowIndex)")
        if let row = tableView.rowController(at: rowIndex) as? AnimalRow {
            playSound(row.animalKey)
        }
    }
    
    // credits to: https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
    private func playSound(_ fileName: String) {
        guard let url = Bundle.main.url(
                forResource: fileName,
                withExtension: "mp3"
        ) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default
            )
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
