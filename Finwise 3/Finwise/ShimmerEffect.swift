//
//  ShimmerEffect.swift
//  Finwise
//
//  Created by UTKARSH NAYAN on 30/03/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig) -> some View {
        self
            .modifier(ShimmerEffectHelper(config: config))
    }
}

fileprivate struct ShimmerEffectHelper: ViewModifier {
    var config: ShimmerConfig
    
    @State private var moveTo: CGFloat = -0.7
    
    func body(content: Content) -> some View {
        content
            .hidden()
            .overlay {
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader { geometry in
                            let size = geometry.size
                            let extraOffset = size.height / 2.5
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                        .fill(.linearGradient(colors: [
                                            .white.opacity(0),
                                            config.highlight.opacity(config.highlightOpacity),
                                            .white.opacity(0)
                                        ], startPoint: .top, endPoint: .bottom))
                                        .blur(radius: config.blur)
                                        .rotationEffect(.init(degrees: -70))
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                        }
                        .mask {
                            content
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}

struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var blur: CGFloat
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 2
}

//#Preview {
//    ContentView()
//}

//
//#Preview {
//    ShimmerEffect()
//}
