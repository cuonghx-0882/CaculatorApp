//
//  ViewController.swift
//  Caculator app
//
//  Created by cuonghx on 4/8/19.
//  Copyright © 2019 cuonghx. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelNumber: UILabel!
    
    let arrayButton = ["AC", "+/-", "%", "/", "7", "8","9", "X", "4", "5", "6", "-", "1", "2" , "3", "+", "0" , ".", "="]
    var numberResult = "0" {
        didSet {
            labelNumber.text = String(numberResult)
        }
    }
    var numberCaculate = "0" {
        didSet {
            labelNumber.text = String(numberCaculate)
        }
    }
    var computingButton : UIButton?
    var calculated = false;

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func handleTouchUpButton (_ button : UIButton){
        var tmp : Double = 0
        switch button.currentTitle {
        case "AC":
            self.computingButton?.backgroundColor = Color.orange
            self.computingButton = nil
            numberCaculate = "0"
            numberResult = "0"
            break
        case "0","1", "2", "3", "4", "5", "6", "7", "8", "9" :
            if self.computingButton != nil {
                if Double(numberCaculate) == 0 || calculated{
                    calculated = false
                    numberCaculate = ""
                }
                numberCaculate = numberCaculate + button.currentTitle!
            }else {
                if Double(numberResult) == 0 || calculated {
                    calculated = false
                    numberResult = ""
                }
                numberResult = numberResult + button.currentTitle!
            }
            break
          
        case "/", "X", "-", "+" :
            if let btn = self.computingButton {
                btn.backgroundColor = Color.orange
                if (button !== self.computingButton){
                    var s = numberResult + btn.currentTitle!  + numberCaculate
                    s = s.replacingOccurrences(of: "X", with: "*")
                    let expn = NSExpression(format:s)
                    self.numberCaculate = "0"
                    self.numberResult = "\(expn.expressionValue(with: nil, context: nil) ?? "NA")"
                }
            }
            self.computingButton = button
            button.backgroundColor = UIColor(displayP3Red: 100/256, green: 100/256, blue: 100/256, alpha: 1)
            break
        case "." :
            numberResult += "."
            break
        case "=" :
            if let button = self.computingButton {
                var s = numberResult + button.currentTitle!  + numberCaculate
                s = s.replacingOccurrences(of: "X", with: "*")
                let expn = NSExpression(format:s)
                self.numberCaculate = "0"
                self.numberResult = "\(expn.expressionValue(with: nil, context: nil) ?? "NA")"
                self.computingButton?.backgroundColor = Color.orange
                self.computingButton = nil
                self.calculated = true
            }
            break
        case "+/-" :
            numberResult = (-Double(numberResult)!).toString()
            break
        case "%" :
            tmp = Double(numberResult)!
            numberResult = (tmp / 100).toString()
        default:
            break
        }
    }
    
}
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayButton.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)

        if let button = cell.viewWithTag(1) as? UIButton {
            button.setTitle(arrayButton[indexPath.item], for: .normal)
            let position = indexPath.item + 1
            button.setBackgroundColor(color: UIColor(displayP3Red: 100/256, green: 100/256, blue: 100/256, alpha: 1), forState: .highlighted)
            if position % 4 == 0 || position == arrayButton.count {
                button.tintColor = UIColor.white
                button.backgroundColor = Color.orange
            }else {
                button.backgroundColor = Color.gray
                button.tintColor = UIColor.black
            }
            button.addTarget(self, action: #selector (handleTouchUpButton(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 16 {
            return CGSize(width: (collectionView.frame.width - 1)  / 2  , height: (collectionView.frame.height - 4 ) / 5 )
        }
        return CGSize(width: (collectionView.frame.width - 3)  / 4  , height: (collectionView.frame.height - 4) / 5 )
    }
}

