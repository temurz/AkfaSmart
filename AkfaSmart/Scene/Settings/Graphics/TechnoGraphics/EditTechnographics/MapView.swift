//
//  MapView.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import MapKit
import UIKit
class LocationInfoManager: ObservableObject {
    @Published var locationInfo: LocationInfo?

    init() {
        self.locationInfo = nil
    }
}

struct MapViewUI: UIViewRepresentable {
    @Binding var selectedLocation: CLLocation?
    @Binding var locationName: String?
    @State private var annotation = MKPointAnnotation()
    @EnvironmentObject var locationInfoManager: LocationInfoManager


    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let gestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map view if needed
        if let location = selectedLocation {
            let coordinate = location.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)

            annotation.coordinate = coordinate
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedLocation: $selectedLocation, locationName: $locationName, annotation: $annotation, locationInfoManager: locationInfoManager)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var selectedLocation: CLLocation?
        @Binding var locationName: String?
        @Binding var annotation: MKPointAnnotation
        var locationInfoManager: LocationInfoManager

        init(selectedLocation: Binding<CLLocation?>, locationName: Binding<String?>, annotation: Binding<MKPointAnnotation>, locationInfoManager: LocationInfoManager) {
            _selectedLocation = selectedLocation
            _locationName = locationName
            _annotation = annotation
            self.locationInfoManager = locationInfoManager
        }

        @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
            let mapView = gestureRecognizer.view as! MKMapView
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

            selectedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            reverseGeocode(location: selectedLocation)

            annotation.coordinate = coordinate
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(annotation)
        }
        
        private func reverseGeocode(location: CLLocation?) {
            guard let location = location else { return }

            let locale = Locale(identifier: AuthApp.shared.language)
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
                guard error == nil, let placemark = placemarks?.first else {
                    print("Reverse geocoding failed with error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                var addressString = ""
                
                if let name = placemark.name {
                    addressString += name + ", "
                }
//                if let thoroughfare = placemark.thoroughfare {
//                    addressString += thoroughfare + ", "
//                }
//                if let locality = placemark.locality {
//                    addressString += locality + ", "
//                }
                if let administrativeArea = placemark.administrativeArea {
                    addressString += administrativeArea + ", "
                }
                if let country = placemark.country {
                    addressString += country
                }
                
                self.locationName = addressString
                
                let locationInfo = LocationInfo(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, name: addressString)
                self.locationInfoManager.locationInfo = locationInfo
            }
        }

    }
}

struct MapView: View {
    @State private var selectedLocation: CLLocation?
    @State private var locationName: String?
    var navigationController: UINavigationController
    @EnvironmentObject var locationInfoManager: LocationInfoManager
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: "CHOOSE_ON_MAP".localizedString) {
                navigationController.popViewController(animated: true)
            }
            MapViewUI(selectedLocation: $selectedLocation, locationName: $locationName)
                .environmentObject(locationInfoManager)
                .frame(maxHeight: .infinity)

            if let name = locationName {
                Text(name)
                    .padding()
            }else {
                Text("")
                    .padding()
            }
        }
//        .navigationTitle("CHOOSE_ON_MAP".localizedString)
//        .navigationBarItems(trailing:
//                                Button(action: {
//            navigationController.popViewController(animated: true)
//        }, label: {
//            Text("SAVE".localizedString)
//                .bold()
//                .foregroundColor(Color.red)
//        })
//        )
    }
}


class LocationInfo {
    var latitude: Double
    var longitude: Double
    var name: String
    
    init(latitude: Double, longitude: Double, name: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
}

struct LocationInfoKey: EnvironmentKey {
    static let defaultValue: LocationInfo? = nil
}

extension EnvironmentValues {
    var locationInfo: LocationInfo? {
        get { self[LocationInfoKey.self] }
        set { self[LocationInfoKey.self] = newValue }
    }
}
