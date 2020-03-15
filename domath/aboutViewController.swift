//
//  aboutViewController.swift
//  domath
//
//  Created by Alex on 6/30/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import UIKit
import AVFoundation

class aboutViewController: UIViewController {

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
        
        informationLabel.layer.masksToBounds = true
        informationLabel.layer.cornerRadius = 15
        versionLabel.layer.masksToBounds = true
        versionLabel.layer.cornerRadius = 10
        facebookButton.layer.cornerRadius = 10
        
        
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
        
        facebookButtonTopConstraint.constant = 0.014084507 * screenHeight
        facebookButtonLeftConstraint.constant = 0.265625 * screenWidth
        facebookButtonRightConstraint.constant = 0.265625 * screenWidth
        
        
        toMenuButtonLeftConstraint.constant = 0.453125 * screenWidth
        toMenuButtonRightConstraint.constant = 0.453125 * screenWidth
        
        let cornerRadius = (screenWidth - 2 * 0.453125 * screenWidth) / 2
        toMenuButton.layer.masksToBounds = true
        toMenuButton.layer.cornerRadius = cornerRadius
        
        
        // Setting font resizing
        
        titleLabel.font = titleLabel.font.withSize(0.078125 * screenWidth)
        currentModeLabel.font = currentModeLabel.font.withSize(0.0375 * screenWidth)
        
        informationLabel.font = informationLabel.font.withSize(0.05 * screenWidth)
        versionLabel.font = versionLabel.font.withSize(0.05 * screenWidth)
        facebookButton.titleLabel?.font =  UIFont(name: "Chalkboard SE", size: 0.05 * screenWidth)
        
        // Preparing Animation
        
        titleLabelTopConstraint.constant -= screenHeight
        toMenuButtonBottomConstraint.constant -= screenHeight
        
        currentScoreNumberRightConstraint.constant -= screenWidth
        currentScoreNumberLeftConstraint.constant += screenWidth
        
        yourScoreLabelRightConstraint.constant -= screenWidth
        yourScoreLabelLeftConstraint.constant += screenWidth
        
        facebookButtonRightConstraint.constant -= screenWidth
        facebookButtonLeftConstraint.constant += screenWidth
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
                        self.currentScoreNumberRightConstraint.constant += screenWidth
                        self.currentScoreNumberLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.yourScoreLabelRightConstraint.constant += screenWidth
                        self.yourScoreLabelLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.25,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: {
                        self.facebookButtonRightConstraint.constant += screenWidth
                        self.facebookButtonLeftConstraint.constant -= screenWidth
                        self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    @IBAction func toMenuButtonAction(_ sender: Any) {
        if (soundsOff == 0) {
            AudioServicesPlaySystemSound(SystemSoundID(1306))
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menuID") as! ViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        UIApplication.tryURL(urls: [
            "fb://profile/Do-Math-Game-174524046752758", // App
            "http://www.facebook.com/Do-Math-Game-174524046752758" // Website if app fails
            ])
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentModeLabel: UILabel!
    
    
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    @IBOutlet weak var toMenuButton: UIButton!
    
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var currentScoreNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentScoreNumberLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentScoreNumberRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yourScoreLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var yourScoreLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var yourScoreLabelRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var toMenuButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var toMenuButtonRightConstraint: NSLayoutConstraint!

    @IBOutlet weak var toMenuButtonBottomConstraint: NSLayoutConstraint!
    

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var facebookButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var facebookButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var facebookButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.openURL(URL(string: url)!)
                return
            }
        }
    }
}
