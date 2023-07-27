//
//  FinanseView.swift
//  bc
//
//  Created by Evgeny Hailov on 29.06.2023.
//

import SwiftUI
import RxSwift

struct FinanсeView: View {
    
    @Binding var path: [Int]
    @ObservedObject var model = FinanсeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if model.error != nil {
                    Text(model.error!.localizedDescription).foregroundColor(.primary)
                } else if model.model != nil && !model.isNil() {
                    if model.model!.isEmpty {
                        Text("noData").foregroundColor(.primary)
                    } else {
                        List(model.model!) { data in
                            FinanсeItem(data: data)
                                .listRowBackground(data.article == "Приход" ? Color.mint : Color.pink)
                                .listRowSeparator(.visible)
                                .listStyle(.automatic)
                        }.refreshable {
                            model.updateData()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Finance")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                FinanсeCustomBarItem(path: $path)
            }
        }
    }
}
    
struct FinanсeItem: View {
    
    @State var isSheet: Bool = false
    var data: FinanseModel
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Button {
                    isSheet.toggle()
                } label: {
                    Image("Check").resizable()
                        .frame(width: 90, height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 0)
                            .foregroundColor(Color.black))
                }
                Text(data.date).font(.system(size: 12)).padding(.top).foregroundColor(Color.white)
            }
            Spacer()
            VStack {
                LabeledContent("direction", value: data.text)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("typeOfWork", value: data.typeOfWork)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("anObject", value: data.objects)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("counterparty", value: data.accoun)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("contractNumber", value: data.number)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("theAmount", value: data.sum)
                    .font(.system(size: 12)).foregroundColor(Color.white)
                LabeledContent("cash", value: data.kassa)
                    .font(.system(size: 12)).foregroundColor(Color.white)
            }
        }
        .sheet(isPresented: $isSheet) {
            ImagesView(data, isPresented: $isSheet)
        }
    }
    
}

struct FinanсeCustomBarItem: ToolbarContent {
    
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
                path = [2]
            } label: {
                Image(systemName: "plus.circle.fill")
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                path = [3]
            } label: {
                Image(systemName: "dollarsign.circle.fill")
            }
        }
    }
    
}
