//
//  VSMonthCell.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/4/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import UIKit

class VSMonthCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    private var sharedCalendar: NSCalendar? {
        didSet {
            guard date != nil else {
                return
            }
            collectionView.reloadData()
        }
    }
    private var date: NSDate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerNib(R.nib.vSDayCell)
    }
    
    func configure(forMonth month: Int, year: Int, calendar: NSCalendar) {
        let components = NSDateComponents()
        components.year = year
        components.month = month
        
        date = calendar.dateFromComponents(components)
        sharedCalendar = calendar
    }
}

extension VSMonthCell: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let calendar = sharedCalendar,
            let date = date else {
                return 0
        }
        let range = calendar.rangeOfUnit(.Month, inUnit: .Calendar, forDate: date)
        return range.length
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(R.reuseIdentifier.dayCell, forIndexPath: indexPath)!
        
        let day = indexPath.row + 1 //add one since indexPaths are zero indexed
        cell.dayLabel.text = "\(day)"
        
        return cell
    }
}

extension VSMonthCell: UICollectionViewDelegate {
    
}