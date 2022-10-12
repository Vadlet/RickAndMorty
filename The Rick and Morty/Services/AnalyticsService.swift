//
//  AnalyticsService.swift
//  The Rick and Morty
//
//  Created by Vadlet on 30.09.2022.
//

import FirebaseAnalytics

enum AnalyticsEvent: String {
    case character
    case episode
    case location
}

protocol AnalyticsServiceProtocol: AnyObject {
    func sendEvent(_ event: AnalyticsEvent, _ person: String)
}

final class AnalyticsService: AnalyticsServiceProtocol {
    func sendEvent(_ event: AnalyticsEvent, _ person: String) {
        Analytics.logEvent(event.rawValue, parameters: ["Person": person])
    }
}
