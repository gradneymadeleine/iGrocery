import SwiftUI

class CartViewModel {
    
    var arr = [Item]()
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func createObjects() -> Array<Item> {
        let url = self.getDocumentsDirectory().appendingPathComponent("grocery.txt")
        var str = ""
        
        do {
         // Get the saved data
         let savedData = try Data(contentsOf: url)
         // Convert the data back into a string
         if let savedString = String(data: savedData, encoding: .utf8) {
            print(savedString)
            str = savedString
         }
        } catch {
         // Catch any errors
         print(error.localizedDescription)
        }
        
        let components = str.components(separatedBy: "\n")
        
        for component in components {
            if component.count > 0 {
                let variables = component.components(separatedBy: ",")
                print(variables)
                arr.append(Item(name: variables[0], details: variables[1], image: variables[2], price: Float(variables[3]) ?? 2.99, quantity: Int(variables[4]) ?? 2, offset: 0, isSwiped: false))
            }
        }
        
        print("BEFORE PASSING")
        print(arr)
        return arr
    }
}
