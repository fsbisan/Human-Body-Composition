//
//  AboutViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import Foundation
import UIKit

final class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .red
        
    }
    
    private func setupNavigationBar() {
        title = "О программе"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
