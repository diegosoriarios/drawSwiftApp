//
//  ViewController.swift
//  draw
//
//  Created by diego.rios on 18/01/19.
//  Copyright © 2019 diego.rios. All rights reserved.
//

import UIKit

class Canvas: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.round)
        
        lines.forEach{ (line) in
            for(i, p) in line.enumerated(){
                if i == 0 {
                    context.move(to: p)
                }else{
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
    
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {
    
    let canvas = Canvas()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
    }


}

