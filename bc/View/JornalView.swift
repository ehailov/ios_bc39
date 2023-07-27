//
//  JornalView.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI

struct JornalView: View {
    
    @Binding var path: [Int]
    @ObservedObject var model = JornalViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if model.error != nil {
                    Text(model.error!.localizedDescription).foregroundColor(.primary)
                } else if model != nil && !model.isNil() {
                    if model.model!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        List(model.model!) { data in
                            JornalItem(data: data)
                        }.refreshable {
                            model.updateData()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                JornalCustomBarItem(path: $path)
                
            }
        }
    }
}

struct JornalItem: View {
    
    @State var isSheet: Bool = false
    var data: JurnalModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Button {
                    isSheet.toggle()
                } label: {
                    AsyncImage(url: URL(string: String(format: "http://bc-24.ru/media/%@", data.file0))) {
                        $0.resizable().scaledToFill()
                    } placeholder: { ProgressView() }
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                Text(data.date).font(.system(size: 10))
            }
            Spacer()
            VStack {
                LabeledContent(String(format: "%@:", data.worker), value: data.work).font(.system(size: 12))
                LabeledContent(String(format: "%@:", data.obj), value: data.typeOfWork).font(.system(size: 12))

            }
            .sheet(isPresented: $isSheet) {
                ImagesView(data, isPresented: $isSheet)
            }
        }
    }
}

struct JornalCustomBarItem: ToolbarContent {
    
    @Binding var path: [Int]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Image("Logo2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 18, alignment: .leading)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                path = [4]
            } label: {
                Image(systemName: "plus.circle.fill")
            }
        }
    }
}
