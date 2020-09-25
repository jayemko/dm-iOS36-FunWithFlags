//
//  AnswerTableViewCell.swift
//  Fun With Flags
//
//  Created by Jason Koceja on 9/23/20.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var answerLabel: UILabel!
    
    var country: Country?
    let hintTitles: [String] = ["Primary Language", "Primary Currency", "Subregion"]
    
    let answerFont = UIFont.boldSystemFont(ofSize: 19)
    let hintFont = UIFont.italicSystemFont(ofSize: 15)
    
    func selected(indexPath: IndexPath, isCorrect: Bool?) {
        print("[\(#function):\(#line)] -- \(indexPath)")
        if indexPath.section == 0 {
            switch isCorrect {
                case true:
                    backgroundColor = .green
                case false:
                    backgroundColor = .red
                default:
                    break}
        } else if indexPath.section == 1 {
            showHint(index: indexPath.row)
        }
    }
    
    func updateViewAtIndexPath(indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                updateAnswerView()
            case 1:
                updateHintViewAtIndex(index: indexPath.row)
            default:
                break
        }
    }
    
    func updateAnswerView() {
        guard let country = country else {return}
        backgroundColor = .none
        answerLabel.textAlignment = NSTextAlignment.center
        answerLabel.font = answerFont
        answerLabel.text = country.name
    }
    
    func showHint(index: Int) {
        
        let hints = [country?.languages.first?.name, country?.currencies.first?.name, country?.subregion]
        answerLabel.text = hints[index]
        answerLabel.font = hintFont
        answerLabel.textAlignment = NSTextAlignment.right
    }
    
    func updateHintViewAtIndex(index:Int) {
        answerLabel.text = hintTitles[index]
        answerLabel.font = hintFont
        answerLabel.textAlignment = NSTextAlignment.left
    }
}
