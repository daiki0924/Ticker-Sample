//
//  ViewController.swift
//  Ticker-Sample
//
//  Created by Daiki Kobayashi on 2023/08/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tickerContainerView: UIView!
    @IBOutlet private weak var tickerLabel: UILabel!
    
//    private let string = "流れる文字列"
    private let string = "【流れる文字列流れる文字列流れる文字列流れる文字列流れる文字列流れる文字列】"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTickerRepeatAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tickerLabel.layer.removeAnimation(forKey: "tickerAnimation")
    }
    
    private func setupView() {
        /// viewからはみ出している分は非表示
        tickerContainerView.clipsToBounds = true
        
        tickerLabel.text = string
        tickerLabel.font = UIFont.systemFont(ofSize: 16)
    }

    func startTickerRepeatAnimation() {
        tickerContainerView.layoutIfNeeded()
        let textSize = string.size(withAttributes: [.font: tickerLabel.font!])

        if textSize.width > tickerContainerView.frame.size.width {
            tickerLabel.text = string + " " + string
            let textSize = (string + " ").size(withAttributes: [.font: tickerLabel.font!])
            
            // 文字列を流すアニメーション
            let tickerAnimation = CABasicAnimation(keyPath: "position.x")
            tickerAnimation.duration = 10
            tickerAnimation.fromValue = textSize.width
            tickerAnimation.toValue = 0

            // 文字列を流すアニメーションのリピート再開時にdelayを加えるためGroupで包む
            // animationGroupのdurationを14、tickerAnimationのdurationを12に設定することでリピート時の間隔を2秒遅らせる
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 12
            animationGroup.repeatCount = .infinity
            // アニメーションスタート処理を遅らせる
            // animationGroup.beginTime = 2 みたいにしていて少し詰まった
            animationGroup.beginTime = CACurrentMediaTime() + 2
            animationGroup.animations = [tickerAnimation]
            tickerLabel.layer.add(animationGroup, forKey: "tickerAnimation")
        } else {
            tickerLabel.text = string
        }
        
    }
}

