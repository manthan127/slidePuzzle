import Foundation

class GameScreenVM: ObservableObject {
    
    @Published var data = [[Int]]()
    
    let row: Int
    let colum: Int
    let max: Int
    let ans: [[Int]]
    
    var XRow: Int
    var XColum: Int
    
    var solved = false
    
    init(row: Int, colum: Int) {
        self.row = row
        self.colum = colum
        max = row*colum
        ans = stride(from: 1, to: max, by: colum).map{Array($0..<(colum+$0))}
        XRow = row - 1
        XColum = colum - 1
        randomOrder()
    }
    
    
    func inver(arr: [Int]) -> Int {
        var c = 0
        (0..<arr.count - 1).forEach { i in
            c += (i+1..<arr.count).filter{ arr[i] > arr[$0] }.count
        }
        return c
    }
    
    
    func randomOrder() {
        
        var rand = (1..<(max)).shuffled()
        rand.append(max)
        
        if inver(arr: rand) % 2 == 1 {
            (rand[0], rand[1]) = (rand[1], rand[0])
        }
        
        data = stride(from: 0, to: max, by: colum).map{Array(rand[$0..<(colum+$0)])}
    }
    
    
    func jump(i: Int, j: Int){
        while XRow != i {
            if i < XRow {
                (data[XRow-1][XColum], data[XRow][XColum]) = (data[XRow][XColum], data[XRow-1][XColum])
                XRow -= 1
            } else {
                (data[XRow+1][XColum], data[XRow][XColum]) = (data[XRow][XColum], data[XRow+1][XColum])
                XRow += 1
            }
        }
        while XColum != j {
            if j < XColum {
                (data[XRow][XColum-1], data[XRow][XColum]) = (data[XRow][XColum], data[XRow][XColum-1])
                XColum -= 1
            } else {
                (data[XRow][XColum+1], data[XRow][XColum]) = (data[XRow][XColum], data[XRow][XColum+1])
                XColum += 1
            }
        }
        solved = data == ans
    }
    
    func slide(i: Int, j: Int) {
        guard let _ = data[safe: XRow+i]?[safe: XColum+j] else {return}
        (data[XRow+i][XColum+j], data[XRow][XColum]) = (data[XRow][XColum], data[XRow+i][XColum+j])
        XColum += j
        XRow += i
        solved = data == ans
    }
    
}
