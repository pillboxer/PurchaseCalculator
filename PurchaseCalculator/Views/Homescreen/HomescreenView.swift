//
//  ContentView.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 31/10/2020.
//

import SwiftUI

protocol Presenter: View {
    associatedtype Presented: View
    var presentee: Presented { get }
    var presenting: Bool { get set }
}

struct HomescreenView: View {
    
    @ObservedObject var coreDataManager = CoreDataManager.shared
    
    var body: some View {
        if !User.doesExist {
            NoUserHomescreen()
        }
        else {
            Text("User Exists")
        }
    }
}

struct HomeRow: RowType {
    
    var handle: String
    var imageName: String
    
    var uuid: String {
        handle
    }
}
