#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 312210                            
   DATA_DOMAIN      : FAM                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : NULL                              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 147                               
   N_OF_OBSERVATIONS: 32088                             
   MAX_REC_LENGTH   : 350                               
   DATE & TIME      : October 19, 2022 @ 19:18:18
*************************************************************************
;
* Use PSID download containing individual ID, household ID, state (PSID coding)
;

**********************************************************************************************************
*This part of code is copied from PSID-generated do-file
;
infix
      ER30000              1 - 1           ER30001              2 - 5           ER30002              6 - 8     
      V1                   9 - 9           V3                  10 - 13          V93                 14 - 15    
      ER30003             16 - 16          V441                17 - 17          V442                18 - 21    
      V537                22 - 23          ER30020             24 - 27          ER30021             28 - 29    
      ER30022             30 - 30          V1101               31 - 31          V1102               32 - 35    
      V1103               36 - 37          ER30043             38 - 41          ER30044             42 - 43    
      ER30045             44 - 44          V1801               45 - 45          V1802               46 - 49    
      V1803               50 - 51          ER30067             52 - 55          ER30068             56 - 57    
      ER30069             58 - 58          V2401               59 - 59          V2402               60 - 63    
      V2403               64 - 65          ER30091             66 - 69          ER30092             70 - 71    
      ER30093             72 - 72          V3001               73 - 73          V3002               74 - 77    
      V3003               78 - 79          ER30117             80 - 83          ER30118             84 - 85    
      ER30119             86 - 86          V3401               87 - 87          V3402               88 - 91    
      V3403               92 - 93          ER30138             94 - 97          ER30139             98 - 99    
      ER30140            100 - 100         V3801              101 - 101         V3802              102 - 105   
      V3803              106 - 107         ER30160            108 - 111         ER30161            112 - 113   
      ER30162            114 - 114         V4301              115 - 115         V4302              116 - 119   
      V4303              120 - 121         ER30188            122 - 125         ER30189            126 - 127   
      ER30190            128 - 128         V5201              129 - 129         V5202              130 - 133   
      V5203              134 - 135         ER30217            136 - 139         ER30218            140 - 141   
      ER30219            142 - 142         V5701              143 - 143         V5702              144 - 147   
      V5703              148 - 149         ER30246            150 - 153         ER30247            154 - 155   
      ER30248            156 - 156         V6301              157 - 157         V6302              158 - 161   
      V6303              162 - 163         ER30283            164 - 167         ER30284            168 - 169   
      ER30285            170 - 170         V6901              171 - 171         V6902              172 - 175   
      V6903              176 - 177         ER30313            178 - 181         ER30314            182 - 183   
      ER30315            184 - 184         V7501              185 - 185         V7502              186 - 189   
      V7503              190 - 191         ER30343            192 - 195         ER30344            196 - 197   
      ER30345            198 - 198         V8201              199 - 199         V8202              200 - 203   
      V8203              204 - 205         ER30373            206 - 209         ER30374            210 - 211   
      ER30375            212 - 212         V8801              213 - 213         V8802              214 - 217   
      V8803              218 - 219         ER30399            220 - 223         ER30400            224 - 225   
      ER30401            226 - 227         V10001             228 - 228         V10002             229 - 232   
      V10003             233 - 234         ER30429            235 - 238         ER30430            239 - 240   
      ER30431            241 - 242         V11101             243 - 243         V11102             244 - 247   
      V11103             248 - 249         V12380             250 - 251         ER30463            252 - 255   
      ER30464            256 - 257         ER30465            258 - 259         V12501             260 - 260   
      V12502             261 - 264         V12503             265 - 266         V13632             267 - 268   
      ER30498            269 - 272         ER30499            273 - 274         ER30500            275 - 276   
      V13701             277 - 277         V13702             278 - 281         V13703             282 - 283   
      V14679             284 - 285         ER30535            286 - 289         ER30536            290 - 291   
      ER30537            292 - 293         V14801             294 - 294         V14802             295 - 298   
      V14803             299 - 300         V16153             301 - 302         ER30570            303 - 306   
      ER30571            307 - 308         ER30572            309 - 310         V16301             311 - 311   
      V16302             312 - 315         V16303             316 - 317         V17539             318 - 319   
      ER30606            320 - 323         ER30607            324 - 325         ER30608            326 - 327   
      V17701             328 - 328         V17702             329 - 333         V17703             334 - 335   
      V18890             336 - 337         ER30642            338 - 342         ER30643            343 - 344   
      ER30644            345 - 346         V19001             347 - 347         V19002             348 - 351   
      V19003             352 - 353         V20190             354 - 355         ER30689            356 - 359   
      ER30690            360 - 361         ER30691            362 - 363         V20301             364 - 364   
      V20302             365 - 368         V20303             369 - 370         V21496             371 - 372   
      ER30733            373 - 376         ER30734            377 - 378         ER30735            379 - 380   
      V21601             381 - 381         V21602             382 - 386         V21603             387 - 388   
      V23328             389 - 390         ER30806            391 - 395         ER30807            396 - 397   
      ER30808            398 - 399         ER2001             400 - 400         ER2002             401 - 405   
      ER4156             406 - 407         ER4157             408 - 409         ER33101            410 - 414   
      ER33102            415 - 416         ER33103            417 - 418         ER5001             419 - 419   
      ER5002             420 - 424         ER6996             425 - 426         ER6997             427 - 428   
      ER33201            429 - 433         ER33202            434 - 435         ER33203            436 - 437   
      ER7001             438 - 438         ER7002             439 - 442         ER9247             443 - 444   
      ER9248             445 - 446         ER33301            447 - 450         ER33302            451 - 452   
      ER33303            453 - 454         ER10001            455 - 455         ER10002            456 - 460   
      ER10004            461 - 462         ER12221            463 - 464         ER33401            465 - 469   
      ER33402            470 - 471         ER33403            472 - 473         ER13001            474 - 474   
      ER13002            475 - 479         ER13004            480 - 481         ER13005            482 - 483   
      ER33501            484 - 488         ER33502            489 - 490         ER33503            491 - 492   
      ER17001            493 - 493         ER17002            494 - 497         ER17004            498 - 499   
      ER17005            500 - 501         ER33601            502 - 505         ER33602            506 - 507   
      ER33603            508 - 509         ER21001            510 - 510         ER21002            511 - 515   
      ER21003            516 - 517         ER21004            518 - 519         ER33701            520 - 524   
      ER33702            525 - 526         ER33703            527 - 528         ER25001            529 - 529   
      ER25002            530 - 534         ER25003            535 - 536         ER25004            537 - 538   
      ER33801            539 - 543         ER33802            544 - 545         ER33803            546 - 547   
      ER36001            548 - 548         ER36002            549 - 553         ER36003            554 - 555   
      ER36004            556 - 557         ER33901            558 - 562         ER33902            563 - 564   
      ER33903            565 - 566         ER42001            567 - 567         ER42002            568 - 572   
      ER42003            573 - 574         ER42004            575 - 576         ER34001            577 - 581   
      ER34002            582 - 583         ER34003            584 - 585         ER47301            586 - 586   
      ER47302            587 - 591         ER47303            592 - 593         ER47304            594 - 595   
      ER34101            596 - 600         ER34102            601 - 602         ER34103            603 - 604   
      ER53001            605 - 605         ER53002            606 - 610         ER53003            611 - 612   
      ER53004            613 - 614         ER34201            615 - 619         ER34202            620 - 621   
      ER34203            622 - 623         ER60001            624 - 624         ER60002            625 - 629   
      ER60003            630 - 631         ER60004            632 - 633         ER34301            634 - 638   
      ER34302            639 - 640         ER34303            641 - 642         ER66001            643 - 643   
      ER66002            644 - 648         ER66003            649 - 650         ER66004            651 - 652   
      ER34501            653 - 657         ER34502            658 - 659         ER34503            660 - 661   
      ER72001            662 - 662         ER72002            663 - 667         ER72003            668 - 669   
      ER72004            670 - 671         ER34701            672 - 676         ER34702            677 - 678   
      ER34703            679 - 680   
