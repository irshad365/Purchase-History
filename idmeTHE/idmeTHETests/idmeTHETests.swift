//
//  idmeTHETests.swift
//  idmeTHETests
//
//  Created by Mohamed Farook, Irshad on 1/18/22.
//

import XCTest
@testable import idmeTHE

class idmeTHETests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHistoryData() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "purchaseHistory", ofType: "json")
        else { fatalError("Can't find purchaseHistory.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        if let decodedResponse = try? decoder.decode(Purchases.self, from: data), let purchase = decodedResponse.first {
            XCTAssertEqual(purchase.purchaseDate.debugDescription, "2020-12-30 00:00:00 +0000")
            XCTAssertEqual(purchase.purchaseDescription, "I'll input the neural ADP panel, that should card the JBOD application!")
        } else {
            XCTAssertFalse(true)
        }
    }
    
    func testPhoneNumberFormater() throws {
        XCTAssertEqual("17025555555".toPhoneNumber,"+1 (702) 555-5555")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
