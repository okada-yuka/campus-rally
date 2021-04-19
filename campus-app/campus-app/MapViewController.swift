//
//  NewMapViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/18.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    

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
        
        self.goBackCenter()
        
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
        
        addAnnotation(latitude: 34.80141666723223,  longitude: 135.77055102690483, title: "ラーネッド記念図書館", subtitle: "")
        addAnnotation(latitude: 34.80080759819321,  longitude: 135.76798711156198, title: "香知館　KC", subtitle: "社会情報学研究室 - SIL")
        addAnnotation(latitude: 34.802973289643795, longitude: 135.77098865560282, title: "情報メディア館　JM", subtitle: "")


    }
    
    private func goBackCenter() {
        self.mapView.setCenter(self.mapView.userLocation.coordinate, animated: false)
        self.mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: false)
    }


}

extension MapViewController: MKMapViewDelegate{
    
    //アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("呼び出される")
        print(annotation.title)
        //アノテーションビューを作成する。
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //吹き出しを表示可能に。
        pinView.canShowCallout = true
        
        let button = UIButton()
        button.frame = CGRect(x:0,y:0,width:80,height:40)
        button.setTitle("クエスト", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6784008145, green: 0.5490569472, blue: 0.7371662259, alpha: 1)
        
        pinView.image = UIImage(named: "pin")!
                pinView.annotation = annotation
                pinView.canShowCallout = true
        
        // 施設ごとにボタン押下時の処理をする
        switch annotation.title {
            case "ラーネッド記念図書館":
                print("ラーネッド")
                button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
            case "香知館　KC":
                print("KC")
                button.addTarget(self, action: #selector(sendLocation_kc), for: .touchUpInside)
            case "情報メディア館　JM":
                print("JM")
                button.addTarget(self, action: #selector(sendLocation_jm), for: .touchUpInside)
            default:
                print("現在地")
                pinView.image = UIImage(named: "purple")!
                        pinView.annotation = annotation
                        pinView.canShowCallout = true
        }
        //button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
        //右側にボタンを追加
        pinView.rightCalloutAccessoryView = button
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
////
////  NewMapViewController.swift
////  campus-app
////
////  Created by Yuka Okada on 2021/04/18.
////
//
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class NewMapViewController: UIViewController {
//
//    @IBOutlet weak var mapView: MKMapView!
//
//    let annotation = MKPointAnnotation()
//    //CLLocationManagerの入れ物を用意
//    var myLocationManager:CLLocationManager!
//
//    //    ピンを立てる
//    func addAnnotation( latitude: CLLocationDegrees,longitude: CLLocationDegrees, title:String, subtitle:String) {
//        mapView.delegate = self
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
//        annotation.title = title
//        annotation.subtitle = subtitle
//        self.mapView.addAnnotation(annotation)
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        // NavigationBarを表示しない
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//
//        //CLLocationManagerをインスタンス化
//        myLocationManager = CLLocationManager()
//        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
//        myLocationManager.requestWhenInUseAuthorization()
//
//        // 中心地はユーザー現在地
//        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
//        mapView.userTrackingMode = MKUserTrackingMode.follow
//
//        // 縮尺を設定
//        var region = mapView.region
//        region.center = mapView.userLocation.coordinate
//        region.span.latitudeDelta = 0.000000001
//        region.span.longitudeDelta = 0.00000001
//        // マップビューに縮尺を設定
//        mapView.setRegion(region, animated:true)
//
//        mapView.delegate = self
//
//        addAnnotation(latitude: 34.80141666723223,  longitude: 135.77055102690483, title: "ラーネッド記念図書館", subtitle: "")
//        addAnnotation(latitude: 34.80080759819321,  longitude: 135.76798711156198, title: "香知館　KC", subtitle: "社会情報学研究室 - SIL")
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//}
//
//extension NewMapViewController: MKMapViewDelegate{
//
//    //アノテーションビューを返すメソッド
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print("呼び出される")
//        print(annotation.title)
//        //アノテーションビューを作成する。
//        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//
//        //吹き出しを表示可能に。
//        pinView.canShowCallout = true
//
//        let button = UIButton()
//        button.frame = CGRect(x:0,y:0,width:80,height:40)
//        button.setTitle("クエスト", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor.blue
//
//        // 施設ごとにボタン押下時の処理をする
//        switch annotation.title {
//        case "ラーネッド記念図書館":
//            print("ラーネッド")
//            button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
//        case "香知館　KC":
//            print("KC")
//            button.addTarget(self, action: #selector(sendLocation_kc), for: .touchUpInside)
//        default:
//            print("どちらでもないです")
//        }
//        //button.addTarget(self, action: #selector(sendLocation), for: .touchUpInside)
//        //右側にボタンを追加
//        pinView.rightCalloutAccessoryView = button
//        return pinView
//    }
//
//    //OKボタン押下時の処理
//    @objc func sendLocation(){
//        print("図書館が呼ばれました")
//    }
//
//    @objc func sendLocation_kc(){
//        let storyboard: UIStoryboard = self.storyboard!
//               // ②遷移先ViewControllerのインスタンス取得
//               let nextView = storyboard.instantiateViewController(withIdentifier: "PinView")
//               // ③画面遷移
//               self.present(nextView, animated: true, completion: nil)
//        print("KCが呼ばれました")
//    }
//
//}
//
