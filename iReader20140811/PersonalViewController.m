//
//  PersonalViewController.m
//  iReader20140811
//
//  Created by lcl on 11/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//

#import "UtilityHeaders.h"
#import "UIImage+ImageRender.h"
#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "InfoTableViewCell.h"
#import "CLTagList.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UserNameChangeViewController.h"
#import "WoWoViewController.h"
#import "TagViewController.h"

@interface PersonalViewController()<UITableViewDataSource,
                                    UITableViewDelegate,
                                    UIActionSheetDelegate,
                                    UIImagePickerControllerDelegate,
                                    VPImageCropperDelegate,
                                    UINavigationControllerDelegate,
                                    UserNameChangeVCDelegate,
                                    WoWoViewControllerDelegate,
                                    TagViewControllerDelegate>
@property (nonatomic,strong) NSArray* sections;
@property (nonatomic,strong) NSMutableDictionary* defaultKV;
@property (nonatomic,strong) NSArray* tags;
@property (nonatomic,strong) NSMutableArray* randomTags;
@property (nonatomic,strong) CLTagList* tagList;
@property (nonatomic,strong) UIImageView* portraitImageView;
@property (nonatomic)        BOOL isNeedReload;
@property (nonatomic,strong) NSString* nUserName;
@property (nonatomic,strong) UserNameChangeViewController* uNameChangeVC;
@property (nonatomic,strong) WoWoViewController * wowoVC;
@property (nonatomic,strong) TagViewController *tagVC;
@end

@implementation PersonalViewController

-(void)viewDidLoad{
    
//  1 init datas
    NSDictionary* avatorDic = @{@"avator":[UIImage imageNamed:@"showgirl2"]};
    NSDictionary* detailDic = @{@"detail":@[@{@"昵称":@"在路上"},@{@"性别":@"女"},@{@"生日":@"1993年12月5日"},@{@"职业":@"学生"}]};
    self.tags = @[@"小说",@"无厘头",@"自由会指引你前进的方向",@"学霸",@"外国文学",@"村上春树"];
    NSDictionary* tagsDic = @{@"标签":self.tags};
    NSDictionary* wowoDic = @{@"窝窝":[NSNull null]};
    NSDictionary* settingDic = @{@"设置":[NSNull null]};
    self.sections = [NSArray arrayWithObjects:avatorDic,detailDic,wowoDic,settingDic,tagsDic,nil];
    
//  2 tableview init
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
//  3 tagList
    CGFloat w = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.tagList = [[CLTagList alloc] initWithFrame:CGRectMake(0, 0, w, 300)];
    [self initPersonalTags];
//    if uncomment the next line, you could know the life circle of a CLTag
//    self.tagList.delegate = self;
    
//  5 isNeedReload
    self.isNeedReload = NO;

    
    
    self.view.backgroundColor = bgColor;
    
//   6 init sub viewController
    self.uNameChangeVC = [[UserNameChangeViewController alloc] init];
    self.wowoVC = [[WoWoViewController alloc] init];
    self.tagVC = [[TagViewController alloc] init];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.tableView reloadData];
}

#pragma mark - Personal Tags handle Method
-(void)reSetRandomTags
{
    [self.tagList removeAllTag];
    self.randomTags = [NSMutableArray arrayWithArray:@[@"宅斗",@"金庸",@"女强",@"你若安好",@"发家致富",@"莫言",@"桐华",@"我是歌手",@"家田喜事",@"韩寒",@"郭敬明",@"朱自清",@"但丁",@"白居易",@"井上彦雄",@"村上村树",@"陆游",@"李白",@"三岛由纪夫",@"东野圭吾",@"卡耐基",@"小说",@"无厘头",@"自由会指引你前进的方向",@"学霸",@"外国文学"]];
}

-(NSUInteger)getRandomTagIndex
{
    return arc4random() % [self.randomTags count];
}

