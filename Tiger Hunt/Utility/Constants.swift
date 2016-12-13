//
//  Constants.swift
//  Tiger Hunt
//
//  Copyright © 2016 Julianna_Gabler. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct Constants {
    // MARK: - Firebase Constants
    static let FIR_BASE_URL = "https://tiger-hunt-firebase.firebaseio.com/"
    static let FIR_STORAGE_URL = "gs://tiger-hunt-firebase.appspot.com"
    
    // MARK: - Login properties
    static let LOGIN_ERROR_TITLE: String = "Log In Error"
    static let LOGIN_ERROR_MSG: String = "Your email or password is inccorect. Please try again"
    static let ACCOUNT_NOT_ENABLED: String = "Your account is no longer active."
    static let SIGNUP_ERROR_TITLE: String = "Registraton Error"
    static let INVALID_EMAIL_MSG: String = "Your password is invalid. Please try again."
    static let WEAK_PASSWORD_MSG: String = "You have entered a weak password. Please try again."
    static let GENERIC_ERROR_MSG: String = "Hmm, something went wrong. Please try again"
    static let SIGNOUT_ERROR_TITLE: String = "Sign Out Error"
    static let PASSWORD_RESET_TITLE = "Password Reset"
    static let PASSWORD_RESET_MSG = "Check your email! We've sent you a link."
    static let ANIMATION_DELAY: Double = 0.1
    
    // MARK: - Mapview Properties
    static let ZOOMED_OUT_DELTA : Double = 0.025
    static let ZOOMED_IN_DELTA : Double = 0.001
    static let MAP_VIEW_INDEX: Int = 0
    static let RIT_LATTITUDE: CLLocationDegrees = CLLocationDegrees(43.083895)
    static let RIT_LONGITUDE: CLLocationDegrees = CLLocationDegrees(-77.676320)
    
    // MARK: - Task List Properties
    static let RIT_ORANGE: UIColor = UIColor(red: CGFloat(243.0/255.0), green: CGFloat(110.0/255.0), blue: CGFloat(33.0/255.0), alpha: 1.0)
    static let NUM_OF_SECTIONS: Int = 2
    static let TASK_LIST_TITLE: String = "PLACES"
    static let ACTIVITY_TITLE: String = "ACTIVITIES (BONUS)"
}
