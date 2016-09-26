//
//  VSMonthlyCalendarCollectionViewController.swift
//  Mood Diary
//
//  Created by Vikas Shah on 9/25/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation
import UIKit

class VSMonthlyCalendarCollectionViewController: UICollectionViewController {
    var calendarDataSource: VSCalendarDataSource? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    init(with calendarDataSource: VSCalendarDataSource) {
        super.init(collectionViewLayout: UICollectionViewLayout())
        self.calendarDataSource = calendarDataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension VSMonthlyCalendarCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfYears = calendarDataSource?.numberOfYearsInbetweenStartAndEndDates(),
            let numberOfMonths = calendarDataSource?.numberOfMonthsInYear else {
                return 0
        }
        return numberOfYears * numberOfMonths
    }
}

extension VSMonthlyCalendarCollectionViewController {
    
}
