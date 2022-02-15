import SwiftUI

struct DisDetailView: View {
    
    @Binding var selectedDiscount : DisModel!
    @Binding var disShow: Bool
    var animation : Namespace.ID
    
    
    var body: some View{
        
        VStack{
            
            VStack{
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    Image(selectedDiscount.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 330)
                        .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                        .matchedGeometryEffect(id: selectedDiscount.image, in: animation)
                    
                    HStack{
                        
                        Button(action: {
                            
                            withAnimation(.spring()){disShow.toggle()}
                            
                        }) {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
        
                    }
                    .padding()
                    // since all edges are ignored....
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                }
                
                // Details View...
                
                HStack(alignment: .top){
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(selectedDiscount.title)
                            .font(.title)
                            .foregroundColor(Color("txt"))
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: selectedDiscount.title, in: animation)
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text("$" + String(selectedDiscount.price))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                }
                .padding()
                .padding(.bottom)
            }
            .background(Color.white)
            .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
            
            // ScrollView For Smaller Size Phones....
            
            if UIScreen.main.bounds.height < 750{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    BottomView(selectedDiscount: $selectedDiscount)
                }
            }
            else{
                
                BottomView(selectedDiscount: $selectedDiscount)
            }
            
            Spacer(minLength: 0)
        }
        .background(Color("bg"))
    }
            
      
}
        
    



