//
//  C4WorkSpace.m
//  drumPads
//
//  Created by Gregory Debicki on 2013-12-01.
//

#import "C4Workspace.h"

@implementation C4WorkSpace {
    NSMutableArray *pads;
    C4Sample *samp0, *samp1, *samp2, *samp3, *samp4, *samp5;
    C4Shape *display, *displayCirc;
    C4Font *f;
}

-(void)setup {
    [self setupDrumPads];
    f = [C4Font fontWithName:@"ArialRoundedMTBold" size:100.0f];
    display = [C4Shape shapeFromString:@"!" withFont:f];
    display.lineWidth = 3.0f;
    display.strokeColor = [UIColor whiteColor];
    display.center = CGPointMake(self.canvas.width*0.5f,
                                 self.canvas.height*0.4f);
    display.animationDuration = 0.2f;
    displayCirc = [C4Shape rect:CGRectMake(0, 0, 150, 150)];
    displayCirc.fillColor = [UIColor whiteColor];
    displayCirc.strokeColor = C4RED;
    displayCirc.center = CGPointMake(self.canvas.width*0.5f,
                                     self.canvas.height*0.4f);
    displayCirc.animationDuration = 0.1f;
    [self addObjects:@[displayCirc, display]];
}

-(void) setupDrumPads {
    pads = [[NSMutableArray alloc] init];
    for (float i = -2.5; i < 4; i++) {
        C4Shape *pad = [C4Shape ellipse:CGRectMake(0, 0, 50, 50)];
        CGFloat j = self.canvas.width/6;
        pad.center = CGPointMake(self.canvas.center.x + (i * j),
                                 self.canvas.height*0.85f - [C4Math absf:(i * j)/4]);
        pad.fillColor = [UIColor whiteColor];
        pad.zPosition = i;
        [pads addObject:pad];
    }
    [self addObjects:pads];
    [self listenFor:@"touchesBegan" fromObjects:pads andRunMethod:@"padTouched:"];
    [self prepareTheSamps];
}

-(void)padTouched:(NSNotification *)notification {
    C4Shape *shape = (C4Shape *)notification.object;
    shape.animationDuration = 0.0f;
    shape.fillColor = C4RED;
    shape.animationDuration = 0.3f;
    shape.fillColor = [UIColor whiteColor];
    displayCirc.rotation += [C4Math randomIntBetweenA:50 andB:150]/100.0f;
    NSInteger shapeId = [C4Math round:
                         (shape.center.x/(self.canvas.width*1.9))*10.0f];
    C4Log(@"%i", shapeId);
    switch (shapeId) {
        case 0:
            if (!samp0.isPlaying) [samp0 play];
            else samp0.currentTime = 0.0f;
            [display shapeFromString:@"unh" withFont:f];
            break;
        case 1:
            if (!samp1.isPlaying) [samp1 play];
            else samp1.currentTime = 0.0f;
            [display shapeFromString:@"tak" withFont:f];
            break;
        case 2:
            if (!samp2.isPlaying) [samp2 play];
            else samp2.currentTime = 0.0f;
            [display shapeFromString:@"bop" withFont:f];
            break;
        case 3:
            if (!samp3.isPlaying) [samp3 play];
            else samp3.currentTime = 0.0f;
            [display shapeFromString:@"bip" withFont:f];
            break;
        case 4:
            if (!samp4.isPlaying) [samp4 play];
            else samp4.currentTime = 0.0f;
            [display shapeFromString:@"tss" withFont:f];
            break;
        case 5:
            if (!samp5.isPlaying) [samp5 play];
            else samp5.currentTime = 0.0f;
            [display shapeFromString:@"clak" withFont:f];
            break;
        default:
            break;
    }
    display.center = CGPointMake(self.canvas.width*0.5f, self.canvas.height*0.4f);
}

-(void) prepareTheSamps {
    samp0 = [C4Sample sampleNamed:@"samp0.wav"];
    samp1 = [C4Sample sampleNamed:@"samp1.wav"];
    samp2 = [C4Sample sampleNamed:@"samp2.wav"];
    samp3 = [C4Sample sampleNamed:@"samp3.wav"];
    samp4 = [C4Sample sampleNamed:@"samp4.wav"];
    samp5 = [C4Sample sampleNamed:@"samp5.wav"];
    [samp0 prepareToPlay];
    [samp1 prepareToPlay];
    [samp2 prepareToPlay];
    [samp3 prepareToPlay];
    [samp4 prepareToPlay];
    [samp5 prepareToPlay];
}

@end
