//
//  Reults.swift
//  desafio-globoplay
//
//  Created by Mariana Maiko on 14/11/24.
//

import Foundation

enum MediaType: String{
    case movie = "Filme"
    case tvShow = "Série"
}

protocol Result{
    var posterPath: String? { get set }
    var id: Int? { get set }
    var overview: String? {get set}
    
    func getTitle() -> String?
    
    func getMediaType() -> MediaType
}
