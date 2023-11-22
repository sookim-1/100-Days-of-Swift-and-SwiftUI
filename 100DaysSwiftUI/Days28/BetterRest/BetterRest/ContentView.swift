//
//  ContentView.swift
//  BetterRest
//
//  Created by 수킴 on 2022/11/14.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var sleepTime: String {
        do {
            let config = MLModelConfiguration()
            // 모델 인스턴스 생성
            let model = try SleepCalculator(configuration: config)

            // DatePicker로 가져온 시간 값
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            // 모델의 파라미터로 입력값들 전달
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            // 결과값 계산
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "에러가 발생했습니다."
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("시간을 선택하세요", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("언제 일어나시겠습니까?")
                            .font(.headline)
                }

                Section {
                    Stepper("\(sleepAmount.formatted())시간", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("수면시간을 지정하세요")
                        .font(.headline)
                }
                
                
                Section {
                    Picker("커피 섭취량", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text($0 == 1 ? "1잔" : "\($0)잔")
                        }
                    }
                    // Stepper(coffeeAmount == 1 ? "1잔" : "\(coffeeAmount)잔", value: $coffeeAmount, in: 1...20)
                } header: {
                    Text("하루 커피 섭취량")
                        .font(.headline)
                }
                
                Section {
                    Text(sleepTime)
                } header: {
                    Text("권장 수면시간")
                        .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("확인") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            // 모델 인스턴스 생성
            let model = try SleepCalculator(configuration: config)

            // DatePicker로 가져온 시간 값
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            // 모델의 파라미터로 입력값들 전달
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            // 결과값 계산
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "추천 수면시간은 "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "에러"
            alertMessage = "계산할 수 없습니다."
        }

        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
