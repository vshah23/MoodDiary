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
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return calendarDataSource.numberOfYearsInbetweenStartAndEndDates()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDataSource.numberOfMonthsInYear
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.monthCell, forIndexPath: indexPath)!
        
        cell.titleLabel.text = calendarDataSource.title(forMonth: indexPath.row)
        let month = indexPath.row
        let year = indexPath.section
        cell.configure(forMonth: month, year: year, calendar: calendarDataSource.calendar)
        
        return cell
    }
    
//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//    }
}