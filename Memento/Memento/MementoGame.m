//
//  MementoGame.m
//  Memento
//
//  Created by Florian BUREL on 07/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "MementoGame.h"


@interface MementoGame ()

// Liste de cartes dans l'ordre ( 0 ... 11)
@property (readwrite, strong, nonatomic) NSArray * deck;

@end



@implementation MementoGame

+ (instancetype)newGame
{
    
    NSArray * baseSet = @[
                          @(MementoGameCardValue1),
                          @(MementoGameCardValue1),
                          @(MementoGameCardValue2),
                          @(MementoGameCardValue2),
                          @(MementoGameCardValue3),
                          @(MementoGameCardValue3),
                          @(MementoGameCardValue4),
                          @(MementoGameCardValue4),
                          @(MementoGameCardJoker1),
                          @(MementoGameCardJoker1),
                          @(MementoGameCardJoker2),
                          @(MementoGameCardJoker2)
                          ];
    
    MementoGame * game = [[MementoGame alloc]init];
    game.deck = baseSet;
    [game shuffle];
    return game;
}

-(void) shuffle
{
    self.deck = [self.deck sortedArrayUsingComparator:^(id obj1, id obj2) {
        return rand()%3-1;
    }];
}

- (MementoGameCard)valueForCardAtPosition:(MementoGamePosition)position
{
    int idx = [self indexOfCardAtPosition:position];
    return [self.deck[idx] intValue];
}


- (int) indexOfCardAtPosition:(MementoGamePosition)position
{
    return 3 * position.row + position.column;
}
@end
