//
//  particularScoreViewController.swift
//  domath
//
//  Created by Alex on 6/30/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import AVFoundation

class particularScoreViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var bestScore = 0
    
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
        } else if (blueColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBlue8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBlue10.png")
                view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        } else if (greyColor == true) {
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            currentModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
        
        bestScoreNumberLabel.layer.masksToBounds = true
        bestScoreNumberLabel.layer.cornerRadius = 15
        bestScoreLabel.layer.masksToBounds = true
        bestScoreLabel.layer.cornerRadius = 10
        
        // setting constraints
        
        if (screenHeight == 812) {
            titleLabelTopConstraint.constant = 40
        }
        
        currentScoreNumberTopConstraint.constant = 0.2623239437 * screenHeight
        currentScoreNumberLeftConstraint.constant = 0.265625 * screenWidth
        currentScoreNumberRightConstraint.constant = 0.265625 * screenWidth
        
        yourScoreLabelTopConstraint.constant = 0.014084507 * screenHeight
        yourScoreLabelLeftConstraint.constant = 0.265625 * screenWidth
        yourScoreLabelRightConstraint.constant = 0.265625 * screenWidth
        
        bottomContainerLeftConstraint.constant = 0.125 * screenWidth
        bottomContainerRightConstraint.constant = 0.125 * screenWidth
        
        toMenuButtonLeftConstraint.constant = 0.1625 * screenWidth
        toMenuButtonRightConstraint.constant = 0.2375 * screenWidth
        shareButtonRightConstraint.constant = 0.1625 * screenWidth
        
        
        let cornerRadius = (screenWidth - 2 * 0.125 * screenWidth - 2 * 0.1625 * screenWidth - 0.2375 * screenWidth) / 2 / 2
        toMenuButton.layer.masksToBounds = true
        toMenuButton.layer.cornerRadius = cornerRadius
        shareButton.layer.masksToBounds = true
        shareButton.layer.cornerRadius = cornerRadius
        
        // Setting font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        currentModeLabel.font = currentModeLabel.font.withSize(0.0375 * screenWidth)
        
        bestScoreNumberLabel.font = bestScoreNumberLabel.font.withSize(0.140625 * screenWidth)
        bestScoreLabel.font = bestScoreLabel.font.withSize(0.053125 * screenWidth)
        
        // setting labels
        
        if (addModeBool == true) {
            
            currentModeLabel.text = "addition mode"
            bestScoreNumberLabel.text = ("\(addModeBestScore)")
            bestScore = addModeBestScore
            
        } else if (subtractModeBool == true) {
            
            currentModeLabel.text = "subtraction mode"
            bestScoreNumberLabel.text = ("\(subtractModeBestScore)")
            bestScore = subtractModeBestScore
            
        } else if (multiplyModeBool == true) {
            
            currentModeLabel.text = "multiplication mode"
            bestScoreNumberLabel.text = ("\(multiplyModeBestScore)")
            bestScore = multiplyModeBestScore
            
        } else if (divideModeBool == true) {
            
            currentModeLabel.text = "division mode"
            bestScoreNumberLabel.text = ("\(divideModeBestScore)")
            bestScore = divideModeBestScore
            
        } else if (mixedModeBool == true) {
            
            currentModeLabel.text = "mixed mode"
            bestScoreNumberLabel.text = ("\(mixedModeBestScore)")
            bestScore = mixedModeBestScore
        }
        
        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        bottomContainerBottomConstraint.constant -= screenHeight
        
        currentScoreNumberRightConstraint.constant -= screenWidth
        currentScoreNumberLeftConstraint.constant += screenWidth
        
        yourScoreLabelRightConstraint.constant -= screenWidth
        yourScoreLabelLeftConstraint.constant += screenWidth
        
        
        // Setting statistics
        
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
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "scoresID") as! scoresViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        share(image: takeScreenshot()!)
    }
    
    
    func share(image: UIImage) {
        let message = "Hey, take a look at my score in the Do Math! game. http://itunes.apple.com/do-math!/id1412104753"
        let objectsToShare = [image as Any, message as Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        bottomContainerBottomConstraint.constant -= screenHeight
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        bottomContainerBottomConstraint.constant += screenHeight
        return screenshotImage
    }

    
    
    // MARK: Outlets

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentModeLabel: UILabel!


    
    @IBOutlet weak var bestScoreNumberLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    @IBOutlet weak var toMenuButton: UIButton!

    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!

    
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
    @IBOutlet weak var shareButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
