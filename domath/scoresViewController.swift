//
//  scoresViewController.swift
//  domath
//
//  Created by Alex on 6/30/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import AVFoundation

class scoresViewController: UIViewController {

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
            subtitleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            guessLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            
        } else if (blueColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBlue8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBlue10.png")
                view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            subtitleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            guessLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)

        } else if (greyColor == true) {
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            subtitleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            guessLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }

        
        // Top label font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        subtitleLabel.font = subtitleLabel.font.withSize(0.0375 * screenWidth)
        guessLabel.font = guessLabel.font.withSize(0.04375 * screenWidth)

        if (screenHeight == 812) {
            titleLabelTopConstraint.constant = 40
        }
        
        addModeButton.layer.cornerRadius = 0.3 * addModeButton.frame.height
        subtractModeButton.layer.cornerRadius = 0.3 * subtractModeButton.frame.height
        multiplyModeButton.layer.cornerRadius = 0.3 * multiplyModeButton.frame.height
        divideModeButton.layer.cornerRadius = 0.3 * divideModeButton.frame.height
        mixedModeButton.layer.cornerRadius = 0.3 * mixedModeButton.frame.height
        
        guessLabelLeftConstraint.constant = 0.21875 * screenWidth
        guessLabelRightConstraint.constant = 0.21875 * screenWidth
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
        
        guessLabelBottomConstraint.constant = 0.0211267606 * screenHeight
        
        toMenuButtonLeftConstraint.constant = 0.453125 * screenWidth
        toMenuButtonRightConstraint.constant = 0.453125 * screenWidth
        
        let cornerRadius = (screenWidth - 2 * 0.453125 * screenWidth) / 2
        toMenuButton.layer.masksToBounds = true
        toMenuButton.layer.cornerRadius = cornerRadius
        
        // Setting scores
        
        addModeBestScore = UserDefaults.standard.integer(forKey: "addModeBestScore")
        subtractModeBestScore = UserDefaults.standard.integer(forKey: "subtractModeBestScore")
        multiplyModeBestScore = UserDefaults.standard.integer(forKey: "multiplyModeBestScore")
        divideModeBestScore = UserDefaults.standard.integer(forKey: "divideModeBestScore")
        mixedModeBestScore = UserDefaults.standard.integer(forKey: "mixedModeBestScore")
        
        addModeButton.setTitle("\(addModeBestScore)", for: .normal)
        subtractModeButton.setTitle("\(subtractModeBestScore)", for: .normal)
        multiplyModeButton.setTitle("\(multiplyModeBestScore)", for: .normal)
        divideModeButton.setTitle("\(divideModeBestScore)", for: .normal)
        mixedModeButton.setTitle("\(mixedModeBestScore)", for: .normal)

        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        toMenuButtonBottomConstraint.constant -= screenHeight
        
        mixedButtonRightConstraint.constant -= screenWidth
        mixedButtonLeftConstraint.constant += screenWidth
        
        guessLabelRightConstraint.constant -= screenWidth
        guessLabelLeftConstraint.constant += screenWidth
        
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
                        self.toMenuButtonBottomConstraint.constant += screenHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.4,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.mixedButtonRightConstraint.constant += screenWidth
                        self.mixedButtonLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.8, delay: 0.4,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.guessLabelRightConstraint.constant += screenWidth
                        self.guessLabelLeftConstraint.constant -= screenWidth
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
    
    
    
    // MARK: Actions
    
    @IBAction func addModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        addModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "particularScoreID") as! particularScoreViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func subtractModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        subtractModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "particularScoreID") as! particularScoreViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func divideModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        divideModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "particularScoreID") as! particularScoreViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func multiplyModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        multiplyModeBool = true

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "particularScoreID") as! particularScoreViewController
        self.present(newViewController, animated: false, completion: nil)
        
    }
    
    @IBAction func mixedModeButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        mixedModeBool = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "particularScoreID") as! particularScoreViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func toMenuButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuID") as! ViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addModeButton: UIButton!
    @IBOutlet weak var subtractModeButton: UIButton!
    @IBOutlet weak var divideModeButton: UIButton!
    @IBOutlet weak var multiplyModeButton: UIButton!
    @IBOutlet weak var mixedModeButton: UIButton!
    
    @IBOutlet weak var toMenuButton: UIButton!
    
    
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
    
    
    @IBOutlet weak var toMenuButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mixedButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var mixedButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var guessLabelBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var guessLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var guessLabelRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
