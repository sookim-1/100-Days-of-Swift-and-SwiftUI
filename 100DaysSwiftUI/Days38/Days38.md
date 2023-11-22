
# 1. iExpense 확장하기

1.  USD 달러 통화를 원화로 변경합니다.
    
    -   format 단위를 변경합니다.
    -   amount는 Int로 변경합니다.
    
    ```swift
    TextField("비용", value: $amount, format: .currency(code: "KRW"))
                        .keyboardType(.decimalPad)
    
    ```
    
2.  값에 따라 스타일을 변경합니다. ($10 미만의 비용, $100 미만의 비용, $100 이상의 비용)
    
    -   비용 별 조건에 따라 텍스트색상을 변경합니다.
    
    ```swift
    Text(expense.amount, format: .currency(code: "KRW"))
                    .foregroundColor(expense.amount < 10 ? .green : (expense.amount < 100 ? .yellow : .red))
    
    ```
    
3.  개인 비용과 사업 비용을 각각의 섹션으로 분리합니다. (삭제되는 방식에 주의합니다.)
    
    ```swift
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
    
    ```
    

----------
