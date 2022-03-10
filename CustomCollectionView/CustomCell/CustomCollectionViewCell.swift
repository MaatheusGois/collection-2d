//
//  CustomCollectionViewCell.swift
//  CustomCollectionView
//
//  Created by Matheus Gois on 10/03/22.
//  Copyright © 2022 4A5. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let identifier = "cell"
    private lazy var titleLabel = buildLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.constraintToSuperview()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(with indexPath: IndexPath) {
        let row = indexPath.row
        titleLabel.text = "\(row)"

        if row.isMultiple(of: 2) {
            backgroundColor = .red
        } else {
            backgroundColor = .green
        }
    }

    fileprivate func buildLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center

        return titleLabel
    }
}
