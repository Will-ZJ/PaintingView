//
//  ViewController.swift
//  PaintingTest
//
//  Created by Will on 2018/7/11.
//  Copyright © 2018年 Will. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test()
    }
    func test() {
        self.view.backgroundColor = UIColor.gray
        let w = self.view.bounds.size.width
        
        let pv = PaintingV.init(frame: CGRect(x: 0, y: 0, width: w, height: 300))
        pv.backgroundColor = UIColor.white
        self.view.addSubview(pv);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

