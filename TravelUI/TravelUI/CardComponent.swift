import SwiftUI

struct CardComponent: View {
    
    // Animation Properties...
    @State var startAnimation = false
    @State var startCardRotation = false
    @State var selectedCard: Card = Card(cardNumber: "", cardValidity: "", cardImage: "")
    
    // Hero Effect...
    @State var cardAnimation = false
    @Namespace var animation
    
    // Color SCheme..
    @Environment(\.colorScheme) var colorSCheme
    
    var body: some View {
        
        ScrollView{
            
            VStack{
                
                // Card View...
                ZStack{
                    
                    // since Zstack will overlay on one another so last card will be first....
                    
                    // to avoid this were reversing the array
                    ForEach(cards.indices.reversed(),id: \.self){index in
                        
                        CardView(card: cards[index])
                        // displaying first three Cards...
                        // other all will be hidden
                        // you can use scrollview to explore all cards...
                        
                        // Scaling...
                            .scaleEffect(selectedCard.id == cards[index].id ? 1 : index == 0 ? 1 : 0.9)
                        
                        // Rotation...
                        // resetting rotation when clicked....
                            .rotationEffect(.init(degrees: startAnimation ? 0 : index == 1 ? -15 : (index == 2 ? 15 : 0)))
                            
                        
                            // On Click...
                            .onTapGesture {animateView(card: cards[index])}
                            
                            .offset(y: startAnimation ? 0 : index == 1 ? 60 : (index == 2 ? -60 : 0))
                        // since we applied rotation so we need to change y in order to get x Axis...
                            
                            // Hero Effect..
                            .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                        
                        // Rotating card back to 0deg...
                            .rotationEffect(.init(degrees: selectedCard.id == cards[index].id && startCardRotation ? -90 : 0))
                        
                        // Moving the selected Card to top...
                            .zIndex(selectedCard.id == cards[index].id ? 1000 : 0)
                            
                        // Hiding unselected Cards...
                            .opacity(startAnimation ? selectedCard.id == cards[index].id ? 1 : 0 : 1)
                    }
                }
                // rotating all cards
                .rotationEffect(.init(degrees: 90))
                // since were rotating so height will be the width...
                // -30 will be horizontal padding...
                .frame(height: getRect().width - 30)
                .scaleEffect(0.9)
                .padding(.top,20)

            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("gray").ignoresSafeArea())
        // blurring the whole view...
        .blur(radius: cardAnimation ? 100 : 0)
        .overlay(
        
            ZStack(alignment: .topTrailing, content: {
                
                // Detail View...
                if cardAnimation{
                    
                    // Close Button...
                    Button(action: {
                        // closing the view...
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5)){
                        
                            startCardRotation = false
                            
                            selectedCard = Card(cardNumber: "", cardValidity: "", cardImage: "")
                            cardAnimation = false
                            startAnimation = false
                        }
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorSCheme != .dark ? .white : .black)
                            .padding()
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    .padding()
                    
                    // Card View...
                    CardView(card: selectedCard)
                        .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            })
        )
    }
    
    func animateView(card: Card){
        
        if selectedCard.cardNumber == ""{
            
            //setting current card...
            selectedCard = card
            
            // rotating card and blurring the whole view...
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)){
                
                // to avoid multiple clicks so were avoiding using toggle()....
                startAnimation = true
            }
            
            // After 0.2s Rotating Card...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                withAnimation(.spring()){
                    startCardRotation = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                
                withAnimation(.spring()){
                    cardAnimation = true
                }
            }
        }
    }
}

// extending view to get Screen Frame...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

// Card View...
struct CardView: View {
    
    var card: Card
    
    var body: some View{
        
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
            
                VStack(alignment: .leading,spacing: 10){
                    
                    Spacer()
                    
                    Text(card.cardNumber)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y: 25)
                    
                    Spacer()
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("COUPON")
                                .fontWeight(.bold)
                        })
                        
                        Spacer(minLength: 10)
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("VALID TILL")
                                .fontWeight(.bold)
                            
                            Text(card.cardValidity)
                                .fontWeight(.bold)
                        })
                    }
                    .foregroundColor(.white)
                    
                }
                .padding()
            )
    }
}
