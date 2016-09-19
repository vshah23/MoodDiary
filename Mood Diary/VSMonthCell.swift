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
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let calendar = sharedCalendar,
            let date = date else {
                return 0
        }
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date)
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

extension VSMonthCell: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = frame.size.width / 7
        let height = frame.size.height / 6
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}