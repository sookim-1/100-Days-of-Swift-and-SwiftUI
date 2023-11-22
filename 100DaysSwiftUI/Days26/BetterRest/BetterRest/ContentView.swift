//
//  ContentView.swift
//  BetterRest
//
//  Created by 수킴 on 2022/11/14.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted())시간", value: $sleepAmount, in: 4...12, step: 1)
            DatePicker("날짜를 입력하세요", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
