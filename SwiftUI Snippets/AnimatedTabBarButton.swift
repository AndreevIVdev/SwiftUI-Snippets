//
//  ContentView.swift
//  SwiftUI Snippets
//
//  Created by Илья Андреев on 31.05.2022.
//

import SwiftUI
import PureSwiftUI

struct AnimatedTabBarButton: View {
    let buttonConfigs: [[(title: String, imageName: String)]]
    
    @State private var showingButton: Bool = true
    @State private var homeLocation: CGPoint = .zero
    
    private let defaultAnimation: Animation = .easeOut(duration: 0.2)
    private let hideAnimation: Animation = .easeOut(duration: 0.2)
    private let showAnimation: Animation = .spring(response: 0.3, dampingFraction: 0.6)

    var body: some View {
        ZStack {
            Color
                .black
                .opacity(showingButton ? 0.8 : 0)
                .animation(defaultAnimation)
            VStack(spacing: 50) {
                Spacer()
                ForEach(buttonConfigs.indices, id: \.self) { row in
                    HStack(spacing: 50) {
                        ForEach(buttonConfigs[row].indices, id: \.self) { column in
                            CustomTabBarButton(title: buttonConfigs[row][column].title, imageName: buttonConfigs[row][column].imageName)
                                .offsetToPositionIfNot(showingButton, homeLocation)
                                .opacity(showingButton ? 1 : 0)
                                .onTapGesture {
                                    print(row, column)
                                }
                        }
                    }
                    .padding(.top, 20)
                }
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .rotationEffect(showingButton ? .degrees(45) : .degrees(0))
                    }
                    .geometryReader { geo in
                        homeLocation = geo.globalCenter
                    }
                    .onTapGesture {
                        withAnimation(showingButton ? hideAnimation : showAnimation) {
                            showingButton.toggle()
                        }
                    }
                    .padding(.bottom)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTabBarButton(
            buttonConfigs: [
                [("Favorite", "star"), ("Tag", "tag"), ("Share", "square.and.arrow.up")],
                [("Comment", "text.bubble"), ("Delete", "trash")]
            ]
        )
    }
}

struct CustomTabBarButton: View {
    
    let title: String
    let imageName: String
    
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 50, height: 50)
            .overlay {
                Image(systemName: imageName)
            }
            .overlay {
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .offset(y: 40)
                    .lineLimit(1)
                    .fixedSize()
            }
    }
}
