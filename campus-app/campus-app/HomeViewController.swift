//
//  HomeViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/18.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 地図の初期化
        initMap()
        
        // Do any additional setup after loading the view.
        
        locManager = CLLocationManager()
        locManager.delegate = self
        
        // 位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 座標の表示
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
        }
        
        // 指定値にピンを立てる
        // ピンを立てたい緯度・経度をセット
        let coordinate = CLLocationCoordinate2DMake(40.0, 135.0)
        // 今回は現在地ではないのでコメントアウト
        //let coordinate = map.userLocation.coordinate
        // ピンを生成
        let pin = MKPointAnnotation()
        // ピンのタイトル・サブタイトルをセット
        pin.title = "テストタイトル"
        pin.subtitle = "テストサブタイトル"
        // ピンに一番上で作った位置情報をセット
        pin.coordinate = coordinate
        // mapにピンを表示する
        mapView.addAnnotation(pin)

        mapView.delegate = self
        
    }
    
    // 地図の中心位置を更新する関数
    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region,animated:true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
//        let lonStr = (locations.last?.coordinate.longitude.description)!
//        let latStr = (locations.last?.coordinate.latitude.description)!
//
//        print("lon : " + lonStr)
//        print("lat : " + latStr)
        
        updateCurrentPos((locations.last?.coordinate)!)
    }

    // 地図の初期化を行う関数
    func initMap() {
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)

        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mapView.userTrackingMode = .follow
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
