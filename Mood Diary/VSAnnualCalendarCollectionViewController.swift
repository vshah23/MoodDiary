//
//  VSAnnualCalendarCollectionViewController.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/2/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import UIKit

private let kCollectionViewLeftRightMargins: CGFloat = 8.0
private let kColelctionViewHeaderHeight: CGFloat = 44.0
class VSAnnualCalendarCollectionViewController: UICollectionViewController {
    let calendarDataSource = VSCalendarDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        registerNibs()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.layoutIfNeeded()
        
        scrollToCurrentMonth(animated: false)
    }
    
    func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0,
                                               left: kCollectionViewLeftRightMargins,
                                               bottom: 0.0,
                                               right: kCollectionViewLeftRightMargins)
        collectionView?.collectionViewLayout = flowLayout
    }
    
    func registerNibs() {
        collectionView?.register(R.nib.vSMonthCell)
        collectionView?.register(R.nib.vSYearTitleHeaderView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
    }
}

// MARK - Datasource
extension VSAnnualCalendarCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendarDataSource.numberOfYearsInbetweenStartAndEndDates()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDataSource.numberOfMonthsInYear
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.monthCell, for: indexPath)!
        
        let month = (indexPath as NSIndexPath).item + 1 //add one for zero indexing
        let year = (indexPath as NSIndexPath).section
        
        cell.configure(forMonth: month, year: year, dataSource: calendarDataSource)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
                assertionFailure("Wrong index path for supplementary view")
                return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: R.reuseIdentifier.vSYearTitleHeaderView,
                                                                         for: indexPath)!
        headerView.titleLabel.text = calendarDataSource.title(forYear: indexPath.section)
        
        return headerView
    }
}

extension VSAnnualCalendarCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension VSAnnualCalendarCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = (collectionView.collectionViewLayout) as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let leftRightMargins = collectionViewLayout.sectionInset.left
        let minCellSpacing = collectionViewLayout.minimumInteritemSpacing
        
        let width = (collectionView.bounds.width - leftRightMargins * 2 - minCellSpacing * 2) / 3
        return CGSize(width: width, height: width) //1:1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.size.width
        let height: CGFloat = kColelctionViewHeaderHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

extension VSAnnualCalendarCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func scrollToCurrentMonth(animated: Bool) {
        let currentYear = Date().vs_year(in: calendarDataSource.calendar)
        let indexPath = IndexPath(item: 0, section: currentYear)

        guard let collectionView = collectionView,
            let attributes = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath) else {
            return
        }
        
        let newContentOffset = CGPoint(x: collectionView.contentOffset.x, y: attributes.frame.origin.y - collectionView.contentInset.top)
        collectionView.setContentOffset(newContentOffset, animated: animated)
    }
}
