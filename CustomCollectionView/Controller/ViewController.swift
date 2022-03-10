//
//  ViewController.swift
//  CustomCollectionView
//
//  Created by Ahmed Abdallah on 10.12.2019.
//  Copyright © 2019 4A5. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private lazy var scrollView = buildScrollView()
    private lazy var collectionView = buildCollection()

    private let elementsCount = 100

    // LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewCode()
    }
}

// MARK: - Constans

extension ViewController {
    private enum Constants {
        static var elemWidth: CGFloat = 300
        static let elemHeight: CGFloat = 100

        static let elementsByRow: CGFloat = 10
        static let spacingBetweenCells: CGFloat = 8
        static let leftSpacing: CGFloat = 424

        // Not change

        static let elemSize: CGSize = .init(width: elemWidth, height: elemHeight)
        static let collectionWidth =
            Constants.elemWidth * Constants.elementsByRow +
        Constants.elementsByRow * Constants.spacingBetweenCells * 1.3
        static let contentInset = UIEdgeInsets(
            top: Constants.spacingBetweenCells,
            left: Constants.spacingBetweenCells,
            bottom: Constants.spacingBetweenCells,
            right: Constants.spacingBetweenCells
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
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.contentInset = Constants.contentInset
        scrollView.contentSize = collectionView.frame.size
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
        layout.itemSize = Constants.elemSize
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

        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }
}