//
//  ProductOwnersListView.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation
struct ProductDealersListView: View {
    var model: ProductWithName
    @ObservedObject var output: ProductDealersListViewModel.Output
    @ObservedObject var locationManager = LocationManager()

    private let loadProductDealersTrigger = PassthroughSubject<ProductDealersListInput, Never>()
    private let reloadProductDealersTrigger = PassthroughSubject<ProductDealersListInput, Never>()
    private let loadMoreProductDealersTrigger = PassthroughSubject<ProductDealersListInput, Never>()
    
    private let showLocationTrigger = PassthroughSubject<Location, Never>()
    private let showPhoneCallTrigger = PassthroughSubject<String, Never>()
    
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                VStack(alignment: .leading) {
                    Text(model.name)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9497A1"))
                    HStack(spacing: 0) {
                        Text("GROUP_WITH_COLON".localizedString)
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#9497A1"))
                        Spacer()
                        Text(model.groupName)
                    }
                    
                    HStack {
                        Text("PRICE".localizedString)
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#9497A1"))
                        Spacer()
                        Text(model.rate.convertDecimals() + "UZS".localizedString)
                    }
                }
                .padding()
                
                List {
                    ForEach(output.items, id: \.dealerId) { item in
                        ProductDealerViewRow(model: item, 
                                             selectLocation: {
                            showLocationTrigger.send(Location(latitude: item.latitude, longitude: item.longitude))
                        },
                                             selectPhone: {
                            showPhoneCallTrigger.send("\(item.phones)")
                        })
                            .padding(.vertical, 4)
                            .onAppear {
                                if output.items.last?.dealerId ?? -1 == item.dealerId && output.hasMorePages {
                                    loadMoreProductDealersTrigger.send(ProductDealersListInput(productName: model.name, latitude: 0.0, longitude: 0.0))
                                }
                            }
                            .listRowSeparator(.hidden)
                    }
                }
                .background(Color(hex: "#EAEEF5"))
                .listStyle(.plain)
            }
        }
        .navigationTitle("DEALERS_WITH_THIS_PRODUCT".localizedString)
        .onAppear {
            
            locationManager.didEndUpdating = { lat, long in
                loadProductDealersTrigger.send(ProductDealersListInput(productName: model.name, latitude: lat, longitude: long))
            }
            
        }
    }
    
    init(model: ProductWithName, viewModel: ProductDealersListViewModel) {
        self.model = model
        let input = ProductDealersListViewModel.Input(
            loadProductDealersTrigger: loadProductDealersTrigger.asDriver(),
            reloadProductDealersTrigger: reloadProductDealersTrigger.asDriver(),
            loadMoreProductDealersTrigger: loadMoreProductDealersTrigger.asDriver(),
            showLocationTrigger: showLocationTrigger.asDriver(),
            showPhoneCallTrigger: showPhoneCallTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    var didEndUpdating: ((Double, Double) -> Void)?
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            didEndUpdating?(latitude, longitude)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
