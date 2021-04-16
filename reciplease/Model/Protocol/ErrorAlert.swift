//
//  ErrorAlert.swift
//  reciplease
//
//  Created by Mosma on 16/04/2021.
//

protocol ErrorAlert: Error {
    var title: String { get }
    var message: String { get }
}
