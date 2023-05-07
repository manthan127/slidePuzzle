import SwiftUI

struct ContentView: View {
    
    @State var row = 3
    @State var colum = 3
    
    @State var mode = true
    
    var body: some View {
        VStack {
            NavigationLink(destination: GameScreen(row: row, colum: colum, mode: mode),
                           label: {
                            Text("Play")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .frame(width: 170, height: 75, alignment: .center)
                                .background(Color(#colorLiteral(red: 0.5, green: 0, blue: 1, alpha: 1)))
                                .cornerRadius(10)
                           })
                .padding()
            VStack {
                Stepper("row :- \(row)") {
                    row+=1
                    if row > 8 {row = 3}
                } onDecrement: {
                    row-=1
                    if row < 3{row = 8}
                }
                Stepper("colum :- \(colum)") {
                    colum+=1
                    if colum > 8 {colum = 3}
                } onDecrement: {
                    colum-=1
                    if colum < 3{colum = 8}
                }
            }
            .padding()
            
            Toggle("move num", isOn: $mode)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
