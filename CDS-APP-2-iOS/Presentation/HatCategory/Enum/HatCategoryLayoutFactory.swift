//
//  HatCategoryLayoutFactory.swift
//  CDS-APP-2-iOS
//
//  Created by 최서연 on 11/25/23.
//

import UIKit

enum HatCategoryLayoutFactory {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, environment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            switch sectionNumber {
            case 0:
                section = createRealtimeBestSection()
            default:
                section = createRealtimeBestSection()
            }
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 7.adjusted, leading: 20.adjusted, bottom: 20.adjusted, trailing: 0)
            
            return section
        }
    }
    
    //MARK: - Section0 Layout
    
    static func createRealtimeBestSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(115.adjusted),
                                              heightDimension: .absolute(157.adjusted))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(504.adjusted),
                                               heightDimension: .estimated(157.adjusted))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
