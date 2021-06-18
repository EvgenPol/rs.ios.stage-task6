import Foundation

class CoronaClass {
    
    var desks: [Int] = []
    var seats = [Int]() { didSet { seats.sort() } }

     init(n: Int) {
        if n > 0 {
            for desk in 0..<n {
                desks.append(desk)
            }
        }
     }
    
    private func findDistanceFromOccupied(desk:Int) -> Int {
        var distance = (left:0, right:0)
        var innerDesk = desk
        while innerDesk != -1 {
            innerDesk -= 1
            if seats.contains(innerDesk) {
                distance.left = abs(desks.distance(from: desk, to: innerDesk))
                innerDesk = 0
            }
        }
        innerDesk = desk
        while innerDesk != desks.count {
            innerDesk += 1
            if seats.contains(innerDesk) {
                distance.right = abs(desks.distance(from: desk, to: innerDesk))
                innerDesk = desks.count
            }
        }
        switch distance {
        case (_, 0): return distance.left
        case (0, _): return distance.right
        default: return min(distance.left, distance.right)
        }
    }

     func seat() -> Int {
        if seats.isEmpty {
            seats.append(0)
            return 0
        } else {
            var max = 0
            var possible = [Int]()
            for desk in desks {
                if !seats.contains(desk) {
                    possible.append(findDistanceFromOccupied(desk: desk))
                    if max < possible.last! {
                        max = possible.last!
                    }
                } else {
                    possible.append(0)
                }
            }
            let place = possible.firstIndex(of: max)!
            seats.append(place)
            return place
        }
     }
    
        func leave(_ p: Int) {
            guard seats.contains(p) else { return }
            seats.remove(at: seats.firstIndex(of: p)!)
        }
    }

