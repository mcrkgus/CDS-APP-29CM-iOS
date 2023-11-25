//
//  HatDetailViewController.swift
//  CDS-APP-2-iOS
//
//  Created by Gahyun Kim on 2023/11/20.
//

import UIKit

import SnapKit
import Then

final class HatDetailViewController: UIViewController {
    
    private let collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Set NavigationBar
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        
        let home = UIBarButtonItem(image: ImageLiterals.icon.icHomeBlack, style: .plain, target: nil, action: nil)
        let search = UIBarButtonItem(image: ImageLiterals.icon.icSearch, style: .plain, target: nil, action: nil)
        let cart = UIBarButtonItem(image: ImageLiterals.icon.icCartBlack, style: .plain, target: nil, action: nil)

        navigationItem.rightBarButtonItems = [cart, search, home]
        for i in [home, search, cart] {
            i.tintColor = .black
        }
    }
    
    
    // MARK: - Set CollectionView
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true

        collectionView.register(MainInfoCollectionViewCell.self, forCellWithReuseIdentifier: MainInfoCollectionViewCell.className)
        collectionView.register(ProductInfoCollectionViewCell.self, forCellWithReuseIdentifier: ProductInfoCollectionViewCell.className)
        
        collectionView.register(ProductInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProductInfoHeaderCollectionReusableView.className)
    }
    
    
    // MARK: - Set UI
    
    private func setUI() {
        collectionView.backgroundColor = .clear
    }
    
    
    // MARK: - Set Layout
    
    private func setLayout() {
        collectionView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: - Set Hierachy
    
    private func setHierachy() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Set Delegate
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension HatDetailViewController: UICollectionViewDelegate {}
extension HatDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCollectionViewCell.className, for: indexPath) as! MainInfoCollectionViewCell
        //나중에 data 추가 예정
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch indexPath.section {
                //case 0은 헤더가 없으므로 생략
            case 1 :
                if kind == UICollectionView.elementKindSectionHeader {
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                       withReuseIdentifier: ProductInfoHeaderCollectionReusableView.className,
                                                                                       for: indexPath) as? ProductInfoHeaderCollectionReusableView
                    else {
                        return ProductInfoHeaderCollectionReusableView()
                    }
                    header.configure()
                    return header
                } else {
                    guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                       withReuseIdentifier: ProductInfoFooterCollectionReusableView.className,
                                                                                       for: indexPath) as? ProductInfoFooterCollectionReusableView
                    else {
                        return ProductInfoFooterCollectionReusableView()
                    }
                    footer.configure()
                    return footer
                }

            default :
                return ProductInfoHeaderCollectionReusableView()
            }
        }
        
        // 헤더의 크기 지정
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
               switch section {
               case 1 :
                   return CGSize(width: 300, height: 50)
                   
               default :
                   return CGSize.zero
               }
         
           }
}

extension HatDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
