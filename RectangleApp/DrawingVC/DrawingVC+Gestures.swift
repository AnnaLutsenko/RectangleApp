//
//  DrawingVC+Gestures.swift
//  RectangleApp
//
//  Created by Anna on 05.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit
import Foundation

extension DrawingViewController: UIGestureRecognizerDelegate  {
    
    /**
     UITapGestureRecognizer - Taping on Objects
     Will make scale scale Effect
     Selecting transparent parts of the imageview won't move the object
     */
    @objc func tapGesture(_ recognizer: UITapGestureRecognizer) {

        for v in view.subviews {
            if v.point(inside: recognizer.location(in: v), with: nil), firstPoint == nil  {
                return
            }
        }
        if firstPoint == nil {
            firstPoint = recognizer.location(in: self.view)
            createCircle()
        } else {
            secondPoint = recognizer.location(in: self.view)
            createRectangle()
        }
        
    }
    
    /**
     UILongPressGestureRecognizer - LongTap on Objects
     Will create rectangle view
     */
    @objc func longPressGesture(_ recognizer: UILongPressGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            firstPoint = recognizer.location(in: view)
            let frame = CGRect(x: recognizer.location(in: view).x, y: recognizer.location(in: view).y, width: 0, height: 0)
            rectView = RectangleView(frame: frame)
            view.addSubview(rectView!)
        case .changed:
            
            guard let v = rectView,
                let startPoint = firstPoint else { return }
            let width = recognizer.location(in: view).x - startPoint.x
            let height = recognizer.location(in: view).y - startPoint.y
            
            var origin: CGPoint = .zero
            origin.x = width < 0 ? startPoint.x - abs(width) : startPoint.x
            origin.y = height < 0 ? startPoint.y - abs(height) : startPoint.y
            
            var frame = CGRect.zero
            frame.origin = origin
            frame.size = CGSize(width: abs(width), height: abs(height))
            v.frame = frame
            
        case .ended:
            rectView = nil
            firstPoint = nil 
        default:
            break
        }
    }
    
    /*
     Support Multiple Gesture at the same time
     */
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    // to Override Control Center screen edge pan from bottom
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
}


