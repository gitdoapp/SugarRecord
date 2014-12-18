//
//  SugarRecordCDResults.swift
//  project
//
//  Created by Pedro Piñera Buendía on 11/12/14.
//  Copyright (c) 2014 SugarRecord. All rights reserved.
//

import Foundation
import CoreData

class SugarRecordCDResults: SugarRecordResultsProtocol
{
    //MARK: - Attributes
    private var results: [NSManagedObject]
    
    //MARK: - Constructors
    
    init(results: [NSManagedObject])
    {
        self.results = results
    }
    
    //MARK: - SugarRecordResultsProtocol
    
    var count:Int {
        get {
            return results.count
        }
    }
    
    func objectAtIndex(index: UInt) -> AnyObject!
    {
        return results[Int(index)] as AnyObject
    }
    
    func firstObject() -> AnyObject!
    {
        return results.first! as AnyObject
    }
    
    func lastObject() -> AnyObject!
    {
        return results.last! as AnyObject
    }
    
    func indexOfObject(object: AnyObject) -> Int
    {
        if let i = find(results, object as NSManagedObject) {
            return i
        }
        else {
            return NSNotFound
        }
    }
    
    func indexOfObjectWithPredicate(predicate: NSPredicate!) -> Int
    {
        var filteredArray: SugarRecordResultsProtocol! = objectsWithPredicate(predicate)
        var first: AnyObject! = filteredArray.firstObject()
        if first != nil {
            return indexOfObject(first)
        }
        else {
            return NSNotFound
        }
    }
    
    func objectsWithPredicate(predicate: NSPredicate!) -> SugarRecordResultsProtocol!
    {
        var array: NSArray = NSArray(array: results)
        return SugarRecordCDResults(results: (array.filteredArrayUsingPredicate(predicate) as [NSManagedObject]))
    }
    
    func sortedResultsUsingProperty(property: String!, ascending: Bool) -> SugarRecordResultsProtocol!
    {
        var array: NSArray = NSArray(array: results)
        return SugarRecordCDResults(results: (array.sortedArrayUsingDescriptors([NSSortDescriptor(key: property, ascending: ascending)]) as [NSManagedObject]))
    }
    
    func sortedResultsUsingDescriptors(properties: [AnyObject]!) -> SugarRecordResultsProtocol!
    {
        var array: NSArray = NSArray(array: results)
        return SugarRecordCDResults(results: (array.sortedArrayUsingDescriptors(properties) as [NSManagedObject]))
    }
    
    func realCollection() -> AnyObject
    {
        return results
    }
    
    subscript (index: Int) -> AnyObject! {
        get {
            return results[index] as AnyObject
        }
    }
}