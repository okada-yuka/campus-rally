//
//  TC1ViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/17.
//

import UIKit

class DrawView_TC1: UIView {
 
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // ここにUIBezierPathを記述する
        // 角が丸い四角形（短形）
        let roundrRectangle = UIBezierPath(roundedRect: CGRect(x: 40, y: 220, width: 310, height: 350), cornerRadius: 10.0)
        // 内側の色
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        // 内側を塗りつぶす
        roundrRectangle.fill()
//        // 線の色
//        UIColor(red: 0, green: 0.8, blue: 0, alpha: 1.0).setStroke()
//        // 線の太さ
//        roundrRectangle.lineWidth = 2.0
//        // 線を塗りつぶす
//        roundrRectangle.stroke()
    }
 
}

class TC1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let drawView = DrawView_TC1(frame: self.view.bounds)
        self.view.addSubview(drawView)
        // drawViewを最背面にする
        self.view.sendSubviewToBack(drawView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
