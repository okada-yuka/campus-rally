//
//  LibraryViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/17.
//

import UIKit

class DrawView: UIView {
 
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

class LibraryViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let drawView = DrawView(frame: self.view.bounds)
        self.view.addSubview(drawView)
        // drawViewを最背面にする
        self.view.sendSubviewToBack(drawView)
        
    
    }

    @IBAction func startCamera(_ sender: Any) {
        let pc = UIImagePickerController()
        pc.sourceType = .camera
        pc.delegate = self
        present(pc, animated: true, completion: nil)
        
        // checkboxにチェックをつける（画像の結果を受け取るところに移動予定）
        // 画像を読み込み
        let image = UIImage(named: "checkbox_true")
        // Image Viewに読み込んだ画像をセット
        image1.image = image
    }
}


extension LibraryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択したor撮影した写真を取得する
        let image = info[.originalImage] as! UIImage
        // ビューに表示する
        imageView.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
}
