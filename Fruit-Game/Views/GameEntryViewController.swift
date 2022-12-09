//
//  ViewController.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import UIKit

class GameEntryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: GameEntryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GameEntryViewModel()
        viewModel.fetchGames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension GameEntryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.gameLevels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.gameLevels[indexPath.row].rawValue
        cell.textLabel?.textColor = .systemOrange
        return cell
    }
}

extension GameEntryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameLevel = viewModel.gameLevels[indexPath.row]
        let game = viewModel.games?.filter { $0.level == gameLevel.rawValue }.first
        let gamePlayViewModel = GamePlayViewModel(gameLevel: gameLevel, models: [], game: game)
        let destination = GamePlayViewController(viewModel: gamePlayViewModel)
        
        navigationController?.pushViewController(destination, animated: true)
    }
}

