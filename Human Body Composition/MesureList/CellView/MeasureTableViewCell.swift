//
//  MeasureTableViewCell.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 09.07.2022.
//

import UIKit

class MeasureTableViewCell: UITableViewCell {
    var measureCellViewModel: MeasureCellViewModelProtocol! {
        didSet{
            var content = defaultContentConfiguration()
            content.text = measureCellViewModel.getMeasureDate()
            contentConfiguration = content
            backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        }
    }
}
