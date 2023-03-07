//
//  Book.swift
//  BookStore
//
//  Created by Zicount on 09.02.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Book: Codable, Comparable, Identifiable {
	@DocumentID var id: String?
	var created: Timestamp
	
	var title: String
	var author: String
	var price: Int
	
	static func <(lhs: Book, rhs: Book) -> Bool {
		return (lhs.author, lhs.title) < (rhs.author, rhs.title)
	}
}
