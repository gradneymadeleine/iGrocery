import SwiftUI

struct CheckOutView: View {
    
    @Binding var checkShow: Bool
    @State var address = ""
    @State var city = ""
    @State var state = ""
    @State var zip = ""
    @State var cardNumber = ""
    @State var expireDate = ""
    @State var cvc = ""
    @State var coupon = ""
    @State var confirmAlert = false
    var animation : Namespace.ID
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    var body: some View{
        
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:15) {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {

                        HStack{

                            Button(action: {

                                withAnimation(.spring()){checkShow.toggle()}

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
                    
                    HStack(spacing: 20){
                        
                        Text("Coupon")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("txt"))
                        
                        Spacer()
                    }
                    .padding()
                    
                    CardComponent()
                    
                    VStack(spacing:15) {
                        
                        HStack(spacing: 20){
                            
                            Text("Address Info: ")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("txt"))
                            
                            Spacer()
                        }
                        .padding()
                        
                        VStack {
                            CustomTextField(image: "house", title: "Address", value: $address, animation: animation)
                            CustomTextField(image: "house", title: "City", value: $city, animation: animation)
                                .padding(.top,5)
                            
                            CustomTextField(image: "house", title: "State", value: $state, animation: animation)
                                .padding(.top,5)
                            CustomTextField(image: "house", title: "Zip Code", value: $zip, animation: animation)
                                .padding(.top,5)
                        }
                        .foregroundColor(.black)
                        
                        HStack(spacing: 20){
                            
                            Text("Payment Info: ")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("txt"))
                            
                            Spacer()
                        }
                        .padding()
                        
                        VStack {
                            CustomTextField(image: "creditcard", title: "Card Number", value: $cardNumber, animation: animation)
                                .padding(.top,5)
                            CustomTextField(image: "timer", title: "Expiration Date(MM/YYYY)", value: $expireDate, animation: animation)
                                .padding(.top,5)
                            CustomTextField(image: "number", title: "CVC/CVV", value: $cvc, animation: animation)
                                .padding(.top,5)
                            CustomTextField(image: "barcode", title: "Coupn", value: $coupon, animation: animation)
                                .padding(.top,5)
                        }
                        .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation{
                                
                                confirmAlert.toggle()
                            }
                        }) {
                            Text("Confirm")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 30)
                                .background(
                                    LinearGradient(gradient: .init(colors: [Color("lightblue"),Color("blue")]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(15)
                        }.sheet(isPresented: $confirmAlert, content: {
                            ConfirmAlertView(show: $confirmAlert, aboveShow: $checkShow)
                                .edgesIgnoringSafeArea(.bottom)
                        })
                        
                        }
                        
                    }
                    
                    .padding(.top)
                }

            }
            .padding(.bottom,UIApplication.shared.windows.first!.safeAreaInsets.bottom == 0 ? 5 : UIApplication.shared.windows.first!.safeAreaInsets.bottom)
            .background(Color("gray").ignoresSafeArea())
//            .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
            
            Spacer(minLength: 0)
        }
    }


struct ConfirmAlertView : View {
    @Binding var show : Bool
    @Binding var aboveShow : Bool
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    var body : some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            VStack(spacing: 25){
                
                Image("delivery")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 50, height: 50)
                    
                
                
                Text("Comfirmed")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text("Your order will be delivered shortly")
                    .font(.footnote)
                
                Button(action: {
                    show.toggle()
                    aboveShow.toggle()
                    
                    // clean the shopping cart
                    let str = ""
                    let url = self.getDocumentsDirectory().appendingPathComponent("grocery.txt")
                    
                    do {
                        try str.write(to: url, atomically: true, encoding: .utf8)
                        let input = try String(contentsOf: url)
                        print(input)
                        print(self.getDocumentsDirectory())
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }){
                    Text("Thank You")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal,25)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color("lightblue"),Color("blue")]), startPoint: .leading, endPoint: .trailing))
//                        .background(Color.purple)
                        .clipShape(Capsule())
                    
                    
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            
//            Button(action: {
//
//                withAnimation{
//                    show.toggle()
//                }
//            }){
//                Image(systemName: "xmark.circle")
//
//                    .font(.system(size: 28, weight: .bold))
//                    .foregroundColor(.blue)
//
//            }
//            .padding()
//
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35))
    }
}

struct BlurView : UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context){
        
    }
    
}

