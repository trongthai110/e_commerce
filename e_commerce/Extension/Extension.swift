//
//  Extension.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import Foundation
import RealmSwift



extension Results {
    // MARK: - ================================= For RealmSwift =================================
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}


extension Double {
    // MARK: - ================================= Get TimeStamp Today =================================
    func getTimeStamp() -> Double {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: now)
        let date = formatter.date(from: dateString)!
        let timestamp = date.timeIntervalSince1970
        return timestamp
    }
    
    // MARK: - ================================= Number to Date =================================
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
    
    // MARK: - ================================= TimeStamp to Hours =================================
    func hoursInDay() -> Double {
        let date = Date(timeIntervalSince1970: self)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        let hours = Double(components.hour ?? 0)
        return hours
    }
    
    func getHour(from timeStamp: Double) -> Int {
        let date = Date(timeIntervalSince1970: timeStamp)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour == 0 ? 24 : hour
    }
    

    func toStarString() -> String {
        let intValue = min(Int(self), 5)
        let fractionalPart = self - Double(intValue)
        let fractionalValue = Int((fractionalPart * 10).rounded())
        
        var result = ""
        for i in 1...5 {
            let char = (i <= intValue) ? "A" : ((i - intValue <= fractionalValue) ? "B" : "C")
            result += char
        }
        
        return result
    }

    // MARK: - ================================= Rounded =================================
    
    func roundedString(decimalPlaces: Int) -> String {
        let divisor = pow(10.0, Double(decimalPlaces))
        let roundedNumber = (self * divisor).rounded() / divisor
        return String(format: "%.\(decimalPlaces)f", roundedNumber)
    }
}


extension String {
    // MARK: - ================================= TimeStamp to Day =================================
    func timeStampToDay(timeStamp: Double, type: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        switch type {
            case 1:
                dateFormatter.dateFormat = "dd/MM"
                
            case 2:
                dateFormatter.dateFormat = "dd MMM yyyy"
                
            default:
                dateFormatter.dateFormat = "dd/MM"
        }
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}


extension Date {
    // MARK: - ================================= Date to TimeStamp =================================
    func timestampForDayAndMonth() -> TimeInterval {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        guard let date = calendar.date(from: components) else { return 0 }
        return date.timeIntervalSince1970
    }
}


extension Int {
    // MARK: - ================================= Get timestamp of month =================================
    func getTimestampsOfMonth(month: Int) -> [Int] {
        let calendar = Calendar.current
        
        // Tính toán số ngày trong tháng được truyền vào
        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: month)
        guard let range = calendar.range(of: .day, in: .month, for: calendar.date(from: dateComponents)!) else {
            return []
        }
        
        // Tạo một mảng các timestamp của các ngày trong tháng
        var timestamps = [Int]()
        for day in 1...range.count {
            let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: month, day: day)
            if let date = calendar.date(from: dateComponents) {
                timestamps.append(Int(date.timeIntervalSince1970))
            }
        }
        
        return timestamps
    }
    
    // MARK: - ================================= Dấu phân hàng nghìn =================================
    func thousandsSeparator() -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal          // Đặt mặc định cho trình định dạng phổ biến để hiển thị số thập phân
        numberFormatter.usesGroupingSeparator = true    // Đã bật dấu tách
        numberFormatter.groupingSeparator = ","         // Đặt dấu phân cách hàng nghìn
        numberFormatter.decimalSeparator = "."          // Đặt dấu phân cách hàng thập phân
        numberFormatter.groupingSize = 3                // Đặt các chữ số giữa mỗi dấu phân cách
        
        let myFormattedDouble = numberFormatter.string(for: self)
        
        return myFormattedDouble!
    }
}


extension Array where Element == TimeInterval {
    // MARK: - ================================= Get oldest Date =================================
    func oldestDate() -> Date? {
        guard let oldestTimestamp = self.min() else { return nil }
        return Date(timeIntervalSince1970: oldestTimestamp)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {return}
        downloaded(from: url, contentMode: mode)
    }
}
