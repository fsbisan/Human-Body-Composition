//
//  MeasureListViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import UIKit

class MeasureListViewController: UITableViewController {
    
    let CellID = "measure"
    private var measureListViewModel: MeasureListViewModelProtocol! {
        didSet {
            measureListViewModel.fetchMeasures { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.register(MeasureTableViewCell.self, forCellReuseIdentifier: CellID)
        measureListViewModel = MeasureListViewModel()
        tableView.backgroundColor = MyCustomColors.bgColorForView.associatedColor
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        measureListViewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! MeasureTableViewCell
        cell.measureCellViewModel = measureListViewModel.cellViewModel(at: indexPath)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            measureListViewModel.deleteMeasureForRow(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func setupNavigationBar() {
        title = "История измерений"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
