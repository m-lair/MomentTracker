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
    @State private var showSecondScreen = false
    
    var body: some View {
        if !showSecondScreen {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Moment Tracker")
                    .font(.largeTitle)
                    .bold()
                
                Text("Keep track of your special moments together")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Button("Continue") {
                    showSecondScreen = true
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        } else {
            VStack(spacing: 20) {
                Spacer()
                
                Text("To Whit💙")
                    .font(.title)
                    .bold()

                Text("I hope you enjoy this walk down memory lane ive put together! Its a short walk but im hoping we will continue to build this as we build our lives together. I love you and Merry Christmas🎄")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Button("Done") {
                    UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    dismiss()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}


#Preview {
    OnboardingView()
}
