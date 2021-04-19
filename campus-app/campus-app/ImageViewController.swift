//
//  ImageViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/18.
//

import UIKit
import SwiftyTesseract

class ImageViewController: UIViewController {

    let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.japanese)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        let start = Date()

        //let fileName = "kochikan.JPG"
        guard let image = UIImage(named: "スクリーンショット 2021-04-19 10.55.37") else { return }

        swiftyTesseract.performOCR(on: image) { recognizedString in
            guard let text = recognizedString else { return }
            print("\(text)")
        }
        
        print("end")
    }
    

}
