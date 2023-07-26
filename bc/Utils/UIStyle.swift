//
//  UIStyle.swift
//  bc
//
//  Created by Evgeny Hailov on 06.07.2023.
//

import SwiftUI

struct EHBlueButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background( RoundedRectangle(cornerRadius: 5.0).fill(Color.blue)
        )
    }
    
}

struct EHRedButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.pink)
        )
    }
    
}
