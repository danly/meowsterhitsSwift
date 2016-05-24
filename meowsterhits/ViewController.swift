//
//  ViewController.swift
//  meowsterhits
//
//  Created by Daniel Gih on 9/6/15.
//  Copyright (c) 2015 danlyG. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    // MARK: - constant variables

    let stackArr = [0, 0, 0, //3 zeros
        1, 1, 1, 1, 1, 1, 1, //7 ones
        2, 2, 2, 2, 2, 2, //6 twos
        3, 3, 3, 3, 3, //5 threes
        4, 4, 4, //3 fours
        5, 5, 5, //3 fives
        6, 6, 6] //3 sixes
    let pracArr = [1,2,3,5]
    // Stack-related constants.
    let BOX_HEIGHT = 50
    let SCREEN_WIDTH = 512
    let SCREEN_HEIGHT = 512

    // MARK: - class variables

    var shuffledStacks = [Int]()
    var stackCounter = 0
    var nextStack = -3 {
        didSet {
            nextStackLabel.text = "\(nextStack)"
        }
    }
    var currentStack = -2 {
        didSet {
            currentStackLabel.text = "\(currentStack)"
        }
    }
    var remaining = 30 {
        didSet {
            remainingStacksLabel.text = "Stacks Left: \(remaining)"
        }
    }

    // MARK: - IBOutlet variables

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentStackLabel: UILabel!
    @IBOutlet weak var nextStackLabel: UILabel!
    @IBOutlet weak var moveStack: UIButton!
    @IBOutlet weak var lowerStack: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var remainingStacksLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! // Image of stacked blocks.

    // MARK: - UIViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Keep game controls hidden until start of game.
        lowerStack.hidden = true
        moveStack.hidden = true
    }

    // MARK: - IBAction methods

    @IBAction func startAction(sender: AnyObject) {
        startGame()
    }

    @IBAction func lowerAction(sender: AnyObject) {
        if currentStack != 0 {
            currentStack -= 1
        } else {
            currentStackLabel.text = "You Lose"
        }
        drawStack()
    }


    @IBAction func moveAction(sender: AnyObject) {
        if currentStack == 0 && (stackCounter < shuffledStacks.count-2) {
//            println("first")
//            println(shuffledStacks.count - stackCounter)
            stackCounter += 1
            currentStack = shuffledStacks[stackCounter]
            nextStack = shuffledStacks[stackCounter+1]
        } else if currentStack == 0 && (stackCounter < shuffledStacks.count-1) {
//            println("second end")
//            println(shuffledStacks.count - stackCounter)
            stackCounter += 1
            currentStack = shuffledStacks[stackCounter]
            nextStack = -1
        } else if nextStack == -1 {
//            println("gethere!")
            remaining = 0
            currentStackLabel.text = "Done!"
            nextStackLabel.text = "Hoorah"
            return
        }
        remaining = shuffledStacks.count - stackCounter
        drawStack()
    }

    // MARK: - custom methods

    func startGame() {
        // Make user buttons visible.
        moveStack.hidden = false
        lowerStack.hidden = false

        timeLabel.text = "Add Current Time"

        // Shuffle array of stack heights.
        if #available(iOS 9.0, *) {
            shuffledStacks = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(stackArr) as! [Int]
        } else {
            shuffledStacks = stackArr.shuffled()
        }
        // Update stack variables.
        currentStack = shuffledStacks[stackCounter]
        nextStack = shuffledStacks[stackCounter + 1]
        drawStack()
    }

    func drawStack() {
        // Initialize context for Core Graphics.
        UIGraphicsBeginImageContextWithOptions(CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT), false, 0)
        let context = UIGraphicsGetCurrentContext()

        // Draw the cat.
        let cat = CGRect(
            x: SCREEN_WIDTH / 2,
            y: SCREEN_HEIGHT - (currentStack + 2) * BOX_HEIGHT,
            width: BOX_HEIGHT,
            height: BOX_HEIGHT)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(context, 1)

        CGContextAddRect(context, cat)
        CGContextDrawPath(context, .FillStroke)

        // Draw yellow rectangles.
        for i in 0 ..< currentStack {
            let rectangle = CGRect(
                x: SCREEN_WIDTH / 2,
                y: SCREEN_HEIGHT - (i + 2) * BOX_HEIGHT,
                width: BOX_HEIGHT,
                height: BOX_HEIGHT)
            CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextSetLineWidth(context, 1)

            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
        }

        // Update image view.
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = img
    }

}
