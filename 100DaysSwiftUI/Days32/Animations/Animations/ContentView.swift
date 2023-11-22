//
//  ContentView.swift
//  Animations
//
//  Created by 수킴 on 2022/11/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        // 암시적애니메이션
        Button("default") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)
        
        // spring 애니메이션
        Button("interpolatingSpring") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
        
        
        // easeInOut 애니메이션
        Button("easeInOut") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.easeInOut(duration: 2)
            .delay(1)
            .repeatCount(3, autoreverses: true), value: animationAmount)
        
        // overlay 수정자
        Button("overlay") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }
        
        // 애니메이션 바인딩하기
        VStack {
            Stepper("Scale 값 : \(animationAmount.formatted(.number))", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("버튼") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        
        // 명시적애니메이션
        Button("명시적애니메이션") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
