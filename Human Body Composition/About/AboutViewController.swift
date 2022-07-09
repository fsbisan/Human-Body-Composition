//
//  AboutViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import Foundation
import UIKit

final class AboutViewController: UIViewController {
    
    lazy var aboutProgramTextLabel: UILabel = {
        let label = UILabel()
        label.text = """
Данная программа создана специально для людей, которые занимаются или только начали заниматься спортом, при этом хотят знать объективные показатели состава своего тела.
В качестве основы для расчета процента жира в организме была взята формула Jackson и Pollock с поправками от Siri - это одна из самых точных методик.

Преимущества данной программы:
* Простота в использовании
* Высокая точность определения (погрешность не более 2-3%)
* Определение сухой массы тела - зная ее, вы сможете определить, какую часть мышц вы потеряли во время похудения или сушки.
* Подробное описание техники измерения
* Анализ проблемных зон отложения жира в процессе измерения
* Интерпретация результатов

Ее преимущества заключаются в том, что процент жира определяется по толщине жировых складок, а это значит, что учитывается только подкожный жир, который и влияет на внешний вид. Даже такие точные методы как МРТ(Магнитно Резонансная Томография), инфракрасный анализ, биоэлектрическое сопротивление уступают данной методике, поскольку они определяют общее количество жира в организме, однако внешность человека не зависит от общего количества количества внутреннего жира, наибольшее влияние на внешний вид оказывает именно количество подкожного жира поэтому формула Jackson и Pollock будет наиболее оптимальной.
"""

        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(aboutProgramTextLabel)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
        setupSubviews(scrollView)
        setConstraints()
    }
    
    private func setupNavigationBar() {
        title = "О программе"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        aboutProgramTextLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            aboutProgramTextLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            aboutProgramTextLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            aboutProgramTextLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            aboutProgramTextLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            aboutProgramTextLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            aboutProgramTextLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16)
            ])
    }
}
