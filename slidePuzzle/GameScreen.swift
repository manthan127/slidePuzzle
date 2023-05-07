import SwiftUI

struct GameScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var VM: GameScreenVM
    
    let mode: Bool
    
    init(row: Int, colum: Int, mode: Bool) {
        self.mode = mode
        
        VM = GameScreenVM(row: row, colum: colum)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 3){
                ForEach(VM.data.indices, id: \.self){i in
                    HStack(spacing: 3){
                        ForEach(VM.data[i].indices, id: \.self){ j in
                            Button(action: {
                                VM.jump(i: i, j: j)
                            }, label: {
                                Text(VM.data[i][j] == VM.max ? "X": "\(VM.data[i][j])")
                                    .foregroundColor(Color.secondary)
                                    .font(.system(size: 500))
                                    .minimumScaleFactor(0.01)
                                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                                    .background(Color(#colorLiteral(red: 0.9866893888, green: 0.619958818, blue: 0.3583016098, alpha: 1)))
                                    .aspectRatio(1, contentMode: .fit)
                            })
                        }
                    }
                }
            }
            .padding(5)
            .background(Color(#colorLiteral(red: 0.3042471707, green: 0.5522135496, blue: 0.9134982228, alpha: 1)))
            .padding(15)
            Color.white
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitleDisplayMode(.inline)
        .highPriorityGesture(
            DragGesture()
                .onEnded { gesture in
                    let height = gesture.translation.height
                    let width = gesture.translation.width
                    
                    if abs(height) > abs(width) {
                        VM.slide(i: (height < 0) == mode ? 1 : -1, j: 0)
                    } else {
                        VM.slide(i: 0, j: (width < 0) == mode ? 1 : -1)
                    }
                }
        )
        .alert(isPresented: $VM.solved, content: {
            Alert(title: Text("You Win!"),
                primaryButton: .default(Text("Home Screen"), action: {
                    presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(Text("Play again"), action: {
                    VM.randomOrder()
                })
            )
        })
    }
    
}

extension Array{
    subscript(safe index: Index) -> Element? {
        (0..<count) ~= index ? self[index] : nil
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(row: 3, colum: 3, mode: true)
    }
}
