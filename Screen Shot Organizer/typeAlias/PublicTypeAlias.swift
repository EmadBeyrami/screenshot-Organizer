//
//  PublicTypeAlias.swift
//  Screen Shot Organizer
//
//  Created by Emad Beyrami on 1/26/1400 AP.
//

import Foundation

public typealias SimpleAction = (() -> ())?
public typealias DataAction<T> = ((T?) -> ())?

