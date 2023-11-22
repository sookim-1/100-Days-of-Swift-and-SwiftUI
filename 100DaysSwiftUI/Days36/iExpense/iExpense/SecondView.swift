//
//  SecondView.swift
//  iExpense
//
//  Created by 수킴 on 2022/11/23.
//

import SwiftUI

struct SecondView: View {
    
    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Hello, \(name)!")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
    
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(name: "sookim")
    }
}
