//
//  SideMenu.swift
//  SwiftUI Snippets
//
//  Created by Илья Андреев on 01.06.2022.
//

import SwiftUI

struct SideMenu: View {
    @State var isShowingSideMenu: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Button {
                        withAnimation {
                            isShowingSideMenu = true
                        }
                    } label: {
                        Text("Show side menu")
                            .bold()
                            .frame(width: 200, height: 44)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            
                    }
                    .frame(width: geo.width, height: geo.height)
                    .offset(x: isShowingSideMenu ? geo.width / 2 : 0)
                    .disabled(isShowingSideMenu)
                    
                    if isShowingSideMenu {
                        SideMenuView()
                            .frame(width: geo.width / 2, alignment: .leading)
                            .transition(.move(edge: .leading))
                    }
                }
                .navigationBarTitle("Side menu", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                isShowingSideMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }

                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded{ value in
                        if value.translation.width < -100 {
                            withAnimation {
                                isShowingSideMenu = false
                            }
                        }
                    }
            )
            
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}

struct SideMenuView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("Person", systemImage: "person")
                .font(.headline.weight(.bold))
                .imageScale(.large)
                .foregroundColor(.white)
                .padding(.top, 100)
            
            Label("Messages", systemImage: "envelope")
                .font(.headline.weight(.bold))
                .imageScale(.large)
                .foregroundColor(.white)
                .padding(.top, 30)
            
            Label("Settings", systemImage: "gear")
                .font(.headline.weight(.bold))
                .imageScale(.large)
                .foregroundColor(.white)
                .padding(.top, 30)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondary)
        .edgesIgnoringSafeArea(.all)
    }
}
