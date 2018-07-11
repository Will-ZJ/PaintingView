//
//  PaintingV.swift
//  PaintingTest
//
//  Created by Will on 2018/7/11.
//  Copyright © 2018年 Will. All rights reserved.
//

import UIKit

class PaintingV: UIView {

    private var lastLayer: CAShapeLayer!
    private var lastPath: UIBezierPath!
    private var layers: [CAShapeLayer]!
    private var cancelLayers: [CAShapeLayer]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layers = []
        cancelLayers = []
        initButtons(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - private mothods
    func initButtons(frame: CGRect) {
        let titles = ["删除","撤销","恢复"]
        let BtnW = frame.width / 3
        for i in 0 ..< titles.count {
            let button = UIButton()
            button.tag = 100 + i
            
            button.frame = CGRect(x: BtnW * CGFloat(i), y: 20, width: BtnW, height: 30)
            
            button.setTitle(titles[i], for: .normal)
            
            button.setTitleColor(UIColor.blue, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .highlighted)
            
            button.addTarget(self, action: #selector(click(button:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    // 获取点
    func pointWithTouches(touches: Set<UITouch>) -> CGPoint {
        let touch = (touches as NSSet).anyObject()
        return ((touch as! UITouch).location(in: self))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = ((touches as NSSet).anyObject() as! UITouch).location(in: self)
        if event?.allTouches?.count == 1 {
            moveToStartPoint(startPoint: point)
        }

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point = ((touches as NSSet).anyObject() as! UITouch).location(in: self)
        if  point.x > 0 && point.x < self.bounds.width && point.y > 0 && point.y < self.bounds.height && event?.allTouches?.count == 1
           {
            lastPath?.addLine(to: point)
            lastLayer?.path = lastPath?.cgPath
           }
    }
    func moveToStartPoint(startPoint:CGPoint){
        let bezierpath = UIBezierPath()

        bezierpath.lineWidth = 2
        bezierpath.lineCapStyle = .round
        bezierpath.lineJoinStyle = .round
        bezierpath.move(to: startPoint)
        lastPath = bezierpath
        
        let shaperlayer = CAShapeLayer()
        shaperlayer.path = bezierpath.cgPath
        shaperlayer.lineCap = kCALineCapRound//线条拐角
        shaperlayer.lineJoin = kCALineJoinRound//线条终点
        shaperlayer.strokeColor = UIColor.red.cgColor
        shaperlayer.lineWidth = 2;
        shaperlayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shaperlayer)
        lastLayer = shaperlayer
        layers.append(lastLayer)
    }
    @objc func click(button: UIButton) {
        let tag = button.tag
        switch tag {
        case 100:
            remove()
        case 101:
            cancel()
        case 102:
            redo()
        default:
            break
        }
    }
    
    // 删除
    func remove() {
        if layers.count == 0 {
            return
        }
        for slayer in layers {
            slayer.removeFromSuperlayer()
        }
        layers.removeAll()
        cancelLayers.removeAll()
    }
    
    // 撤销
    func cancel() {
        
        if layers.count == 0 {
            return
        }
        layers.last?.removeFromSuperlayer()
        cancelLayers.append(layers.last!)
        layers.removeLast()
    }
    
    // 恢复
    func redo() {
        if cancelLayers.count == 0 {
            return
        }
        self.layer.addSublayer(cancelLayers.last!)
        layers.append(cancelLayers.last!)
        cancelLayers.removeLast()
    }
    
}
