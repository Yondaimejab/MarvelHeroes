//
//  ApiClientErros.swift
//  Petstagram
//
//  Created by joel Alcantara on 19/6/22.
//

import Foundation

enum ApiClientError: Error {
	case invalidURL
	case requestFailed(Int)
	case postProcessingFailed(Error)

	var localizedDescription: String {
		switch self {
		case .invalidURL: return NSLocalizedString("Invalid URL Provided", comment: "")
		case .requestFailed(let statusCode): return NSLocalizedString("Invalid Request Code \(statusCode)", comment: "")
		case .postProcessingFailed(let error): return error.localizedDescription
		}
	}
}
