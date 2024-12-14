//
//  MeshGradientView.swift
//  WHIT
//
//  Created by Marcus Lair on 11/27/24.
//

import SwiftUI
import Foundation

struct MeshGradientView: View {
    var baseColor: Color
    @State private var isAnimating = false
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], [isAnimating ? 0.1 : 0.9, 0.5], [1.0, isAnimating ? 0.9 : 0.1],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ],
            colors: (0..<9).map { index in
                generateColor(at: index, isAnimating: isAnimating)
            }
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
            }
        }
    }
    
    func generateColor(at index: Int, isAnimating: Bool) -> Color {
        guard let components = baseColor.getHSBComponents() else {
            return baseColor // Fallback if HSB components cannot be extracted
        }
        
        let baseHue = components.hue
        let baseSaturation = components.saturation
        let baseBrightness = components.brightness
        let baseOpacity = components.alpha
        
        var hueAdjustment: Double = Double.random(in: -0.15...0.15)
        let saturationAdjustment: Double = Double.random(in: -0.5...0.5)
        var brightnessAdjustment: Double = Double.random(in: -0.5...0.5)
        
        // Apply animation to certain colors for dynamic effect
        if isAnimating && (index == 4 || index == 5 || index == 7) {
            hueAdjustment += 0.2
            brightnessAdjustment += 0.2
        }
        
        // Ensure values are within valid ranges
        var newHue = baseHue + hueAdjustment
        if newHue < 0 { newHue += 1.0 }
        else if newHue > 1 { newHue -= 1.0 }
        
        let newSaturation = min(max(baseSaturation + saturationAdjustment, 0.0), 1.0)
        let newBrightness = min(max(baseBrightness + brightnessAdjustment, 0.0), 1.0)
        
        return Color(hue: newHue, saturation: newSaturation, brightness: newBrightness, opacity: baseOpacity)
    }
}

extension Color {
    func getHSBComponents() -> (hue: Double, saturation: Double, brightness: Double, alpha: Double)? {
        // For iOS only
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        let success = uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return success ? (Double(hue), Double(saturation), Double(brightness), Double(alpha)) : nil
    }
}
