//
//  Bill.h
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import <Realm/Realm.h>

@interface Bill : RLMObject

@property NSString *name;
@property float amount;
@property NSDate *dateBill; //Date sur la facture
@property NSDate *dateShoot; //Date de création de la photo
@property NSString *imageLink; //nom ou lien de l'image
@property NSString *category; //Categorie de la facture
@property NSString *user; //Pour plus tard
@property NSString *descriptionBill; //description de la facture
@property int objectId; //identifiant unique


@end

// This protocol enables typed collections. i.e.:
// RLMArray<Bill>
RLM_ARRAY_TYPE(Bill)
