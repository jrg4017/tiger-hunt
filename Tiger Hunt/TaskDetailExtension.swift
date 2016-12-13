//
//  TaskDetailExtension.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit
import Photos
import FirebaseStorage

extension TaskDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let capturedImage = self.resizeImage(info)
        
        // set upload path
        let uid: String = (self.user?.getUID())!
        let filePath = "\(uid)/\("\(self.task.getID()).jpg")"
        let downloadURL = self.uploadImage(capturedImage, self.taskImageView, filePath: filePath)

        self.task.setCompletedImageURL(downloadURL)
        
        self.insertCompletedTask(task: self.task)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
