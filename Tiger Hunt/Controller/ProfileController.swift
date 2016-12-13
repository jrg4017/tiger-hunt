//
//  ProfileController.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    // MARK: - PROPERTIES
    let picker = UIImagePickerController()
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var user: User?
    
    // MARK: - IBACTION
    @IBAction func uploadPhoto(_ sender: UIButton) {
        self.picker.allowsEditing = false
        self.picker.sourceType = .photoLibrary
        self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(self.picker, animated: true, completion: nil)
    }

    @IBAction func deleteUser(_ sender: AnyObject) {
        DataService.dataService.removeUser(self.user!)
        FIRAuth.auth()?.currentUser?.delete(completion: {action in
            self.switchRootController(storyboardName: "Login")
        })
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = "\(self.user?.getUID())"
        
        StorageService.storageService.downLoadPhoto(uid: uid, photoID: uid, imageView: self.profilePicImageView, view: self.view)
        
        setData()
        setpLogoutButton()
        
        self.picker.delegate = self
    }

    
    // MARK: - HELPER FUNCS
    func setpLogoutButton() {
        let rightBtn = UIBarButtonItem(image: UIImage(named: "complete-task"), style: .plain, target: self, action: #selector(logout(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    func logout(sender: UIBarButtonItem) {
        try! FIRAuth.auth()?.signOut()
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: ("uid"))
        defaults.synchronize()
        
        self.switchRootController(storyboardName: "Login")
    }
    
    func setData() {
        loadUser()
        
        self.nameLabel.text = self.user?.getName()
        self.emailLabel.text = self.user?.getEmail()
        self.scoreLabel.text = "\(self.user?.getTotalPoints()) points"
        
    }
    
    func loadUser() {
        let firUser = FIRAuth.auth()?.currentUser
        
        //single update of name and email
        DataService.dataService.USERS_REF.child((firUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
           
            self.nameLabel.text = name
            self.emailLabel.text = firUser?.email
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //continual update of current points
        DataService.dataService.USERS_REF.child((firUser?.uid)!).observe(.value,  with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let totalPoints = value?["totalPoints"] as? Int ?? 0
            
            self.scoreLabel.text = "\(totalPoints) points"
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
