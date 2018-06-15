//
//  Config.swift
//  DhyanaGenric
//
//  Created by AVANTARI on 28/11/17.
//  Copyright © 2017 AVANTARI. All rights reserved.
//

import Foundation

struct Config {
    // Urls
    static var BASE_URL                       = "https://dhyana.avantari.org/v1" //"http://192.168.0.145:4600/v1" //"https://y9mowvd7hk.execute-api.us-east-1.amazonaws.com/latest/v1" //"http://local.avantari.org:3500/v1"



    // Keys for userdefaults
    static var emotion_data                   = "EMOTION_DATA"
    static var bearer_token                   = "BEARER_TOKEN"
    static var downloaded_files               = "DOWNLOADED_FILES"
    static var selected_emotion               = "SELECTED_EMOTION"
    static var user_logged_in                 = "USER_LOGGED_IN"
    static var device_connected               = "DEVICE_CONNECTED"
    static var connected_device_udid          = "CONNECTED_DEVICE_UDID"
    static var current_device_id              = "CURRENT_DEVICE_ID"
    static var unlock_free_emotions           = "UNLOCK_FREE_EMOTIONS"
    static var single_emotion_data            = "SINGLE_EMOTION_DATA"
    static var userLoggedInEmail              = "USER_LOGGEDIN_EMAIL"
    static var firmwareZipUrl                 = "FIRMWARE_ZIP_URL"
    static var currencyCode                   = "CURRENCY_CODE"
    static var priceArray                     = "PRICE_ARRAY"

    // Name for notifications
    static var applicationDidEnterBackground  = "APPLICATION_DID_ENTER_BACKGROUND"
    static var applicationDidBecomeActive     = "APPLICATION_DID_BECOME_ACTIVE"
    static var shouldEnableScrolling          = "SHOULD_ENABLE_SCROLLING"
    static var shouldDisableScrolling         = "SHOULD_DISABLE_SCROLLING"
    static var changeBigIcon                  = "CHANGE_BIG_ICON"
    static var uploadCompleted                = "UPLOADING_COMPLETED"
    static var errorInUpload                  = "ERROR_IN_UPLOAD"
    static var report_datapoints              = "REPORT_DATAPOINTS"
    static var mindfull_report_datapoints     = "MINDFULL_REPORT_DATAPOINTS"
    static var manage_emotions                = "MANAGE_EMOTIONS"
    static var changeScreenBasedOnProduct     = "CHANGE_SCREEN_BASED_ON_PRODUCT"
    static var resetHomeScreen                = "RESET_HOME_SCREEN"
    static var changeBreathingTimerLabel      = "CHANGE_BREATHING_TIMER_LABEL"
    static var shouldEnableDownViewScrolling  = "SHOULD_ENABLE_DOWN_VIEW_SCROLLING"
    static var shouldDisableDownViewScrolling = "SHOULD_DISABLE_DOWN_VIEW_SCROLLING"


    static var failureMessage: [String: Any]  = ["message":"Server Error. Check your internet connection and try again."]
}
