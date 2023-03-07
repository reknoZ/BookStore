//
//  BookViewModel.swift
//  BookStore
//
//  Created by Zicount on 09.02.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class BookViewModel: ObservableObject {
	private let db = Firestore.firestore()
	
	@Published var taskCompleted = false
	
	@MainActor
	func addBook(bookData: [String: Any]) async {
		do {
			try await db.collection("books").document().setData(bookData)
			taskCompleted = true
			print ("DEBUG: Book added successfully.")
		} catch {
			print ("DEBUG: Unable to add book")
		}
	}
	
	@MainActor
	func editBook(bookID: String, bookData: [String: Any]) async {
		do {
			try await db.collection("books").document(bookID).updateData(bookData)
			taskCompleted = true
			print ("DEBUG: Book updated successfully.")
		} catch {
			print ("DEBUG: Unable to update book")
		}
	}
	
	func deleteBook(book: Book) async {
		guard let bookID = book.id else {
			print ("Debug: Unable to find book id")
			return
		}
		
		do {
			try await db.collection("books").document(bookID).delete()
			print ("DEBUG: Book deleted successfully.")
		} catch {
			print ("DEBUG: Unable to delete book.")
		}
	}
}
