//
//  MemeCollectionViewController.swift
//  Meme1.0
//
//  Created by liulei on 16/9/4.
//  Copyright © 2016年 liulei. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var memeFlowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustFlowLayout()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeReuseCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.backgroundImage.image = meme.memedImage
        return cell
    }
    
    @IBAction func addImages(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("createMeme")
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        adjustFlowLayout()
    }
    
    func adjustFlowLayout() {
        let space:CGFloat = 2.0
        let frameSize = self.view.frame.size
        let shorterSide = min(frameSize.height, frameSize.width)
        let dimension = (shorterSide - (2 * space)) / 3.0
        memeFlowLayout.minimumInteritemSpacing = space
        memeFlowLayout.minimumLineSpacing = space
        memeFlowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewID") as! MemeDetailViewController
        let meme = memes[indexPath.item]
        controller.meme = meme
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
}