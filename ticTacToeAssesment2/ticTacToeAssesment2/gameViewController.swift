//
//  gameViewController.swift
//  ticTacToeAssesment2
//
//  Created by MAC on 10/05/2021.
//

import AVFoundation
import UIKit

class gameViewController: UIViewController {

    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    @IBOutlet weak var gameOnLabel: UILabel!
    var matrix: [[Int]] = [[0,0,0], [0,0,0], [0,0,0]]
    
    var whosTurn = 0 // 1 for player 1 and 2 for player 2
    var player1 = 0
    var player2 = 0
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        startGame()
    }
    
    func startGame(){
        
        playerTurnLabel.isHidden = false
        matrix = [[0,0,0], [0,0,0], [0,0,0]]
        displayMat(matrix: matrix)
        
        whosTurn = Int.random(in: 1...2)
        
        if (whosTurn == 1){ // player 1 goes first and s/he is x
            
            player1 = 1
            player2 = 2
            
            player1Label.text = "Player 1: X"
            player2Label.text = "Player 2: O"
            
            if (pOrC == 1){
                player2Label.text = "Computer: O"
            }
            
            playerTurnLabel.text = "Player 1 turn"
            
            gameOnLabel.isHidden = true
            
        } else{
            player1 = 2
            player2 = 1
            
            player1Label.text = "Player 1: O"
            player2Label.text = "Player 2: X"
            
            playerTurnLabel.text = "Player 2 turn"
            
            if (pOrC == 1){
                player2Label.text = "Computer: X"
                playerTurnLabel.text = "Computer's turn"
                playComputer()
            }
            
            gameOnLabel.isHidden = true
        }
    }
    
    func displayMat(matrix: [[Int]]){
        
        var tempTag = 1
        for i in 0...2{
            for j in 0...2{
                if (matrix[i][j] == 0){
                    let tempButton = self.view.viewWithTag(tempTag) as? UIButton
                    tempButton?.setBackgroundImage(nil, for: .normal)
                    
                }else if (matrix[i][j] == 1){
                    let tempButton = self.view.viewWithTag(tempTag) as? UIButton
                    tempButton?.setBackgroundImage(UIImage(named: "x"), for: .normal)
                    
                }else if (matrix[i][j] == 2){
                    let tempButton = self.view.viewWithTag(tempTag) as? UIButton
                    tempButton?.setBackgroundImage(UIImage(named: "o"), for: .normal)
                    
                }else {
                }
                tempTag += 1
            }
        }
    }
        
    
    @IBAction func buttonClickedXorO(_ sender: UIButton) {
        
        let tapSound = Bundle.main.path(forResource: "sound", ofType: ".mp3")
        
        do{
            try soundEffect = AVAudioPlayer(contentsOf: URL (fileURLWithPath: tapSound!))
        } catch {
            print("error")
        }
        
        var tempObject = 0
        
        if (whosTurn == 1) {
           
            tempObject = player1
            playerTurnLabel.text = "Player 1 turn"
            
        } else{
            tempObject = player2
            playerTurnLabel.text = "Player 2 turn"
        }
        
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag{
        case 1:
            if (matrix[0][0] == 0){
                matrix[0][0] = tempObject
                justPlayed()
            }
        case 2:
            if (matrix[0][1] == 0){
                matrix[0][1] = tempObject
                justPlayed()
            }
        case 3:
            if (matrix[0][2] == 0){
                matrix[0][2] = tempObject
                justPlayed()
            }
        case 4:
            if (matrix[1][0] == 0){
                matrix[1][0] = tempObject
                justPlayed()
            }
        case 5:
            if (matrix[1][1] == 0){
                matrix[1][1] = tempObject
                justPlayed()
            }
        case 6:
            if (matrix[1][2] == 0){
                matrix[1][2] = tempObject
                justPlayed()
            }
        case 7:
            if (matrix[2][0] == 0){
                matrix[2][0] = tempObject
                justPlayed()
            }
        case 8:
            if (matrix[2][1] == 0){
                matrix[2][1] = tempObject
                justPlayed()
            }
        case 9:
            if (matrix[2][2] == 0){
                matrix[2][2] = tempObject
                justPlayed()
            }
        default:
            print("Some kind of error")
        }
    }

    
    func justPlayed(){
        
        displayMat(matrix: matrix)
        checkWhoWins()
        
        if (whosTurn == 1){
            whosTurn = 2
            playerTurnLabel.text = "Player 2 turn"
            if (pOrC == 1){
                playComputer()
            }
        } else {
            whosTurn = 1
            playerTurnLabel.text = "Player 1 turn"
        }
        
    }

    func playComputer(){
        
        var check = true
        
        repeat{
            let randomPlaceRow = Int.random(in: 0...2)
            let randomPlaceCol = Int.random(in: 0...2)
            
            if (matrix[randomPlaceRow][randomPlaceCol] == 0){
                
                matrix[randomPlaceRow][randomPlaceCol] = player2
                check = false
            }
        } while (check)
        justPlayed()
        
    }
    
    func checkWhoWins(){
        
        var counter = true
        
        if ((matrix[0][0] == matrix [1][1]) && (matrix [1][1] == matrix [2][2]) && matrix [1][1] != 0) {
            decalreWinner(whoWon: matrix[1][1])
        } else if ((matrix[2][0] == matrix [1][1]) && (matrix [1][1] == matrix [0][2]) && matrix [1][1] != 0){
            decalreWinner(whoWon: matrix[1][1])
        } else {
            
            for i in 0...2 {
                if ((matrix[i][0] == matrix[i][1]) && (matrix[i][1] == matrix[i][2]) && matrix[i][0] != 0){
                    decalreWinner(whoWon: matrix[i][0])
                    counter = false
                }
            }
            
            if counter {
                for i in 0...2 {
                    if ((matrix[0][i] == matrix[1][i]) && (matrix[1][i] == matrix[2][i]) && matrix[0][i] != 0){
                        decalreWinner(whoWon: matrix[0][i])
                    }
                }
            }
            
        }
    }
    
    func decalreWinner(whoWon: Int){
        
        if (whoWon == player1) {
            // player 1  won!!
            gameOnLabel.isHidden = false
            gameOnLabel.text = "Player 1 Won!!"
            playerTurnLabel.isHidden = true
            
        } else if (whoWon == player2){
            //player 2 won
            gameOnLabel.isHidden = false
            
            if (pOrC == 1){
                gameOnLabel.text = "Computer Won!!"
                
                playerTurnLabel.isHidden = true
            } else{
                gameOnLabel.text = "Player 2 Won!!"
                
                playerTurnLabel.isHidden = true
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func goBaack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        startGame()
    }
    
    
    
    
}
