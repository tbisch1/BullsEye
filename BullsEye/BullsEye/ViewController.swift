//
//  ViewController.swift
//  BullsEye
//
//  Created by Tyler Bischoff on 1/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
//        currentValue = lroundf(slider.value)
//        targetValue = Int.random(in: 1...100)
//        startNewRound()
        
        startOver()
    }

    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        let points: Int
        if difference == 0 {
            points = 200
        }
        else if difference == 1 {
            points = 150
        }
        else {
            points = 100 - difference
        }
        
        score += points

//        var difference: Int = currentValue - targetValue
//        if difference < 0 {
//            difference = -difference
//        }
//        if currentValue > targetValue {
//            difference = currentValue - targetValue
//        }
//        else if targetValue > currentValue {
//            difference = targetValue - currentValue
//        }
//        else {
//            difference = 0
//        }
        
        let title: String
            if difference == 0 {
                title = "Perfect!"
            }
            else if difference < 5 {
                title = "You almost had it!"
            }
            else if difference < 10 {
                title = "Pretty good!"
            }
            else {
                title = "Not even close..."
            }
        
        let message = "You scored \(points) points"
//        let message = "The value of the slider is: \(currentValue)" +
//            "\nThe target value is: \(targetValue)" +
//            "\nThe difference is \(difference)"
        
        let alert = UIAlertController(
//            title: "Hello, World",
            title: title,
//            message: "this is my first app!",
            message: message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
//            title: "Awesome",
            title: "Ok",
            style: .default,
            handler: {_ in self.startNewRound()
            }
        )
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
//        startNewRound()
    }
        
    @IBAction func sliderMoved(_ slider: UISlider) {
//        print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        round = 0
        score = 0
        
        startNewRound()
        
        let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}
