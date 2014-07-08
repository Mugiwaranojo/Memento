//
//  ViewController.m
//  Memento
//
//  Created by Florian BUREL on 07/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "ViewController.h"
#import "MementoGame.h"
#import "CardView.h"

@interface ViewController ()

// jeu en cours
@property (readwrite, strong, nonatomic) MementoGame * game;
@property (readwrite, strong, nonatomic) CardView * lastSelected;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Ajout des Gesture Recognizer
    
    _game = [MementoGame newGame];
    _lastSelected=NULL;
    for (UIView * item in self.view.subviews)
    {
        if([item isKindOfClass:[CardView class]])
        {
            UITapGestureRecognizer * tap = [UITapGestureRecognizer new];
            [tap addTarget:self action:@selector(cardTapped:)];
            [item addGestureRecognizer:tap];

        }
    }
    
}
- (IBAction)restartGame:(id)sender {
    for (UIView * item in self.view.subviews)
    {
        if([item isKindOfClass:[CardView class]])
        {
            CardView * card = (CardView *) item;
            if([card isShowingValueSide])
            {
                [card flip];
            }
        }
    }
    [_game shuffle];
    _lastSelected=NULL;
}

-(void) cardTapped: (UITapGestureRecognizer *) sender;
{
    CardView * selectedCard = (CardView *) sender.view;
    [self displayImageCard:selectedCard];
    [selectedCard flip];
    
    if(_lastSelected==NULL)
    {
        _lastSelected = selectedCard;
    }
    else if( [self tagToImageCard:_lastSelected.tag] == [self tagToImageCard: selectedCard.tag] )
    {
        _lastSelected=NULL;
    }
    else
    {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.45 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_lastSelected flip];
            [selectedCard flip];
             _lastSelected=NULL;
        });

    }
    
    
}


-(MementoGameCard) tagToImageCard: (int) tag
{
    MementoGamePosition position;
    int index= tag-1;
    position.row= index/3;
    position.column= index%3;
    return [_game valueForCardAtPosition:position];
}

-(void) displayImageCard : (CardView *) selectedCard
{
    MementoGameCard card= [self tagToImageCard:selectedCard.tag];
    switch (card) {
        case MementoGameCardValue1:
            selectedCard.image = [UIImage imageNamed:@"Nami"];
            break;
        case MementoGameCardValue2:
            selectedCard.image = [UIImage imageNamed:@"franky"];
            break;
        case MementoGameCardValue3:
            selectedCard.image = [UIImage imageNamed:@"luffy"];
            break;
        case MementoGameCardValue4:
            selectedCard.image = [UIImage imageNamed:@"robin"];
            break;
        case MementoGameCardJoker1:
            selectedCard.image = [UIImage imageNamed:@"sogeking"];
            break;
        default:
            selectedCard.image = [UIImage imageNamed:@"zorro"];
            break;
    }
}

@end
