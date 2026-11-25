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
    
    var amountForegruondColor: Color {
        if self.amount >= 10_000.0 {
            if self.amount >= 50_000.0 {
                return .red
            } else {
                return .orange
            }
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
                Section("Amout") {
                    HStack {
                        VStack {
                            Text("Total")
                                .font(.headline)
                            Text("\(expenses.totalAmount.formatted(.currency(code: "KRW")))")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Personal")
                                .font(.headline)
                            Text("\(expenses.personalAmount.formatted(.currency(code: "KRW")))")
                        }
                        .foregroundStyle(.cyan)
                        
                        Spacer()
                        
                        VStack {
                            Text("Business")
                                .font(.headline)
                            Text("\(expenses.businessAmount.formatted(.currency(code: "KRW")))")
                        }
                        .foregroundStyle(.orange)
                    }
                }
                
                ForEach(expenses.items) { item in
                    HStack(spacing: 20) {
                        Image(systemName: item.type == "Personal" ? "person" : "suitcase")
                            .font(.title2)
                            .foregroundStyle(item.type == "Personal" ? Color.cyan : Color.orange)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: "KRW"))
                            .foregroundStyle(item.amountForegruondColor)
                    }
                }
                .onDelete(perform: removeItems)
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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
