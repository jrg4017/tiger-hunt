//
//  ProfileController.swift
//  Tiger Hunt
//
//  Created by Julianna Gabler on 12/11/16.
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let SIGNOUT_ERROR_TITLE: String = "Sign Out Error"
    let SIGNOUT_ERROR_MSG: String = " Hmm, something went wrong. Try again later."
    
    var user: User?
    
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
        try! FIRAuth.auth()?.signOut()
        self.switchRootController(storyboardName: "Login")
    }
    
    func setData() {
        self.user = self.getUser()
        
        self.nameLabel.text = self.user?.getName()
        self.usernameLabel.text = "\(self.user?.getDateJoined())"
        self.emailLabel.text = self.user?.getEmail()
        self.scoreLabel.text = "\(self.user?.getTotalPoints()) points"
        
        self.profilePicImageView.image = UIImage(named: "not-submitted.png")
        
        self.profilePicImageView.maskCircle(view: self.view)
    }
}
