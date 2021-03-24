//
//  Tomato.swift
//  tomato
//
//  Created by vozio on 2020/10/13.
//

import SwiftyUserDefaults
class Tomato {

    static func createTestRecords() { //生成测试用数据 , (测试用的!)
        var BeginTime = Date()
        BeginTime.addTimeInterval(86400 * 30 * -1 )
        var tempTomatoRecord:[TomatoRecord] = []
        for index in 0..<200 {
            let addRecord = TomatoRecord()
            addRecord.dtStartTime = BeginTime
            addRecord.dtEndTime = BeginTime.addingTimeInterval(1500)
            addRecord.stEvent = "number\(index)"
            
            tempTomatoRecord.append(addRecord)

            BeginTime.addTimeInterval(5000)
        }
        Defaults.tomatoRecords = tempTomatoRecord
    }
    
    static func cleanRecords() { //删掉所有记录 (测试用的?)
        Defaults.tomatoRecords = []
    }
    
    
    static func appendRecord(_ trTomato:TomatoRecord) { //增加一条番茄记录
        Defaults.tomatoRecords.append(trTomato)
    }
    
    static func recordsBetween(dtStart:Date , dtEnd:Date)->[TomatoRecord] { //查找两个时间范围内的番茄记录
        let rtRecords = Defaults.tomatoRecords.filter {
            ($0.dtStartTime > dtStart) && ($0.dtStartTime < dtEnd)
        }

        return rtRecords
    }
    
    static func recordsBetween(stStartYMD:String , stEndYMD:String)->[TomatoRecord] { //查找两个时间范围内的🍅记录.格式如 2020-05-20
        let dtStart = NSDate.dateFromISOString(string: "\(stStartYMD)T00:00:00") as Date
        let dtEnd = NSDate.dateFromISOString(string: "\(stEndYMD)T00:00:00") as Date
        return recordsBetween(dtStart: dtStart, dtEnd: dtEnd)
    }
    
    ///查找多个时间范围内的番茄记录,返回一个多维数组
    static func recordsOfTimeSpans(times:[(Date,Date)])->[[TomatoRecord]] {
        var rt :[[TomatoRecord]] = []
        let tempRecords = Defaults.tomatoRecords
        for (start , end ) in times {
            let oneTimeRecords = tempRecords.filter {
                ($0.dtStartTime > start) && ($0.dtStartTime < end)
            }
            rt.append(oneTimeRecords)
        }
        return rt
    }
    
    static func findRecordByUUID(stUUID:String)->TomatoRecord? { //根据uuid找到单条记录.
        let tempRecords = Defaults.tomatoRecords
        return tempRecords.first { item -> Bool in
            return item.uuid == stUUID
        }
    }
    
    static func findRecordByStartDate(dtDate:Date)->TomatoRecord? { //根据开始时间找到单条记录.
        let tempRecords = Defaults.tomatoRecords
        return tempRecords.first { item -> Bool in
            return item.dtStartTime == dtDate
        }
    }
    
    
    static func deleteRecord(stUUID:String) { //删除某个番茄记录id
        var tempRecords = Defaults.tomatoRecords

        let itIndex = tempRecords.firstIndex{ item -> Bool in
            return item.uuid == stUUID
        }
        tempRecords.remove(at: itIndex!)
        Defaults.tomatoRecords = tempRecords
    }
    
    static func editRecord(_ trTomato:TomatoRecord) { //编辑某个🍅记录
        var tempRecords = Defaults.tomatoRecords

        let itIndex = tempRecords.firstIndex{ item -> Bool in
            return item.uuid == trTomato.uuid
        }
        tempRecords[itIndex!] = trTomato
        Defaults.tomatoRecords = tempRecords
    }
    
    static func deleteRecordsBetween(dtStart:Date , dtEnd:Date) { //删除两个时间范围内的番茄记录
        let tempRecords = Defaults.tomatoRecords.filter {
            !(($0.dtStartTime > dtStart) && ($0.dtStartTime < dtEnd))
        }
        
        Defaults.tomatoRecords = tempRecords
    }
    
    static func deleteRecordsBetween(stStartYMD:String , stEndYMD:String) { //删除两个时间范围内的🍅记录.格式如 2020-05-20
        let dtStart = NSDate.dateFromISOString(string: "\(stStartYMD)T00:00:00") as Date
        let dtEnd = NSDate.dateFromISOString(string: "\(stEndYMD)T00:00:00") as Date
        deleteRecordsBetween(dtStart: dtStart, dtEnd: dtEnd)
    }
    
}

class TomatoRecord: Codable ,DefaultsSerializable {
    init() {
        uuid = UUID.init().uuidString
    }
    var dtStartTime:Date! //走表开始时间
    var dtEndTime:Date! // 走表结束时间
    var stEvent:String! //走表事件
    var isRecording:Bool! // 是否还在走表中(可能没用)
    var uuid:String! // uuid
    var itEventImgIndex:Int! // 事件图标
}


