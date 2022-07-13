//
//  MeasureTableViewCell.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 09.07.2022.
//

import UIKit

final class MeasureTableViewCell: UITableViewCell {
    static var cellIdentifier = "MeasureTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(dateLabel, dryBodyMassLabel, relativeFatBodyMassLabel, weightLabel)
        backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var dryBodyMassLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var relativeFatBodyMassLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dryBodyMassLabel.translatesAutoresizingMaskIntoConstraints = false
        relativeFatBodyMassLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 100),
            relativeFatBodyMassLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            relativeFatBodyMassLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            dryBodyMassLabel.topAnchor.constraint(equalTo: relativeFatBodyMassLabel.bottomAnchor, constant: 5),
            dryBodyMassLabel.leftAnchor.constraint(equalTo: relativeFatBodyMassLabel.leftAnchor),
            weightLabel.leftAnchor.constraint(equalTo: relativeFatBodyMassLabel.rightAnchor, constant: 10),
            weightLabel.topAnchor.constraint(equalTo: relativeFatBodyMassLabel.topAnchor)
        ])
    }
    
    var measureCellViewModel: MeasureCellViewModelProtocol! {
        didSet{
            dateLabel.text = measureCellViewModel.getMeasureDate()
            relativeFatBodyMassLabel.text = measureCellViewModel.getMeasureRelativeFatBodyMass()
            dryBodyMassLabel.text = measureCellViewModel.getDryBodyMass()
            weightLabel.text = measureCellViewModel.getWeight()
        }
    }
}
