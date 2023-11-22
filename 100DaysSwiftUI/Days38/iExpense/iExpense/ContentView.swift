//
//  ContentView.swift
//  iExpense
//
//  Created by 수킴 on 2022/11/23.
//

import SwiftUI

/// 개인용 사업용 나누는 뷰
struct ExpensesTypeView: View {
    let type: String
    let expenses: Expenses
    let removeItemsAction: Optional<(IndexSet) -> Void>
    
    var body: some View {
        VStack {
            Text(type)
            List {
                ForEach(expenses.items) { item in
                    if item.type == type {
                        ExpenseView(expense: item)
                    }
                }
                .onDelete(perform: removeItemsAction)
            }
        }
    }
}

struct ExpenseView: View {
    let expense: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type)
            }
            Spacer()
            Text(expense.amount, format: .currency(code: "KRW"))
                .foregroundColor(expense.amount < 10 ? .green : (expense.amount < 100 ? .yellow : .red))
        }
    }
}

/// 단일 비용 표시하는 구조체
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String        // 이름
    let type: String        // 개인, 사업 용 여부
    let amount: Double      // 비용
}

/// 비용 항목의 배열을 저장하는 클래스
class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}

struct ContentView: View {
    
    @StateObject var expenses = Expenses()          // 처음 인스턴스 생성할 때만 @StateObject
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                ExpensesTypeView(type: "개인", expenses: expenses, removeItemsAction: removeItems)
                ExpensesTypeView(type: "사업", expenses: expenses, removeItemsAction: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
