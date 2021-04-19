//
//  KCViewController.swift
//  campus-rally
//
//  Created by Yuka Okada on 2021/04/19.
//

import UIKit

class KCViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

    @IBAction func subQuest_1(_ sender: Any) {
        // 確認のポップアップをつけてみてもいいかも
        
        // checkboxにチェックをつける（画像の結果を受け取るところに移動予定）
        // 画像を読み込み
        let image = UIImage(named: "checkbox_true")
        // Image Viewに読み込んだ画像をセット
        image2.image = image
    }
    
    @IBAction func subQuest_2(_ sender: Any) {
        // 確認のポップアップをつけてみてもいいかも
        
        // checkboxにチェックをつける（画像の結果を受け取るところに移動予定）
        // 画像を読み込み
        let image = UIImage(named: "checkbox_true")
        // Image Viewに読み込んだ画像をセット
        image3.image = image
    }
}

extension KCViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
