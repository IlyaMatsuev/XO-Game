import Foundation;

public class Game {

    public func play() {
        print("Welcome to the XO console game!", terminator: "\n\n")
        let players = definePlayers()
        let board = Board()
        // The alternative of while(true)
        for moves in 0...Int.max {
            let sign = (moves % 2 == 0) ? PlayerSign.x : PlayerSign.o
            players[sign]!.turn(board: board, sign: sign)
            board.printBoard()
            if board.isDrawOrWin() {
                finish(sign: sign, board: board)
                break
            }
        }
        print("Game Over.")
    }

    private func finish(sign: PlayerSign, board: Board) {
        let boardState = board.getState()
        if boardState == BoardState.draw {
            print("It's a draw... Try one more time!")
        } else {
            print("The " + sign.rawValue + " sign has won!")
        }
    }

    private func definePlayers() -> Dictionary<PlayerSign, Playing> {
        let person = choosePersonSign()
        let computer = chooseComputerSign(person: person)
        return [
            person: Person(),
            computer: Computer()
        ];
    }

    private func choosePersonSign() -> PlayerSign {
        let playerSignInputPattern = "^(x|o)$"
        var userInput: String
        repeat {
            print("Please, choose your sign (X / O): ", terminator: "")
            userInput = readLine()?.lowercased() ?? ""
        } while userInput.range(of: playerSignInputPattern, options: .regularExpression) == nil
        return PlayerSign(rawValue: userInput) ?? PlayerSign.x
    }

    private func chooseComputerSign(person: PlayerSign) -> PlayerSign {
        // Choose the opposite sign for the computer
        return person == PlayerSign.x ? PlayerSign.o : PlayerSign.x
    }
}
