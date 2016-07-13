//
//  MobileConnectServiceConfiguration.swift
//  MobileConnectSDK
//
//  Created by jenkins on 11/07/2016.
//  Copyright © 2016 GSMA. All rights reserved.
//

import UIKit

///Configuration needed for instantiating the MCService instance
public class MobileConnectServiceConfiguration: BaseServiceConfiguration {
    
    let authorizationURLString : String
    let tokenURLString : String
    let assuranceLevel : MCLevelOfAssurance
    let metadata : MetadataModel?
    let scopes : [String]
    let subscriberId : String?
    let clientName : String? //aka application short name from discovery response
    let context : String? //context value required while authorizing
    
    /**
     This constructor may change with addition of new features in future versions.
     It is recommended to use the init with discovery response if possible.
     - Parameter clientKey: the client id received from the discovery OperatorData model
     - Parameter clientSecret: the client secret received from the discovery OperatorData model
     - Parameter authorizationURLString: the authorization url received from the discovery OperatorData model
     - Parameter tokenURLString: the token url received from the discovery OperatorData model
     - Parameter subscriberId: the subscriber id received from the Discovery service operatorData model
    */
    public required init(clientKey : String,
                         clientSecret : String,
                         authorizationURLString : String,
                         tokenURLString : String,
                         assuranceLevel : MCLevelOfAssurance,
                         subscriberId : String?,
                         metadata : MetadataModel?,
                         clientName : String?,
                         context : String?,
                         scopes : [String] = [MobileConnectAuthentication])
    {
        NSException.checkClientName(clientName, forProducts: scopes)
        NSException.checkContext(context, forProducts: scopes)
        
        self.scopes = scopes
        self.authorizationURLString = authorizationURLString
        self.tokenURLString = tokenURLString
        self.assuranceLevel = assuranceLevel
        self.subscriberId = subscriberId
        self.clientName = clientName
        self.context = context
        self.metadata = metadata
        
        super.init(clientKey: clientKey, clientSecret: clientSecret, redirectURL: MobileConnectSDK.getRedirectURL())
    }
    
    public convenience init(discoveryResponse : DiscoveryResponse, assuranceLevel : MCLevelOfAssurance = MCLevelOfAssurance.Level2, scopes : [String] = [MobileConnectAuthorization, MobileConnectIdentityPhone]) {
        
        let localClientKey : String = discoveryResponse.response?.client_id ?? ""
        
        let localClientSecret : String = discoveryResponse.response?.client_secret ?? ""
        
        let localAuthorizationURLString : String = discoveryResponse.authorizationEndpoint ?? ""
        
        let localTokenURLString : String = discoveryResponse.tokenEndpoint ?? ""
        
        let localSubscriberId : String? = discoveryResponse.subscriber_id
        
        let clientName : String? = discoveryResponse.applicationShortName ?? ""
        
        let localAssuranceLevel : MCLevelOfAssurance = assuranceLevel
        
        let localMetadata : MetadataModel? = discoveryResponse.metadata
        
        self.init(clientKey: localClientKey,
                  clientSecret: localClientSecret,
                  authorizationURLString: localAuthorizationURLString,
                  tokenURLString: localTokenURLString,
                  assuranceLevel: localAssuranceLevel,
                  subscriberId : localSubscriberId,
                  metadata: localMetadata,
                  clientName: clientName,
                  context: "",
                  scopes: scopes)
    }
}
