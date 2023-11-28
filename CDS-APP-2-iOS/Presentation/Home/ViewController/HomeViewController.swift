//
//  ViewController.swift
//  CDS-APP-2-iOS
//
//  Created by 변희주 on 2023/11/16.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let recommendSmallCellData: [RecommendSmallCellData] = RecommendSmallCellData.recommendSmallCellDummy()
    private let promotionCellData: [PromotionCellData] = PromotionCellData.promotionCellDummy()
    private let productCellData: [ProductCellData] = ProductCellData.productCellDummy()
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFunctions()
    }

    // MARK: - Functions
    
    private func setUI() {
        self.view.backgroundColor = .clear
    }
    
    private func setHierachy() {
        self.view.addSubviews(homeView)
    }
        
    private func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addFunctions() {
        setUI()
        setHierachy()
        setLayout()
        setRegister()
        setDelegate()
        setNavigation()
    }
    
    private func setRegister() {
        // section 0
        homeView.homeCollectionView.register(HomeCardCollectionViewCell.self,
                                             forCellWithReuseIdentifier: HomeCardCollectionViewCell.className)
        
        // section 1
        homeView.homeCollectionView.register(HomeRecommendBigCollectionViewCell.self,
                                             forCellWithReuseIdentifier: HomeRecommendBigCollectionViewCell.className)
        homeView.homeCollectionView.register(HomeRecommendSmallCollectionViewCell.self,
                                             forCellWithReuseIdentifier: HomeRecommendSmallCollectionViewCell.className)
        
        // section 3
        homeView.homeCollectionView.register(HomePromotionCollectionViewCell.self,
                                             forCellWithReuseIdentifier: HomePromotionCollectionViewCell.className)
        homeView.homeCollectionView.register(HomePromotionReusableView.self,
                                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                             withReuseIdentifier: HomePromotionReusableView.className)
        
        // section 4
        homeView.homeCollectionView.register(HomeProductCollectionViewCell.self,
                                             forCellWithReuseIdentifier: HomeProductCollectionViewCell.className)
        homeView.homeCollectionView.register(HomeTitleReusableView.self,
                                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                             withReuseIdentifier: HomeTitleReusableView.className)
        homeView.homeCollectionView.register(HomeSeeAllReusableView.self,
                                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                             withReuseIdentifier: HomeSeeAllReusableView.className)
        
    }
    
    private func setDelegate() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
    }
    
    private func setNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 2
        case 3:
            return 6
        default:
            return 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = HomeSection(rawValue: indexPath.section) else {
            print("Wrong Section !")
            return UICollectionViewCell()
        }
        
        switch sectionType {
        case .card:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCardCollectionViewCell.className,
                                                                for: indexPath) as? HomeCardCollectionViewCell else { return UICollectionViewCell() }
            return cell
            
        case .recommend:
            if indexPath.row == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendBigCollectionViewCell.className,
                                                                    for: indexPath) as? HomeRecommendBigCollectionViewCell else { return UICollectionViewCell() }
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendSmallCollectionViewCell.className,
                                                                    for: indexPath) as? HomeRecommendSmallCollectionViewCell else { return UICollectionViewCell() }
                cell.configureCell(data: recommendSmallCellData[indexPath.item - 1])
                return cell
            }
            
        case .promotion:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePromotionCollectionViewCell.className,
                                                                for: indexPath) as? HomePromotionCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(data: promotionCellData[indexPath.item])
            cell.handler = { [weak self] in
                guard let self else { return }
                cell.isTapped.toggle()
            }
            return cell
            
        case .product:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCollectionViewCell.className,
                                                                for: indexPath) as? HomeProductCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(data: productCellData[indexPath.item])
            cell.handler = { [weak self] in
                guard let self else { return }
                cell.isTapped.toggle()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 2 {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomePromotionReusableView.className,
                                                                                   for: indexPath) as? HomePromotionReusableView else { fatalError() }
                header.configureHeader(data: PromotionHeaderData.thirdSectionHeaderData())
                return header
            } else if indexPath.section == 3 {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomeTitleReusableView.className,
                                                                                   for: indexPath) as? HomeTitleReusableView else { fatalError() }
                header.configureHeader(data: StringLiterals.Home.fourthSection.header)
                return header
            } else {
                return UICollectionReusableView()
            }
            
        case UICollectionView.elementKindSectionFooter:
            if indexPath.section == 3 {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: HomeSeeAllReusableView.className,
                                                                                   for: indexPath) as? HomeSeeAllReusableView else { fatalError() }
                return footer
            } else {
                return UICollectionReusableView()
            }
        default:
            return UICollectionReusableView()
        }
    }
}
