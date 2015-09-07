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

    let pracArr = [1,2,3]
    
    var shuffledStacks = []
    var gameStarted = false
    var currentStack = 5
    var nextStack = 10
    
    
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
        
        currentStackLabel.text = String(currentStack)
        
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
        
        if currentStack == 0 {
            currentStack = nextStack
        }
        
        
        currentStackLabel.text = String(currentStack)
    }
    

    

    


    func startGame() {
        gameStarted = true
        shuffledStacks = pracArr.shuffled()
        //        println(shuffledStacks)
        currentStack = shuffledStacks[0] as! Int
        nextStack = shuffledStacks[1] as! Int
        currentStackLabel.text = String(currentStack)
    }

}

extension Array {
    func shuffled() -> [T] {
        if count < 2 { return self }
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}