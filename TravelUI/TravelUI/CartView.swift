import SwiftUI

struct CartView: View {
    @State var cartData = CartViewModel().createObjects()
    @State var checkShow = false
    var animation : Namespace.ID
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }

    var body: some View {

        VStack{
            
            HStack(spacing: 20){
                
                Text("My cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .onTapGesture {
                        print(cartData)
                    }
                
                Spacer()
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {

                LazyVStack(spacing: 0){
                    
                    ForEach(refresh()){data in

                        ItemView(item: $cartData[getIndex(item: data)],items: $cartData)
                    }
                }
            }
            
//             Bottom View...
            
            VStack{

                HStack{

                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)

                    Spacer()

                    // calculating Total Price...
                    Text(calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top,.horizontal])


                Button(action: {
                    checkShow = true
                }) {
                    Text("Check out")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color("lightblue"),Color("blue")]), startPoint: .leading, endPoint: .trailing)
                        ).sheet(isPresented: $checkShow, content: {
                            CheckOutView(checkShow: $checkShow, animation: animation)
                        })
                        .cornerRadius(15)
                }

            }
            .background(Color.white)

        }
        .background(Color("gray").ignoresSafeArea())
    }

    func getIndex(item: Item)->Int{
        
        print("INDEX:")
        print(cartData.firstIndex{ (item1) -> Bool in
            return item.id == item1.id
        } ?? 0)
        return cartData.firstIndex{ (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }

    func calculateTotalPrice()->String{

        var price : Float = 0

        cartData.forEach { (item) in
            price += Float(item.quantity) * item.price
        }

        return getPrice(value: price)
    }
    
    func refresh() -> Array<Item> {
//        let url = self.getDocumentsDirectory().appendingPathComponent("grocery.txt")
//
//        for item in cartData {
//            var str = item.name + "," + item.details + "," + item.image + ","
//            str += String(item.price) + "," + String(item.quantity) + ",0,false\n"
//
//            do {
//                try str.write(to: url, atomically: true, encoding: .utf8)
//                let input = try String(contentsOf: url)
//                print(input)
//                print(self.getDocumentsDirectory())
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
        
        cartData = CartViewModel().createObjects()
        return cartData
    }
}
