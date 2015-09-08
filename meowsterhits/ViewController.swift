//
//  ViewController.swift
//  meowsterhits
//
//  Created by Daniel Gih on 9/6/15.
//  Copyright (c) 2015 danlyG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentStackLabel: UILabel!
    @IBOutlet weak var nextStackLabel: UILabel!
    @IBOutlet weak var moveStack: UIButton!
    @IBOutlet weak var lowerStack: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    let stackArr = [0, 0, 0, //3 zeros
                    1, 1, 1, 1, 1, 1, 1, //7 ones
                    2, 2, 2, 2, 2, 2, //6 twos
                    3, 3, 3, 3, 3, //5 threes
                    4, 4, 4, //3 fours
                    5, 5, 5, //3 fives
                    6, 6, 6] //3 sixes

    let pracArr = [1,2,3,5]
    
    var shuffledStacks = []
    var gameStarted = false
    var currentStack = -2
    var nextStack = -3
    var stackCounter = 0
    var remaining = 30
    
    @IBAction func startAction(sender: AnyObject) {
        startGame()
//        currentStack = 8
//        nextStack = 14
//        currentStackLabel.text = String(currentStack)
    }
    
    @IBAction func lowerAction(sender: AnyObject) {
        if gameStarted == false {
            startGame()
        }
        
        if currentStack != 0 {
            currentStack--
            currentStackLabel.text = String(currentStack)
        } else {
            currentStackLabel.text = "You Lose"
        }
        
    }
    

    @IBAction func moveAction(sender: AnyObject) {
        if gameStarted == false {
            startGame()
        }

        
        if currentStack == 0 && (stackCounter < shuffledStacks.count-2) {
            println("first")
            println(shuffledStacks.count - stackCounter)
            stackCounter++
            currentStack = shuffledStacks[stackCounter] as! Int
            nextStack = shuffledStacks[stackCounter+1] as! Int
        } else if currentStack == 0 && (stackCounter < shuffledStacks.count-1) {
            println("second end")
            println(shuffledStacks.count - stackCounter)
            stackCounter++
            currentStack = shuffledStacks[stackCounter] as! Int
            nextStack = -1
        } else if nextStack == -1 {
            println("gethere!")
            currentStackLabel.text = "Done!"
            nextStackLabel.text = "Hoorah"
            return
        }
        
        
        currentStackLabel.text = String(currentStack)
        nextStackLabel.text = String(nextStack)
    }
    

    


    func startGame() {
        gameStarted = true
        shuffledStacks = pracArr.shuffled()
        currentStack = shuffledStacks[stackCounter] as! Int
        nextStack = shuffledStacks[stackCounter + 1] as! Int
        currentStackLabel.text = String(currentStack)
        nextStackLabel.text = String(nextStack)
    }

}

extension Array {
    func shuffled() -> Array {
        if count < 2 { return self }
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}