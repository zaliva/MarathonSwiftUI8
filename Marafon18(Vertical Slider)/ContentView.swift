//
//  ContentView.swift
//  Marafon18(Vertical Slider)
//
//  Created by ViktorM1Max on 20.03.2024.
//

import SwiftUI

struct VerticalSliderView: View {
    var sliderWidth: CGFloat = 100.0
    var sliderHeight: CGFloat = 250.0
    
    @State var sliderValue: CGFloat = 0.5
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        let dragGesture = DragGesture(minimumDistance: 0.0)
            .onChanged { value in
                sliderValue = sliderValue - (value.translation.height + value.velocity.height)*0.00005
                
                if sliderValue > 1 || sliderValue < 0 {
                    dragOffset.height = -(value.translation.height)*0.05
                } else {
                    withAnimation(.linear(duration: 0.22)) {
                        self.dragOffset = .zero
                    }
                }
                
                sliderValue = sliderValue > 1 ? 1 : sliderValue
                sliderValue = sliderValue < 0 ? 0 : sliderValue
            }
            .onEnded { _ in
                withAnimation {
                    self.dragOffset = .zero
                }
            }
        
        return ZStack(alignment: .bottom) {
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(width: sliderWidth, height: sliderHeight)
            
            Rectangle()
                .fill(.blue)
                .frame(width: sliderWidth, height: sliderHeight * sliderValue)
        }
        .foregroundStyle(.orange)
        .cornerRadius(20)
        .offset(y: -dragOffset.height)
        .scaleEffect(CGSize(width: 1.0 - abs(dragOffset.height*0.005), height: 1.0 + abs(dragOffset.height*0.01)))
        .overlay(alignment: .bottom, content: {
            
            Image(systemName: sliderValue > 0 ? "speaker.wave.3.fill" : "speaker.slash.fill", variableValue: sliderValue)
                .font(.title)
                .foregroundStyle(.white)
                .scaleEffect(1)
                .symbolEffect(.bounce, value: sliderValue == 0)
                .padding(.bottom, 30)
        })
        .gesture(dragGesture)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            VerticalSliderView()
        }
    }
}

#Preview {
    ContentView()
}
