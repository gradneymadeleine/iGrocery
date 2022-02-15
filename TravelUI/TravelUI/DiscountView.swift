import SwiftUI

struct DiscountView: View {
    
    var selectedDiscount : DisModel!
    var animation : Namespace.ID
  
    var body: some View {
        VStack {
            
            VStack{
                
                HStack{
                    VStack{
                        Image(selectedDiscount.image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 75, height: 75)
                            .cornerRadius(35)
                            .matchedGeometryEffect(id: selectedDiscount.image, in: animation)
                        Text(selectedDiscount.title)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color("txt"))
                    }
                    
                    
                }
            }
        }
    }
}

