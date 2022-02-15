import SwiftUI

// Card Model And Sample Data...

struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardNumber: String
    var cardValidity: String
    var cardImage: String
}

var cards = [

    Card(cardNumber: "13Hidgh", cardValidity: "21-01-2025", cardImage: "card3"),
    
    Card(cardNumber: "19HiGk9", cardValidity: "21-01-2025", cardImage: "card2"),
    
    Card(cardNumber: "HKg182H", cardValidity: "21-01-2025", cardImage: "card1"),

]
