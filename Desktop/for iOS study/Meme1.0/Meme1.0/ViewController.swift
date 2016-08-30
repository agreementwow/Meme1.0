//
//  ViewController.swift
//  Meme1.0
//
//  Created by liulei on 16/8/29.
//  Copyright © 2016年 liulei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 8
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }

    //pick an image from album
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .PhotoLibrary
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    //pick an image from camera
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .Camera
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelActions(sender: AnyObject) {
        imagePickerView.image = nil
    }
    
    //clear textfield when begin editing
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text = ""
        }
    }
    
    //dismiss the keyboard when pressing return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //keyboard adjustments
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
}

