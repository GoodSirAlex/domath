//
//  gameViewController.swift
//  domath
//
//  Created by Alex on 6/29/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import GameplayKit
import AudioToolbox
import AVFoundation

class gameViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Properties
    
    var player: AVAudioPlayer?
    let endSound = SimpleSound(named: "end3-bass")
    let tapSound = SimpleSound(named: "tap2")
    
    var timerView: UIView!
    var redFrame: UIView!
    var yPosition: CGFloat!
    var randomButton = GKRandomDistribution(lowestValue: 0, highestValue: 3)
    
    var startTimer = Timer()
    var continueTimer = Timer()
    var endTimer = Timer()
    var buttonTimer = Timer()
    var pauseGameTimer = Timer()
    var seconds = 8
    var timerDuration = 0.0
    
    var scoreIncrease = 0
    
    var correctAnswer = 0
    var secondAnswer = 0
    var thirdAnswer = 0
    var fourthAnswer = 0
    var correctButton = 0
    
    //MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if (beigeColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBeige.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBeige10.png")
                view.backgroundColor = UIColor(red: 230/255, green: 221/255, blue: 191/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            scoreLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            scoreNumberLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        } else if (blueColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBlue8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBlue10.png")
                view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            scoreLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            scoreNumberLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        } else if (greyColor == true) {
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            scoreLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            scoreNumberLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
        
        scoreCounter = 0
        vibrationOff = UserDefaults.standard.integer(forKey: "vibrationState")

        // Setting objects' shapes
        
        taskLabel.layer.masksToBounds = true
        taskLabel.layer.cornerRadius = 0.09375 * taskLabel.frame.width
        
        firstAnswerButton.layer.cornerRadius = 0.2857142857 * firstAnswerButton.frame.width
        secondAnswerButton.layer.cornerRadius = 0.2857142857 * secondAnswerButton.frame.width
        thirdAnswerButton.layer.cornerRadius = 0.2857142857 * thirdAnswerButton.frame.width
        fourthAnswerButton.layer.cornerRadius = 0.2857142857 * fourthAnswerButton.frame.width
        
        
        // Setting Constraints
        
        if (screenHeight == 812) {
            titleLabelTopConstraint.constant = 40
            scoreNumberTopConstraint.constant = 40
        }
        
        taskLabelLeftConstraint.constant = 0.265625 * screenWidth
        taskLabelRightConstraint.constant = 0.265625 * screenWidth
        
        
        firstAnswerButtonTopConstraint.constant = 0.0211267606 * screenHeight
        firstAnswerButtonLeftConstraint.constant = 0.265625 * screenWidth
        firstAnswerButtonRightConstraint.constant = 0.03125 * screenWidth
        secondAnswerButtonTopConstraint.constant = 0.0211267606 * screenHeight
        secondAnswerButtonRightConstraint.constant = 0.265625 * screenWidth
        thirdAnswerButtonTopConstraint.constant = 0.0211267606 * screenHeight
        thirdAnswerButtonLeftConstraint.constant = 0.265625 * screenWidth
        thirdAnswerButtonRightConstraint.constant = 0.03125 * screenWidth
        fourthAnswerButtonTopConstraint.constant = 0.0211267606 * screenHeight
        fourthAnswerButtonRightConstraint.constant = 0.265625 * screenWidth
        
        toMenuButtonLeftConstraint.constant = 0.453125 * screenWidth
        toMenuButtonRightConstraint.constant = 0.453125 * screenWidth
        
        let cornerRadius = (screenWidth - 2 * 0.453125 * screenWidth) / 2
            
            toMenuButton.layer.masksToBounds = true
        toMenuButton.layer.cornerRadius = cornerRadius
        
        
        // Setting font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        currentModeLabel.font = currentModeLabel.font.withSize(0.0375 * screenWidth)
        
        scoreNumberLabel.font = scoreNumberLabel.font.withSize(0.09375 * screenWidth)
        scoreLabel.font = scoreLabel.font.withSize(0.0375 * screenWidth)
        
        // Setting timer: grey screen
        
        timerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        timerView.backgroundColor = UIColor(red: 127 / 255, green: 127 / 255, blue: 127 / 255, alpha: 0.2)
        self.view.addSubview(timerView)
        
        self.view.bringSubview(toFront: titleLabel)
        self.view.bringSubview(toFront: currentModeLabel)
        self.view.bringSubview(toFront: scoreNumberLabel)
        self.view.bringSubview(toFront: scoreLabel)
        self.view.bringSubview(toFront: taskLabel)
        self.view.bringSubview(toFront: firstAnswerButton)
        self.view.bringSubview(toFront: secondAnswerButton)
        self.view.bringSubview(toFront: thirdAnswerButton)
        self.view.bringSubview(toFront: fourthAnswerButton)
        self.view.bringSubview(toFront: toMenuButton)
        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        scoreNumberTopConstraint.constant -= screenHeight
        toMenuButtonBottomConstraint.constant -= screenHeight
        
        taskLabelRightConstraint.constant -= screenWidth
        taskLabelLeftConstraint.constant += screenWidth
        
        firstAnswerButtonLeftConstraint.constant -= screenWidth
        secondAnswerButtonRightConstraint.constant += screenWidth
        thirdAnswerButtonLeftConstraint.constant -= screenWidth
        fourthAnswerButtonRightConstraint.constant += screenWidth

        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.7,
                       options: [], animations: {
                        self.titleLabelTopConstraint.constant += screenHeight
                        self.scoreNumberTopConstraint.constant += screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5,
                       options: [], animations: {
                        self.toMenuButtonBottomConstraint.constant += screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.taskLabelRightConstraint.constant += screenWidth
                        self.taskLabelLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.firstAnswerButtonLeftConstraint.constant += screenWidth
                        self.secondAnswerButtonRightConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.thirdAnswerButtonLeftConstraint.constant += screenWidth
                        self.fourthAnswerButtonRightConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        self.timerView.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
        self.view.layoutIfNeeded()
        
        startGame()
        
    }
    
    
    @objc func gameAction() {
        startTimer.invalidate()
        endGameTimer()
    }
    
    
    
    
    
    // MARK: Task and Correct Answer Setting
    
    @objc func startGame() {
        
        // Setting time given
        
        if (addModeBool == true) {
            if (scoreCounter < 30) {
                seconds = 8
                timerDuration = 8.0
            } else {
                seconds = 14
                timerDuration = 14.0
            }
        } else if (multiplyModeBool == true) {
            if (scoreCounter < 30) {
                seconds = 8
                timerDuration = 8.0
            } else {
                seconds = 16
                timerDuration = 16.0
            }
        } else if (subtractModeBool == true) {
            if (scoreCounter < 30) {
                seconds = 8
                timerDuration = 8.0
            } else {
                seconds = 14
                timerDuration = 14.0
            }
        } else if (divideModeBool == true) {
            if (scoreCounter < 25) {
                seconds = 8
                timerDuration = 8.0
            } else {
                seconds = 16
                timerDuration = 16.0
            }
        } else if (mixedModeBool == true) {
            if (scoreCounter < 30) {
                seconds = 8
                timerDuration = 8.0
            } else {
                seconds = 16
                timerDuration = 16.0
            }
        }
        
        startTimer.invalidate()
        startTimer = Timer.scheduledTimer(timeInterval: timerDuration, target: self, selector: #selector(gameAction), userInfo: nil, repeats: true)
        
        // Starting timer animation
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        self.timerView.layer.removeAllAnimations()
        self.timerView.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: timerDuration, animations: {
            self.timerView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        //
        // Enabling answer buttons
        //
        
        firstAnswerButton.isEnabled = true
        secondAnswerButton.isEnabled = true
        thirdAnswerButton.isEnabled = true
        fourthAnswerButton.isEnabled = true
        
        //
        // Setting new values in top bar
        //
        
        scoreNumberLabel.text = ("\(scoreCounter)")
        
        
        
        //
        // Setting the game in time mode
        //
        
        scoreIncrease = 1
        
        if (addModeBool == true) {
            
            currentModeLabel.text = "addition mode"
            
            addModeBasic = false
            addModeIntermediate = false
            addModeAdvanced = false
            addModeSilver = false
            addModeGold = false
            addModePlatinum = false
            addModeElite = false
            
            // Starting mode
            
            if (scoreCounter < 10) {
                addModeBasic = true
                addMode()
            } else if (scoreCounter < 20) {
                addModeIntermediate = true
                addMode()
            } else if (scoreCounter < 30) {
                addModeAdvanced = true
                addMode()
                scoreIncrease = 2
            } else if (scoreCounter < 40) {
                addModeSilver = true
                addMode()
                scoreIncrease = 2
            } else if (scoreCounter < 50) {
                addModeGold = true
                addMode()
                scoreIncrease = 5
            } else if (scoreCounter < 60) {
                addModePlatinum = true
                addMode()
                scoreIncrease = 5
            } else {
                addModeElite = true
                addMode()
                scoreIncrease = 7
            }
            
        } else if (multiplyModeBool == true) {
            
            // Starting mode
            
            currentModeLabel.text = "multiplication mode"
            
            multiplyModeBasic = false
            multiplyModeIntermediate = false
            multiplyModeAdvanced = false
            multiplyModeSilver = false
            multiplyModeGold = false
            multiplyModePlatinum = false
            
            if (scoreCounter < 10) {
                multiplyModeBasic = true
                multiplyMode()
            } else if (scoreCounter < 20) {
                multiplyModeIntermediate = true
                multiplyMode()
            } else if (scoreCounter < 30) {
                multiplyModeAdvanced = true
                multiplyMode()
                scoreIncrease = 2
            } else if (scoreCounter < 40) {
                multiplyModeSilver = true
                multiplyMode()
                scoreIncrease = 2
            } else if (scoreCounter < 50) {
                multiplyModeGold = true
                multiplyMode()
                scoreIncrease = 5
            } else {
                multiplyModePlatinum = true
                multiplyMode()
                scoreIncrease = 5
            }
            
        } else if (subtractModeBool == true) {
            
            // Starting mode
            
            currentModeLabel.text = "subtraction mode"
            
            subtractModeBasic = false
            subtractModeIntermediate = false
            subtractModeAdvanced = false
            subtractModeSilver = false
            subtractModeGold = false
            subtractModePlatinum = false
            
            if (scoreCounter < 10) {
                subtractModeBasic = true
                subtractMode()
            } else if (scoreCounter < 20) {
                subtractModeIntermediate = true
                subtractMode()
            } else if (scoreCounter < 30) {
                subtractModeAdvanced = true
                subtractMode()
                scoreIncrease = 2
            } else if (scoreCounter < 40) {
                subtractModeSilver = true
                subtractMode()
                scoreIncrease = 2
            } else if (scoreCounter < 50) {
                subtractModeGold = true
                subtractMode()
                scoreIncrease = 5
            } else if (scoreCounter < 60) {
                subtractModePlatinum = true
                subtractMode()
                scoreIncrease = 5
            }
            
            
        } else if (divideModeBool == true) {
            
            currentModeLabel.text = "division mode"
            
            divideModeBasic = false
            divideModeIntermediate = false
            divideModeAdvanced = false
            divideModeElite = false
            
            // Starting mode
            
            if (scoreCounter < 10) {
                divideModeBasic = true
                divideMode()
            } else if (scoreCounter < 25) {
                divideModeIntermediate = true
                divideMode()
            } else if (scoreCounter < 40) {
                divideModeAdvanced = true
                divideMode()
                scoreIncrease = 2
            } else {
                divideModeElite = true
                divideMode()
                scoreIncrease = 5
            }
            
            
        } else if (mixedModeBool == true) {
            
            currentModeLabel.text = "mixed mode"
            
            // Starting mode
            
            let randSign = randomButton.nextInt()
            switch randSign {
            case 0: addModeBasic = false
                    addModeIntermediate = false
                    addModeAdvanced = false
                    addModeSilver = false
                    addModeGold = false
                    addModePlatinum = false
                    addModeElite = false
            
                    // Starting mode
            
                    if (scoreCounter < 10) {
                        addModeBasic = true
                        addMode()
                    } else if (scoreCounter < 20) {
                        addModeIntermediate = true
                        addMode()
                    } else if (scoreCounter < 30) {
                        addModeAdvanced = true
                        addMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 40) {
                        addModeSilver = true
                        addMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 50) {
                        addModeGold = true
                        addMode()
                        scoreIncrease = 5
                    } else if (scoreCounter < 60) {
                        addModePlatinum = true
                        addMode()
                        scoreIncrease = 5
                    } else {
                        addModeElite = true
                        addMode()
                        scoreIncrease = 7
                        }
                
            case 1: multiplyModeBasic = false
                    multiplyModeIntermediate = false
                    multiplyModeAdvanced = false
                    multiplyModeSilver = false
                    multiplyModeGold = false
                    multiplyModePlatinum = false
            
                    if (scoreCounter < 10) {
                        multiplyModeBasic = true
                        multiplyMode()
                    } else if (scoreCounter < 20) {
                        multiplyModeIntermediate = true
                        multiplyMode()
                    } else if (scoreCounter < 30) {
                        multiplyModeAdvanced = true
                        multiplyMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 40) {
                        multiplyModeSilver = true
                        multiplyMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 50) {
                        multiplyModeGold = true
                        multiplyMode()
                        scoreIncrease = 5
                    } else {
                        multiplyModePlatinum = true
                        multiplyMode()
                        scoreIncrease = 5
                        }
                
            case 2: subtractModeBasic = false
                    subtractModeIntermediate = false
                    subtractModeAdvanced = false
                    subtractModeSilver = false
                    subtractModeGold = false
                    subtractModePlatinum = false
            
                    if (scoreCounter < 10) {
                        subtractModeBasic = true
                        subtractMode()
                    } else if (scoreCounter < 20) {
                        subtractModeIntermediate = true
                        subtractMode()
                    } else if (scoreCounter < 30) {
                        subtractModeAdvanced = true
                        subtractMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 40) {
                        subtractModeSilver = true
                        subtractMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 50) {
                        subtractModeGold = true
                        subtractMode()
                        scoreIncrease = 5
                    } else if (scoreCounter < 60) {
                        subtractModePlatinum = true
                        subtractMode()
                        scoreIncrease = 5
                        }
                
            default: divideModeBasic = false
                    divideModeIntermediate = false
                    divideModeAdvanced = false
                    divideModeElite = false
            
                    // Starting mode
            
                    if (scoreCounter < 10) {
                        divideModeBasic = true
                        divideMode()
                    } else if (scoreCounter < 25) {
                        divideModeIntermediate = true
                        divideMode()
                        scoreIncrease = 2
                    } else if (scoreCounter < 40) {
                        divideModeAdvanced = true
                        divideMode()
                        scoreIncrease = 5
                    } else {
                        divideModeElite = true
                        divideMode()
                        scoreIncrease = 5
                    }
            }
            
        }
        
        
        //
        // Setting answer buttons
        //
        
        
        correctButton = randomButton.nextInt()
        switch correctButton {
        case 0: firstAnswerButton.setTitle(String(correctAnswer), for: .normal)
        secondAnswerButton.setTitle(String(secondAnswer), for: .normal)
        thirdAnswerButton.setTitle(String(thirdAnswer), for: .normal)
        fourthAnswerButton.setTitle(String(fourthAnswer), for: .normal)
            
        case 1: firstAnswerButton.setTitle(String(secondAnswer), for: .normal)
        secondAnswerButton.setTitle(String(correctAnswer), for: .normal)
        thirdAnswerButton.setTitle(String(thirdAnswer), for: .normal)
        fourthAnswerButton.setTitle(String(fourthAnswer), for: .normal)
            
        case 2: firstAnswerButton.setTitle(String(thirdAnswer), for: .normal)
        secondAnswerButton.setTitle(String(secondAnswer), for: .normal)
        thirdAnswerButton.setTitle(String(correctAnswer), for: .normal)
        fourthAnswerButton.setTitle(String(fourthAnswer), for: .normal)
            
        default: firstAnswerButton.setTitle(String(fourthAnswer), for: .normal)
        secondAnswerButton.setTitle(String(secondAnswer), for: .normal)
        thirdAnswerButton.setTitle(String(thirdAnswer), for: .normal)
        fourthAnswerButton.setTitle(String(correctAnswer), for: .normal)
        }
    }
    
    //
    // MARK: Add Mode setting
    //
    
    func addMode() {
        var highestNumber = 0
        var highestPicker = 0
        
        if (addModeBasic == true) {
            highestNumber = 15
            highestPicker = 5
        } else if (addModeIntermediate == true) {
            highestNumber = 15
            highestPicker = 11
        } else if (addModeAdvanced == true) {
            highestNumber = 99
            highestPicker = 11
        } else if (addModeSilver == true) {
            highestNumber = 200
            highestPicker = 13
        } else if (addModeGold == true) {
            highestNumber = 99
            highestPicker = 13
        } else if (addModePlatinum == true) {
            highestNumber = 1000
            highestPicker = 15
        } else if (addModeElite == true) {
            highestNumber = 1000
            highestPicker = 15
        }
        
        
        let randomNumber = GKRandomDistribution(lowestValue: 1, highestValue: highestNumber)
        let randomPicker = GKRandomDistribution(lowestValue: 0, highestValue: highestPicker)
        
        
        if (addModeBasic == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) + \(secondNumber) ?"
            correctAnswer = firstNumber + secondNumber
            
            var randomAnswers = [Int]()
            if correctAnswer > 3 {
                
                // filling the array of close but wrong answers
                
                for answer in (correctAnswer - 3)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 4) {
                    randomAnswers.append(answer)
                }
                
                
                var removeIndex = randomPicker.nextInt()
                secondAnswer = randomAnswers.remove(at: removeIndex)
                
                removeIndex = randomPicker.nextInt()
                while removeIndex >= randomAnswers.count {
                    removeIndex = randomPicker.nextInt()
                }
                thirdAnswer = randomAnswers.remove(at: removeIndex)
                
                removeIndex = randomPicker.nextInt()
                while removeIndex >= randomAnswers.count {
                    removeIndex = randomPicker.nextInt()
                }
                fourthAnswer = randomAnswers.remove(at: removeIndex)
                randomAnswers.removeAll()
                
            } else if correctAnswer == 3 {
                let minorRandomPicker = GKRandomDistribution(lowestValue: 0, highestValue: 3)
                randomAnswers = [2, 4, 5, 6]
                
                var removeIndex = minorRandomPicker.nextInt()
                secondAnswer = randomAnswers.remove(at: removeIndex)
                
                removeIndex = minorRandomPicker.nextInt()
                while removeIndex >= randomAnswers.count {
                    removeIndex = minorRandomPicker.nextInt()
                }
                thirdAnswer = randomAnswers.remove(at: removeIndex)
                
                
                removeIndex = minorRandomPicker.nextInt()
                while removeIndex >= randomAnswers.count {
                    removeIndex = minorRandomPicker.nextInt()
                }
                fourthAnswer = randomAnswers.remove(at: removeIndex)
                
            } else if correctAnswer == 2 {
                
                let minorRandomPicker = GKRandomDistribution(lowestValue: 0, highestValue: 3)
                randomAnswers = [1, 3, 4, 5, 6]
                
                var removeIndex = minorRandomPicker.nextInt()
                secondAnswer = randomAnswers.remove(at: removeIndex)
                
                removeIndex = minorRandomPicker.nextInt()
                while removeIndex >= randomAnswers.count {
                    removeIndex = minorRandomPicker.nextInt()
                }
                thirdAnswer = randomAnswers.remove(at: removeIndex)
                
                
                removeIndex = minorRandomPicker.nextInt()
                while removeIndex >= randomAnswers.count {
                    removeIndex = minorRandomPicker.nextInt()
                }
                fourthAnswer = randomAnswers.remove(at: removeIndex)
            }
        } else if (addModeIntermediate == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            let thirdNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) + \(secondNumber) + \(thirdNumber) ?"
            correctAnswer = firstNumber + secondNumber + thirdNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 10)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (addModeAdvanced == true || addModeSilver == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) + \(secondNumber) ?"
            correctAnswer = firstNumber + secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 10)
                    if(addModeSilver == true) {
                        randomAnswers.append(correctAnswer - 20)
                    }
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                    if(addModeSilver == true) {
                        randomAnswers.append(correctAnswer + 20)
                    }
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (addModeGold == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            let thirdNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) + \(secondNumber) + \(thirdNumber) ?"
            correctAnswer = firstNumber + secondNumber + thirdNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 20)
                    randomAnswers.append(correctAnswer - 10)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                    randomAnswers.append(correctAnswer + 20)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (addModePlatinum == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            let thirdNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) + \(secondNumber) + \(thirdNumber)?"
            correctAnswer = firstNumber + secondNumber + thirdNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 30)
                    randomAnswers.append(correctAnswer - 10)
                    randomAnswers.append(correctAnswer - 20)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                    randomAnswers.append(correctAnswer + 20)
                    randomAnswers.append(correctAnswer + 30)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (addModeElite == true) {
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) + \(secondNumber) ?"
            correctAnswer = firstNumber + secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 30)
                    randomAnswers.append(correctAnswer - 10)
                    randomAnswers.append(correctAnswer - 20)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                    randomAnswers.append(correctAnswer + 20)
                    randomAnswers.append(correctAnswer + 30)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
        }
        
    }
    
    
    
    //
    // Multiply Mode setting
    //
    
    
    func multiplyMode() {
        
        var highestNumber = 0
        var highestPicker = 0
        
        if (multiplyModeBasic == true) {
            highestNumber = 10
            highestPicker = 9
        } else if (multiplyModeIntermediate == true) {
            highestNumber = 30
            highestPicker = 13
        } else if (multiplyModeAdvanced == true) {
            highestNumber = 10
            highestPicker = 13
        } else if (multiplyModeSilver == true) {
            highestNumber = 50
            highestPicker = 15
        } else if (multiplyModeGold == true) {
            highestNumber = 70
            highestPicker = 15
        } else if (multiplyModePlatinum == true) {
            highestNumber = 100
            highestPicker = 15
        }
        
        
        
        let randomNumber = GKRandomDistribution(lowestValue: 1, highestValue: highestNumber)
        let randomPicker = GKRandomDistribution(lowestValue: 0, highestValue: highestPicker)
        
        if (multiplyModeBasic == true) {
            
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) x \(secondNumber) ?"
            correctAnswer = firstNumber * secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 1:
                randomAnswers = [2, 3, 4]
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [1, 2, 4, 5]
            case 4:
                randomAnswers = [1, 2, 3, 5, 6]
            case 5:
                randomAnswers = [1, 4, 6, 7, 8, 9]
            case 6:
                randomAnswers = [2, 3, 4, 5, 7, 8, 9]
            case 7:
                randomAnswers = [2, 3, 4, 5, 6, 8, 9, 10]
            default:
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
            
        } else if (multiplyModeIntermediate == true) {
            
            let randomPosition = GKRandomDistribution(lowestValue: 0, highestValue: 1)
            let secondRandomNumber = GKRandomDistribution(lowestValue: 1, highestValue: 10)
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = secondRandomNumber.nextInt()
            let position = randomPosition.nextInt()
            if (position == 0) {
               taskLabel.text = "\(firstNumber) x \(secondNumber) ?"
            } else {
                taskLabel.text = "\(secondNumber) x \(firstNumber) ?"
            }
            correctAnswer = firstNumber * secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer - 20)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer + 20)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
            
        } else if (multiplyModeAdvanced == true) {
            
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            let thirdNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) x \(secondNumber) x \(thirdNumber) ?"
            correctAnswer = firstNumber * secondNumber * thirdNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer - 20)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer + 20)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (multiplyModeSilver == true || multiplyModeGold == true) {
            
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) x \(secondNumber) ?"
            correctAnswer = firstNumber * secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer - 20)
                    randomAnswers.append(correctAnswer - 30)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer + 20)
                    randomAnswers.append(correctAnswer + 30)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
            
        } else if (multiplyModePlatinum == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) x \(secondNumber) ?"
            correctAnswer = firstNumber * secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 2:
                randomAnswers = [1, 3, 4, 5]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [3, 5, 6, 7]
            case 5:
                randomAnswers = [3, 4, 6, 7, 8]
            case 6:
                randomAnswers = [4, 5, 7, 8, 9]
            default:
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer - 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer - 20)
                    randomAnswers.append(correctAnswer - 30)
                }
                
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    randomAnswers.append(answer)
                }
                if correctAnswer >= 30 {
                    randomAnswers.append(correctAnswer + 10)
                }
                if correctAnswer > 100 {
                    randomAnswers.append(correctAnswer + 20)
                    randomAnswers.append(correctAnswer + 30)
                }
                
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        }
        
    }
    
    
    
    
    //
    // Subtract Mode setting
    //
    
    func subtractMode() {
        
        var highestNumber = 0
        var highestPicker = 0
        
        if (subtractModeBasic == true) {
            highestNumber = 20
            highestPicker = 5
        } else if (subtractModeIntermediate == true) {
            highestNumber = 30
            highestPicker = 10
        } else if (subtractModeAdvanced == true) {
            highestNumber = 99
            highestPicker = 10
        } else if (subtractModeSilver == true) {
            highestNumber = 500
            highestPicker = 12
        } else if (subtractModeGold == true) {
            highestNumber = 200
            highestPicker = 12
        } else if (subtractModePlatinum == true) {
            highestNumber = 100
            highestPicker = 12
        }
        
        let randomNumber = GKRandomDistribution(lowestValue: 1, highestValue: highestNumber)
        let randomPicker = GKRandomDistribution(lowestValue: 0, highestValue: highestPicker)
        
        if (subtractModeBasic == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            if firstNumber > secondNumber {
                correctAnswer = firstNumber - secondNumber
                taskLabel.text = "\(firstNumber) - \(secondNumber) ?"
            } else {
                correctAnswer = secondNumber - firstNumber
                taskLabel.text = "\(secondNumber) - \(firstNumber) ?"
            }
            
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 0:
                randomAnswers = [1, 2, 3, 4, 5, 6]
            case 1:
                randomAnswers = [0, 2, 3, 4, 5, 6]
            case 2:
                randomAnswers = [0, 1, 3, 4, 5, 6]
            default:
                for answer in (correctAnswer - 3)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 4) {
                    randomAnswers.append(answer)
                }
            }
            
            // Picking other answers from random answers
            
            var removeIndex = randomPicker.nextInt()
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
            
        } else if ((subtractModeIntermediate == true) || (subtractModeAdvanced == true) || (subtractModeSilver == true)) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) - \(secondNumber) ?"
            correctAnswer = firstNumber - secondNumber
            
            var randomAnswers = [Int]()
            
            if abs(correctAnswer) >= 20 {
                randomAnswers.append(correctAnswer - 10)
                if (subtractModeSilver == true) {
                   randomAnswers.append(correctAnswer - 20)
                }
            }
            for answer in (correctAnswer - 3)..<correctAnswer {
                randomAnswers.append(answer)
            }
            for answer in (correctAnswer + 1)..<(correctAnswer + 4) {
                randomAnswers.append(answer)
            }
            if abs(correctAnswer) >= 20 {
                randomAnswers.append(correctAnswer + 10)
                if (subtractModeSilver == true) {
                    randomAnswers.append(correctAnswer + 20)
                }
            }
            
            // Picking other answers from random answers
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (subtractModeGold == true || subtractModePlatinum == true) {
            
            let firstNumber = randomNumber.nextInt()
            let secondNumber = randomNumber.nextInt()
            let thirdNumber = randomNumber.nextInt()
            taskLabel.text = "\(firstNumber) - \(secondNumber) - \(secondNumber) ?"
            correctAnswer = firstNumber - secondNumber - thirdNumber
            
            var randomAnswers = [Int]()
            
            if abs(correctAnswer) >= 20 {
                randomAnswers.append(correctAnswer - 10)
                randomAnswers.append(correctAnswer - 20)
            }
            for answer in (correctAnswer - 3)..<correctAnswer {
                randomAnswers.append(answer)
            }
            for answer in (correctAnswer + 1)..<(correctAnswer + 4) {
                randomAnswers.append(answer)
            }
            if abs(correctAnswer) >= 20 {
                randomAnswers.append(correctAnswer + 10)
                randomAnswers.append(correctAnswer + 20)
            }
            
            // Picking other answers from random answers
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        }
        
    }

    
    
    
    //
    // Divide Mode setting
    //
    
    func divideMode() {
        
        var firstHighestNumber = 0
        var secondHighestNumber = 0
        var highestPicker = 0
        
        if (divideModeBasic == true) {
            firstHighestNumber = 10
            highestPicker = 5
        } else if (divideModeIntermediate == true) {
            firstHighestNumber = 10
            secondHighestNumber = 60
            highestPicker = 10
        } else if (divideModeAdvanced == true) {
            firstHighestNumber = 10
            highestPicker = 10
        } else if (divideModeElite == true) {
            firstHighestNumber = 100
            highestPicker = 12
        }
        
        let firstRandomNumber = GKRandomDistribution(lowestValue: 1, highestValue: firstHighestNumber)
        let randomPicker = GKRandomDistribution(lowestValue: 0, highestValue: highestPicker)
        
        if (divideModeBasic == true) {
            
            let firstNumber = firstRandomNumber.nextInt()
            let secondNumber = firstRandomNumber.nextInt()
            let task = firstNumber * secondNumber
            taskLabel.text = "\(task) / \(firstNumber) ?"
            correctAnswer = secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 1:
                randomAnswers = [2, 3, 4]
            case 2:
                randomAnswers = [3, 4, 5, 6]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [2, 5, 6, 7]
            case 5:
                randomAnswers = [4, 6, 7, 8, 9]
            case 6:
                randomAnswers = [2, 3, 4, 5, 7, 8, 9]
            case 7:
                randomAnswers = [2, 3, 4, 5, 6, 8, 9, 10]
            default:
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    if answer <= task {
                        randomAnswers.append(answer)
                    }
                }
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (divideModeIntermediate == true) {
            
            
            let secondRandomNumber = GKRandomDistribution(lowestValue: 1, highestValue: secondHighestNumber)
            let randomPosition = GKRandomDistribution(lowestValue: 0, highestValue: 1)
            let position = randomPosition.nextInt()
            var firstNumber = 0
            var secondNumber = 0
            if (position == 0) {
                firstNumber = firstRandomNumber.nextInt()
                secondNumber = secondRandomNumber.nextInt()
            } else {
                firstNumber = secondRandomNumber.nextInt()
                secondNumber = firstRandomNumber.nextInt()
            }
            let task = firstNumber * secondNumber
            taskLabel.text = "\(task) / \(firstNumber) ?"
            correctAnswer = secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 1:
                randomAnswers = [2, 3, 4]
            case 2:
                randomAnswers = [3, 4, 5, 6]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [2, 5, 6, 7]
            case 5:
                randomAnswers = [4, 6, 7, 8, 9]
            case 6:
                randomAnswers = [2, 3, 4, 5, 7, 8, 9]
            case 7:
                randomAnswers = [2, 3, 4, 5, 6, 8, 9, 10]
            default:
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    if answer <= task {
                        randomAnswers.append(answer)
                    }
                }
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        } else if (divideModeAdvanced == true) {
            
            let firstNumber = firstRandomNumber.nextInt()
            let secondNumber = firstRandomNumber.nextInt()
            let thirdNumber = firstRandomNumber.nextInt()
            let task = firstNumber * secondNumber * thirdNumber
            taskLabel.text = "\(task) / \(firstNumber) / \(secondNumber) ?"
            correctAnswer = thirdNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 1:
                randomAnswers = [2, 3, 4]
            case 2:
                randomAnswers = [3, 4, 5, 6]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [2, 5, 6, 7]
            case 5:
                randomAnswers = [4, 6, 7, 8, 9]
            case 6:
                randomAnswers = [2, 3, 4, 5, 7, 8, 9]
            case 7:
                randomAnswers = [2, 3, 4, 5, 6, 8, 9, 10]
            default:
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    if answer <= task {
                        randomAnswers.append(answer)
                    }
                }
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
            
        } else if (divideModeElite == true) {
            
            let firstNumber = firstRandomNumber.nextInt()
            let secondNumber = firstRandomNumber.nextInt()

            let task = firstNumber * secondNumber
            taskLabel.text = "\(task) / \(firstNumber) ?"
            correctAnswer = secondNumber
            
            var randomAnswers = [Int]()
            
            switch correctAnswer {
            case 1:
                randomAnswers = [2, 3, 4]
            case 2:
                randomAnswers = [3, 4, 5, 6]
            case 3:
                randomAnswers = [2, 4, 5, 6]
            case 4:
                randomAnswers = [2, 5, 6, 7]
            case 5:
                randomAnswers = [4, 6, 7, 8, 9]
            case 6:
                randomAnswers = [2, 3, 4, 5, 7, 8, 9]
            case 7:
                randomAnswers = [2, 3, 4, 5, 6, 8, 9, 10]
            default:
                if (correctAnswer > 20) {
                    randomAnswers.append(correctAnswer - 10)
                }
                for answer in (correctAnswer - 5)..<correctAnswer {
                    randomAnswers.append(answer)
                }
                for answer in (correctAnswer + 1)..<(correctAnswer + 6) {
                    if answer <= task {
                        randomAnswers.append(answer)
                    }
                }
                if (correctAnswer > 20) {
                    randomAnswers.append(correctAnswer + 10)
                }
            }
            
            var removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            secondAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            thirdAnswer = randomAnswers.remove(at: removeIndex)
            
            removeIndex = randomPicker.nextInt()
            while removeIndex >= randomAnswers.count {
                removeIndex = randomPicker.nextInt()
            }
            fourthAnswer = randomAnswers.remove(at: removeIndex)
            randomAnswers.removeAll()
            
        }
        
    }
    
    
    
    
    
    
    
    // MARK: Actions
    
    @IBAction func firstAnswerButtonAction(_ sender: Any) {
        firstAnswerButton.backgroundColor = UIColor(red: 60 / 255, green: 124 / 255, blue: 128 / 255, alpha: 1.0)
        if firstAnswerButton.currentTitle == String(correctAnswer) {
            if (soundsOff == 0) {
                tapSound.play()
            }
            scoreCounter += scoreIncrease
            buttonAnimation()
        } else {
            startTimer.invalidate()
            endGameTimer()
        }
    }
    
    @IBAction func secondAnswerButtonAction(_ sender: Any) {
        secondAnswerButton.backgroundColor = UIColor(red: 60 / 255, green: 124 / 255, blue: 128 / 255, alpha: 1.0)
        if secondAnswerButton.currentTitle == String(correctAnswer) {
            if (soundsOff == 0) {
                tapSound.play()
            }
            scoreCounter += scoreIncrease
            buttonAnimation()
        } else {
            startTimer.invalidate()
            endGameTimer()
        }
    }
    
    @IBAction func thirdAnswerButtonAction(_ sender: Any) {
        thirdAnswerButton.backgroundColor = UIColor(red: 60 / 255, green: 124 / 255, blue: 128 / 255, alpha: 1.0)
        if thirdAnswerButton.currentTitle == String(correctAnswer) {
            if (soundsOff == 0) {
                tapSound.play()
            }
            scoreCounter += scoreIncrease
            buttonAnimation()
        } else {
            startTimer.invalidate()
            endGameTimer()
        }
    }
    
    @IBAction func fourthAnswerButtonAction(_ sender: Any) {
        fourthAnswerButton.backgroundColor = UIColor(red: 60 / 255, green: 124 / 255, blue: 128 / 255, alpha: 1.0)
        if fourthAnswerButton.currentTitle == String(correctAnswer) {
            if (soundsOff == 0) {
                tapSound.play()
            }
            scoreCounter += scoreIncrease
            buttonAnimation()
        } else {
            startTimer.invalidate()
            endGameTimer()
        }
    }
    
    
    func buttonAnimation() {
        buttonTimer.invalidate()
        buttonTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(buttonAnimationAction), userInfo: nil, repeats: true)
    }
    
    @objc func buttonAnimationAction() {
        buttonTimer.invalidate()
        firstAnswerButton.backgroundColor = UIColor(red: 73 / 255, green: 165 / 255, blue: 169 / 255, alpha: 1.0)
        secondAnswerButton.backgroundColor = UIColor(red: 73 / 255, green: 165 / 255, blue: 169 / 255, alpha: 1.0)
        thirdAnswerButton.backgroundColor = UIColor(red: 73 / 255, green: 165 / 255, blue: 169 / 255, alpha: 1.0)
        fourthAnswerButton.backgroundColor = UIColor(red: 73 / 255, green: 165 / 255, blue: 169 / 255, alpha: 1.0)
        //let timeSpentForCalculation = startTimer.fireDate.timeIntervalSince(Date())
        //print(timerDuration - timeSpentForCalculation)
        startGame()
    }
    

    
    @IBAction func menuButtonAction(_ sender: Any) {

        addModeBool = false
        multiplyModeBool = false
        subtractModeBool = false
        divideModeBool = false
        mixedModeBool = false
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        startTimer.invalidate()
        let currentFrame = self.timerView.layer.presentation()!.frame
        yPosition = currentFrame.origin.y
        self.timerView.layer.removeAllAnimations()
        self.timerView.transform = CGAffineTransform(translationX: 0, y: yPosition)
        
        continueTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(toMenuTimerAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func toMenuTimerAction() {
        continueTimer.invalidate()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuID") as! ViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    func endGameTimer() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        firstAnswerButton.isEnabled = false
        secondAnswerButton.isEnabled = false
        thirdAnswerButton.isEnabled = false
        fourthAnswerButton.isEnabled = false
        
        switch correctButton {
        case 0:
            firstAnswerButton.backgroundColor = UIColor(red: 162 / 255, green: 166 / 255, blue: 46 / 255, alpha: 1.0)
        case 1:
            secondAnswerButton.backgroundColor = UIColor(red: 162 / 255, green: 166 / 255, blue: 46 / 255, alpha: 1.0)
        case 2:
            thirdAnswerButton.backgroundColor = UIColor(red: 162 / 255, green: 166 / 255, blue: 46 / 255, alpha: 1.0)
        default:
            fourthAnswerButton.backgroundColor = UIColor(red: 162 / 255, green: 166 / 255, blue: 46 / 255, alpha: 1.0)
        }

        
        let currentFrame = self.timerView.layer.presentation()!.frame
        yPosition = currentFrame.origin.y
        self.timerView.layer.removeAllAnimations()
        self.timerView.transform = CGAffineTransform(translationX: 0, y: yPosition)
        
        //timerView.backgroundColor = UIColor(red: 237 / 255, green: 122 / 255, blue: 102 / 255, alpha: 0.2)
        timerView.backgroundColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 0.4)
        
        redFrame = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.redFrame.layer.borderWidth = 6
        //self.redFrame.layer.borderColor = UIColor(red: 206/255, green: 121/255, blue: 104/255, alpha: 1).cgColor
        self.redFrame.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
        self.view.addSubview(redFrame)
        
        if (vibrationOff == 0) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        
        if (soundsOff == 0) {
            endSound.play()
        }
        
        
        endTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(endGameAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func endGameAnimation() {
        
        endTimer.invalidate()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.7,
                       options: [], animations: {
                        self.titleLabelTopConstraint.constant -= screenHeight
                        self.scoreNumberTopConstraint.constant -= screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5,
                       options: [], animations: {
                        self.toMenuButtonBottomConstraint.constant -= screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.taskLabelRightConstraint.constant += screenWidth
                        self.taskLabelLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.firstAnswerButtonLeftConstraint.constant -= screenWidth
                        self.secondAnswerButtonRightConstraint.constant += screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.thirdAnswerButtonLeftConstraint.constant -= screenWidth
                        self.fourthAnswerButtonRightConstraint.constant += screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.timerView.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        endTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(endGameTimerAction), userInfo: nil, repeats: true)
    }
    
    @objc func endGameTimerAction() {
        endTimer.invalidate()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "restartID") as! restartViewController
        self.present(newViewController, animated: false, completion: nil)
        
    }
    
    
    
    
    
    
    
    // MARK: outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreNumberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentModeLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    @IBOutlet weak var toMenuButton: UIButton!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreNumberTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var taskLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var taskLabelRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstAnswerButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstAnswerButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstAnswerButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondAnswerButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondAnswerButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdAnswerButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdAnswerButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdAnswerButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthAnswerButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthAnswerButtonRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var toMenuButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

