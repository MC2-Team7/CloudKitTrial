//
//  ContentView.swift
//  CloudKitTrial
//
//  Created by JaeUngJang on 2023/05/04.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    
    @StateObject private var vm: ItemListViewModel
    
    @State var title: String = ""
    @State var price: String = ""
    
    init(vm: ItemListViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    func deleteItem(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = vm.items[index]
            if let recordId = item.recordId {
                vm.deleteItem(recordId)
            }
            
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TextField("Enter Ingredient", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Enter Price", text: $price)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save") {
                    guard let price = try? Decimal(price, format: .number) else { return }
                    
                    vm.saveItem(title: title, price: price)
                    
                    self.title = ""
                    self.price = ""
                    
                }.disabled(title.trimmingCharacters(in: .whitespaces).isEmpty || price.trimmingCharacters(in: .whitespaces).isEmpty)
                
                Spacer()
                
                List {
                    ForEach(vm.items, id: \.recordId) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Text("$ " + String(describing: item.price))
                        }
                    }.onDelete(perform: deleteItem)
                }
                
                
                    .navigationTitle("Ingredient")
            }
            .padding()
            .onAppear {
                vm.populateItem()
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
