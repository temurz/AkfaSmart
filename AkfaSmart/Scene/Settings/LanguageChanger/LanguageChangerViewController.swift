//
//  LanguageChangerViewController.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 16/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import UIKit

class LanguageChangerView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a new button with the title "Tap me!"
        let tapMeButton = UIButton(frame: CGRect(x: 10, y: 10, width: 200, height: 50))
        tapMeButton.setTitle("Tap me!", for: .normal)
        
        // Set the background color of the button
        tapMeButton.backgroundColor = UIColor.blue
        
        // Add a target function that will be called when the button is tapped
        tapMeButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        // Add the button to the view hierarchy
        self.view.addSubview(tapMeButton)
    }
    
    @objc func buttonPressed() {
        print("The button has been pressed!")
    }
}

