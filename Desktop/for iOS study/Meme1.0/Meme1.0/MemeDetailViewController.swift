//
//  MemeDetailViewController.swift
//  Meme1.0
//
//  Created by liulei on 16/9/5.
//  Copyright © 2016年 liulei. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme : Meme!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 8
    ]
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var btmLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topLabel.text = meme.topText
        btmLabel.text = meme.btmText
        let topText = topLabel.text
        let btmText = btmLabel.text
        topLabel.attributedText = NSAttributedString(string: topText!, attributes: memeTextAttributes)
        btmLabel.attributedText = NSAttributedString(string: btmText!, attributes: memeTextAttributes)
        
        memedImage.image = meme.image
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(MemeDetailViewController.editImage))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    
    func editImage() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("createMeme") as! ViewController
        controller.editingMeme = meme
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
        
}