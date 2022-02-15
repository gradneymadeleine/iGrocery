import SwiftUI

struct DisModel: Identifiable{
    var id = UUID().uuidString
    var image : String
    var title: String
    var price: Float
    var quantity: Int
    var detial : String
}

var disItem = [
    DisModel(image: "r1", title: "Potato", price: 2.99, quantity: 0, detial: "IN-N-OUT potatos"),
    DisModel(image: "r2", title: "Cookies", price: 2.99, quantity: 0, detial: "very sweet cookies"),
    DisModel(image: "r3", title: "Fresh Bread", price: 2.99, quantity: 0, detial: "very fresh bread"),
    DisModel(image: "r4", title: "Watermelon", price: 2.99, quantity: 0, detial: "very big watermeln"),
    DisModel(image: "r5", title: "Lemon", price: 2.99, quantity: 0, detial: "very yellow lemon"),
]


