//
//  ViewController.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import ReactiveSwift
import ReactiveCocoa

extension MainVC: Makeable {
    static func make() -> MainVC { R.storyboard.main.mainVC()! }
}

final class MainVC: UIViewController {
    
    private enum C {
        static let maxAmountCards = 50
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MainVM?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(for: CardTVC.self)
        binding()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        viewModel?.getCards()
    }
    
    private func binding() {
        guard let viewModel = viewModel else { return }
        reactive.makeBindingTarget { vc, cards in
            vc.navigationItem.rightBarButtonItem?.isEnabled = cards.count < C.maxAmountCards
            vc.tableView.isHidden = cards.isEmpty
        } <~ viewModel.cards
        
        tableView.reactive.reloadData <~ viewModel.cards.map { _ in }
    }
    
    @objc private func addButtonTapped() {
        viewModel?.addCard()
    }
}

// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { .delete }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let card = viewModel?.cards.value[indexPath.row] else { return }
        viewModel?.showCardDetails(for: card)
    }
}

// MARK: -  UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cards.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let card = viewModel?.cards.value[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(cellClass: CardTVC.self, for: indexPath)
        cell.configure(card: card)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        tableView.beginUpdates()
        viewModel?.removeCard(at: indexPath.row) {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.endUpdates()
    }
}
