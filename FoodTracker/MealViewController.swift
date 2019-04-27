//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Iury Miguel on 20/04/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

/*
 !!! The UITextFieldDelegate protocol defines eight optional methods. Just implement the ones you need to get the behaviors you desire. For now, you’ll need to implement two of these methods
 */

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    // Aspect ratio lets it always square. 1:1
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // ISSO AQUI É UMA CALLBACK!!!!
        ratingControl.setOnRatingChangedListener(listener: { (rating) in
            print("New Rating: \(rating)")
        })
    }

    //MARK: Actions
//    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        mealNameLabel.text = "Default Text"
//    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true // If the system must process return button press.
    }
    // It is called when textField.resignFirstResponder() is invoked.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    /**
     A image view is not a control, it is a view. So, it is necessary to
     insert a tap gesture recognizer in order to set the action method below.
     Control - TextFields, Buttons, etc.
     View - Label, ImageView, etc.
     */
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}

