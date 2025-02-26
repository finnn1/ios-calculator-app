import XCTest

class LinkedListTTD: XCTestCase {
    // TODO: 다양한 데이터를 담을 수 있는 Linked List 만들기
    var linkedList: LinkedList<Int>!
    var linkedList2: LinkedList<Int>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        linkedList = LinkedList<Int>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        linkedList = nil
    }
    
    // MARK: - Add values into linked list.

    func test_값을2개넣으면_count는_2를반환() throws {
        // given
        let inputValue1: Int = 3
        let inputValue2: Int = 3
        let expectation: Int = 2
        
        // what
        linkedList.pushBeforeHead(element: inputValue1)
        linkedList.pushBeforeHead(element: inputValue2)
        
        // then
        XCTAssertEqual(linkedList.count, expectation)
    }
    
    func test_head_쪽에_추가하면_popHead는_추가한값을반환() throws {
        // given
        let inputValue: Int = 7
        let expectation: Int = inputValue
        
        // what
        linkedList.pushBeforeHead(element: inputValue)
        
        // then
        XCTAssertEqual(linkedList.popHead(), expectation)
    }
    
    func test_popHead하면_count가_줄어든다() throws {
        // given
        let inputValue: Int = 7
        let expectation1: Int = 1
        let expectation2: Int = 0
        
        // what
        linkedList.pushBeforeHead(element: inputValue)
        
        // then
        XCTAssertEqual(linkedList.count, expectation1)
        
        // what
        linkedList.popHead()
        
        // then
        XCTAssertEqual(linkedList.count, expectation2)
    }
    
    func test_peekHead할경우_head의데이터를보여준다() throws {
        // given
        let inputValue: Int = 8
        let expectation: Int = inputValue
        
        // what
        linkedList.pushBeforeHead(element: inputValue)
        
        // then
        XCTAssertEqual(linkedList.peekHead(), expectation)
    }
    
    func test_값이없을경우_true를반환() throws {
        // given
        // what
        // then
        XCTAssertTrue(linkedList.isEmpty())
    }
    
    func test_값이있을경우_false를반환() throws {
        // given
        // what
        // then
        XCTAssertTrue(linkedList.isEmpty())
    }

    func test_tail_쪽에_추가하면_popTail는_추가한값을반환() throws {
        // given
        let inputValue: Int = 7
        let expectation: Int = inputValue
        
        // what
        linkedList.pushAfterTail(element: inputValue)
        
        // then
        XCTAssertEqual(linkedList.popTail(), expectation)
    }
    
    func test_popTail하면_count가_줄어든다() throws {
        // given
        let inputValue: Int = 7
        let expectation1: Int = 1
        let expectation2: Int = 0
        
        // what
        linkedList.pushAfterTail(element: inputValue)
        
        // then
        XCTAssertEqual(linkedList.count, expectation1)
        
        // what
        linkedList.popTail()
        
        // then
        XCTAssertEqual(linkedList.count, expectation2)
    }
    
    func test_peekTail할경우_Tail의데이터를보여준다() throws {
        // given
        let inputValue: Int = 8
        let expectation: Int = inputValue
        
        // what
        linkedList.pushAfterTail(element: inputValue)
        
        // then
        XCTAssertEqual(linkedList.peekTail(), expectation)
    }
    
    func test_1번인덱스의값을제거하면_count의값이1줄어든다() throws {
        // given
        let index: Int = 1
        let inputValue1: Int = 1
        let inputValue2: Int = 2
        let inputValue3: Int = 3
        let expectation1: Int = 3
        let expectation2: Int = 2
        
        // what
        linkedList.pushAfterTail(element: inputValue1)
        linkedList.pushAfterTail(element: inputValue2)
        linkedList.pushAfterTail(element: inputValue3)
        
        // then
        XCTAssertEqual(linkedList.count, expectation1)
        
        // what
        linkedList.remove(at: index)
        
        // then
        XCTAssertEqual(linkedList.count, expectation2)
    }
    
    func test_서브스크립트로_해당값에_접근() throws {
        // given
        let index: Int = 1
        let inputValue1: Int = 1
        let inputValue2: Int = 2
        let inputValue3: Int = 3
        let expectation: Int = 2
        
        // what
        linkedList.pushAfterTail(element: inputValue1)
        linkedList.pushAfterTail(element: inputValue2)
        linkedList.pushAfterTail(element: inputValue3)
        
        // then
        switch linkedList[index] {
        case .success(let data):
            XCTAssertEqual(data, expectation)
        case .failure(_):
            break
        }
    }
    
    func test_반복문사용() throws {
        // given
        let inputValue1: Int = 1
        let inputValue2: Int = 2
        let inputValue3: Int = 3
        let expectation: [Int] = [1, 2, 3]
        
        // what
        linkedList.pushAfterTail(element: inputValue1)
        linkedList.pushAfterTail(element: inputValue2)
        linkedList.pushAfterTail(element: inputValue3)
        
        // then
        for (i, j) in zip(linkedList, expectation) {
            XCTAssertEqual(i, j)
        }
    }
    
    func test_배열리터럴로초기화하기() throws {
        // what
        let expectation: [Int] = [1, 2, 3, 4]
        
        // given
        linkedList = [1, 2, 3, 4]
        
        // then
        for (i, j) in zip(linkedList, expectation) {
            XCTAssertEqual(i, j)
        }
    }
    
    func test_서브스크립트_인덱스를벗어나면_에러던지기() throws {
        // what
        let inputValues: [Int] = [1, 2, 3, 4]
        let index: Int = 7
        
        // given
        inputValues.forEach { linkedList.pushAfterTail(element: $0) }
        
        // then
        switch linkedList[index] {
        case .success(_):
            break
        case .failure(let error):
            XCTAssertEqual(error, LinkedListError.indexOutOfRange)
        }
    }
    
    func test_remove메서드_인덱스를벗어나면_에러던지기() throws {
        // what
        let inputValues: [Int] = [1, 2, 3, 4]
        let index: Int = 8
        
        // given
        inputValues.forEach { linkedList.pushAfterTail(element: $0) }
        
        // then
        switch linkedList.remove(at: index) {
        case .success(_):
            break
        case .failure(let error):
            XCTAssertEqual(error, LinkedListError.indexOutOfRange)
        }
    }
    
    func test_insert메서드로값넣기() throws {
        // given
        let defaultValues: [Int] = [1, 2, 3, 4]
        let inputValue: Int = 7
        let inputIndex: Int = 2
        let expectation1: [Int] = defaultValues
        var expectation2: [Int] = defaultValues
        expectation2.insert(inputValue, at: inputIndex)
        
        // what
        defaultValues.forEach { linkedList.pushAfterTail(element: $0) }
        
        // then
        for (i, j) in zip(linkedList, expectation1) {
            XCTAssertEqual(i, j)
        }
        
        // what
        linkedList.insert(inputValue, at: inputIndex)
        
        // then
        for (i, j) in zip(linkedList, expectation2) {
            XCTAssertEqual(i, j)
        }
    }
    
    func test_맨앞에insert() throws {
        // given
        let defaultValues: [Int] = [1]
        let inputValue: Int = 7
        let inputIndex: Int = 0
        let expectation1: [Int] = defaultValues
        var expectation2: [Int] = defaultValues
        expectation2.insert(inputValue, at: inputIndex)
        
        // what
        defaultValues.forEach { linkedList.pushAfterTail(element: $0) }
        
        // then
        for (i, j) in zip(linkedList, expectation1) {
            XCTAssertEqual(i, j)
        }
        
        // what
        linkedList.insert(inputValue, at: inputIndex)
        
        // then
        for (i, j) in zip(linkedList, expectation2) {
            XCTAssertEqual(i, j)
        }
    }
    
    func test_꺼낸값이동등한면_true() throws {
        // given
        // what
        linkedList = [1, 2, 3]
        linkedList2 = [1, 2, 3]
        
        // then
        XCTAssertTrue(linkedList.popHead() == linkedList2.popHead())
    }
    
    func test_내부값이_모두동등한면_true() throws {
        // given
        // what
        linkedList = [1, 2, 3]
        linkedList2 = [1, 2, 3]
        
        // then
        XCTAssertTrue(linkedList == linkedList2)
    }
    
    func test_배열인스턴스를_LinkedList타입으로_변환() throws {
        // given
        let array = [1, 2, 3]
        
        // what
        linkedList = LinkedList(array)
        
        // then
        for (linkedListElement, arrayElement) in zip(linkedList, array) {
            XCTAssertEqual(linkedListElement, arrayElement)
        }
    }
}
