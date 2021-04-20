//
//  MapViewController.swift
//  campus-rally
//
//  Created by Yuka Okada on 2021/04/19.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    // 初期化
    func initMap() {
            // 縮尺を設定
            var region:MKCoordinateRegion = mapView.region
            region.span.latitudeDelta = 0.002
            region.span.longitudeDelta = 0.002
            mapView.setRegion(region,animated:true)

            // 現在位置表示の有効化
            mapView.showsUserLocation = true
            // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
            mapView.userTrackingMode = .follow
        }
    
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
        
    
        
        initMap()
        mapView.delegate = self
        
//        self.goBackCenter()
        
//        // 反映されていない・・
//        // 縮尺を設定
//        var region = mapView.region
//        region.center = self.mapView.userLocation.coordinate
//        region.span.latitudeDelta = 0.0001
//        region.span.longitudeDelta = 0.0001
//        // マップビューに縮尺を設定
//        mapView.setRegion(region, animated:true)
        
        // コンパスの表示
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .adaptive
        // 画面の右下に表示する
        compass.frame = CGRect(x: 300, y: 700, width: 40, height: 40)
        self.view.addSubview(compass)
        // デフォルトのコンパスを非表示にする
        mapView.showsCompass = false
        
        // NavigationBarを表示しない
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        addAnnotation(latitude: 34.80141666723223,  longitude: 135.77055102690483, title: "ラーネッド記念図書館", subtitle: "LIBRARY")
        addAnnotation(latitude: 34.80080759819321,  longitude: 135.76798711156198, title: "香知館", subtitle: "KC")
        addAnnotation(latitude: 34.802973289643795, longitude: 135.77098865560282, title: "情報メディア館", subtitle: "JM")


    }
    
//    private func goBackCenter() {
//        self.mapView.setCenter(self.mapView.userLocation.coordinate, animated: false)
//        self.mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: false)
//    }


}

extension MapViewController: MKMapViewDelegate{
    
    //アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        //アノテーションビューを作成する。
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //吹き出しを表示可能に。
        pinView.canShowCallout = true

        let button = UIButton()
        button.frame = CGRect(x:0,y:0,width:80,height:40)
//        button.setTitle("クエスト", for: .normal)
//
//        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6784008145, green: 0.5490569472, blue: 0.7371662259, alpha: 1)
        
        button.setImage(UIImage(named: "pin_purple")!, for: .normal)
        
        pinView.image = UIImage(named: "pin_purple")!
                pinView.annotation = annotation
                pinView.canShowCallout = true
        
        // 施設ごとにボタン押下時の処理をする
        switch annotation.title {
            case "ラーネッド記念図書館":
                print("ラーネッド")
                button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
                //右側にボタンを追加
                pinView.rightCalloutAccessoryView = button
            case "香知館　KC":
                print("KC")
                button.addTarget(self, action: #selector(sendLocation_kc), for: .touchUpInside)
                //右側にボタンを追加
                pinView.rightCalloutAccessoryView = button
            case "情報メディア館　JM":
                print("JM")
                button.addTarget(self, action: #selector(sendLocation_jm), for: .touchUpInside)
                //右側にボタンを追加
                pinView.rightCalloutAccessoryView = button
            default:
                print("現在地")
                pinView.image = UIImage(named: "current_icon")!
                        pinView.annotation = annotation
                        pinView.canShowCallout = true
        }
        //button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
        
        
        
        return pinView
    }

    //OKボタン押下時の処理
    @objc func sendLocation(){
        let storyboard: UIStoryboard = self.storyboard!
           // ②遷移先ViewControllerのインスタンス取得
           let nextView = storyboard.instantiateViewController(withIdentifier: "Library")
           // ③画面遷移
           self.present(nextView, animated: true, completion: nil)
        print("図書館が呼ばれました")
    }
    
    @objc func sendLocation_kc(){
        let storyboard: UIStoryboard = self.storyboard!
           // ②遷移先ViewControllerのインスタンス取得
           let nextView = storyboard.instantiateViewController(withIdentifier: "KC")
           // ③画面遷移
           self.present(nextView, animated: true, completion: nil)
        print("KCが呼ばれました")
    }
    
    @objc func sendLocation_jm(){
        let storyboard: UIStoryboard = self.storyboard!
           // ②遷移先ViewControllerのインスタンス取得
           let nextView = storyboard.instantiateViewController(withIdentifier: "JM")
           // ③画面遷移
           self.present(nextView, animated: true, completion: nil)
        print("KCが呼ばれました")
    }
}
