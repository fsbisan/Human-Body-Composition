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
            Данная программа создана для пользователей, которые хотят узнать достоверные данные о составляющей тела человека – проценте жира в организме с помощью метода калиперометрии. Этот метод заключается в измерении толщины кожно-жировых складок на определенных участках тела при помощи специальных устройств – калиперов.
            Используется формула для оценки жировой массы тела по трем складкам: у мужчин – на животе возле пупка, на груди и на середине бедра сзади; у женщин – на задней поверхности плеча, верхнеподвздошная и на середине бедра сзади. В основе исчисления расчета процента жира в организме заложены исследования сформулированные Jackson и Pollock с поправками от Siri (разработанная ими формула представляет собой одну из наиболее точных методик расчета, используемых для установления процента жира в организме).
            Результаты измерений, полученные с помощью приложения «Калькулятор состава тела», могут быть использованы специалистом в основе первичных данных для оценки уровня физического развития, пищевого статуса и предварительной диагностики ожирения пользователя.
            Преимущество исчисления процента жира в организме методом калиперометрии заключается в использовании сведений о толщине жировых складок, в том числе учитывая в основе своей подкожный жир, который оказывает существенное влияние на внешний вид человека.
            Вышеуказанной методике уступают иные антропометрические приемы и способы измерения весовых (масса тела), пространственных (длинна тела, периметр грудной клетки), линейных, объемных иных характеристик тела организма.
             У спортсменов масса тела может значительно превышать нормативные значения для общей популяции, но их нельзя считать тучными, так как масса тела спортсменов в большей степени представлена мышечной массой и массивным скелетом, а не жировой тканью. В настоящее время неясно, насколько безопасно иметь избыточную мышечную массу, так как она, как и избыточная масса жира, предъявляет повышенные требования ко всем системам организма в основе своей к сердечнососудистой системе.
            Современные методы измерения жира в организме такие как  МРТ (магнитно-резонансная томография), инфракрасный анализ, биоэлектрическое сопротивление, уступают методике калипометрииб поскольку они определяют общее количество жира в организме. При этом учитываются показатели жира во всём теле, в том числе внутренней его части, которые не оказывают существенное влияние на внешний вид.
            Приложение и используемая в его основе формула даёт возможность определить процент жира в организме, который располагается под кожей и влияет на внешность человека, и может использоваться в процессе подбора рациона питания, и выбора типа и интенсивности тренировочных нагрузок.
            Преимущества «Калькулятор состава тела»:
            * Простота в использовании.
            * Высокая точность вычисления (погрешность не более 2-3%).
            * Определение сухой массы тела - зная ее, вы сможете узнать, какую часть мышц вы потеряли во время процесса похудения или сушки.
            * Выявление проблемных зон отложения жира в процессе измерения.
            * Исчисление процента жира в организме и сухой массы тела, с последующей интерпретацией результата относительно телосложения пользователя.
            * Сохранение сведений о составе тела человека с учётом половозрастных показателей, с возможностью просмотра данных о результатах, полученных пользователем в разные дни.
            «Калькулятор состава тела» будет полезен для специалистов в области биологии человека, антропологов, диетологов, эпидемиологов, гигиенистов, спортивных врачей и других специалистов.

Связаться с автором вы можете по данному адресу: fsbisan@mail.ru

"""

        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    // MARK: - UIScrollView
    
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
            aboutProgramTextLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
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

