//
//  restartViewController.swift
//  domath
//
//  Created by Alex on 6/30/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import AVFoundation
import Charts

class restartViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
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
            bestScoreLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            bestScoreNumberLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        } else if (blueColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBlue8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBlue10.png")
                view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            bestScoreLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            bestScoreNumberLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        } else if (greyColor == true) {
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            bestScoreLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            bestScoreNumberLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
        
        currentScoreNumberLabel.layer.masksToBounds = true
        currentScoreNumberLabel.layer.cornerRadius = 15
        yourScoreLabel.layer.masksToBounds = true
        yourScoreLabel.layer.cornerRadius = 10
        flipSideView.layer.masksToBounds = true
        flipSideView.layer.cornerRadius = 15
        continueButton.layer.cornerRadius = 10
        
        // setting constraints
        
        if (screenHeight == 812) {
            titleLabelTopConstraint.constant = 40
            bestScoreNumberTopConstraint.constant = 40
        }
        
        currentScoreNumberTopConstraint.constant = 0.2623239437 * screenHeight
        currentScoreNumberLeftConstraint.constant = 0.265625 * screenWidth
        currentScoreNumberRightConstraint.constant = 0.265625 * screenWidth
        
        yourScoreLabelTopConstraint.constant = 0.014084507 * screenHeight
        yourScoreLabelLeftConstraint.constant = 0.265625 * screenWidth
        yourScoreLabelRightConstraint.constant = 0.265625 * screenWidth
        
        flipSideViewTopConstraint.constant = 0.2447183 * screenHeight
        flipSideViewLeftConstraint.constant = 0.1875 * screenWidth
        flipSideViewRightConstraint.constant = 0.1875 * screenWidth
        
        bottomContainerLeftConstraint.constant = 0.125 * screenWidth
        bottomContainerRightConstraint.constant = 0.125 * screenWidth
        
        toMenuButtonLeftConstraint.constant = 0.053125 * screenWidth
        toMenuButtonRightConstraint.constant = 0.18125 * screenWidth
        shareButtonLeftConstraint.constant = 0.18125 * screenWidth
        shareButtonRightConstraint.constant = 0.053125 * screenWidth
        
        let cornerRadius = screenWidth * (1 - 2 * 0.125 - 2 * 0.053125 - 2 * 0.18125) / 3 / 2
        
        toMenuButton.layer.masksToBounds = true
        toMenuButton.layer.cornerRadius = cornerRadius
        restartButton.layer.masksToBounds = true
        restartButton.layer.cornerRadius = cornerRadius
        shareButton.layer.masksToBounds = true
        shareButton.layer.cornerRadius = cornerRadius
        
        leaderboardButton.layer.borderWidth = 0.5
        //leaderboardButton.layer.borderColor = UIColor.white.cgColor
        leaderboardButton.layer.borderColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1).cgColor
        statisticsButton.layer.borderWidth = 0.5
        //statisticsButton.layer.borderColor = UIColor.white.cgColor
        statisticsButton.layer.borderColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1).cgColor
        
        // Setting font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        currentModeLabel.font = currentModeLabel.font.withSize(0.0375 * screenWidth)
        bestScoreNumberLabel.font = bestScoreNumberLabel.font.withSize(0.109375 * screenWidth)
        bestScoreLabel.font = bestScoreLabel.font.withSize(0.0375 * screenWidth)
        
        currentScoreNumberLabel.font = currentScoreNumberLabel.font.withSize(0.140625 * screenWidth)
        yourScoreLabel.font = yourScoreLabel.font.withSize(0.053125 * screenWidth)
        
        
        // Setting labels and scores
        
        currentScoreNumberLabel.text = ("\(scoreCounter)")
        
        if (addModeBool == true) {
            
            currentModeLabel.text = "addition mode"
            addModeBestScore = UserDefaults.standard.integer(forKey: "addModeBestScore")
            if (scoreCounter > addModeBestScore) {
                UserDefaults.standard.set(scoreCounter, forKey: "addModeBestScore")
                bestScoreNumberLabel.text = ("\(scoreCounter)")
            } else {
                bestScoreNumberLabel.text = ("\(addModeBestScore)")
            }
            
        } else if (subtractModeBool == true) {
            
            currentModeLabel.text = "subtraction mode"
            subtractModeBestScore = UserDefaults.standard.integer(forKey: "subtractModeBestScore")
            if (scoreCounter > subtractModeBestScore) {
                UserDefaults.standard.set(scoreCounter, forKey: "subtractModeBestScore")
                bestScoreNumberLabel.text = ("\(scoreCounter)")
            } else {
                bestScoreNumberLabel.text = ("\(subtractModeBestScore)")
            }
            
        } else if (multiplyModeBool == true) {
            
            currentModeLabel.text = "multiplication mode"
            multiplyModeBestScore = UserDefaults.standard.integer(forKey: "multiplyModeBestScore")
            if (scoreCounter > multiplyModeBestScore) {
                UserDefaults.standard.set(scoreCounter, forKey: "multiplyModeBestScore")
                bestScoreNumberLabel.text = ("\(scoreCounter)")
            } else {
                bestScoreNumberLabel.text = ("\(multiplyModeBestScore)")
            }
            
        } else if (divideModeBool == true) {
            
            currentModeLabel.text = "division mode"
            divideModeBestScore = UserDefaults.standard.integer(forKey: "divideModeBestScore")
            if (scoreCounter > divideModeBestScore) {
                UserDefaults.standard.set(scoreCounter, forKey: "divideModeBestScore")
                bestScoreNumberLabel.text = ("\(scoreCounter)")
            } else {
                bestScoreNumberLabel.text = ("\(divideModeBestScore)")
            }
            
        } else if (mixedModeBool == true) {
            
            currentModeLabel.text = "mixed mode"
            mixedModeBestScore = UserDefaults.standard.integer(forKey: "mixedModeBestScore")
            if (scoreCounter > mixedModeBestScore) {
                UserDefaults.standard.set(scoreCounter, forKey: "mixedModeBestScore")
                bestScoreNumberLabel.text = ("\(scoreCounter)")
            } else {
                bestScoreNumberLabel.text = ("\(mixedModeBestScore)")
            }
            
        }
        
        // MARK: Additional Menu Settings
        
        // MARK: Leaderboard settings
        
        leaderboardButton.isEnabled = false
        textFieldBottomConstraint.constant = 0.19 * screenHeight
        
        // MARK: statistics settings
        
        // Hiding statistics at load
        
        allTimeHighLabel.isHidden = true
        statisticsView.isHidden = true
        avgLabel.isHidden = true
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        // current date scores update
        
        let currentDate = formatter.string(from: date)
        if ((scoresDictionaryDate[currentDate]) != nil) {
            var listOfScores = scoresDictionaryDate[currentDate]
            listOfScores?.append(scoreCounter)
            scoresDictionaryDate.updateValue(listOfScores!, forKey:currentDate)
        } else {
            scoresDictionaryDate.updateValue([scoreCounter], forKey:currentDate)
        }
        
        // current datetime scores update
        
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let currentDateTime = formatter.string(from: date)
        scoresDictionaryDateTime.updateValue(scoreCounter, forKey: currentDateTime)
        
        let newScore = statisticsScore(date: currentDateTime, value: scoreCounter)
        dailyScoresList.append(newScore)
        if (scoreCounter > maxDailyScore) {
            maxDailyScore = scoreCounter
        }
        //let xAxis = XAxis()
        //let chartFormmater = BarChartFormatter()
        
        var counter = 1.0
        var totalScore = 0
        var entryList = [BarChartDataEntry]()
        for score in dailyScoresList {
            print(score.value)
            let entry = BarChartDataEntry(x: counter, y: Double(score.value))
            totalScore += score.value
            entryList.append(entry)
            counter += 1
        }
        let avgScore = Double(totalScore) / (counter - 1)
        avgLabel.text = "Avg. \(String(format: "%.2f", avgScore))"
        
        //xAxis.valueFormatter=chartFormmater
        //statisticsView.xAxis.valueFormatter=xAxis.valueFormatter
        
        statisticsView.delegate = self
        
        let dataset = BarChartDataSet(values: entryList, label: nil)
        dataset.drawValuesEnabled = false
        let data = BarChartData(dataSets: [dataset])
        // Setting bar width
        let barWidth = 1.0
        data.barWidth = barWidth
        statisticsView.data = data
        
        
        statisticsView.leftAxis.axisMinimum = 0
        statisticsView.leftAxis.axisMaximum = Double(maxDailyScore + 10 - maxDailyScore % 10)
        statisticsView.xAxis.axisMinimum = 0
        statisticsView.xAxis.axisMaximum = Double(dailyScoresList.count + 10 - dailyScoresList.count % 10)
        
        statisticsView.pinchZoomEnabled = true
        statisticsView.dragEnabled = true
        statisticsView.setScaleEnabled(false)
        statisticsView.doubleTapToZoomEnabled = false
        
        statisticsView.setVisibleXRangeMaximum(15)
        statisticsView.scaleYEnabled = false
        statisticsView.scaleXEnabled = false
        statisticsView.moveViewToX(Double(dailyScoresList.count + 1))
        
        statisticsView.leftAxis.drawGridLinesEnabled = true
        statisticsView.leftAxis.drawAxisLineEnabled = true
        statisticsView.leftAxis.drawLabelsEnabled = true
        statisticsView.leftAxis.gridColor = UIColor.white
        statisticsView.leftAxis.axisLineColor = UIColor.white
        statisticsView.leftAxis.labelTextColor = UIColor.white
        statisticsView.leftAxis.labelFont = UIFont(name: "Chalkboard SE", size: 12)!
        
        statisticsView.rightAxis.drawGridLinesEnabled = false
        statisticsView.rightAxis.drawAxisLineEnabled = false
        statisticsView.rightAxis.drawLabelsEnabled = false
        statisticsView.xAxis.drawGridLinesEnabled = false
        statisticsView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        statisticsView.xAxis.drawLabelsEnabled = false
        statisticsView.xAxis.drawAxisLineEnabled = true
        statisticsView.xAxis.spaceMin = barWidth
        statisticsView.xAxis.axisLineColor = UIColor.white
        statisticsView.drawValueAboveBarEnabled = true
        statisticsView.drawMarkers = true
        
        let marker =  BalloonMarker(color: UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1),
                                    font: UIFont(name: "Chalkboard SE", size: 12)!,
                                    textColor: UIColor.white,
                                    insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        marker.image = UIImage(named: "dashboard-point_heart")
        marker.size = CGSize(width: 50, height: 50)
        statisticsView.marker = marker
        
        statisticsView.legend.enabled = false
        statisticsView.notifyDataSetChanged()
        
        print(scoresDictionaryDate.keys)
        print(scoresDictionaryDate.values)
        
        print(scoresDictionaryDateTime.keys)
        print(scoresDictionaryDateTime.values)
        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        bestScoreNumberTopConstraint.constant -= screenHeight
        bottomContainerBottomConstraint.constant -= screenHeight
        
        currentScoreNumberRightConstraint.constant -= screenWidth
        currentScoreNumberLeftConstraint.constant += screenWidth
        
        yourScoreLabelRightConstraint.constant -= screenWidth
        yourScoreLabelLeftConstraint.constant += screenWidth
        
        flipSideView.isHidden = true
        
    }
   /*
    @objc(BarChartFormatter)
    public class BarChartFormatter: NSObject, IAxisValueFormatter{
        
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            
            return Array(scoresDictionaryDateTime.keys)[Int(value)]
        }
    }*/
    
    
    
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
                        self.bestScoreNumberTopConstraint.constant += screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5,
                       options: [], animations: {
                        self.bottomContainerBottomConstraint.constant += screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.currentScoreNumberRightConstraint.constant += screenWidth
                        self.currentScoreNumberLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.yourScoreLabelRightConstraint.constant += screenWidth
                        self.yourScoreLabelLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    
    
    
    // MARK: Actions
    
    @IBAction func currentScoreTappedAction(_ sender: Any) {
        UIView.transition(with: flipSideView, duration: 0.4, options: .transitionFlipFromRight, animations: {
            self.currentScoreNumberLabel.isHidden = true
            self.flipSideView.isHidden = false
        }, completion: nil)
        UIView.transition(with: flipSideView, duration: 0.4, options: .transitionFlipFromRight, animations: {
            self.yourScoreLabel.isHidden = true
            self.flipSideView.isHidden = false
        }, completion: nil)
        
        
    }
    @IBAction func flipSideViewTappedAction(_ sender: Any) {
        UIView.transition(with: currentScoreNumberLabel, duration: 0.4, options: .transitionFlipFromLeft, animations: {
            self.currentScoreNumberLabel.isHidden = false
            self.flipSideView.isHidden = true
            self.yourScoreLabel.isHidden = false
        }, completion: nil)
        UIView.transition(with: yourScoreLabel, duration: 0.4, options: .transitionFlipFromLeft, animations: {
            self.yourScoreLabel.isHidden = false
            self.flipSideView.isHidden = true
        }, completion: nil)
    }
    
    
    
    
    @IBAction func toMenuButtonAction(_ sender: Any) {
        
        addModeBool = false
        multiplyModeBool = false
        subtractModeBool = false
        divideModeBool = false
        mixedModeBool = false
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuID") as! ViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func restartButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameID") as! gameViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        share(image: takeScreenshot()!)
    }
    
    
    func share(image: UIImage) {
        let message = "Man, I have just scored \(scoreCounter) in the Do Math! game. http://itunes.apple.com/do-math!/id1412104753"
        let objectsToShare = [image as Any, message as Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        bottomContainerBottomConstraint.constant -= screenHeight
        yourScoreLabel.text = "score"
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        bottomContainerBottomConstraint.constant += screenHeight
        yourScoreLabel.text = "your score"
        return screenshotImage
    }
    
    @IBAction func leaderboardButtonAction(_ sender: Any) {
        signInView.isHidden = false
        allTimeHighLabel.isHidden = true
        statisticsView.isHidden = true
        avgLabel.isHidden = true
        
        leaderboardButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        leaderboardButton.backgroundColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        statisticsButton.backgroundColor = UIColor.clear
        statisticsButton.setTitleColor(UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1), for: UIControlState.normal)
        statisticsButton.isEnabled = true
        leaderboardButton.isEnabled = false
    }
    
    @IBAction func statisticsButtonAction(_ sender: Any) {
        signInView.isHidden = true
        allTimeHighLabel.isHidden = false
        statisticsView.isHidden = false
        avgLabel.isHidden = false
        
        statisticsButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        statisticsButton.backgroundColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        leaderboardButton.backgroundColor = UIColor.clear
        leaderboardButton.setTitleColor(UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1), for: UIControlState.normal)
        statisticsButton.isEnabled = false
        leaderboardButton.isEnabled = true
    }
    
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentModeLabel: UILabel!
    @IBOutlet weak var bestScoreNumberLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    @IBOutlet weak var currentScoreNumberLabel: UILabel!
    @IBOutlet weak var yourScoreLabel: UILabel!
    
    @IBOutlet weak var toMenuButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bestScoreNumberTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var currentScoreNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentScoreNumberLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentScoreNumberRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yourScoreLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var yourScoreLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var yourScoreLabelRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomContainerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shareButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var shareButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var statisticsView: BarChartView!
    @IBOutlet weak var flipSideView: UIView!
    @IBOutlet weak var flipSideViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var flipSideViewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var flipSideViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameIsBusyLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var allTimeHighLabel: UILabel!
    @IBOutlet weak var signInView: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// MARK: - ChartViewDelegate
extension restartViewController: ChartViewDelegate
{
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        //print("chartValueSelected : x = \(highlight.x)")
        
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        //print("chartValueNothingSelected")
    }
}
