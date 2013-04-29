//
//  BoolMatrix.cpp
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

#include "BoolMatrix.h"

BoolMatrix(int length)
{
    this.length = length;
    cells = new BOOL [length * length];
    for (int i = 0; i < length * length; i++) {
        cells[i] = NO;
    }
}

~BOOLMatrix()
{
    delete [] cells;
}