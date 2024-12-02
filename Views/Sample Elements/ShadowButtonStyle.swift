//
//  ShadowButtonStyle.swift
//  WHIT
//
//  Created by Marcus Lair on 12/1/24.
//


import SwiftUI


// Mohammad Azam
// azamsharp.school
// Twitter: @azamsharp
struct ShadowButtonStyle: ButtonStyle {
    
    var shadowColor: Color = .black
    var shadowRadius: CGFloat = 10
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 5
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Image("Cheetah").opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            .shadow(
                color: configuration.isPressed ? shadowColor.opacity(0.4): shadowColor.opacity(0.8),
                radius: configuration.isPressed ? shadowRadius / 2 : shadowRadius,
                x: shadowX,
                y: shadowY
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ShadowButtonStyle {
    static var shadow: ShadowButtonStyle {
        ShadowButtonStyle()
    }
}

struct ContentScreen: View {
    
    var body: some View {
        VStack {
            Button {
            
            } label: {
                Text("Hello, World!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
            }
            .buttonStyle(.shadow)
        }
    }
}

#Preview {
    ContentScreen()
}
