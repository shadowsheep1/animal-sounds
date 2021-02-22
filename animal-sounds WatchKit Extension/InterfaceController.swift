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
        "lion"
    ]
    
    private var animals: [String] {
        var animals: [String] = []
        for animalKey in animalsKeys {
            animals.append(NSLocalizedString(animalKey, comment: ""))
        }
        return animals
    }
    
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
                row.animalImage.setImageNamed(animalsKeys[i])
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print("selected item at \(rowIndex)")
        playSound(animalsKeys[rowIndex])
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
