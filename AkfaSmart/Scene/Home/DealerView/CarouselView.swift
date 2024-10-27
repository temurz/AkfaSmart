//
//  CarouselView.swift
//  AkfaSmart
//
//  Created by Temur on 22/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct Carousel: UIViewRepresentable {
    @Binding var data: [Dealer]
    var didSelectInformation: (Dealer) -> ()
    
    func makeUIView(context: Context) -> UIScrollView {
        //ScrollView Content Size
        let total = UIScreen.main.bounds.width * CGFloat(data.count + 1)
        let view = UIScrollView()
        view.isPagingEnabled = true
        //height = 1.0 for disabling vertical scrolling.
        view.contentSize = CGSize(width: total, height: 0.5)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false

        //Embed SwiftUI View into UIView
        let listView = DealersListView(
            data: $data,
        didSelectInformation: didSelectInformation)
        let view1 = UIHostingController(rootView: listView)
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: 120)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
}
