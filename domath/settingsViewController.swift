//
//  settingsViewController.swift
//  domath
//
//  Created by Alex on 6/30/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import AVFoundation

class settingsViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        beigeColor = UserDefaults.standard.bool(forKey: "beigeColor")
        blueColor = UserDefaults.standard.bool(forKey: "blueColor")
        greyColor = UserDefaults.standard.bool(forKey: "greyColor")
        
        if (beigeColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBeige.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBeige10.png")
                view.backgroundColor = UIColor(red: 230/255, green: 221/255, blue: 191/255, alpha: 1)
            }
            secondColorButton.layer.borderWidth = 0
            thirdColorButton.layer.borderWidth = 0
            firstColorButton.layer.borderWidth = 4
            firstColorButton.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            settingsLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        } else if (blueColor == true) {
            backgroundImage.image = UIImage(named: "backgroundBlue8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundBlue10.png")
                view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
            }
            firstColorButton.layer.borderWidth = 0
            thirdColorButton.layer.borderWidth = 0
            secondColorButton.layer.borderWidth = 4
            secondColorButton.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
            titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
            settingsLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        } else if (greyColor == true) {
            backgroundImage.image = UIImage(named: "backgroundGrey8.png")
            if (screenHeight == 812) {
                backgroundImage.image = UIImage(named: "backgroundGrey10.png")
                view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
            secondColorButton.layer.borderWidth = 0
            firstColorButton.layer.borderWidth = 0
            thirdColorButton.layer.borderWidth = 4
            thirdColorButton.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
            titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
            settingsLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        }
        
        musicContainer.layer.cornerRadius = 20
        musicContainer.clipsToBounds = true
        
        vibrationContainer.layer.cornerRadius = 20
        vibrationContainer.clipsToBounds = true
        
        colorThemeContainer.layer.cornerRadius = 20
        colorThemeContainer.clipsToBounds = true
        
        
        // Loading settings
        
        vibrationOff = UserDefaults.standard.integer(forKey: "vibrationState")
        
        if (vibrationOff == 1) {
            vibrationSwitch.setOn(false, animated: true)
        }
        
        soundsOff = UserDefaults.standard.integer(forKey: "soundsState")
        
        if (soundsOff == 1) {
            soundsSwitch.setOn(false, animated: true)
        }
        
        // setting constraints
        
        if (screenHeight == 812) {
            titleLabelTopConstraint.constant = 40
        }
        
        musicContainerTopConstraint.constant = 0.235915493 * screenHeight
        musicContainerLeftConstraint.constant = 0.265625 * screenWidth
        musicContainerRightConstraint.constant = 0.265625 * screenWidth
        
        vibrationContainerTopConstraint.constant = 0.0211267606 * screenHeight
        vibrationContainerLeftConstraint.constant = 0.265625 * screenWidth
        vibrationContainerRightConstraint.constant = 0.265625 * screenWidth
        
        colorThemeContainerTopConstraint.constant = 0.0211267606 * screenHeight
        colorThemeContainerLeftConstraint.constant = 0.265625 * screenWidth
        colorThemeContainerRightConstraint.constant = 0.265625 * screenWidth
        
        musicLabelTopConstraint.constant = 0.014084507 * screenHeight
        musicLabelBottomConstraint.constant = 0.0052816901 * screenHeight
        
        vibrationLabelTopConstraint.constant = 0.014084507 * screenHeight
        vibrationLabelBottomConstraint.constant = 0.0052816901 * screenHeight
        
        firstColorButtonLeftConstraint.constant = 0.028125 * screenWidth
        firstColorButtonRightConstraint.constant = 0.028125 * screenWidth
        secondColorButtonRightConstraint.constant = 0.01875 * screenWidth
        firstColorButtonTopConstraint.constant = 0.014084507 * screenHeight
        secondColorButtonTopConstraint.constant = 0.014084507 * screenHeight
        thirdColorButtonLeftConstraint.constant = 0.01875 * screenWidth
        thirdColorButtonTopConstraint.constant = 0.014084507 * screenHeight
        colorThemeLabelTopConstraint.constant = 0.014084507 * screenHeight
        
        toMenuButtonLeftConstraint.constant = 0.453125 * screenWidth
        toMenuButtonRightConstraint.constant = 0.453125 * screenWidth
        
        let cornerRadiusToMenuButton = (screenWidth - 2 * 0.453125 * screenWidth) / 2
        toMenuButton.layer.masksToBounds = true
        toMenuButton.layer.cornerRadius = cornerRadiusToMenuButton
        
        let cornerRadius = screenWidth * (1 - 2 * 0.265625 -
                                2 * 0.028125 - 2 * 0.01875) / 3 / 2
        firstColorButton.layer.cornerRadius = cornerRadius
        secondColorButton.layer.cornerRadius = cornerRadius
        thirdColorButton.layer.cornerRadius = cornerRadius
        
        // setting font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        settingsLabel.font = settingsLabel.font.withSize(0.0375 * screenWidth)
        
        musicLabel.font = musicLabel.font.withSize(0.053125 * screenWidth)
        vibrationLabel.font = vibrationLabel.font.withSize(0.053125 * screenWidth)
        colorThemeLabel.font = colorThemeLabel.font.withSize(0.053125 * screenWidth)
        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        toMenuButtonBottomConstraint.constant -= screenHeight
        
        musicContainerRightConstraint.constant -= screenWidth
        musicContainerLeftConstraint.constant += screenWidth
        
        vibrationContainerRightConstraint.constant -= screenWidth
        vibrationContainerLeftConstraint.constant += screenWidth
        
        colorThemeContainerRightConstraint.constant -= screenWidth
        colorThemeContainerLeftConstraint.constant += screenWidth
        
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
        
        UIView.animate(withDuration: 0.6, delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.musicContainerRightConstraint.constant += screenWidth
                        self.musicContainerLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.vibrationContainerRightConstraint.constant += screenWidth
                        self.vibrationContainerLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.25,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.colorThemeContainerRightConstraint.constant += screenWidth
                        self.colorThemeContainerLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    // MARK: Actions
    

    @IBAction func vibrationSwitchToggled(_ sender: Any) {
        if vibrationSwitch.isOn {
            vibrationOff = 0
            UserDefaults.standard.set(vibrationOff, forKey: "vibrationState")
        } else {
            vibrationOff = 1
            UserDefaults.standard.set(vibrationOff, forKey: "vibrationState")
        }
    }
    
    @IBAction func soundsSwitchToggled(_ sender: Any) {
        if soundsSwitch.isOn {
            soundsOff = 0
            UserDefaults.standard.set(soundsOff, forKey: "soundsState")
        } else {
            soundsOff = 1
            UserDefaults.standard.set(soundsOff, forKey: "soundsState")
        }
    }
    
    
    @IBAction func toMenuButtonAction(_ sender: Any) {
        
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuID") as! ViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func firstColorButtonAction(_ sender: Any) {
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        blueColor = false
        beigeColor = true
        greyColor = false
        UserDefaults.standard.set(beigeColor, forKey: "beigeColor")
        UserDefaults.standard.set(blueColor, forKey: "blueColor")
        UserDefaults.standard.set(greyColor, forKey: "greyColor")
        
        backgroundImage.image = UIImage(named: "backgroundBeige.png")
        if (screenHeight == 812) {
            backgroundImage.image = UIImage(named: "backgroundBeige10.png")
            view.backgroundColor = UIColor(red: 230/255, green: 221/255, blue: 191/255, alpha: 1)
        }
        secondColorButton.layer.borderWidth = 0
        thirdColorButton.layer.borderWidth = 0
        firstColorButton.layer.borderWidth = 4
        //firstColorButton.layer.borderColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1).cgColor
        firstColorButton.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
        titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        settingsLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
    }
    
    @IBAction func secondColorButtonAction(_ sender: Any) {
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        blueColor = true
        beigeColor = false
        greyColor = false
        UserDefaults.standard.set(beigeColor, forKey: "beigeColor")
        UserDefaults.standard.set(blueColor, forKey: "blueColor")
        UserDefaults.standard.set(greyColor, forKey: "greyColor")
        
        backgroundImage.image = UIImage(named: "backgroundBlue8.png")
        if (screenHeight == 812) {
            backgroundImage.image = UIImage(named: "backgroundBlue10.png")
            view.backgroundColor = UIColor(red: 29/255, green: 28/255, blue: 65/255, alpha: 1)
        }
        firstColorButton.layer.borderWidth = 0
        thirdColorButton.layer.borderWidth = 0
        secondColorButton.layer.borderWidth = 4
        //secondColorButton.layer.borderColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1).cgColor
        secondColorButton.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
        titleLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        settingsLabel.textColor = UIColor(red: 114/255, green: 168/255, blue: 201/255, alpha: 1)
        
    }
    @IBAction func thirdColorButtonAction(_ sender: Any) {
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        blueColor = false
        beigeColor = false
        greyColor = true
        UserDefaults.standard.set(beigeColor, forKey: "beigeColor")
        UserDefaults.standard.set(blueColor, forKey: "blueColor")
        UserDefaults.standard.set(greyColor, forKey: "greyColor")
        backgroundImage.image = UIImage(named: "backgroundGrey8.png")
        if (screenHeight == 812) {
            backgroundImage.image = UIImage(named: "backgroundGrey10.png")
            view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
        firstColorButton.layer.borderWidth = 0
        secondColorButton.layer.borderWidth = 0
        thirdColorButton.layer.borderWidth = 4
        //thirdColorButton.layer.borderColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1).cgColor
        thirdColorButton.layer.borderColor = UIColor(red: 180/255, green: 90/255, blue: 88/255, alpha: 1).cgColor
        titleLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        settingsLabel.textColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var vibrationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var musicContainer: UIView!
    @IBOutlet weak var vibrationContainer: UIView!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicContainerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicContainerRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibrationContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibrationContainerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibrationContainerRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButton: UIButton!
    @IBOutlet weak var toMenuButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var musicLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibrationLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibrationLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var vibrationSwitch: UISwitch!
    @IBOutlet weak var soundsSwitch: UISwitch!
    
    @IBOutlet weak var firstColorButton: UIButton!
    @IBOutlet weak var secondColorButton: UIButton!
    @IBOutlet weak var firstColorButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstColorButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondColorButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstColorButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondColorButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorThemeContainer: UIView!
    @IBOutlet weak var colorThemeContainerLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorThemeContainerRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorThemeContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorThemeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorThemeLabel: UILabel!
    @IBOutlet weak var thirdColorButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdColorButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdColorButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
