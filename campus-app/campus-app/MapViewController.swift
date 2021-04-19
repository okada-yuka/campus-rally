//
//  MapViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/18.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }

        let reuseId = "pin"
        let  pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView.canShowCallout = true
        pinView.animatesDrop = true
        let btn = UIButton(type: .detailDisclosure)
        btn.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        pinView.rightCalloutAccessoryView = btn
        return pinView
    }

    //    ピンの中のiマークを押したときの処理
    @objc func buttonEvent(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
               // ②遷移先ViewControllerのインスタンス取得
               let nextView = storyboard.instantiateViewController(withIdentifier: "PinView")
               // ③画面遷移
               self.present(nextView, animated: true, completion: nil)

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




    @IBOutlet weak var mapView: MKMapView!
    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        myLocationManager.requestWhenInUseAuthorization()

        // 中心地はユーザー現在地

        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        mapView.userTrackingMode = MKUserTrackingMode.follow

        // 縮尺を設定
        var region = mapView.region
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        // マップビューに縮尺を設定
        mapView.setRegion(region, animated:true)

        // 以下ピン
        addAnnotation(latitude: 34.80141666723223,  longitude: 135.77055102690483, title: "ラーネッド記念図書館", subtitle: "")
        addAnnotation(latitude: 34.80080759819321,  longitude: 135.76798711156198, title: "香知館　KC", subtitle: "社会情報学研究室 - SIL")
        
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
