//
//  RedditPostTests.swift
//  RedditPostTests
//
//  Created by Nicolas Wang on 08/09/2020.
//  Copyright © 2020 Nicolas Wang. All rights reserved.
//

import XCTest
@testable import RedditPost

class RedditPostTests: XCTestCase {

    private typealias SUT = (presenter: PostPresenterProtocol, interactor: PostInteractorProtocol, wireframe: MockWireframe)
    private var sut: SUT?

    override func setUp() {
        super.setUp()
        sut = getSUT()
    }

}

extension RedditPostTests {
    func testAPI() {
        let interactor = sut?.interactor

        interactor?.getPosts(completion: { posts in
            print(posts)
            guard !posts.isEmpty else { return }
            let post = posts[0]
            
            XCTAssertNotNil(post.data?.id)
            XCTAssertNotNil(post.data?.numComments)
            XCTAssertNotNil(post.data?.author)
            XCTAssertNotNil(post.data?.createdUtc)
            XCTAssertNotNil(post.data?.visited)
            XCTAssertNotNil(post.data?.saved)
            XCTAssertNotNil(post.data?.title)
        })
    }
    
    func testPresenter() {
        let presenter = sut?.presenter
        let interactor = sut?.interactor
        interactor?.getPosts(completion: { posts in
            presenter?.posts = posts
        })
        
        let rows = presenter?.numberOfRows()
        XCTAssertEqual(rows, 25)
        
        let post = presenter?.post(at: 0)
        XCTAssertNotNil(post?.data?.id)
        
        presenter?.didSelectItem(at: 0)
        if let didPush = sut?.wireframe.didPush {
            XCTAssertTrue(didPush)
        }

        presenter?.dismissAll()
        if let posts = presenter?.posts {
            let empty = posts.isEmpty
            XCTAssertTrue(empty)
        }
    }
}
extension RedditPostTests {
    private func getSUT() -> SUT {
        let api = MockApi()
        let interactor = PostInteractor(api: api)
        let presenter = PostPresenter(view: PostViewController())
        let wireframe = MockWireframe()
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        return (presenter, interactor, wireframe)
    }
    
    private class MockApi: PostApiProtocol {
        func getPosts(completion: @escaping ([RedditModel]) -> Void) {
            guard let json = getData(of: "post") else { return }
            guard let model = Request<[RedditModel]>.parsedModel(with: json, at: "data.children") else { return }
            completion(model)
        }
        
        private func getData(of file: String) -> Data? {
            let data = readDictionaryJson(fileName: file)
            return data
        }
        
        func readDictionaryJson(fileName: String) -> Data? {
            do {
                if let file = Bundle.main.path(forResource: fileName, ofType: "json") {
                    let data = try Data(contentsOf: URL(fileURLWithPath: file))
                    return data
                }
            } catch {
                print(error.localizedDescription)
            }
            return nil
        }
    }
    
    private class MockWireframe: PostWireframeProtocol {
        var didPush = false
        func pushToDetail(with item: RedditModel) {
            didPush = true
        }
    }
}
