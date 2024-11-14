//
//  CarouselView.swift
//  AkfaSmart
//
//  Created by Temur on 22/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct Carousel: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @Binding var data: [Dealer]
    @Binding var currentIndex: Int
    var didSelectInformation: (Dealer) -> ()
    var addDealerAction: () -> Void
    
    func makeUIView(context: Context) -> UIScrollView {
        //ScrollView Content Size
        let total = UIScreen.main.bounds.width * CGFloat(data.count)
        let view = UIScrollView()
        view.isPagingEnabled = true
        //height = 1.0 for disabling vertical scrolling.
        view.contentSize = CGSize(width: total, height: 0.5)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = context.coordinator

        //Embed SwiftUI View into UIView
        let listView = DealersListView(
            data: $data,
        didSelectInformation: didSelectInformation,
        addDealerAction: addDealerAction)
        let view1 = UIHostingController(rootView: listView)
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: 120)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: Carousel?
        
        init(_ parent: Carousel) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let parent = parent else { return }
            // Calculate the current card index
            let pageWidth = scrollView.frame.width
            let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
            
            // Update the currentIndex binding if the page changed
            if currentPage != parent.currentIndex && currentPage < parent.data.count {
                parent.currentIndex = currentPage
            }
        }
    }
}
