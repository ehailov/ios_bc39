//
//  ImagesView.swift
//  bc
//
//  Created by Evgeny Hailov on 17.07.2023.
//

import SwiftUI

struct ImagesView: View {
    
    @ObservedObject var model: ImagesViewModel
   
    var body: some View {
        Color.black.overlay {
        VStack {
            ButtonView(isPresented: $model.isPresented, isSharedSheet: $model.isSharedSheet)
            GeometryReader { gp in
                TabView {
                    ForEach(0..<model.images.count) { num in
                        ItemView(num: num, model: model)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: gp.size.width, height: gp.size.height)
            }
            .sheet(isPresented: $model.isSharedSheet) {
                    SharedSheet(items: model.sharedImages)
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    init(_ model: ImageModel, isPresented: Binding<Bool>) {
        self.model = ImagesViewModel(model: model, isPresented: isPresented)
    }
    
}

struct ItemView: View {
    
    var num: Int
    @ObservedObject var model: ImagesViewModel
    
    var body: some View {
        AsyncImage(url: model.getUrl(model.images[num])) { phase in
            switch phase {
            case .empty:
                ProgressView().tint(.white)
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .tag(num)
                    .onAppear() {
                        model.sharedImages.append(image.snapshot())
                    }
            case .failure:
                Text("noData").foregroundColor(.white)
            @unknown default:
                EmptyView()
            }
            
        }
    }
    
}

struct ButtonView: View {
    
    @Binding var isPresented: Bool
    @Binding var isSharedSheet: Bool
    
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
            Button {
                isSharedSheet.toggle()
            } label: {
                Image(systemName: "square.and.arrow.up.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.trailing)
            .padding(.top)
        }
    }
    
}
