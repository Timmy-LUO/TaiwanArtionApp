//
//  CalendarView.swift
//  TaiwanArtionApp
//
//  Created by 羅承志 on 2022/8/11.
//

import UIKit
import SnapKit
import JTAppleCalendar

class CalendarView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .backgroundColor
        layer.cornerRadius = 10
        setupUI()
        setupJTAppleCalendar()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIs
    private let calendar: JTACMonthView = {
        let calendar = JTACMonthView()
        calendar.register(DateCell.self,
                          forCellWithReuseIdentifier: DateCell.identifier)
        calendar.register(DateHeader.self,
                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                          withReuseIdentifier: DateHeader.identifier)
        calendar.backgroundColor = .backgroundColor
        calendar.showsHorizontalScrollIndicator = false
        calendar.scrollingMode = .stopAtEachCalendarFrame
        calendar.allowsMultipleSelection = true
        calendar.allowsRangedSelection = true
        calendar.scrollDirection = .horizontal
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
        return calendar
    }()
    
    private func setupJTAppleCalendar() {
        calendar.calendarDataSource = self
        calendar.calendarDelegate = self
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(300)
        }
    }
    
    // MARK: - Methods
    private func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    private func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.black
        } else {
            cell.dateLabel.textColor = UIColor.systemGray4
        }
    }
    
    private func handleCellSelected(cell: DateCell, cellState: CellState) {
        
        if cellState.isSelected {
            cell.selectedView.isHidden = false
            cell.dateLabel.textColor = .white
        } else {
            cell.selectedView.isHidden = true
        }
        
        cell.selectedView.isHidden = !cellState.isSelected
        switch cellState.selectedPosition() {
        case .left:
            cell.selectedView.layer.cornerRadius = 16
            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .middle:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = []
        case .right:
            cell.selectedView.layer.cornerRadius = 16
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        case .full:
            cell.selectedView.layer.cornerRadius = 16
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        default: break
        }
    }
    
    private func calendarHeader(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月"
        return formatter.string(from: date)
    }
}

// MARK: - Calendar DataSource
extension CalendarView: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2022 01 01")!
        let endDate = Date()
        let configurationParameters =
            ConfigurationParameters(startDate: startDate,
                                    endDate: endDate,
                                    numberOfRows: 6,
                                    calendar: Calendar.current,
                                    generateInDates: .forAllMonths,
                                    generateOutDates: .tillEndOfGrid,
                                    firstDayOfWeek: .monday,
                                    hasStrictBoundaries: true)
        return configurationParameters
    }
}

// MARK: - Calendar Delegate
extension CalendarView: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        self.calendar(calendar, willDisplay: cell,
                      forItemAt: date,
                      cellState: cellState,
                      indexPath: indexPath)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: DateHeader.identifier, for: indexPath) as! DateHeader
        header.headerLabel.text = calendarHeader(date: range.start)
        return header
    }

    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 100)
    }
}
