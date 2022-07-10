//
//  MeasureTableViewCell.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 09.07.2022.
//

import UIKit

class MeasureTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var measureCellViewModel: MeasureCellViewModelProtocol! {
        didSet{
            var content = defaultContentConfiguration()
            content.text = measureCellViewModel.getMeasureDate()
            content.secondaryText = measureCellViewModel.getMeasureRelativeFatBodyMass()
            contentConfiguration = content
            backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        }
    }
}
