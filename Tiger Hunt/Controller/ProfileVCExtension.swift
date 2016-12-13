//
//  ProfileVCExtension.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profilePicImageView.contentMode = .scaleAspectFit
        self.profilePicImageView.image = chosenImage
        self.profilePicImageView.maskCircle(view: self.view)
        
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
