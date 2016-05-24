//
//  ViewController.swift
//  meowsterhits
//
//  Created by Daniel Gih on 9/6/15.
//  Copyright (c) 2015 danlyG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let gameVC = storyboard.instantiateViewControllerWithIdentifier("GameVC") as! UIViewController
//        self.view.addSubview(gameVC.view)
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentStackLabel: UILabel!
    @IBOutlet weak var nextStackLabel: UILabel!
    @IBOutlet weak var moveStack: UIButton!
    @IBOutlet weak var lowerStack: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var remainingStacksLabel: UILabel!
    
    // MARK: - constants
    
    let MAX_STACK = 7
    
    
    // Image of stacked blocks.
    @IBOutlet weak var imageView: UIImageView!
    
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
        drawStack()
//        currentStack = 8
//        nextStack = 14
//        currentStackLabel.text = String(currentStack)
    }
    
    @IBAction func lowerAction(sender: AnyObject) {
        if gameStarted == false {
            startGame()
        }
        
        if currentStack != 0 {
            currentStack -= 1//= currentStack - 1
            currentStackLabel.text = String(currentStack)
        } else {
            currentStackLabel.text = "You Lose"
        }
        drawStack()
        
    }
    

    @IBAction func moveAction(sender: AnyObject) {
        if gameStarted == false {
            startGame()
        }

        
        if currentStack == 0 && (stackCounter < shuffledStacks.count-2) {
//            println("first")
//            println(shuffledStacks.count - stackCounter)
            stackCounter += 1 //= stackCounter + 1
            currentStack = shuffledStacks[stackCounter] as! Int
            nextStack = shuffledStacks[stackCounter+1] as! Int
        } else if currentStack == 0 && (stackCounter < shuffledStacks.count-1) {
//            println("second end")
//            println(shuffledStacks.count - stackCounter)
            stackCounter += 1 //= stackCounter + 1
            currentStack = shuffledStacks[stackCounter] as! Int
            nextStack = -1
        } else if nextStack == -1 {
//            println("gethere!")
            gameStarted = false
            remaining = shuffledStacks.count - stackCounter
            remainingStacksLabel.text = "Stacks Left: 0"
            currentStackLabel.text = "Done!"
            nextStackLabel.text = "Hoorah"
            return
        }
        remaining = shuffledStacks.count - stackCounter
        remainingStacksLabel.text = "Stacks Left: \(remaining)"
        currentStackLabel.text = String(currentStack)
        nextStackLabel.text = String(nextStack)
    }

    func startGame() {
        gameStarted = true
        timeLabel.text = "Add Current Time"
        shuffledStacks = stackArr.shuffled()
        currentStack = shuffledStacks[stackCounter] as! Int
        nextStack = shuffledStacks[stackCounter + 1] as! Int
        currentStackLabel.text = String(currentStack)
        nextStackLabel.text = String(nextStack)
    }
    
    // MARK: - core graphics methods
    
    func drawStack() {
        
        let BOX_HEIGHT = 50
        let SCREEN_WIDTH = 512
        let SCREEN_HEIGHT = 512
        
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT), false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        for i in 0 ..< (shuffledStacks[0] as! Int + 1) {
            let rectangle = CGRect(
                x: SCREEN_WIDTH / 2,
                y: SCREEN_HEIGHT - (i + 2) * BOX_HEIGHT,
                width: BOX_HEIGHT,
                height: BOX_HEIGHT)
            CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextSetLineWidth(context, 1)
            
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
        }
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }

}

extension Array {
    func shuffled() -> Array {
        if count < 2 { return self }
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            if i != j { // Check if you are not trying to swap an element with itself
                swap(&list[i], &list[j])
            }
        }
        return list
    }
}

class UIGameViewController: UIViewController {

    
    


}








