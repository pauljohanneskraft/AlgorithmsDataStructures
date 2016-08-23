//
//  TreeTests.swift
//  TreeTests
//
//  Created by Paul Kraft on 09.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import XCTest
import Algorithms_and_Data_structures

class TreeTests: XCTestCase {
	
	let arr = [9235,25,52,2,5,23,35,65,532,6,54,75,7,56,8,4]
	
	func testBinomialHeap() {
		var binHeap = BinomialHeap<Int>()
		for r in arr {
			// print("\(r):", terminator: "")
			binHeap.push(r)
			// print(" ready.")
			// print(binHeap)
		}
		var binHeapArray = [Int]()
		for _ in arr.indices {
			let min = binHeap.pop()!
			binHeapArray.append(min)
			// print("\(i):", min)
			// print(binHeap)
		}
		print(binHeapArray)
		XCTAssert(binHeapArray == arr.sorted())
	}
	
	func testMaxHeap() {
		
		var maxHeap = BinaryMaxHeap<Int>()
		
		maxHeap.array = arr
		
		var sorted = [Int]()
		
		for _ in arr.indices {
			sorted.append(maxHeap.pop()!)
		}
		print(sorted)
		XCTAssert(sorted == arr.sorted().reversed())
		
	}
	
	func testBinaryTree() {
		var bin = BinaryTree<Int>()
				
		for e in arr { bin.push(e) }
		
		print(bin.array)
		
		XCTAssert(bin.array == arr.sorted())
	}
}






