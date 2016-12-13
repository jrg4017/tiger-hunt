//
//  ProfileVCExtension.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import FirebaseAuth

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let capturedImage = self.resizeImage(info)
        
        // set upload path
        let uid = FIRAuth.auth()?.currentUser?.uid
        let filePath = "\(uid)/profile.jpg"
        self.uploadImage(capturedImage, self.profilePicImageView, filePath: filePath)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
