%{
#include "y.tab.h"
%}

%%
[0369] {return ZERO;}
[147] {return ONE;}
[258] {return TWO;}
[\n] {return NL;}
. ;
%%
