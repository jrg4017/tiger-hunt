//
//  ProfileController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var user: User!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        self.picker.allowsEditing = false
        self.picker.sourceType = .photoLibrary
        self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(self.picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setpLogoutButton()
        
        self.picker.delegate = self
    }
    
    func setpLogoutButton() {
        let rightBtn = UIBarButtonItem(image: UIImage(named: "complete-task"), style: .plain, target: self, action: #selector(logout(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    func logout(sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        defaults.synchronize()
        
        self.switchRootController(storyboardName: "Login")
    }
    
    func setData() {
        self.nameLabel.text = self.user.getName()
        self.usernameLabel.text = "@\(self.user.getUsername())"
        self.emailLabel.text = self.user.getEmail()
        self.scoreLabel.text = " points"
        
        self.profilePicImageView.image = UIImage(named: "not-submitted.png")
        self.profilePicImageView.maskCircle(view: self.view)
    }
}
