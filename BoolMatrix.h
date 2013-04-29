//
//  BoolMatrix.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#ifndef __Orgo__BoolMatrix__
#define __Orgo__BoolMatrix__

#include <Foundation/Foundation.h>

class BoolMatrix
{
public:
    BoolMatrix(int length);
    ~BoolMatrix();
private:
    int length;
    BOOL **cells;
};

#endif /* defined(__Orgo__BoolMatrix__) */
