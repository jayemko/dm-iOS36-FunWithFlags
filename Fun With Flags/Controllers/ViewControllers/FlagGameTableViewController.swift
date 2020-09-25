//
//  FlagGameTableViewController.swift
//  Fun With Flags
//
//  Created by Jason Koceja on 9/23/20.
//

import UIKit

class FlagGameTableViewController: UITableViewController {
    
    // NOT proud to be using WebView to display SVG, but is bandaid for now til CocoaPods (SVGKit?)
    @IBOutlet weak var flagWebView: UIWebView!
    
    var game: Game?
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    func newGame() {
        GameController.shared.fetchCountries(completion: { (result) in
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.game = GameController.shared.game
                        self.updateViews()
                    }
                case .failure(_):
//                    print("[\(#function):\(#line)] -- debug")
                    break
            }
            
        })
    }
    
    func updateViews() {
        tableView.isUserInteractionEnabled = true
        
        guard let game = game else {return}
        
        // NOT proud to be using WebView to display SVG, but is bandaid for now til CocoaPods (SVGKit?)
        let request = URLRequest(url: game.countries[game.selectedInt].flag)
        flagWebView.scalesPageToFit = true
        flagWebView.contentScaleFactor = 1.0
        flagWebView.loadRequest(request)
        
        tableView.reloadData()
    }
    
    @IBAction func reloadBarButtonTapped(_ sender: Any) {
        newGame()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSelected = indexPath.row
        
        let isCorrect = game?.selectedInt == cellSelected ? true : false
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? AnswerTableViewCell else {return}
        cell.selected(indexPath: indexPath, isCorrect: isCorrect)
        
        if indexPath.section == 0 &&    isCorrect {
            presentCongratulationsToUser()
        }
    }
    
    func presentCongratulationsToUser() {
        let alertController = UIAlertController(title: "Correct!", message: "Play again?", preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.newGame()
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(firstAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Who's flag is pictured above?"
            case 1:
                return "Hints (tap to reveal)"
            default:
                return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as? AnswerTableViewCell, let game = game else {return UITableViewCell()}
        cell.country = game.countries[indexPath.row]
        cell.updateViewAtIndexPath(indexPath: indexPath)
        return cell
    }
}
