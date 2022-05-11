import XCTest
import EnhanceKit

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        
    }
    
    func testDataEncryptAndDecrypt() {
        let str:NSString = "abcdefg"
        let data = str.data(using:  String.Encoding.utf8.rawValue)! as NSData
        // 32位
        let secKey: NSString = "cCaCAbACtQDUsbc6AgMnAAcCBEquaek5"
        let encryptData = data.aesEncrypt(withKey: secKey.data(using: String.Encoding.utf8.rawValue)!, iv: nil)!
        let decryptData = (encryptData as NSData).aesDecryptWithkey(secKey.data(using: String.Encoding.utf8.rawValue)!, iv: nil)
        let result: NSString = NSString.init(data: decryptData!, encoding: String.Encoding.utf8.rawValue)!
        
        XCTAssert(str == result, "Pass")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
