//
//  ImagesView.swift
//  bc
//
//  Created by Evgeny Hailov on 17.07.2023.
//

import SwiftUI

struct ImagesView: View {
    
    @ObservedObject var model: ImagesViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        Color.black.overlay {
            VStack {
                ButtonView(isPresented: $isPresented)
                GeometryReader { gp in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0 ..< model.images.count) { id in
                                AsyncImage(url: URL(string: String(format: "http://bc-24.ru/media/%@", model.images[id]))) {
                                    $0.resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                        .tint(.white)
                                }
                                .frame(width: gp.size.width, height: gp.size.height)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    init(_ model: ImageModel, isPresented: Binding<Bool>) {
        self.model = ImagesViewModel(model: model)
        _isPresented = isPresented
    }
}

struct ButtonView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("close")
            }
            .padding(.leading)
            .padding(.top)
            Spacer()
        }
    }
    
}
    
