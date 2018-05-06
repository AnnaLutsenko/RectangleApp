//
//  DrawingViewController.swift
//  RectangleApp
//
//  Created by Anna on 05.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    // UI Elements
    var tapView: UIView?
    var rectView: UIView?
    
    /// Points
    var firstPoint: CGPoint?
    var secondPoint: CGPoint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
    func initController() {
        /// Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(tapGesture)
        
        /// Long Press Gesture
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        view.addGestureRecognizer(longPressGesture)
    }
    
    func createCircle() {
        guard let point = firstPoint else { return }
        let tapView = getTapView()
        tapView.center = point
        view.addSubview(tapView)
        self.tapView = tapView
    }
    
    func getTapView() -> UIView {
        let tapView = UIView()
        tapView.frame.size = CGSize(width: Constant.Tap.size, height: Constant.Tap.size)
        tapView.backgroundColor = UIColor.customGrey
        tapView.layer.cornerRadius = CGFloat(Constant.Tap.size/2)
        return tapView
    }
    
    func createRectangle() {
        guard let point1 = firstPoint,
            let point2 = secondPoint else { return }
        //
        let absX = abs(point1.x - point2.x)
        let absY = abs(point1.y - point2.y)
        let width = absX < 100 ? 100 : absX
        let height = absY < 100 ? 100 : absY
        //
        let frame = CGRect(x: min(point1.x, point2.x), y: min(point1.y, point2.y), width: width, height: height)
        let rectangle = RectangleView(frame: frame)
        //
        view.addSubview(rectangle)
        //
        firstPoint = nil
        secondPoint = nil
        tapView?.removeFromSuperview()
    }
        
}