/**
 番茄工作记录项目
 */
class TomatoRecordItem: Identifiable, Codable {
    init() {
        id = UUID.init().uuidString
    }
    var id :String!             // uuid
    var dtStartTime:Date!        //走表开始时间
    var dtEndTime:Date!          //走表结束时间
    var stEvent:String!          //走表事件
    var isRecording:Bool!        //是否还在走表中(可能没用)
    var itEventImgIndex:Int!    //事件图标
}

/**
 番茄工具逻辑类
 */
class TomatoBLL: ObservableObject {
    static let shared = TomatoBLL()
    
    @Published var items: [TomatoRecordItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    //初始化读取UserDefault中记录
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([TomatoRecordItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
    
    //打印番茄记录
    func printTomato(){
        print("--------printTomato items :",items.count)
    }
    
    //创建测试记录===
    func createTestRecords() { //生成测试用数据 , (测试用的!)
        var BeginTime = Date()
        BeginTime.addTimeInterval(86400 * 30 * -1 )
        let stArEvent = ["吃饭","睡觉","打豆豆","抽烟","喝酒","烫头",]
        var tempRecords = [TomatoRecordItem]()
        for index in 0..<500 {
            let addRecord = TomatoRecordItem()
            addRecord.dtStartTime = BeginTime
            addRecord.dtEndTime = BeginTime.addingTimeInterval(3000)
            addRecord.stEvent = "\(stArEvent[Int(arc4random())%6])"
            tempRecords.append(addRecord)
            BeginTime.addTimeInterval(20000)
        }
        
        self.items = tempRecords
    }
    
    //删掉所有记录 (测试用的?)
    func cleanRecords() {
        items = []
    }
    
    //增加一条番茄记录
    func appendRecord(_ trTomato:TomatoRecordItem) {
        items.append( trTomato)
    }
    
    //查找两个时间范围内的番茄记录
    func recordsBetween(dtStart:Date , dtEnd:Date)->[TomatoRecordItem] {
        let rtRecords = items.filter {
            ($0.dtStartTime > dtStart) && ($0.dtStartTime < dtEnd)
        }

        return rtRecords
    }
    
    //查找两个时间范围内的🍅记录.格式如 2020-05-20
    func recordsBetween(stStartYMD:String , stEndYMD:String)->[TomatoRecordItem] {
        let dtStart = NSDate.dateFromISOString(string: "\(stStartYMD)T00:00:00") as Date
        let dtEnd = NSDate.dateFromISOString(string: "\(stEndYMD)T00:00:00") as Date
        return recordsBetween(dtStart: dtStart, dtEnd: dtEnd)
    }
    
    //查找多个时间范围内的番茄记录,返回一个多维数组
    func recordsOfTimeSpans(times:[(Date,Date)])->[[TomatoRecordItem]] {
        var rt :[[TomatoRecordItem]] = []
        let tempRecords = items
        for (start , end ) in times {
            let oneTimeRecords = tempRecords.filter {
                ($0.dtStartTime > start) && ($0.dtStartTime < end)
            }
            rt.append(oneTimeRecords)
        }
        return rt
    }
    
    //根据uuid找到单条记录.
    func findRecordByUUID(stUUID:String)->TomatoRecordItem? {
        return items.first { item -> Bool in
            return item.id == stUUID
        }
    }
    
    //根据开始时间找到单条记录.
    func findRecordByStartDate(dtDate:Date)->TomatoRecordItem? {
        return items.first { item -> Bool in
            return item.dtStartTime == dtDate
        }
    }
    
    //删除某个番茄记录id
    func deleteRecord(stUUID:String) {
        let itIndex = items.firstIndex{ item -> Bool in
            return item.id == stUUID
        }
        items.remove(at: itIndex!)
    }
    //编辑某个🍅记录
    func editRecord(_ trTomato:TomatoRecordItem) {

        let itIndex = items.firstIndex{ item -> Bool in
            return item.id == trTomato.id
        }
        items[itIndex!] = trTomato
    }
    
    //删除两个时间范围内的番茄记录
    func deleteRecordsBetween(dtStart:Date , dtEnd:Date) {
        let tempRecords = items.filter {
            !(($0.dtStartTime > dtStart) && ($0.dtStartTime < dtEnd))
        }
        
        items = tempRecords
    }
    
    //删除两个时间范围内的🍅记录.格式如 2020-05-20
    func deleteRecordsBetween(stStartYMD:String , stEndYMD:String) {
        let dtStart = NSDate.dateFromISOString(string: "\(stStartYMD)T00:00:00") as Date
        let dtEnd = NSDate.dateFromISOString(string: "\(stEndYMD)T00:00:00") as Date
        deleteRecordsBetween(dtStart: dtStart, dtEnd: dtEnd)
    }
}