using ~/Downloads/state/J312215.txt, clear ;
*DIRECTORY TO PSID FILE SETTING
;

**********************************************************************************************************
*Rename variables and change to panel format
;

rename ER30001 intnum68;
rename ER30002 pernum;



 rename  V93             state1968;

 rename  V442            intnum1969;
 rename  V537            state1969;

 rename  V1102           intnum1970;
 rename  V1103           state1970;

 rename  V1802           intnum1971;
 rename  V1803           state1971;

 rename  V2402           intnum1972;
 rename  V2403           state1972;

 rename  V3002           intnum1973;
 rename  V3003           state1973;

 rename  V3402           intnum1974;
 rename  V3403             state1974;

 rename  V3802           intnum1975;
 rename  V3803           state1975;

 rename  V4302           intnum1976;
 rename  V4303           state1976;

 rename  V5202           intnum1977;
 rename  V5203             state1977;

 rename  V5702           intnum1978;
 rename  V5703             state1978;

 rename  V6302           intnum1979;
 rename  V6303             state1979;

 rename  V6902           intnum1980;
 rename  V6903             state1980;

 rename  V7502           intnum1981;
 rename  V7503             state1981;

 rename  V8202           intnum1982;
 rename  V8203             state1982;

 rename  V8802           intnum1983;
 rename  V8803             state1983;

 rename  V10002          intnum1984;
 rename  V10003            state1984;

 rename  V11102          intnum1985;
 rename  V11103            state1985;


 rename  V12502          intnum1986;
 rename  V12503            state1986;


 rename  V13702          intnum1987;
 rename  V13703            state1987;

 rename  V14802          intnum1988 ;
 rename  V14803            state1988  ;

 rename  V16302          intnum1989 ;
 rename  V16303            state1989 ;

 rename  V17702          intnum1990;
 rename  V17703            state1990 ;

 rename  V19002          intnum1991  ;
 rename  V19003            state1991 ;

 rename  V20302          intnum1992  ;
 rename  V20303            state1992 ;

 rename  V21602          intnum1993 ;
 rename  V21603            state1993 ;

 rename  ER2002          intnum1994 ;
 rename  ER4156         state1994 ;

 rename  ER5002          intnum1995;
 rename  ER6996         state1995 ;

 rename  ER7002          intnum1996;
 rename  ER9247         state1996 ;

 rename  ER10002         intnum1997 ;
 rename  ER12221         state1997 ;

 rename  ER13002         intnum1999    ;
 rename  ER13004        state1999  ;

 rename  ER17002         intnum2001  ;
 rename  ER17004        state2001   ;

 rename  ER21002         intnum2003 ;
 rename  ER21003        state2003 ;

 rename  ER25002         intnum2005;
 rename  ER25003        state2005;

 rename  ER36002         intnum2007;
 rename  ER36003        state2007;

 rename  ER42002         intnum2009;
 rename  ER42003        state2009;

 rename  ER47302         intnum2011;
 rename  ER47303        state2011;

 rename  ER53002         intnum2013;
 rename  ER53003        state2013;

 rename  ER60002         intnum2015;
 rename  ER60003        state2015;

 rename  ER66002         intnum2017;
 rename  ER66003        state2017;

 rename  ER72002         intnum2019;
 rename  ER72003         state2019;

;


;

generate MID=intnum68*1000+pernum;
keep MID intnum* state*;
reshape long state intnum, i(MID) j(year);

duplicates drop intnum year, force;
keep intnum state year;

export delimited using "~/Dropbox/Data/PSID_MAIN/StateVertical.csv", replace;



