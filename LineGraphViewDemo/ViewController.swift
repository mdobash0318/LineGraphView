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

    let values: [Int] = [10, 20, 15, 0, 300, 550, 0, 45, 100, 100, 200, 200, 300, 400, 501, 40, 500, 10, 20, 15, 300, 50, 0, 45, 110 ,100, 100, 40]
    
    lazy var lineGraphView: LineGraphView = {
        let line:LineGraphView = LineGraphView(graphHeight: UIScreen.main.bounds.height * 0.3,
                                               values: values,
                                               lineOptions: .init(strokeWidth: 5, strokeColor: .red),
                                               lineAnimationOptions: .init(isAnime: true, duration: 3)
        )
        
        line.backgroundColor = .white
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.black.cgColor
        line.horizontalMargin = 30

        
        line.ruledLine(lineWidth: UIScreen.main.bounds.width)
        
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(lineGraphView)
        lineGraphView.translatesAutoresizingMaskIntoConstraints = false
        lineGraphView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        lineGraphView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width ).isActive = true
        lineGraphView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineGraphView.heightAnchor.constraint(equalToConstant: lineGraphView.graphHeight).isActive = true
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lineGraphView.setLineGraph()
    }


}

