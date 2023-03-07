//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Zicount on 09.02.23.
//

import SwiftUI
import FirebaseCore

@main
struct BookStoreApp: App {

	init() {
		FirebaseApp.configure()
	}

    var body: some Scene {
        WindowGroup {
			ContentView()
				.environmentObject(BookViewModel())
        }
    }
}
