//
//  DoublyLinkedList.swift
//  Algorithms and Data structures
//
//  Created by Paul Kraft on 09.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public struct DoublyLinkedList < Element > : _List {
	
	mutating public func pushBack(_ element: Element) {
		if root == nil	{ root = DoublyLinkedItem(data: element) }
		else			{ root!.pushBack(element) }
		assert(invariant)
	}
	
	public mutating func popBack() -> Element? {
		if root?.next == nil {
			let tmp = root?.data
			root = nil
			assert(invariant)
			return tmp
		}
		let v = root?.popBack()
		assert(invariant)
		return v
	}
	
	public subscript(index: Int) -> Element? {
		get {
			guard index >= 0 else { return nil }
			var current = root
			for _ in 0..<index { current = current?.next }
			assert(invariant)
			return current?.data
		}
		set {
			guard newValue != nil else { return }
			guard root != nil else {
				assert(index == 0, "Index out of bounds")
				root = DoublyLinkedItem(data: newValue!)
				assert(invariant)
				return
			}
			
			if index == 0 {
				root = DoublyLinkedItem(data: newValue!, next: root?.next)
				root?.next?.prev = root
				assert(invariant)
				return
			}
			
			var current = root
			var index = index - 1
			
			while index > 0 {
				current = current?.next
				assert(current != nil, "Index out of bounds")
				index -= 1
			}
			let c = current!
			c.next = DoublyLinkedItem(data: newValue!, prev: c, next: c.next?.next)
			c.next!.next?.prev = c.next
			assert(invariant)
		}
	}
	
	public mutating func insert(_ data: Element, at index: Int) throws {
		guard root != nil else {
			if index == 0	{ root = DoublyLinkedItem(data: data) }
			else			{ throw ListError.IndexOutOfRange }
			assert(invariant)
			return
		}
		
		var current = root
		var index = index - 1
		
		while index > 0 {
			current = current?.next
			if current == nil { throw ListError.IndexOutOfRange }
			index -= 1
		}
		
		current!.next = DoublyLinkedItem(data: data, prev: current, next: current?.next)
		assert(invariant)
	}
	
	public mutating func remove(at index: Int) throws -> Element {
		assert(invariant)
		guard index >= 0 else { throw ListError.IndexOutOfRange }
		
		if index == 0 {
			let tmp = root!.data
			self.root = root?.next
			return tmp
		}
		
		var current = root
		var index = index - 1
		
		while index > 0 {
			current = current?.next
			if current == nil { throw ListError.IndexOutOfRange }
			index -= 1
		}
		
		let next = current?.next
		let tmp = current!.next!.data
		current!.next = next?.next
		assert(invariant)
		return tmp
	}
	
	internal var root : DoublyLinkedItem < Element >?
	
	public init() { root = nil }
	
	public init(arrayLiteral: Element...) {
		self.init()
		self.array = arrayLiteral
	}
	
	public var array: [Element] {
		get {
			guard root != nil else { return [] }
			return root!.array
		}
		set {
			assert(invariant)
			guard newValue.count > 0 else { return }
			self.root = DoublyLinkedItem(data: newValue.first!)
			for e in newValue.dropFirst() {
				self.root!.pushBack(e)
			}
			assert(invariant)
		}
	}
	
	public var description : String {
		return "[\(root != nil ? root!.description : "")]"
	}
	
	public var count : Int {
		if root != nil { return root!.count }
		return 0
	}
	
	private var invariant : Bool {
		var current = root
		repeat {
			if current?.next != nil && current?.next?.prev !== current {
				print(current?.array)
				print(current?.next?.prev?.data, "!==", current?.data)
				return false
			}
			current = current?.next
		} while current != nil
		return true
	}
}

internal final class DoublyLinkedItem<Element> : _ListItem, CustomStringConvertible {
	let data : Element
	var next : DoublyLinkedItem?
	var prev : DoublyLinkedItem?
	
	convenience init(data: Element) {
		self.init(data: data, prev: nil, next: nil)
	}
	
	init(data: Element, prev: DoublyLinkedItem? = nil, next: DoublyLinkedItem? = nil) {
		self.data = data
		self.next = next
		self.prev = prev
	}
	
	func pushBack(_ newData: Element) {
		if next == nil	{ next = DoublyLinkedItem(data: newData, prev: self) }
		else			{ next!.pushBack(newData) }
	}
	
	var description : String {
		if next == nil { return "\(data)" }
		return "\(data) <-> \(next!)"
	}
}
