//
//  SWMAtom.h
//  Orgo
//
//  Created by Spencer MacKinnon on 4/28/13.
//  Copyright (c) 2013 Spencer MacKinnon. All rights reserved.
//

typedef enum {
    CARBON,
    HYDROGEN,
    NITROGEN,
    OXYGEN,
    PHOSPHORUS
} SWM_ATOM_NAME;

typedef enum {
    SINGLE,
    DOUBLE,
    TRIPLE,
    RESONANCE
} SWM_BOND_TYPE;

typedef struct  {
    SWM_ATOM_NAME _atomNAME;
} SWM_ATOM;

typedef struct {
    SWM_BOND_TYPE _bondType;
} SWM_BOND;