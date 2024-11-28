//
//  OnboardingView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//


// OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Date Tracker")
                .font(.largeTitle)
                .bold()
            
            Text("Keep track of your special moments together")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                dismiss()
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
    }
}
