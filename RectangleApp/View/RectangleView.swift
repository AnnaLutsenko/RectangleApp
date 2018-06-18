//
//  RectangleView.swift
//  RectangleApp
//
//  Created by Anna on 06.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class RectangleView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.customGrey
        //
        addGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addGestures() {
        isUserInteractionEnabled = true
        
        /// Pan Gesture (for moving view)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
        
        /// Double Tap Gesture
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGesture)
        
        /// Long Press Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        addGestureRecognizer(longPressGesture)
        
        /// Rotation Gesture
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGesture(_:)))
        addGestureRecognizer(rotationGesture)
        
        /// Pinch Gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self,
                                                    action: #selector(pinchGesture(_:)))
        addGestureRecognizer(pinchGesture)
    }
    
    /**
     UIPanGestureRecognizer - Moving Objects
     */
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        if let view = recognizer.view {
            moveView(view: view, recognizer: recognizer)
        }
    }
    
    /**
     UILongPressGestureRecognizer - LongTap on Objects
     Will change color of view
     */
    @objc func longPressGesture(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began else { return }
        //
        if let view = recognizer.view {
            view.backgroundColor = UIColor.getRandomColor()
        }
    }
    
    /**
     UITapGestureRecognizer - Double Tap on Objects
     Will delete object
     */
    @objc func doubleTapGesture(_ recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            view.removeFromSuperview()
        }
    }
    
    /**
     UIRotationGestureRecognizer - Rotating Objects
     */
    @objc func rotationGesture(_ recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    /**
     UIPinchGestureRecognizer - Pinching Objects
     */
    @objc func pinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view,
            recognizer.numberOfTouches == 2 {
            
            //
            let p1 = recognizer.location(ofTouch: 0, in: self)
            let p2 = recognizer.location(ofTouch: 1, in: self)
            
            let absolutePoint = CGPoint(x: p2.x - p1.x, y: p2.y - p1.y)
            let radians = atan2(Double(absolutePoint.x), Double(absolutePoint.y))
            
            let absRad = fabs(radians)
            
            if absRad > .pi/3 && absRad < 2*(.pi/3) {
                // increase in X direction
                view.transform = view.transform.scaledBy(x: recognizer.scale, y: 1)
            } else if absRad > 2*(.pi/3) && absRad < 5*(.pi/6) {
                view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            } else {
                // increase in Y direction
                view.transform = view.transform.scaledBy(x: 1, y: recognizer.scale)
            }
            
            recognizer.scale = 1
        }
    }
    
    /**
     Moving Objects
     */
    
    func moveView(view: UIView, recognizer: UIPanGestureRecognizer)  {
        
        view.superview?.bringSubview(toFront: view)
        let superLocation = recognizer.location(in: view.superview)
        view.center = superLocation
    }
}
