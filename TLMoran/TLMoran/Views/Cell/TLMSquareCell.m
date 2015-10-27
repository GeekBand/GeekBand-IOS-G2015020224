//
//  TLMSquareCell.m
//  TLMoran
//
//  Created by Tiyang Lou on 10/24/15.
//  Copyright © 2015 Tiyang Lou. All rights reserved.
//

#import "TLMSquareCell.h"
#import "TLMSquareCollectionCell.h"
#import "TLMPictureModel.h"
#import "UIImageView+WebCache.h"

@implementation TLMSquareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TLMSquareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    TLMPictureModel *pictureModel = self.dataArr[indexPath.row];
    NSString *pic = pictureModel.pic_link;
    pic = [pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *pic_url = [NSURL URLWithString:pic];
    [cell.pictureImageView sd_setImageWithURL:pic_url];
    cell.titleLabel.text = pictureModel.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd", indexPath.row);
    TLMPictureModel *pictureModel = self.dataArr[indexPath.row];
    self.squareVC.pic_url = pictureModel.pic_link;
    self.squareVC.pic_id = pictureModel.pic_id;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
