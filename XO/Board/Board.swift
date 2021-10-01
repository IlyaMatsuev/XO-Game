public class Board {

    private var positions: [[String?]] = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
    ];

    private var state = BoardState.playing

    public var size: Int {
        positions.count
    }

    public func isDrawOrWin() -> Bool {
        return state == BoardState.draw || state == BoardState.win
    }

    public func move(x: Int, y: Int, sign: PlayerSign) -> Bool {
        if isDrawOrWin() || !areCoordsValid(x: x, y: y) || positions[x][y] != nil {
            return false
        }
        positions[x][y] = sign.rawValue
        state = computeState(sign: sign, lastMove: Coordinates(x: x, y: y))
        return true
    }

    public func printBoard() {
        let lineDelimiter = "\n|---|---|---|"
        print(lineDelimiter)
        for row in 0..<size {
            print("| ", terminator: "")
            for column in positions {
                print((column[row]?.uppercased() ?? " ") + " | ", terminator: "")
            }
            print(lineDelimiter)
        }
        print()
    }

    public func getState() -> BoardState {
        return state
    }

    private func areCoordsValid(x: Int, y: Int) -> Bool {
        // x and y coords should be in the range of 0 - 2
        return (x >= 0 && x <= size - 1) && (y >= 0 || y <= size - 1)
    }

    private func computeState(sign: PlayerSign, lastMove: Coordinates) -> BoardState {
        if hasTreeInRow(sign: sign, lastMove: lastMove) {
            return BoardState.win
        } else if !hasFreePosition() {
            return BoardState.draw
        }
        return BoardState.playing
    }

    private func hasTreeInRow(sign: PlayerSign, lastMove: Coordinates) -> Bool {
        return positions[lastMove.x].allSatisfy { $0 == sign.rawValue }
            || positions.allSatisfy { $0[lastMove.y] == sign.rawValue }
            || hasDiagonalLine(sign: sign)
    }

    private func hasFreePosition() -> Bool {
        return positions.contains { column in
            return column.contains { $0 == nil }
        };
    }

    private func hasDiagonalLine(sign: PlayerSign) -> Bool {
        var leftDiagonalSignMatchCount = 0
        var rightDiagonalSignMatchCount = 0
        for i in positions.indices {
            // Check left diagonal
            if positions[i][i] == sign.rawValue {
                leftDiagonalSignMatchCount += 1
            }
            // Check right diagonal
            if positions[i][size - 1 - i] == sign.rawValue {
                rightDiagonalSignMatchCount += 1
            }
        }
        return leftDiagonalSignMatchCount == size || rightDiagonalSignMatchCount == size
    }

    private struct Coordinates {
        public var x: Int
        public var y: Int
    }
}
