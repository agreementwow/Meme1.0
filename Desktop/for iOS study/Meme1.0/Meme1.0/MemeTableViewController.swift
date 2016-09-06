//
//  MemeTableViewController.swift
//  Meme1.0
//
//  Created by liulei on 16/9/5.
//  Copyright © 2016年 liulei. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeReuseTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.memeImage.image = meme.memedImage
        cell.topText.text = meme.topText
        cell.btmText.text = meme.btmText
        return cell
    }
    
    @IBAction func addImages(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("createMeme")
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewID") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        controller.meme = meme
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
}