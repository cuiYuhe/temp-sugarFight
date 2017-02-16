//
//  YHAppDetailOfStoreModel.h
//  SugarFight
//
//  Created by Cui yuhe on 16/7/27.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAppDetailOfStoreModel : NSObject
/** primaryGenreName:Entertainment */
@property (nonatomic, copy) NSString *primaryGenreName;
/** artworkUrl100:http://is4.mzstatic.com/image/thumb/Purple18/v4/b0/51/7c/b0517cf0-566a-2f3c-74ac-1ae42afcde41/source/100x100bb.jpg, */
@property (nonatomic, copy) NSString *artworkUrl100;
/** sellerUrl:http://www.insightcode.com, */
@property (nonatomic, copy) NSString *sellerUrl;
/** currency :USD */
@property (nonatomic, copy) NSString *currency;
/** artworkUrl512 :http://is4.mzstatic.com/image/thumb/Purple18/v4/b0/51/7c/b0517cf0-566a-2f3c-74ac-1ae42afcde41/source/512x512bb.jpg, */
@property (nonatomic, copy) NSString *artworkUrl512;
/** ipadScreenshotUrls:[] */
@property (nonatomic, strong) NSArray *ipadScreenshotUrls;
/** fileSizeBytes:75577635, */
@property (nonatomic, strong) NSNumber *fileSizeBytes;
/** genres:[Entertainment,Social Networking] */
@property (nonatomic, strong) NSArray *genres;
/** languageCodesISO2A:[EN] */
@property (nonatomic, copy) NSString *languageCodesISO2A;
/** artworkUrl60:http://is4.mzstatic.com/image/thumb/Purple18/v4/b0/51/7c/b0517cf0-566a-2f3c-74ac-1ae42afcde41/source/60x60bb.jpg, */
@property (nonatomic, copy) NSString *artworkUrl60;
/** supportedDevices:[iPad2Wifi,iPad23G,iPhone4S,iPadThirdGen,iPadThirdGen4G,iPhone5,iPodTouchFifthGen,iPadFourthGen,iPadFourthGen4G,iPadMini,iPadMini4G,iPhone5c,iPhone5s,iPhone6,iPhone6Plus,iPodTouchSixthGen] */
@property (nonatomic, strong) NSArray *supportedDevices;
/** trackViewUrl:https://itunes.apple.com/us/app/quan-tang-zheng-ba/id1124805920?mt=8&uo=4, */
@property (nonatomic, copy) NSString *trackViewUrl;
/** description:1.用于大众娱乐,上传靓照;2.增加人与人之间互动的一款应用; */
@property (nonatomic, copy) NSString *desc;
/** version:1.1.1, */
@property (nonatomic, copy) NSString *version;
/** bundleId:com.icg.sugarFight, */
@property (nonatomic, copy) NSString *bundleId;
/** artistViewUrl:https://itunes.apple.com/us/developer/guang-zhou-ce-ma-xin-xi-ji/id1120502474?uo=4, */
@property (nonatomic, copy) NSString *artistViewUrl;
/** releaseDate:2016-06-24T18:29:02Z, */
@property (nonatomic, copy) NSString *releaseDate;
/** appletvScreenshotUrls:[] */
@property (nonatomic, strong) NSArray *appletvScreenshotUrls;
/** isGameCenterEnabled:0, */
@property (nonatomic, assign) BOOL isGameCenterEnabled;
/** wrapperType:software, */
@property (nonatomic, copy) NSString *wrapperType;
/** genreIds:[6016,6005], */
@property (nonatomic, strong) NSArray *genreIds;


/** trackId:1124805920, */
@property (nonatomic, strong) NSNumber *trackId;

/** minimumOsVersion:8.0, */
@property (nonatomic, copy) NSString *minimumOsVersion;

/** formattedPrice:Free, */
@property (nonatomic, copy) NSString *formattedPrice;

/** primaryGenreId:6016,, */
@property (nonatomic, strong) NSNumber *primaryGenreId;


/** currentVersionReleaseDate:2016-07-09T19:50:54Z,, */
@property (nonatomic, copy) NSString *currentVersionReleaseDate;


/** artistId:1120502474, */
@property (nonatomic, strong) NSNumber *artistId;


/** trackContentRating:4+, */
@property (nonatomic, copy) NSString *trackContentRating;


/** artistName:广州策码信息技术咨询有限公司,, */
@property (nonatomic, copy) NSString *artistName;

/** price:0,*/
@property (nonatomic, strong) NSNumber *price;


/** trackCensoredName:全糖争霸, */
@property (nonatomic, copy) NSString *trackCensoredName;

/** trackName:全糖争霸,, */
@property (nonatomic, copy) NSString *trackName;

/** kind:software, */
@property (nonatomic, copy) NSString *kind;

/** gfeatures:[] */
@property (nonatomic, copy) NSArray *features;


/** contentAdvisoryRating:4+, */
@property (nonatomic, copy) NSString *contentAdvisoryRating;

/** screenshotUrls:[http://a4.mzstatic.com/us/r30/Purple30/v4/39/51/d2/3951d23e-3f88-4807-a1ff-d6b4b133e73b/screen1136x1136.jpeg,http://a2.mzstatic.com/us/r30/Purple30/v4/fc/fa/5c/fcfa5c6b-3039-0c26-80c2-1bfdd7786004/screen1136x1136.jpeg,http://a3.mzstatic.com/us/r30/Purple20/v4/b0/77/09/b0770980-3657-aa4d-3b8f-cda24c65a768/screen1136x1136.jpeg,http://a3.mzstatic.com/us/r30/Purple30/v4/27/e7/0b/27e70b84-ab92-6929-494e-787a541ee074/screen1136x1136.jpeg,http://a5.mzstatic.com/us/r30/Purple20/v4/6b/31/58/6b315820-ec09-595c-9e72-ca6a5a47a3e5/screen1136x1136.jpeg]
 , */
@property (nonatomic, strong) NSArray *screenshotUrls;

/** releaseNotes:1.美化部分界面
 2.优化vip用户活跃率展示
 3.优化BCR界面的图片压缩., */
@property (nonatomic, copy) NSString *releaseNotes;
/** isVppDeviceBasedLicensingEnabled:1, */
@property (nonatomic, assign) BOOL isVppDeviceBasedLicensingEnabled;

/** sellerName:Guangzhou Insightcode Gear Information Technology Consulting Co., Ltd.,*/
@property (nonatomic, copy) NSString *sellerName;

/** advisories:[] */
@property (nonatomic, copy) NSArray *advisories;

@end
