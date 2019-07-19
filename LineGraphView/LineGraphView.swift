//
//  LineGraphView.swift
//  LineGraphView
//
//  Created by 土橋正晴 on 2019/07/18.
//  Copyright © 2019 m.dobashi. All rights reserved.
//

import Foundation

public class LineGraphView: UIView {
    
    public let lineLayer:CAShapeLayer = CAShapeLayer()
    /// グラフに表示する値を格納する配列
    public var valueCount: [CGFloat]?
    
    /// アニメーションの表示の有無 デフォルト:true
    public var isAnime: Bool = true
    
    /// 線の太さ
    public var lineWidth: CGFloat = 1
    
    /// 線の色
    public var strokeColor: UIColor = UIColor.black
    
    /// 初期位置
    public var fromValue: Any? = 0.0
    
    /// アニメーションの終了時の位置
    public var toValue: Any? = 1.0
    
    /// アニメーションの速度
    public var duration:  CFTimeInterval = 1
    
    /// グラフを表示するViewの高さ
    public var graphHeight: CGFloat = 0
    
    /// デフォルト:.linear
    public var timingFunction:CAMediaTimingFunction? = .init(name: .linear)
    
    
    /// 値を表示する
    public var valueLabel:UILabel {
        let label: UILabel = UILabel()
        label.backgroundColor = labelBackgroundColor
        label.textColor = labelTextColor
        label.font = labelFont
        label.textAlignment = labelTextAlignment
        label.isHidden = isHideLabel
        
        return label
    }
    
    public var labelBackgroundColor:UIColor = .clear
    public var labelFont: UIFont?
    public var labelTextColor: UIColor?
    
    /// デフォルト:.right
    public var labelTextAlignment:NSTextAlignment = .right
    
    /// ラベルの非表示 デフォルト:false
    public var isHideLabel:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    
    public convenience init(graphHeight height: CGFloat, count: [CGFloat]){
        self.init()
        graphHeight = height
        valueCount = count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 棒グラフの描画
    /// isAnimeがtrueならアニメーションを流す
    /// falseなら描画のみ
    public func lineAnimetion(){
        guard let _valueCount = valueCount else {
            debugPrint("valueCount is nil")
            return
        }
        layer.addSublayer(lineLayer)
        let path = UIBezierPath()
        let graphY: CGFloat = (graphHeight / 12)
        let lableY: CGFloat = (graphHeight / 11)
        path.move(to: CGPoint(x: 20, y: graphHeight - _valueCount[0] * graphY))
        
        /* 一つ目の値を表示するラベルを生成 */
        let firstLabel: UILabel = {
            let label:UILabel = valueLabel
            label.frame = CGRect(x: 20, y: graphHeight - _valueCount[0] * lableY - 10, width: 0, height: 0)
            label.text = "\(Int(_valueCount[0]))"
            label.textColor = .black
            label.sizeToFit()
            
            return label
        }()
        addSubview(firstLabel)
        
        for i in 1..<_valueCount.count {
            path.addLine(to: CGPoint(x: 20 * CGFloat(i + 1), y: graphHeight - _valueCount[i] * graphY))
            
            let label: UILabel = {
                let label:UILabel = valueLabel
                label.frame = CGRect(x: 20 * CGFloat(i + 1), y: graphHeight - _valueCount[i] * lableY - 10, width: 0, height: 0)
                label.text = "\(Int(_valueCount[i]))"
                label.sizeToFit()
                
                return label
            }()
            addSubview(label)
        }
        
        lineLayer.path = path.cgPath
        lineLayer.lineWidth = lineWidth
        lineLayer.fillColor = UIColor.white.cgColor
        lineLayer.strokeColor = strokeColor.cgColor
        
        if isAnime == true {
            let anime = CABasicAnimation(keyPath:"strokeEnd")
            anime.fromValue = fromValue
            anime.toValue = toValue
            anime.timingFunction = timingFunction
            anime.duration = duration
            anime.fillMode = .forwards
            
            
            lineLayer.add(anime, forKey: nil)
        }
    }
}
