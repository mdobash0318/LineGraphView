//
//  LineGraphView.swift
//  LineGraphView
//
//  Created by 土橋正晴 on 2019/07/18.
//  Copyright © 2019 m.dobashi. All rights reserved.
//

import Foundation

public class LineGraphView: UIView {
    
    public let scrollView: UIScrollView = UIScrollView()
    
    public let lineLayer:CAShapeLayer = CAShapeLayer()
    /// グラフに表示する値を格納する配列
    public var valueCount: [Int]?
    
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
    public var duration: CFTimeInterval = 1
    
    /// グラフを表示するViewの高さ
    public var graphHeight: CGFloat = 0
    
    /// デフォルト:.linear
    public var timingFunction:CAMediaTimingFunction? = .init(name: .linear)
    
    /// 棒グラフの横の余白
    public var horizontalMargin:CGFloat = 20
    
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
    
    public var labelBackgroundColor:UIColor = .white
    public var labelFont: UIFont?
    public var labelTextColor: UIColor?
    
    /// デフォルト:.right
    public var labelTextAlignment:NSTextAlignment = .right
    
    /// ラベルの非表示 デフォルト:false
    public var isHideLabel:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    public convenience init(graphHeight height: CGFloat, values: [Int]){
        self.init()
        graphHeight = height
        valueCount = values
        
        
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 棒グラフの描画
    /// isAnimeがtrueならアニメーションを流す
    /// falseなら描画のみ
    public func setLineGraph(){
        guard let _valueCount:[Int] = valueCount else {
            debugPrint("valueCount is nil")
            return
        }
        
        scrollView.contentSize.width = horizontalMargin * CGFloat(_valueCount.count + 1)
        scrollView.layer.addSublayer(lineLayer)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 15, y: graphHeight - positioningY(value: CGFloat(_valueCount[0]))))
        
        /* 一つ目の値を表示するラベルを生成 */
        let firstLabel: UILabel = {
            let label:UILabel = valueLabel
            label.frame = CGRect(x: 15, y: graphHeight - positioningY(value: CGFloat(_valueCount[0])), width: 0, height: 0)
            label.text = "\(_valueCount[0])"
            label.sizeToFit()
            
            return label
        }()
        scrollView.addSubview(firstLabel)
        
        for i in 1..<_valueCount.count {
            path.addLine(to: CGPoint(x: horizontalMargin * CGFloat(i + 1), y: graphHeight - positioningY(value: CGFloat(_valueCount[i]))))
            
            let label: UILabel = {
                let label:UILabel = valueLabel
                label.frame = CGRect(x: horizontalMargin * CGFloat(i + 1), y: graphHeight - positioningY(value: CGFloat(_valueCount[i])), width: 0, height: 0)
                label.text = "\(_valueCount[i])"
                label.sizeToFit()
                
                return label
            }()
            scrollView.addSubview(label)
        }
        
        lineLayer.path = path.cgPath
        lineLayer.lineWidth = lineWidth
        lineLayer.fillColor = UIColor.clear.cgColor
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
    
    public func positioningY(value: CGFloat) -> CGFloat {
        let maxValue:Int = (valueCount?.max())!
        let height:CGFloat = (graphHeight * (value / CGFloat(maxValue))) + 20
        if graphHeight >= height {
            return height
        } else {
            return graphHeight
        }
    }
}
