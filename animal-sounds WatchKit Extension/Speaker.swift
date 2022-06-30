//
//  Speaker.swift
//  animal-sounds WatchKit Extension
//
//  Created by fabio.bombardi on 30/06/22.
//

import WatchKit
import AVFoundation

class Speaker: NSObject {
    private let synth = AVSpeechSynthesizer()
    private var completion: () -> Void = {}

    override init() {
        super.init()
        synth.delegate = self
    }
    
    init(_ completion: @escaping () -> Void) {
        super.init()
        synth.delegate = self
        self.completion = completion
    }

    func speak(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        synth.speak(utterance)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        completion()
    }
}
