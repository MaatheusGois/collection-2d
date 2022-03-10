//
//  ViewController.swift
//  CustomCollectionView
//
//  Created by Ahmed Abdallah on 10.12.2019.
//  Copyright © 2019 4A5. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // Views

    private lazy var scrollView = buildScrollView()
    private lazy var collectionView = buildCollection()

    // Properties

    private let elementsCount = 100

    // LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewCode()
    }
}

// MARK: - Constans

private extension ViewController {
    enum Constants {
        static var cellWidth: CGFloat = 100
        static let cellHeight: CGFloat = 100

        static let elementsByRow: CGFloat = 10
        static let spacingBetweenCells: CGFloat = 8
        static let leftSpacing: CGFloat = 1.3

        // Not change

        static let cellSize: CGSize = .init(
            width: cellWidth,
            height: cellHeight
        )

        static let collectionWidth =
        cellWidth * elementsByRow +
        elementsByRow * spacingBetweenCells * leftSpacing

        static let contentInset = UIEdgeInsets(
            top: spacingBetweenCells,
            left: spacingBetweenCells,
            bottom: spacingBetweenCells,
            right: spacingBetweenCells
        )
    }
}

// MARK: - Setup

fileprivate extension ViewController {
    func setupViewCode() {
        setupViewHierarchy()
        setupConstraints()
        setupViews()
        setupCollectionView()
    }

    func setupViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
    }

    func setupConstraints() {
        scrollView.constraintToSuperview()
        collectionView
            .constraintTo(scrollView.contentLayoutGuide)
            .heightAnchor(equalTo: scrollView.heightAnchor)
            .widthAnchor(equalTo: Constants.collectionWidth)
    }

    func setupViews() {
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        collectionView.backgroundColor = .white
    }

    func setupCollectionView() {
        collectionView.dataSource = self

        collectionView.contentInset = Constants.contentInset
        scrollView.contentSize = collectionView.frame.size
    }
}

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

// MARK: - Builders

extension ViewController {
    func buildScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true

        return scrollView
    }

    func buildCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Constants.cellSize
        layout.minimumLineSpacing = Constants.spacingBetweenCells
        layout.minimumInteritemSpacing = Constants.spacingBetweenCells

        let collection = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: layout
        )

        collection.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }
}
