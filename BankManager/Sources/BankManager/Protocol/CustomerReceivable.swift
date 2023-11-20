//
//  Receivable.swift
//
//
//  Created by jyubong, Toy on 11/16/23.
//


public protocol CustomerReceivable {
    associatedtype Customer: CustomerNumbering
    var charge: Banking { get }
    
    func receive(customer: Customer)
}
