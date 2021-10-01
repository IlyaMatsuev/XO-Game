public class Person: Playing {

    private let inputTurnPattern = "^[1-3]x[1-3]y$"
    private let xInputIndex = 0
    private let yInputIndex = 2

    public func turn(board: Board, sign: PlayerSign) {
        var userInput: String
        repeat {
            print("Your turn (example: 1x3y): ", terminator: "")
            userInput = readLine()?.lowercased() ?? ""
        } while !checkInputCoordsValid(input: userInput) || !move(input: userInput, board: board, sign: sign)
    }

    private func checkInputCoordsValid(input: String) -> Bool {
        if input.range(of: inputTurnPattern, options: .regularExpression) == nil {
            print("Please, enter the coordinates in the correct format from 1 to 3 (example: 1x3y).")
            return false
        }
        return true
    }

    private func move(input: String, board: Board, sign: PlayerSign) -> Bool {
        let tokens = Array(input)
        let x = tokens[xInputIndex].wholeNumberValue! - 1
        let y = tokens[yInputIndex].wholeNumberValue! - 1

        if !board.move(x: x, y: y, sign: sign) {
            print("You can't move to this position")
            return false
        }

        return true
    }
}
