//
//  NewMapViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/18.
//


import UIKit
import MapKit
import CoreLocation

class NewMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    //    ピンを立てる
    func addAnnotation( latitude: CLLocationDegrees,longitude: CLLocationDegrees, title:String, subtitle:String) {
        mapView.delegate = self
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        self.mapView.addAnnotation(annotation)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        addAnnotation(latitude: 34.80141666723223,  longitude: 135.77055102690483, title: "ラーネッド記念図書館", subtitle: "")
        addAnnotation(latitude: 34.80080759819321,  longitude: 135.76798711156198, title: "香知館　KC", subtitle: "社会情報学研究室 - SIL")


    }


}

extension NewMapViewController: MKMapViewDelegate{
    
    //アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("呼び出される")
        print(annotation.title)
        //アノテーションビューを作成する。
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //吹き出しを表示可能に。
        pinView.canShowCallout = true
        
        let button = UIButton()
        button.frame = CGRect(x:0,y:0,width:40,height:40)
        button.setTitle("OK", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        
        // 施設ごとにボタン押下時の処理をする
        switch annotation.title {
        case "ラーネッド記念図書館":
            print("ラーネッド")
            button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
        case "香知館　KC":
            print("KC")
            button.addTarget(self, action: #selector(sendLocation_kc), for: .touchUpInside)
        default:
            print("どちらでもないです")
        }
        //button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
        //右側にボタンを追加
        pinView.rightCalloutAccessoryView = button
        return pinView
    }

    //OKボタン押下時の処理
    @objc func sendLocation(){
        print("図書館が呼ばれました")
    }
    
    @objc func sendLocation_kc(){
        let storyboard: UIStoryboard = self.storyboard!
               // ②遷移先ViewControllerのインスタンス取得
               let nextView = storyboard.instantiateViewController(withIdentifier: "PinView")
               // ③画面遷移
               self.present(nextView, animated: true, completion: nil)
        print("KCが呼ばれました")
    }
}

