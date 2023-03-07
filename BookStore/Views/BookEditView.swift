//
//  BookEditView.swift
//  BookStore
//
//  Created by Zicount on 09.02.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct BookEditView: View {
	@Environment(\.dismiss) var dismiss
	
	@EnvironmentObject var bookVM: BookViewModel
	
	@State private var title = ""
	@State private var author = ""
	@State private var price = 9
	
	var book: Book?
	
	var buttonTitle: String {
		if let _ = book {
			return "Edit Book"
		} else {
			return "Add Book"
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				Text (buttonTitle)
					.foregroundColor(Color("bookColor"))
					.font(.largeTitle.bold())
				
				Spacer()
				
				Button {
					dismiss()
				} label: {
					Image(systemName: "xmark")
						.padding(8)
						.background(Color("bookColor"))
						.foregroundColor(.white)
						.clipShape(Circle())
				}
			}
			.padding(.vertical, 30)

			Spacer()
			
			VStack(spacing: 20) {
				VStack(alignment: .leading) {
					Text ("Title:")
						.foregroundColor(Color("bookColor").opacity(0.6))
					
					TextField ("Enter Title", text: $title)
						.textFieldStyle(.roundedBorder)
				}
					
				VStack(alignment: .leading) {
					Text ("Author:")
						.foregroundColor(Color("bookColor").opacity(0.6))
					
					TextField ("Enter Author", text: $author)
						.textFieldStyle(.roundedBorder)
				}
				
				VStack(alignment: .leading) {
					Text ("Price:")
						.foregroundColor(Color("bookColor").opacity(0.6))
					
					TextField ("Enter Price", value: $price, format: .number)
						.textFieldStyle(.roundedBorder)
				}
			}
			
			Spacer()
			
			Button {
				EditBook()
			} label: {
				Text (buttonTitle)
					.bold()
					.frame(maxWidth: .infinity, maxHeight: 55)
					.background(Color("bookColor"))
					.foregroundColor(.white)
					.clipShape(Capsule())
			}
			
			Spacer ()
		}
		.padding(.horizontal)
		.onAppear {
			if let book = book {
				title = book.title
				author = book.author
				price = book.price
			}
		}
    }
	
	func EditBook() {
		let bookData: [String: Any] = [
			"title": title,
			"author": author,
			"price": price,
			"created": FieldValue.serverTimestamp()
		]
		
		if let book = book {
			// Update Book
			guard let bookID = book.id else { return }
			
			Task {
				await bookVM.editBook(bookID: bookID, bookData: bookData)
				if bookVM.taskCompleted {
					dismiss()
				}
			}
		} else {
			// Add Book
			Task {
				await bookVM.addBook(bookData: bookData)
				if bookVM.taskCompleted {
					dismiss()
				}
			}
		}
	}
}

struct BookEditView_Previews: PreviewProvider {
    static var previews: some View {
        BookEditView()
    }
}
