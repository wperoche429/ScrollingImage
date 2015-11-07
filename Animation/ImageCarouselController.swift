//
//  ImageCarouselController.swift
//  AUTStudent
//
//  Created by Eddie Chae on 3/11/15.
//  Copyright © 2015 Datacom. All rights reserved.
//

import Foundation
import UIKit

class ImageCarouselController {
    
    
    // MARK: Properties
    
    
    var baseView: UIView
    var backgroundImages: [UIImage?]
    var movementAnimationDuration: NSTimeInterval
    var transitionAnimationDuration: NSTimeInterval
    
    
    // MARK: Background ImageViews
    
    
    var backgroundImageViews: [UIImageView] = []
    let backgroundImageViewA : UIImageView = UIImageView()
    let backgroundImageViewB : UIImageView = UIImageView()

    
    // MARK: ImageView and Image Pointers
    
    
    var imageViewPos: Int = 0
    var ImagePos: Int = 0

    
    // MARK: Init
    
    
    init(baseView: UIView, backgroundImages: [UIImage?], movementAnimationDuration: NSTimeInterval = 30, transitionAnimationDuration: NSTimeInterval = 6) {
        // Assign Properties
        self.baseView = baseView
        self.backgroundImages = backgroundImages
        self.movementAnimationDuration = movementAnimationDuration
        self.transitionAnimationDuration = transitionAnimationDuration
        
        // Initialise baseView to correctly fit images
        self.baseView.layoutIfNeeded()
        self.baseView.clipsToBounds = true

        // Setup ImageViews
        setupImageViews()
    }
    
    // Setup ImageViews to be animated
    func setupImageViews() {
        // Adds the 2 background ImageViews to baseView
        backgroundImageViews.append(backgroundImageViewA)
        backgroundImageViews.append(backgroundImageViewB)
        self.baseView.addSubview(backgroundImageViews[imageViewPos + 1])
        self.baseView.addSubview(backgroundImageViews[imageViewPos])
        
        // Setup initial background ImageView
//        backgroundImageViews[0].resizeWithImage(backgroundImages[ImagePos]!, toFitView: self.baseView)
//        backgroundImageViews[0].addGradientLayer(UIColor.clearColor(), toColor: UIColor.blackColor())
    }
    
    
    // MARK: Start Animation
    
    
    // Call this method to initiate the carousel
    func startImageCarousel() {
        animateMovement(nil)
    }
    
    
    // MARK: Timer Animation
    
    
    // Animates the horizontal movement of the background ImageViews
    @objc private func animateMovement(val: NSTimer?) {
        UIView.animateWithDuration(
            movementAnimationDuration,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
                self.backgroundImageViews[self.imageViewPos].frame =
                    CGRectMake(-self.backgroundImageViews[self.imageViewPos].bounds.width + self.baseView.bounds.width,
                        0,
                        self.backgroundImageViews[self.imageViewPos].bounds.width,
                        self.backgroundImageViews[self.imageViewPos].bounds.height)

                // Start timer functions for continuous flow of carousel
                _ = NSTimer.scheduledTimerWithTimeInterval((self.movementAnimationDuration - self.transitionAnimationDuration), target: self, selector: "setupNextImageView:", userInfo: nil, repeats: false)
                _ = NSTimer.scheduledTimerWithTimeInterval((self.movementAnimationDuration - self.transitionAnimationDuration), target: self, selector: "animateTransition:", userInfo: nil, repeats: false)
                _ = NSTimer.scheduledTimerWithTimeInterval((self.movementAnimationDuration - self.transitionAnimationDuration), target: self, selector: "animateMovement:", userInfo: nil, repeats: false)
            },
            completion: nil
        )
    }

    // Sets up the next background ImageView with the next image and updates the position pointers
    @objc private func setupNextImageView(val: NSTimer) {
        // Update pointer values for Image and ImageViews
        self.ImagePos = (self.ImagePos + 1) % self.backgroundImages.count
        self.imageViewPos = 1 - self.imageViewPos
        
        // Set up next ImageView with next image
//        self.backgroundImageViews[self.imageViewPos].resizeWithImage(self.backgroundImages[self.ImagePos]!, toFitView: self.baseView)
//        self.backgroundImageViews[self.imageViewPos].addGradientLayer(UIColor.clearColor(), toColor: UIColor.blackColor())
    }
    
    // Animates the transition between the 2 background ImageViews
    @objc private func animateTransition(val: NSTimer?) {
        UIView.animateWithDuration(
            self.transitionAnimationDuration,
            animations: { () -> Void in
                self.backgroundImageViews[1 - self.imageViewPos].alpha = 0
                self.backgroundImageViews[self.imageViewPos].alpha = 1
            },
            completion: nil
        )
    }

    
}
