//
//  ContentView.swift
//  BookStore
//
//  Created by Zicount on 09.02.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
	@State private var showingEditBookView = false
	@EnvironmentObject var bookVM: BookViewModel
	
	@FirestoreQuery(collectionPath: "books") var books: [Book]
	
	var body: some View {
		NavigationView {
			List {
				ForEach (books.sorted()) { book in
					NavigationLink {
						BookDetailView(book: book)
					} label: {
						HStack(alignment: .center) {
							Image("stranger")
								.resizable()
								.frame(width: 50, height: 70)
								.cornerRadius(10)
							
							VStack(alignment: .leading) {
								Text (book.title)
									.font(.headline)
								
								Text (book.author)
									.font(.subheadline)
									.foregroundColor(.secondary)
							}
						}
					}
				}
				.onDelete(perform: delete)
			}
			.listStyle(.plain)
			.navigationTitle("Book Store")
			.sheet(isPresented: $showingEditBookView) {
				BookEditView()
			}
			.toolbar {
				ToolbarItem (placement: .navigationBarTrailing) {
					Button {
						showingEditBookView = true
					} label: {
						Image(systemName: "plus")
							.padding()
							.background(Color("bookColor"))
							.foregroundColor(.white)
							.clipShape(Circle())
					}
				}
			}
			.accentColor(Color("bookColor"))
		}
	}
	
	func delete(at offsets: IndexSet) {
		offsets.forEach { index in
			let book = books[index]
			Task {
				await bookVM.deleteBook(book: book)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			ContentView()
	    }
	}
}
