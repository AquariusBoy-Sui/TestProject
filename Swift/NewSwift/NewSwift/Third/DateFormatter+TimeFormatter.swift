import Foundation

extension DateFormatter {

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mmss"
        return formatter
    }
    
    static var timeFormatterMMSS: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter
    }

}
