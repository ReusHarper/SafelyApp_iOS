// ==================== Dependencies ====================
import SideMenu
import UIKit
import FirebaseAnalytics
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
        
    // ==================== Structs ====================
    struct option {
        var title = String()
        var segue = String()
    }
    
    // ==================== General ====================
    var options: [option] = [
        option(title: "Account", segue: "goToAccount"),
        option(title: "Groups", segue: "goToGroups"),
        option(title: "Close", segue: "goToLogin")
    ]

    private let ZOOM = Float(16.0)
    private var menuState: Bool = false
    private var locationCurrent: CLLocation = CLLocation()
    private var changeTypeMap: Bool = false
    private var menu: SideMenuNavigationController!
    
    @IBOutlet var viewPrueba: UIView!
    
    // Prueba de Google Maps
    private var camera : GMSCameraPosition?
    //private var mapView : GMSMapView?
    private let locationManager = CLLocationManager()
    
    // ==================== Buttons ====================
    @IBOutlet var menuButton: GradientButtonUI!
    @IBOutlet var alertsButton: GradientButtonUI!
    @IBOutlet var markerButton: GradientButtonUI!
    @IBOutlet var typeMapButton: GradientButtonUI!
    @IBOutlet var emergencyButton: GradientButtonUI!
    @IBOutlet var mainView: UIView!
    @IBOutlet var mapView: GMSMapView!
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuraciones iniciales
        mapView?.settings.myLocationButton = true
        mapView?.settings.compassButton = false
        mapView?.settings.indoorPicker = false
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        locationManager.delegate = self
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("No se encontro el archivo de estilo JSON")
            }
        } catch {
            NSLog("Fallo en cargar el archivo de estilo JSON: \(error)")
        }
            
        // Solicitud de permiso de ubicacion
        DispatchQueue.global().async {
            self.requestPermissions()
        }

        // Generacion de mapa
        view.addSubview(mapView!)
        view.sendSubviewToBack(mapView!)
        mapView?.isHidden = false
        
        // Establecimiento de menu lateral
        menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigation") as? SideMenuNavigationController
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    // MARK: Visualizacion de menu lateral
    @IBAction func menuAction(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    // MARK: Solicitud de permisos
    private func requestPermissions() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: Establecimiento de ubicacion actual
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc_latitude = locationManager.location?.coordinate.latitude ?? 0.0
        let loc_longitude = locationManager.location?.coordinate.longitude ?? 0.0
        
        // Asignacion actual de posicion
        locationCurrent = CLLocation(latitude: loc_latitude, longitude: loc_longitude)
        
        // Desplazamiento con animacion de la posicion de la camara
        animateCamera(latitude: loc_latitude, longitude: loc_longitude)
        
        // Agregacion de marcador
        setMarkerCurrentLocation(latitude: loc_latitude, longitude: loc_longitude)
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // MARK: Animacion y desplazamiento de camara
    private func animateCamera(latitude: Double, longitude: Double) {
        CATransaction.begin()
        CATransaction.setValue(Float(0.75), forKey: kCATransactionAnimationDuration)
        
        let camera = GMSCameraPosition(
            target: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            zoom: ZOOM,
            bearing: 0,
            viewingAngle: 0
        )
        mapView.animate(to: camera)
        
        CATransaction.commit()
    }
    
    // MARK: Colocacion de marcador de posicion actual
    private func setMarkerCurrentLocation(latitude: Double, longitude: Double) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.map = mapView
        marker.title = "Tu ubicacion actual"
        marker.snippet = "Lat: \(latitude), Long: \(longitude)"
    }
    
    // MARK: Retorno de posicion actual
    @IBAction func setCurrentPosition(_ sender: Any) {
        let latitude = locationCurrent.coordinate.latitude
        let longitude = locationCurrent.coordinate.longitude
        
        if (locationCurrent.coordinate.latitude != 0.0 && locationCurrent.coordinate.longitude != 0) {
            animateCamera(latitude: latitude, longitude: longitude)
        }
    }
    
    // MARK: Cambio de estilo de mapa
    @IBAction func setChangeTypeMap(_ sender: Any) {
        // Cambio a estilo satelital
        if !changeTypeMap {
            mapView.mapType = GMSMapViewType.satellite
            changeTypeMap = true
        }
        // Cambio a estilo 2D
        else {
            mapView.mapType = GMSMapViewType.normal
            changeTypeMap = false
        }
    }
    
    // MARK: Lista de notificaciones
    @IBAction func getNotifications(_ sender: Any) {
        print("Notificaciones")
        let storyboard = UIStoryboard(name: "Notifications", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NotificationID")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
//    // MARK: Visualizacion de menu lateral
//    @IBAction func showSideMenu(_ sender: Any) {
//        print("Menu lateral")
//    }
    
    // MARK: Cambio de vista a Emergency
    @IBAction func showEmergencyView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Emergency", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EmergencyID")
        vc.modalPresentationStyle = .fullScreen
        //vc.userReceived = user
        present(vc, animated: true, completion: nil)
    }
}
