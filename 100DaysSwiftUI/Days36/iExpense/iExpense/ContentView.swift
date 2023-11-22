//
//  ContentView.swift
//  iExpense
//
//  Created by 수킴 on 2022/11/23.
//

import SwiftUI

/// 사용자 정보를 저장하는 클래그
class User: ObservableObject {
    
    @Published var firstName = "Soo"
    @Published var lastName = "Kim"
    
}

/// Codable 구조체
struct CodableUser: Codable {
    
    let firstName: String
    let lastName: String
    
}

struct ContentView: View {
    
    @State private var showingSheet = false
    @StateObject var user = User()
    @State private var numbers: [Int] = []
    @State private var currentNumber = 1
    
    // @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    @State private var codableUser = CodableUser(firstName: "Soo", lastName: "Kim")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName).")
                
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
                
                Button("Show Sheet") {
                    tapCount += 1
                    
                    // UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                    showingSheet.toggle()
                }
                
                Button("User객체 저장하기") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(codableUser) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("행 추가하기") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Sookim")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
