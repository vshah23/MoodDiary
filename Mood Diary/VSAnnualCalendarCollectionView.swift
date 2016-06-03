//
//  VSAnnualCalendarCollectionView.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/2/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import UIKit

class VSAnnualCalendarCollectionView: UICollectionViewController {
    let annualDataSource = VSAnnualCalendarDataSource()
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return annualDataSource.numberOfYearsBetweenDates()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return annualDataSource.numberOfMonthsInYear
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.monthCell.identifier, forIndexPath: indexPath)
        
        return cell
    }
}