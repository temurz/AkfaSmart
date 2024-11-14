//
//  HomeView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct HomeView: View {
    @ObservedObject var output: HomeViewModel.Output
    @State var balanceIsVisible = false
    @State var totalOfMonth = 0.0
    @State var totalOfYear = 0.0
    @State var searchText = ""
    @State var infoDealer = Dealer(dealerId: nil, dealerClientCid: nil, name: nil, clientName: nil, balance: 0, purchaseForMonth: 0, purchaseForYear: 0)
    @State var showDealerDetails = false
    @State var refresh = false
    @State private var initialDealers = [Dealer]()
    @State private var initialCards = [Card]()
    
    var showSideMenuAction: (() -> Void)?
    
    private let getDealersTrigger = PassthroughSubject<Void,Never>()
    private let getMobileClassInfoTrigger = PassthroughSubject<Void,Never>()
    private let showAddDealerViewTrigger = PassthroughSubject<Void,Never>()
    private let showClassDetailViewTrigger = PassthroughSubject<Void,Never>()
    private let showMessagesViewTrigger = PassthroughSubject<Void,Never>()
    private let showArticlesViewTrigger = PassthroughSubject<Void,Never>()
    private let showNewsViewTrigger = PassthroughSubject<Void,Never>()
    private let getCardsTrigger = PassthroughSubject<Void,Never>()
    private let showCardsMainViewTrigger = PassthroughSubject<Void,Never>()
    private let addCardViewTrigger = PassthroughSubject<Void,Never>()
    private let cardSettingsViewTrigger = PassthroughSubject<Card,Never>()
    
    private let showDealerDetailsViewTrigger = PassthroughSubject<Dealer,Never>()
    
    let cancelBag = CancelBag()
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack(alignment: .leading, spacing: 0) {
                ViewWithShadowOnBottom {
                    VStack {
                        HStack(spacing: 12) {
                            ZStack {
                                Button {
                                    showSideMenuAction?()
                                } label: {
                                    Image("person_a")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Color(hex: "#C8CDD0"))
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.top, 7)
                                }
                            }
                            .frame(width: 42, height: 42)
                            .background(Colors.avatarBackgroundGrayColor)
                            .cornerRadius(21)
                                
//                            ZStack(alignment: .leading) {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Colors.borderGrayColor2)
//                                Image(systemName: "magnifyingglass")
//                                    .resizable()
//                                    .foregroundColor(.gray)
//                                    .frame(width: 20, height: 20)
//                                    .padding(.leading, 14)
//                                TextField("SEARCH_PRODUCT".localizedString, text: $searchText)
//                                    .padding(.leading, 44)
//                            }
//                            .frame(height: 42)
                            Spacer()
                            notificationView
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("MY_DEALERS".localizedString)
                                .font(.headline)
                            Spacer()
                            Text("ALL_LOWERCASED".localizedString)
                                .font(.headline)
                                .foregroundStyle(Color.red)
                            
                        }
                        .padding(.horizontal)
                        if output.needToRender {
                            Carousel(
                                data: $output.items, currentIndex: $output.currentDealerIndex) { dealer in
                                    showDealerDetailsViewTrigger.send(dealer)
                                } addDealerAction: {
                                    showAddDealerViewTrigger.send(())
                                }
                                .frame(height: 120)
                        } else {
                            Carousel(
                                data: $output.items, currentIndex: $output.currentDealerIndex) { dealer in
                                    showDealerDetailsViewTrigger.send(dealer)
                                } addDealerAction: {
                                    showAddDealerViewTrigger.send(())
                                }
                                .frame(height: 120)
                        }
                        HStack {
                            Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(output.currentDealerIndex == 0 ? Colors.customRedColor : Colors.circleGrayColor)
                            if output.items.count > 2 {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(output.currentDealerIndex != 0 && output.currentCardIndex != output.items.count - 1 ? Colors.customRedColor : Colors.circleGrayColor)
                            }
                            if output.items.count > 1 {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(output.currentDealerIndex == output.cards.count - 1 ? Colors.customRedColor : Colors.circleGrayColor)
                            }
                            
                            Spacer()
                        }
                        HStack {
                            Text("MY_CARDS".localizedString)
                                .font(.headline)
                            Spacer()
                            Button {
                                showCardsMainViewTrigger.send(())
                            } label: {
                                Text("ALL_LOWERCASED".localizedString)
                                    .font(.headline)
                                    .foregroundStyle(Color.red)
                            }
                        }
                        .padding(.horizontal)
                        if output.needToRender {
                            CardsCarousel(data: $output.cards, currentIndex: $output.currentCardIndex, targetIndex: .constant(nil), height: 180, didSelectCard: { card in
                                if card.id < 0 {
                                    addCardViewTrigger.send(())
                                } else {
                                    cardSettingsViewTrigger.send(card)
                                }
                            })
                                .frame(height: 180)
                        }else {
                            CardsCarousel(data: $output.cards, currentIndex: $output.currentCardIndex, targetIndex: .constant(nil), height: 180, didSelectCard: { card in
                                if card.id < 0 {
                                    addCardViewTrigger.send(())
                                } else {
                                    cardSettingsViewTrigger.send(card)
                                }
                            })
                                .frame(height: 180)
                        }
                        HStack {
                            Spacer()
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(output.currentCardIndex == 0 ? Colors.customRedColor : Colors.circleGrayColor)
                            if output.cards.count > 2 {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(output.currentCardIndex != 0 && output.currentCardIndex != output.cards.count - 1 ? Colors.customRedColor : Colors.circleGrayColor)
                            }
                            if output.cards.count > 1 {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(output.currentCardIndex == output.cards.count - 1 ? Colors.customRedColor : Colors.circleGrayColor)
                            }
                            Spacer()
                        }
                        
                    }
                    .padding(.vertical)
                }
                .refreshable {
                    getDealersTrigger.send(())
                    getMobileClassInfoTrigger.send(())
                    getCardsTrigger.send(())
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            getDealersTrigger.send(())
            getMobileClassInfoTrigger.send(())
            getCardsTrigger.send(())
        }
    }
    
    
    var notificationView: some View {
        ZStack(alignment: .topTrailing) {
            Menu {
                Button {
                    showMessagesViewTrigger.send(())
                } label: {
                    Text("MESSAGES".localizedString)
                    if output.unreadDataCount.countUnreadMessages != 0 {
                        Text("\(output.unreadDataCount.countUnreadMessages)")
                            .foregroundStyle(Color.green)
                    }
                }
                Button {
                    showArticlesViewTrigger.send(())
                } label: {
                    Text("ARTICLES".localizedString)
                    if output.unreadDataCount
                        .countUnreadArticles != 0 {
                        Text("\(output.unreadDataCount.countUnreadArticles)")
                            .foregroundColor(.green)
                    }
                }
                Button {
                    showNewsViewTrigger.send(())
                } label: {
                    Text("NEWS".localizedString)
                    if output.unreadDataCount.countUnreadNews != 0 {
                        Text("\(output.unreadDataCount.countUnreadNews)")
                    }
                }
            } label: {
                Image("bell")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            if output.unreadDataCount.hasUnreadData {
                Color.green
                    .frame(width: 8, height: 8)
                    .clipShape(Circle())
            }
        }
    }
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input(
            getDealersTrigger: getDealersTrigger.asDriver(), 
            getMobileClassInfo: getMobileClassInfoTrigger.asDriver(),
            showAddDealerViewTrigger: showAddDealerViewTrigger.asDriver(), 
            showClassDetailViewTrigger: showClassDetailViewTrigger.asDriver(),
            showMessagesViewTrigger: showMessagesViewTrigger.asDriver(),
            showArticlesViewTrigger: showArticlesViewTrigger.asDriver(),
            showNewsViewTrigger: showNewsViewTrigger.asDriver(), 
            getCardsTrigger: getCardsTrigger.asDriver(),
            showDealerDetailsViewTrigger: showDealerDetailsViewTrigger.asDriver(),
            showCardsMainViewTrigger: showCardsMainViewTrigger.asDriver(),
            addCardViewTrigger: addCardViewTrigger.asDriver(),
            cardSettingsViewTrigger: cardSettingsViewTrigger.asDriver()
        )
        
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    HomeView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
}

struct ViewWithShadowOnBottom<Content: View>: View {
    
    var content: () -> Content
    var body: some View {
        VStack {
            
            content()
            Spacer()
            Colors.borderGrayColor2
                .frame(height: 2)
                .shadow(color: .black.opacity(0.1),radius: 2, x: 0, y: 2)
                
        }
        .frame(height: 74)
        
    }
}
