//
//  DayFormatters.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/25/22.
//

import Foundation

let dateFormatterZulu: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return df
}()

let dateFormatterZuluMS: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    return df
}()
