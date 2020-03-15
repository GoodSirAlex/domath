//
//  ViewController.swift
//  domath
//
//  Created by Alex on 6/29/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // MARK: Setting color theme
        
        beigeColor = UserDefaults.standard.bool(forKey: "beigeColor")
        blueColor = UserDefaults.standard.bool(forKey: "blueColor")
        greyColor = UserDefaults.standard.bool(forKey: "greyColor")
        
        if (beigeColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBeige.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBeige10.png")
                view.backgroundColor = UIColor(red: 230/255, green: 221/255, blue: 191/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            subtitleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            selectModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        } else if (blueColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBlue8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBlue10.png")
                view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            subtitleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            selectModeLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        } else if (greyColor == true) {
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            subtitleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            selectModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        } else {
            greyColor = true
            UserDefaults.standard.set(greyColor, forKey: "greyColor")
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            subtitleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            selectModeLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
        
        soundsOff = UserDefaults.standard.integer(forKey: "soundsState")
        
        
        // Top label font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        subtitleLabel.font = subtitleLabel.font.withSize(0.0375 * screenWidth)
        
        if (screenHeight == 812) {
            titleLabelTopConstraint.constant = 40
        }
        
        addModeButton.layer.masksToBounds = true
        addModeButton.layer.cornerRadius = 0.3 * addModeButton.frame.height
        subtractModeButton.layer.masksToBounds = true
        subtractModeButton.layer.cornerRadius = 0.3 * subtractModeButton.frame.height
        multiplyModeButton.layer.masksToBounds = true
        multiplyModeButton.layer.cornerRadius = 0.3 * multiplyModeButton.frame.height
        divideModeButton.layer.masksToBounds = true
        divideModeButton.layer.cornerRadius = 0.3 * divideModeButton.frame.height
        mixedModeButton.layer.masksToBounds = true
        mixedModeButton.layer.cornerRadius = 0.3 * mixedModeButton.frame.height
        
        selectModeLabelBottomConstraint.constant = 0.0211267606 * screenHeight
        selectModeLabelLeftConstraint.constant = 0.265625 * screenWidth
        selectModeLabelRightConstraint.constant = 0.265625 * screenWidth
        selectModeLabel.font = selectModeLabel.font.withSize(0.04375 * screenWidth)
        
        constraintBetweenAddAndSubtract.constant = 0.03125 * screenWidth
        constraintBetweenDivideAndMultiply.constant = 0.03125 * screenWidth
        addButtonLeftConstraint.constant = 0.265625 * screenWidth
        subtractButtonRightConstraint.constant = 0.265625 * screenWidth
        divideButtonLeftConstraint.constant = 0.265625 * screenWidth
        multiplyButtonRightConstraint.constant = 0.265625 * screenWidth
        mixedButtonLeftConstraint.constant = 0.265625 * screenWidth
        mixedButtonRightConstraint.constant = 0.265625 * screenWidth
        
        addButtonBottomConstraint.constant = 0.0211267606 * screenHeight
        subtractButtonBottomConstraint.constant = 0.0211267606 * screenHeight
        divideButtonTopConstraint.constant = 0.0211267606 * screenHeight
        multiplyButtonTopConstraint.constant = 0.0211267606 * screenHeight
        
        
        bottomContainerLeftConstraint.constant = 0.125 * screenWidth
        bottomContainerRightConstraint.constant = 0.125 * screenWidth
        
        informationButtonLeftConstraint.constant = 0.053125 * screenWidth
        informationButtonRightConstraint.constant = 0.18125 * screenWidth
        awardsButtonLeftConstraint.constant = 0.18125 * screenWidth
        awardsButtonRightConstraint.constant = 0.053125 * screenWidth
        
        
        let cornerRadius = screenWidth * (1 - 2 * 0.125 - 2 * 0.053125 - 2 * 0.18125) / 3 / 2
        
        informationButton.layer.masksToBounds = true
        informationButton.layer.cornerRadius = cornerRadius
        settingsButton.layer.masksToBounds = true
        settingsButton.layer.cornerRadius = cornerRadius
        awardsButton.layer.masksToBounds = true
        awardsButton.layer.cornerRadius = cornerRadius
        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        bottomContainerBottomConstraint.constant -= screenHeight
        
        mixedButtonRightConstraint.constant -= screenWidth
        mixedButtonLeftConstraint.constant += screenWidth
        
        selectModeLabelRightConstraint.constant -= screenWidth
        selectModeLabelLeftConstraint.constant += screenWidth
        
        addButtonLeftConstraint.constant -= screenWidth
        subtractButtonRightConstraint.constant += screenWidth
        divideButtonLeftConstraint.constant -= screenWidth
        multiplyButtonRightConstraint.constant += screenWidth
        
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
        
        UIView.animate(withDuration: 0.8, delay: 0.4,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.mixedButtonRightConstraint.constant += screenWidth
                        self.mixedButtonLeftConstraint.constant -= screenWidth
                        self.selectModeLabelRightConstraint.constant += screenWidth
                        self.selectModeLabelLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.4,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: [], animations: {
                        self.subtractButtonRightConstraint.constant -= screenWidth
                        self.multiplyButtonRightConstraint.constant -= screenWidth
                        self.addButtonLeftConstraint.constant += screenWidth
                        self.divideButtonLeftConstraint.constant += screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)

        
    }
    
    
    
    
    @IBAction func addModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        addModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameID") as! gameViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    @IBAction func subtractModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        subtractModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameID") as! gameViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    @IBAction func multiplyModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        multiplyModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameID") as! gameViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func divideModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        divideModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameID") as! gameViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func mixedModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        mixedModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameID") as! gameViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    
    @IBAction func settingsButtonAction(_ sender: Any) {
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "settingsID") as! settingsViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    @IBAction func informationButtonAction(_ sender: Any) {
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "aboutID") as! aboutViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func awardsButtonAction(_ sender: Any) {
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "scoresID") as! scoresViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addModeButton: UIButton!
    @IBOutlet weak var subtractModeButton: UIButton!
    @IBOutlet weak var divideModeButton: UIButton!
    @IBOutlet weak var multiplyModeButton: UIButton!
    @IBOutlet weak var mixedModeButton: UIButton!
    
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var awardsButton: UIButton!
    
    
    @IBOutlet weak var constraintBetweenAddAndSubtract: NSLayoutConstraint!
    @IBOutlet weak var constraintBetweenDivideAndMultiply: NSLayoutConstraint!
    @IBOutlet weak var addButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtractButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var multiplyButtonRightConstraint: NSLayoutConstraint!
        @IBOutlet weak var divideButtonLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtractButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var divideButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var multiplyButtonTopConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var bottomContainerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerRightConstraint: NSLayoutConstraint!
        @IBOutlet weak var informationButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var informationButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var awardsButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var awardsButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mixedButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var mixedButtonRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomContainerBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var selectModeLabel: UILabel!
    @IBOutlet weak var selectModeLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectModeLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectModeLabelRightConstraint: NSLayoutConstraint!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

