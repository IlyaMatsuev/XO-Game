public class Computer: Playing {

    public func turn(board: Board, sign: PlayerSign) {
        var coords = getRandomCoords(max: board.size)
        while !board.move(x: coords.x, y: coords.y, sign: sign) {
            coords = getRandomCoords(max: board.size)
        }
    }

    private func getRandomCoords(max: Int) -> (x: Int, y: Int) {
        return (getRandom(max: max), getRandom(max: max))
    }

    private func getRandom(max: Int) -> Int {
        return Int.random(in: 0..<max)
    }
}
