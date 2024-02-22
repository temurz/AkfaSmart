//
//  DealersListView.swift
//  AkfaSmart
//
//  Created by Temur on 21/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct DealersListView: View {
    @Binding var data: [Dealer]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(data, id: \.dealerId) { model in
                DealerViewRow(width: UIScreen.main.bounds.width, model: model)
                    .padding(.vertical)
            }
        }
    }
}


struct Carousel: UIViewRepresentable {
    @Binding var data: [Dealer]
    @Binding var page: Int
    var width: CGFloat
    var height: CGFloat
    
    func makeUIView(context: Context) -> UIScrollView {
        //ScrollView Content Size
        let total = width * CGFloat(data.count)
        let view = UIScrollView()
        view.isPagingEnabled = true
        //height = 1.0 for disabling vertical scrolling.
        view.contentSize = CGSize(width: total, height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false

        //Embed SwiftUI View into UIView
        let view1 = UIHostingController(rootView: DealersListView(data: $data))
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
}
