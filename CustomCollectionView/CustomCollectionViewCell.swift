//
//  CustomCollectionViewCell.swift
//  CustomCollectionView
//
//  Created by Ahmed Abdallah on 10.12.2019.
//  Copyright © 2019 4A5. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let identifier = "CustomCollectionViewCell"
    @IBOutlet weak var titleLBL: UILabel!

    func setup(with indexPath: IndexPath) {
        let row = indexPath.row
        titleLBL.text = "\(row)"

        if row.isMultiple(of: 2) {
            backgroundColor = .red
        } else {
            backgroundColor = .green
        }
    }
}
