//
//  MeasureListViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import UIKit

class MeasureListViewController: UITableViewController {
    let CellID = "measure"
    var measureList: [MeasureData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        measureList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        let measure = measureList[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy г.  HH:mm"
        guard let measureDate = measure.date else { return cell }
        var content = cell.defaultContentConfiguration()
        content.text = dateFormatter.string(from: measureDate)

        cell.contentConfiguration = content
        return cell
    }

    private func setupNavigationBar() {
        title = "История измерений"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        measureList = StorageManager.shared.fetchData()
        tableView.reloadData()
    }
}
