//
//  PromotionViewCell.swift
//  AkfaSmart
//
//  Created by Temur on 12/07/2025.
//  Copyright © 2025 Tuan Truong. All rights reserved.
//

import SwiftUI

struct PromotionViewCell: View {
    let model: Promotion
    
    let imageWidth = (Constants.screenWidth - 64) * 0.38
    
    @State private var timeRemaining: TimeInterval = 0
    @State private var timer: Timer?
    @State private var isExpired = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(spacing: 16) {
                    Text(model.title ?? "")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(model.description ?? "")
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .font(.footnote)
                }
                VStack {
                    Spacer()
                    CachedImageView(urlString: model.image ?? "", width: imageWidth, height: imageWidth*0.7, cornerRadius: 0)
                        
                }
            }
            VStack {
                Text(isExpired ? "EXPIRED" : formatTime(timeRemaining))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color.black.opacity(0.18)
                            .blur(radius: 4)
                            .cornerRadius(6)
                    )
                    
                Spacer()
            }
            
        }
        .padding()
        .background(Color(hex: model.backgroundColor ?? "#86B1E0"))
        .cornerRadius(12, corners: .allCorners)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        calculateTimeRemaining()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            calculateTimeRemaining()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func calculateTimeRemaining() {
        guard let endDateString = model.endTime else {
            isExpired = true
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        
        guard let endDate = formatter.date(from: endDateString) else {
            isExpired = true
            return
        }
        
        // Set end time to end of day (23:59:59)
        let calendar = Calendar.current
        let endOfDay = calendar.startOfDay(for: endDate).addingTimeInterval(24 * 60 * 60 - 1)
        
        let now = Date()
        let remaining = endOfDay.timeIntervalSince(now)
        
        if remaining <= 0 {
            isExpired = true
            timeRemaining = 0
            stopTimer()
        } else {
            isExpired = false
            timeRemaining = remaining
        }
    }
    
    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let totalSeconds = Int(timeInterval)
        let days = totalSeconds / (24 * 60 * 60)
        let hours = (totalSeconds % (24 * 60 * 60)) / (60 * 60)
        let minutes = (totalSeconds % (60 * 60)) / 60
        let seconds = totalSeconds % 60
        
        if days > 0 {
            return String(format: "%02d : %02d : %02d : %02d", days, hours, minutes, seconds)
        } else {
            return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
        }
    }
}
