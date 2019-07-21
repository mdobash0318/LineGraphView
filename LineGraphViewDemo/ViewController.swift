//
//  ViewController.swift
//  LineGraphViewDemo
//
//  Created by 土橋正晴 on 2019/07/20.
//  Copyright © 2019 m.dobashi. All rights reserved.
//

import UIKit
import LineGraphView

class ViewController: UIViewController {

    let values: [CGFloat] = [10,20,15, 300,50, 0, 45, 10000, 100, 40,]
    
    lazy var lineGraphView: LineGraphView = {
        let line:LineGraphView = LineGraphView(graphHeight: 400, values: values)
        line.duration = 1
        line.lineWidth = 5
        line.strokeColor = .red
        line.backgroundColor = .white
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.black.cgColor
        line.toValue = 1.0
        
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(lineGraphView)
        lineGraphView.translatesAutoresizingMaskIntoConstraints = false
        lineGraphView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        lineGraphView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lineGraphView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineGraphView.heightAnchor.constraint(equalToConstant: lineGraphView.graphHeight).isActive = true
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lineGraphView.lineAnimetion()
    }


}

