//
//  BookDetailView.swift
//  BookStore
//
//  Created by Zicount on 09.02.23.
//

import SwiftUI
import FirebaseFirestore

struct BookDetailView: View {
	@State private var showingBookEditView = false
	
	let book: Book
	
    var body: some View {
		ScrollView {
			VStack {
				Image ("friday")
					.resizable()
					.scaledToFit()
					.frame(maxWidth: .infinity)
					.frame(height: 400)
				
				VStack (alignment: .leading, spacing: 20) {
					BookRow(label: "Title", value: book.title)
					BookRow(label: "Author", value: book.author)
					BookRow(label: "Price", value: "$\(book.price)")
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle(book.title)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					showingBookEditView = true
				} label: {
					Image (systemName: "square.and.pencil")
				}
			}
		}
		.sheet(isPresented: $showingBookEditView) {
			BookEditView(book: book)
		}
	}
}

struct BookRow: View {
	let label: String
	let value: String
	
	var body: some View {
		HStack (spacing: 20) {
			Spacer()
			Text (label)
			Text (value).bold()
			Spacer()
		}
		.font(.body)
		.foregroundColor(.white)
		.frame(maxWidth: .infinity)
		.frame(height: 100)
		.background(Color("bookColor"), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
	}
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
		BookDetailView(book: Book(created: Timestamp(date: Date()), title: "Friday", author: "Robert A. Heinlein", price: 19))
    }
}
