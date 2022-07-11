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
            Данная программа создана специально для пользователей, которые занимаются или только начали заниматься спортом, при этом хотят владеть знаниями об объективных показателях состава своего тела, таких как процент жира в организме.
            В основе исчисления расчета процента жира в организме заложены исследования по формуле Jackson и Pollock с поправками от Siri (данная формула представляет собой одну из наиболее точных методик расчета, имеющихся в современной науке).

            Преимущества приложения:
* Простота в использовании.
* Высокая точность вычисления (погрешность не более 2-3%).
* Определение сухой массы тела - зная ее, вы сможете узнать, какую часть мышц вы потеряли во время процесса похудения или сушки.
* Выявление проблемных зон отложения жира в процессе измерения.
* Исчисление процента жира в организме и сухой массы тела, с последующей интерпретацией результата относительно телосложения пользователя.
* Сохранение сведений о составе тела человека с учётом половозрастных показателей, с возможностью просмотра данных о результатах, полученных пользователем в разные дни.
            Преимущество методики исчисления процента жира в организме позволяет использовать сведения о толщине жировых складок, в том числе учитывать в основе своей подкожный жир, который оказывает существенное влияние на внешний вид человека. Вышеуказанной методике уступают такие методы как МРТ (Магнитно-резонансная томография), инфракрасный анализ, биоэлектрическое сопротивление, поскольку они определяют общее количество жира в организме. При этом учитываются показатели жира во всём теле, в том числе внутренней его части, которые не оказывают существенное влияние на внешний вид.
            Приложение и используемая в его основе формула даёт возможность определить процент жира в организме, который располагается под кожей и влияет на внешность человека, и может использоваться в процессе подбора рациона питания, и выбора типа и интенсивности тренировочных нагрузок.

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
        setupSubviews(scrollView)
        setConstraints()
        setGradientBackground()
        tabBarController?.tabBar.barTintColor = MyCustomColors.bgColorForTF.associatedColor
    }
    
    private func setupNavigationBar() {
        title = "О ПРОГРАММЕ"
        
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
extension AboutViewController {
    func setGradientBackground() {
        let colorTop =  UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

