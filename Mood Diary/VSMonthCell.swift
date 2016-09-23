//
//  VSMonthCell.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/4/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import UIKit

class VSMonthCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate var sharedDataSource: VSCalendarDataSource? {
        didSet {
            guard date != nil else {
                return
            }
            collectionView.reloadData()
        }
    }
    fileprivate var date: Date? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(R.nib.vSDayCell)
        collectionView.register(R.nib.vSTitleHeaderView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
    }
    
    func configure(forMonth month: Int, year: Int, dataSource: VSCalendarDataSource) {
        var components = DateComponents()
        components.year = year
        components.month = month
        
        date = dataSource.calendar.date(from: components)
        sharedDataSource = dataSource
    }
}

extension VSMonthCell: UICollectionViewDataSource {  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = sharedDataSource,
            let date = date else {
                return 0
        }
        
        return dataSource.numberOfDaysForMonthInDate(date)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dayCell, for: indexPath)!,
        day = (indexPath as NSIndexPath).row + 1 //add one since indexPaths are zero indexed
        
        cell.dayLabel.text = "\(day)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let calendar = sharedDataSource?.calendar,
            let date = date,
            kind == UICollectionElementKindSectionHeader else {
                assertionFailure("Wrong index path for supplementary view")
                return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: R.reuseIdentifier.vSTitleHeaderView,
                                                                         for: indexPath)!
        headerView.titleLabel.text = sharedDataSource?.title(forMonth: date.vs_month(in: calendar))
        
        return headerView
    }
}

extension VSMonthCell: UICollectionViewDelegate {
    
}

extension VSMonthCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.size.width / 7
        let height = frame.size.height / 7
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
