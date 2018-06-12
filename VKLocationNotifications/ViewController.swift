//
//  ViewController.swift
//  VKLocationNotifications
//
//  Created by Vamshi Krishna on 26/05/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

//Trigger a notification when a user enters particular region
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        VKNotificationService.sharedInstance.authorizeUser()
        CoreLocationService.sharedInstance.authorizeUser()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("internalNotification.enteredRegion"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAction(_:)),
                                               name: NSNotification.Name("internalNotification.handleAction"),
                                               object: nil)
        
    }
    
    @IBAction func triggerNotification(_ sender: Any) {
        CoreLocationService.sharedInstance.updateLocation()
    }
    
    @objc
    func didEnterRegion() {
        VKNotificationService.sharedInstance.locationRequest()
    }
    
    @objc
    func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionID else { return }
        switch action {
        case .location: changeBackground()
        }
    }
    
    func changeBackground() {
        view.backgroundColor = .green
    }
}

