import SwiftUI

struct CustomTextField: View {
    
    // Fields...
    var image: String
    var title: String
    @Binding var value: String
    
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack(spacing: 6){
            
            HStack(alignment: .bottom){
                
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(value == "" ? .gray : .primary)
                    .frame(width: 35)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    if value != ""{
                        
                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        
                        if value == ""{
                            
                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                        }
                        
                        if title == "Card Number"{
                            
                            SecureField("", text: $value)
                        } else if title == "CVC/CVV"{
                            TextField("", text: $value)
                                .keyboardType(title == "CVC/CVV" ? .numberPad : .default)
                        } else if title == "zip" {
                            TextField("", text: $value)
                                .keyboardType(title == "Zip Code" ? .numberPad : .default)
                        }
                        else{
                            TextField("", text: $value)
                            // For Phone Number...
                                .keyboardType(title == "Coupon" ? .numberPad : .default)
                        }
                    }
                }
            }
            
            if value == ""{
                
                Divider()
            }
        }
        .padding(.horizontal)
        .padding(.vertical,10)
        .background(Color("txt-1").opacity(value != "" ? 1 : 0))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.05), radius: 5, x: -5, y: -5)
        .padding(.horizontal)
        .padding(.top)
        .animation(.linear)
    }
}
