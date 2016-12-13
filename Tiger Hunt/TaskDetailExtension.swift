//
//  TaskDetailExtension.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import UIKit

extension TaskDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.taskImageView.contentMode = .scaleAspectFit
        self.taskImageView.image = chosenImage
        self.taskImageView.maskCircle(view: self.view)
        
        dismiss(animated:true, completion: nil)
        
        var data = NSData()
        data = UIImageJPEGRepresentation(self.taskImageView.image!, 0.8)! as NSData
        // set upload path
        let uid: String = (self.user?.getUID())!
        let filePath = "\(uid)/\("\(self.task.getID()).jpg")"
        
        let downloadURL = StorageService.storageService.uploadPhoto(filePath: filePath, data: data)
        self.task.setCompletedImageURL(downloadURL)
        
        self.insertCompletedTask(task: self.task)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
