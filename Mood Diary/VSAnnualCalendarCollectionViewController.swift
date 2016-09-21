//
//  VSAnnualCalendarCollectionViewController.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/2/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import UIKit

class VSAnnualCalendarCollectionViewController: UICollectionViewController {
    let calendarDataSource = VSCalendarDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.registerNib(R.nib.vSMonthCell)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return calendarDataSource.numberOfYearsInbetweenStartAndEndDates()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDataSource.numberOfMonthsInYear
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.monthCell, forIndexPath: indexPath)!
        
        let month = indexPath.row + 1 //add one for zero indexing
        let year = indexPath.section
        
        cell.titleLabel.text = calendarDataSource.title(forMonth: month)
        cell.configure(forMonth: month, year: year, dataSource: calendarDataSource)
        
        return cell
    }
    
//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//    }
}

extension VSAnnualCalendarCollectionViewController {
//    func scrollToCurrentMonth(animated: Bool) {
//        let indexPath = NSIndexPath(forItem: <#T##Int#>, inSection: <#T##Int#>)
//    }
}

extension VSAnnualCalendarCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 3
        return CGSizeMake(width, width) //1:1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = (collectionView.bounds.size.width - 20) / 3 / 2
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
}