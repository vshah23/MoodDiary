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
        
        collectionView?.register(R.nib.vSMonthCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendarDataSource.numberOfYearsInbetweenStartAndEndDates()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDataSource.numberOfMonthsInYear
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.monthCell, for: indexPath)!
        
        let month = (indexPath as NSIndexPath).row + 1 //add one for zero indexing
        let year = (indexPath as NSIndexPath).section
        
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 3
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
        let height = (collectionView.bounds.size.width) / 3 / 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}
