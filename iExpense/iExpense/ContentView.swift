//
//  ContentView.swift
//  iExpense
//
//  Created by 문준민 on 11/24/26.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    var amountForegroundColor: Color {
        if amount >= 50_000 {
            return .red
        } else if amount >= 10_000 {
            return .orange
        } else {
            return .green
        }
    }
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalExpenses: [ExpenseItem] {
        self.items.filter { $0.type == "Personal" }
    }

    var businessExpenses: [ExpenseItem] {
        self.items.filter { $0.type == "Business" }
    }
    
    
    var totalAmount: Double {
        var result: Double = 0.0
        for item in items {
            result += item.amount
        }
        
        return result
    }
    
    var personalAmount: Double {
        var result: Double = 0.0
        for item in items {
            if item.type == "Personal" {
                result += item.amount
            }
        }
        
        return result
    }
    
    var businessAmount: Double {
        var result: Double = 0.0
        for item in items {
            if item.type == "Business" {
                result += item.amount
            }
        }
        
        return result
    }
    
    func removeItems(at offsets: IndexSet, from items: [ExpenseItem]) {
        let ids = offsets.map { items[$0].id }

        self.items.removeAll {
            ids.contains($0.id)
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
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                // 합계 금액
                Section("Summary") {
                    HStack {
                        VStack {
                            Text("Total")
                                .font(.headline)
                            Text("\(expenses.totalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "KRW")))")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Personal")
                                .font(.headline)
                            Text("\(expenses.personalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "KRW")))")
                        }
                        .foregroundStyle(.cyan)
                        
                        Spacer()
                        
                        VStack {
                            Text("Business")
                                .font(.headline)
                            Text("\(expenses.businessAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "KRW")))")
                        }
                        .foregroundStyle(.orange)
                    }
                }
                
                // 개인
                Section("PERSONAL"){
                    ForEach(expenses.personalExpenses) { item in
                        HStack(spacing: 20) {
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundStyle(Color.cyan)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "KRW"))
                                .foregroundStyle(item.amountForegroundColor)
                        }
                    }
                    .onDelete { offsets in
                        expenses.removeItems(at: offsets, from: expenses.personalExpenses)
                    }
                }
                
                // 업무
                Section("BUSINESS"){
                    ForEach(expenses.businessExpenses) { item in
                        HStack(spacing: 20) {
                            Image(systemName: "suitcase")
                                .font(.title2)
                                .foregroundStyle(Color.orange)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "KRW"))
                                .foregroundStyle(item.amountForegroundColor)
                        }
                    }
                    .onDelete { offsets in
                        expenses.removeItems(at: offsets, from: expenses.businessExpenses)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

#Preview {
    ContentView()
}