-(void)initPersonalTags
{
    [self reSetRandomTags];
    if ([self.randomTags count]) {
        for (NSInteger i = 0; i < 6; i++) {
            NSInteger index = [self getRandomTagIndex];
            [self.tagList addTag:[self.randomTags objectAtIndex:index] withImage:nil];
            [self.randomTags removeObjectAtIndex:index];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self reSetRandomTags];
}


#pragma tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return [[[self.sections objectAtIndex:section] objectForKey:@"detail"] count];
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        PersonalTableViewCell* cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.title.text = @"头像";
        if (self.isNeedReload == YES) {
            UIImage* newImg = [UIImage imageWithImage:self.portraitImageView.image scaledToSize:CGSizeMake(40, 40)];
            cell.thumbNail.image = [cell virtualLizeImg:newImg];
//            [cell setLayoutCustom];
        }
        [cell.contentView addSubview:cell.container];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.cornerRadius = 10.0;
        cell.clipsToBounds = YES;
        return cell;
    }else if(indexPath.section == 1){
        InfoTableViewCell* cell = [[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.title.text = [[[[self.sections objectAtIndex:indexPath.section] objectForKey:@"detail"] objectAtIndex:indexPath.row] allKeys][0];
        if ([self.nUserName length] > 0 && indexPath.row == 0) {
            cell.subTitle.text = self.nUserName;
//            [cell setLayoutCustom];
        }else{
            cell.subTitle.text = [[[[self.sections objectAtIndex:indexPath.section] objectForKey:@"detail"] objectAtIndex:indexPath.row] objectForKey:cell.title.text];
        }
        
        [cell.contentView addSubview:cell.container];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 4){
        InfoTableViewCell* cell = [[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.title.text = [[self.sections objectAtIndex:indexPath.section] allKeys][0];
        cell.subTitle.text = @"";
        [cell.contentView addSubview:cell.container];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.cornerRadius = 10.0;
        cell.clipsToBounds = YES;
        return cell;
    }else{
        InfoTableViewCell* cell = [[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.title.text = [[self.sections objectAtIndex:indexPath.section] allKeys][0];
        cell.subTitle.text = @"";
        [cell.contentView addSubview:cell.container];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.cornerRadius = 10.0;
        cell.clipsToBounds = YES;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 88.0f;
            break;
        default:
            return UITableViewAutomaticDimension;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 15;
            break;
        default:
            return UITableViewAutomaticDimension;
            break;
    }
//    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
//        NSLog(@"%lf",self.tagList.tagListHeight);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return self.tagList.tagListHeight;
    }else{
        return 5;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4) {
        self.tagList.backgroundColor = [UIColor whiteColor];
        return self.tagList;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        [self editThumbNail];
    }
    if (indexPath.section==1 && indexPath.row==0) {
        InfoTableViewCell* cell = (InfoTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//        UserNameChangeViewController* uNameChangeVC = [[UserNameChangeViewController alloc] init];
        self.uNameChangeVC.userNameChangeDelegate = self;
        self.uNameChangeVC.textField.text = cell.subTitle.text;
        [self.navigationController pushViewController:self.uNameChangeVC animated:YES];
    }
    if (indexPath.section == 2) {
//        WoWoViewController * wowoVC = [[WoWoViewController alloc] init];
        self.wowoVC.wowoVCDelegate = self;
        [self.navigationController pushViewController:self.wowoVC animated:YES];
    }
    if (indexPath.section == 4) {
        self.tagVC.tagViewControllerdelegate = self;
        [self.navigationController pushViewController:self.tagVC animated:YES];
    }

}


-(void)editThumbNail
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}



#pragma mark - Tag delegate

- (void)tagDidAddTag:(CLTag *)tag
{
    NSLog(@"Tag > %@ has been added", tag);
}

- (void)tagDidRemoveTag:(CLTag *)tag
{
    NSLog(@"Tag > %@ has been removed", tag);
}

- (void)tagDidSelectTag:(CLTag *)tag
{
    NSLog(@"Tag > %@ has been selected", tag);
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}


#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    self.isNeedReload = YES;
    NSLog(@"self.portraitImageView.image.size %@",NSStringFromCGSize(self.portraitImageView.image.size));
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    self.isNeedReload = NO;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UserNameChangeVCDelegate
-(void)didChangeUserName:(UserNameChangeViewController *)userNameChangeVC withNewName:(NSString *)newName
{
    self.nUserName = newName;
    [userNameChangeVC dismissViewControllerAnimated:YES completion:^{
       // TO DO
    }];
}

#pragma mark - WoWoViewController Delegate 
-(void)didFinishSetting:(WoWoViewController*)wowoVC
{
    [wowoVC dismissViewControllerAnimated:YES completion:^{
        //TO DO
    }];

}

#pragma mark - TagViewController Delegate
-(void)didFinishTagSelected:(TagViewController *)tagVC
{
    
    [tagVC dismissViewControllerAnimated:YES completion:^{
        //To do
    }];
}


#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 100.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 2;
//        NSLog(@"frame_portraitImageView %@",NSStringFromCGRect(CGRectMake(x, y, w, h)));
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        //        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        //        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        //        _portraitImageView.layer.shadowOpacity = 0.5;
        //        _portraitImageView.layer.shadowRadius = 2.0;
        _portraitImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _portraitImageView.layer.borderWidth = 2.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor blackColor];
    }
    return _portraitImageView;
}

//#pragma mark - hidden statusbar
//-(BOOL)prefersStatusBarHidden
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}


@end
