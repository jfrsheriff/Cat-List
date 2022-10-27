//
//  DataParserTests.swift
//  Cat ListTests
//
//  Created by Jaffer Sheriff U on 27/10/22.
//
import XCTest
@testable import Cat_List

final class DataParserTests: XCTestCase {

    struct User : Codable , Equatable{
        let name : String
        let age : Int
        let lastJob : String
    }
    
    struct UserSnakeCase : Codable , Equatable{
        let name : String
        let age : Int
        let last_job : String
    }
    
    struct UserFailing : Codable , Equatable{
        let age : Int
    }
    
    func test_init_emptyDecoderExpectsValidModel(){
        let sut = makeSUT()
        
        let sampleUser = getSampleUserModel()
        let jsonEncoder = JSONEncoder()
        
        do{
            let data = try jsonEncoder.encode(sampleUser)
            let parsedModel : User = try sut.parse(data)
            XCTAssertEqual(parsedModel, sampleUser)
        }catch{
            XCTFail("Parsing Error Occured : \(error)")
        }
    }
    
    
    func test_init_emptyDecoderWithSnakeCaseModelExpectsValidModel(){
        let sut = makeSUT()
        
        let sampleUser = getSampleUserModel()
        let sampleUserSnakeCase = getSampleUserModelSnakeCase()
        
        let jsonEncoder = JSONEncoder()
        
        do{
            let data = try jsonEncoder.encode(sampleUserSnakeCase)
            let parsedModel : User = try sut.parse(data)
            XCTAssertEqual(parsedModel, sampleUser)
        }catch{
            
            XCTFail("Parsing Error Occured : \(error)")
        }
    }
    
    func test_init_emptyDecoderWithInvalidModelExpectsException(){
        let sut = makeSUT()
        let invalidModel = getSampleFailingModel()
        
        let jsonEncoder = JSONEncoder()
        
        do{
            let data = try jsonEncoder.encode(invalidModel)
            let _ : User = try sut.parse(data)
            XCTFail("Parsing Succeeded But Expected a Exception")
        }catch{
            
        }
    }
    
    // MARK: - Helpers
    
    private func getSampleUserModel() -> User{
        User(name: "Jack", age: 30, lastJob: "IOS Developer")
    }
    
    private func getSampleUserModelSnakeCase() -> UserSnakeCase{
        UserSnakeCase(name: "Jack", age: 30, last_job: "IOS Developer")
    }
    
    private func getSampleFailingModel() -> UserFailing{
        UserFailing(age: 30)
    }

    private func makeSUT() -> DataParser{
        DataParser()
    }
}
