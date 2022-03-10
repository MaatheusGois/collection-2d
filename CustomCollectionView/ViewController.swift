//
//  ViewController.swift
//  CustomCollectionView
//
//  Created by Ahmed Abdallah on 10.12.2019.
//  Copyright © 2019 4A5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cVWidth: NSLayoutConstraint!

    private let elementsCount = 1000

    // LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
}

extension ViewController {

    // MARK: - Constans

    private enum Constants {
        static var elemWidth: CGFloat = 300
        static let elemHeight: CGFloat = 100

        static let elementsByRow: CGFloat = 100
        static let spacingBetweenCells: CGFloat = 8
        static let leftSpacing: CGFloat = 424

        // Not change

        static let elemSize: CGSize = .init(width: elemWidth, height: elemHeight)
        static let collectionWidth =
            Constants.elemWidth * Constants.elementsByRow +
            Constants.leftSpacing +
            Constants.elementsByRow * Constants.spacingBetweenCells
        static let contentInset = UIEdgeInsets(
            top: Constants.spacingBetweenCells,
            left: Constants.spacingBetweenCells,
            bottom: .zero,
            right: Constants.leftSpacing
        )
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        cVWidth.constant = Constants.collectionWidth
        collectionView.contentInset = Constants.contentInset
        scrollView.contentSize = collectionView.frame.size

        collectionView.register(
            UINib(nibName: CustomCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
    }
}

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.setup(with: indexPath)

        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return Constants.elemSize
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.spacingBetweenCells
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.spacingBetweenCells
    }
}
