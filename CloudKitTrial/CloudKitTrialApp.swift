//
//  CloudKitTrialApp.swift
//  CloudKitTrial
//
//  Created by JaeUngJang on 2023/05/04.
//

import SwiftUI
import CloudKit

@main
struct CloudKitTrialApp: App {
    
    // public container
    let container = CKContainer(identifier: "iCloud.com.example.cookcook")
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ItemListViewModel(container: container))
        }
    }
}
