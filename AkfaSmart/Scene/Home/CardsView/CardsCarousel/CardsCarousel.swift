//
//  CardsCarousel.swift
//  AkfaSmart
//
//  Created by Temur on 21/10/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct CardsCarousel: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @Binding var data: [Card]
    @Binding var currentIndex: Int
    @Binding var targetIndex: Int?
    var height: CGFloat
    var didSelectCard: (Card) -> Void
    
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
        let listView = CardsHorizontalListView(
            data: $data, didSelectCard: didSelectCard)
        let view1 = UIHostingController(rootView: listView)
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: height)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let totalWidth = UIScreen.main.bounds.width * CGFloat(data.count)
        uiView.contentSize = CGSize(width: totalWidth, height: height)
        
        // Scroll to target index if it's set and different from the current index
        if let target = targetIndex, target != currentIndex, target < data.count {
            let targetOffset = CGFloat(target) * uiView.frame.width
            uiView.setContentOffset(CGPoint(x: targetOffset, y: 0), animated: true)
            // Update current index on the next run loop
            DispatchQueue.main.async {
                currentIndex = target
                targetIndex = nil
            }
            
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: CardsCarousel?
        
        init(_ parent: CardsCarousel) {
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
