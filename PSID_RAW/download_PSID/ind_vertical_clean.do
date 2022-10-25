#delimit ;
set more off;
*  PSID DATA CENTER *****************************************************
   JOBID            : 306126                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 165                               
   N_OF_OBSERVATIONS: 82573                             
   MAX_REC_LENGTH   : 371                               
   DATE & TIME      : April 21, 2022 @ 18:25:14
*************************************************************************
;
* Uses individual ID, pernum, mpair, relationship to head, sequence number, family ID

**********************************************************************************************************
*This part of code is copied from PSID-generated do-file
;
infix
      ER30000              1 - 1           ER30001              2 - 5           ER30002              6 - 8     
      ER30003              9 - 9           ER30005             10 - 10          ER30020             11 - 14    
      ER30021             15 - 16          ER30022             17 - 17          ER30024             18 - 18    
      ER30043             19 - 22          ER30044             23 - 24          ER30045             25 - 25    
      ER30047             26 - 26          ER30067             27 - 30          ER30068             31 - 32    
      ER30069             33 - 33          ER30071             34 - 34          ER30091             35 - 38    
      ER30092             39 - 40          ER30093             41 - 41          ER30095             42 - 42    
      ER30117             43 - 46          ER30118             47 - 48          ER30119             49 - 49    
      ER30121             50 - 50          ER30138             51 - 54          ER30139             55 - 56    
      ER30140             57 - 57          ER30142             58 - 58          ER30160             59 - 62    
      ER30161             63 - 64          ER30162             65 - 65          ER30164             66 - 66    
      ER30188             67 - 70          ER30189             71 - 72          ER30190             73 - 73    
      ER30192             74 - 74          ER30217             75 - 78          ER30218             79 - 80    
      ER30219             81 - 81          ER30221             82 - 82          ER30246             83 - 86    
      ER30247             87 - 88          ER30248             89 - 89          ER30250             90 - 90    
      ER30283             91 - 94          ER30284             95 - 96          ER30285             97 - 97    
      ER30287             98 - 98          ER30313             99 - 102         ER30314            103 - 104   
      ER30315            105 - 105         ER30317            106 - 106         ER30343            107 - 110   
      ER30344            111 - 112         ER30345            113 - 113         ER30347            114 - 114   
      ER30373            115 - 118         ER30374            119 - 120         ER30375            121 - 121   
      ER30377            122 - 122         ER30399            123 - 126         ER30400            127 - 128   
      ER30401            129 - 130         ER30405            131 - 131         ER30429            132 - 135   
      ER30430            136 - 137         ER30431            138 - 139         ER30435            140 - 140   
      ER30463            141 - 144         ER30464            145 - 146         ER30465            147 - 148   
      ER30469            149 - 149         ER30498            150 - 153         ER30499            154 - 155   
      ER30500            156 - 157         ER30504            158 - 158         ER30535            159 - 162   
      ER30536            163 - 164         ER30537            165 - 166         ER30541            167 - 167   
      ER30570            168 - 171         ER30571            172 - 173         ER30572            174 - 175   
      ER30576            176 - 176         ER30606            177 - 180         ER30607            181 - 182   
      ER30608            183 - 184         ER30612            185 - 185         ER30642            186 - 190   
      ER30643            191 - 192         ER30644            193 - 194         ER30648            195 - 195   
      ER30689            196 - 199         ER30690            200 - 201         ER30691            202 - 203   
      ER30695            204 - 204         ER30733            205 - 208         ER30734            209 - 210   
      ER30735            211 - 212         ER30739            213 - 213         ER30806            214 - 218   
      ER30807            219 - 220         ER30808            221 - 222         ER30812            223 - 223   
      ER33101            224 - 228         ER33102            229 - 230         ER33103            231 - 232   
      ER33107            233 - 233         ER33201            234 - 238         ER33202            239 - 240   
      ER33203            241 - 242         ER33207            243 - 243         ER33301            244 - 247   
      ER33302            248 - 249         ER33303            250 - 251         ER33307            252 - 252   
      ER33401            253 - 257         ER33402            258 - 259         ER33403            260 - 261   
      ER33407            262 - 262         ER33501            263 - 267         ER33502            268 - 269   
      ER33503            270 - 271         ER33507            272 - 272         ER33601            273 - 276   
      ER33602            277 - 278         ER33603            279 - 280         ER33607            281 - 281   
      ER33701            282 - 286         ER33702            287 - 288         ER33703            289 - 290   
      ER33707            291 - 291         ER33801            292 - 296         ER33802            297 - 298   
      ER33803            299 - 300         ER33807            301 - 301         ER33901            302 - 306   
      ER33902            307 - 308         ER33903            309 - 310         ER33907            311 - 311   
      ER34001            312 - 316         ER34002            317 - 318         ER34003            319 - 320   
      ER34007            321 - 321         ER34101            322 - 326         ER34102            327 - 328   
      ER34103            329 - 330         ER34107            331 - 331         ER34201            332 - 336   
      ER34202            337 - 338         ER34203            339 - 340         ER34207            341 - 341   
      ER34301            342 - 346         ER34302            347 - 348         ER34303            349 - 350   
      ER34308            351 - 351         ER34501            352 - 356         ER34502            357 - 358   
      ER34503            359 - 360         ER34507            361 - 361         ER34701            362 - 366   
      ER34702            367 - 368         ER34703            369 - 370         ER34707            371 - 371   
using "~/Dropbox/CDS/IndFileVertical/J306126.txt", clear ;



*DIRECTORY SETTING
;
label variable ER30000         "RELEASE NUMBER"                           ;
label variable ER30001         "1968 INTERVIEW NUMBER"                    ;
label variable ER30002         "PERSON NUMBER                         68" ;
label variable ER30003         "RELATIONSHIP TO HEAD                  68" ;
label variable ER30005         "MARR PAIRS INDICATOR                  68" ;
label variable ER30020         "1969 INTERVIEW NUMBER"                    ;
label variable ER30021         "SEQUENCE NUMBER                       69" ;
label variable ER30022         "RELATIONSHIP TO HEAD                  69" ;
label variable ER30024         "MARR PAIRS INDICATOR                  69" ;
label variable ER30043         "1970 INTERVIEW NUMBER"                    ;
label variable ER30044         "SEQUENCE NUMBER                       70" ;
label variable ER30045         "RELATIONSHIP TO HEAD                  70" ;
label variable ER30047         "MARR PAIRS INDICATOR                  70" ;
label variable ER30067         "1971 INTERVIEW NUMBER"                    ;
label variable ER30068         "SEQUENCE NUMBER                       71" ;
label variable ER30069         "RELATIONSHIP TO HEAD                  71" ;
label variable ER30071         "MARR PAIRS INDICATOR                  71" ;
label variable ER30091         "1972 INTERVIEW NUMBER"                    ;
label variable ER30092         "SEQUENCE NUMBER                       72" ;
label variable ER30093         "RELATIONSHIP TO HEAD                  72" ;
label variable ER30095         "MARR PAIRS INDICATOR                  72" ;
label variable ER30117         "1973 INTERVIEW NUMBER"                    ;
label variable ER30118         "SEQUENCE NUMBER                       73" ;
label variable ER30119         "RELATIONSHIP TO HEAD                  73" ;
label variable ER30121         "MARR PAIRS INDICATOR                  73" ;
label variable ER30138         "1974 INTERVIEW NUMBER"                    ;
label variable ER30139         "SEQUENCE NUMBER                       74" ;
label variable ER30140         "RELATIONSHIP TO HEAD                  74" ;
label variable ER30142         "MARR PAIRS INDICATOR                  74" ;
label variable ER30160         "1975 INTERVIEW NUMBER"                    ;
label variable ER30161         "SEQUENCE NUMBER                       75" ;
label variable ER30162         "RELATIONSHIP TO HEAD                  75" ;
label variable ER30164         "MARR PAIRS INDICATOR                  75" ;
label variable ER30188         "1976 INTERVIEW NUMBER"                    ;
label variable ER30189         "SEQUENCE NUMBER                       76" ;
label variable ER30190         "RELATIONSHIP TO HEAD                  76" ;
label variable ER30192         "MARR PAIRS INDICATOR                  76" ;
label variable ER30217         "1977 INTERVIEW NUMBER"                    ;
label variable ER30218         "SEQUENCE NUMBER                       77" ;
label variable ER30219         "RELATIONSHIP TO HEAD                  77" ;
label variable ER30221         "MARR PAIRS INDICATOR                  77" ;
label variable ER30246         "1978 INTERVIEW NUMBER"                    ;
label variable ER30247         "SEQUENCE NUMBER                       78" ;
label variable ER30248         "RELATIONSHIP TO HEAD                  78" ;
label variable ER30250         "MARR PAIRS INDICATOR                  78" ;
label variable ER30283         "1979 INTERVIEW NUMBER"                    ;
label variable ER30284         "SEQUENCE NUMBER                       79" ;
label variable ER30285         "RELATIONSHIP TO HEAD                  79" ;
label variable ER30287         "MARR PAIRS INDICATOR                  79" ;
label variable ER30313         "1980 INTERVIEW NUMBER"                    ;
label variable ER30314         "SEQUENCE NUMBER                       80" ;
label variable ER30315         "RELATIONSHIP TO HEAD                  80" ;
label variable ER30317         "MARR PAIRS INDICATOR                  80" ;
label variable ER30343         "1981 INTERVIEW NUMBER"                    ;
label variable ER30344         "SEQUENCE NUMBER                       81" ;
label variable ER30345         "RELATIONSHIP TO HEAD                  81" ;
label variable ER30347         "MARR PAIRS INDICATOR                  81" ;
label variable ER30373         "1982 INTERVIEW NUMBER"                    ;
label variable ER30374         "SEQUENCE NUMBER                       82" ;
label variable ER30375         "RELATIONSHIP TO HEAD                  82" ;
label variable ER30377         "MARR PAIRS INDICATOR                  82" ;
label variable ER30399         "1983 INTERVIEW NUMBER"                    ;
label variable ER30400         "SEQUENCE NUMBER                       83" ;
label variable ER30401         "RELATIONSHIP TO HEAD                  83" ;
label variable ER30405         "MARR PAIRS INDICATOR                  83" ;
label variable ER30429         "1984 INTERVIEW NUMBER"                    ;
label variable ER30430         "SEQUENCE NUMBER                       84" ;
label variable ER30431         "RELATIONSHIP TO HEAD                  84" ;
label variable ER30435         "MARR PAIRS INDICATOR                  84" ;
label variable ER30463         "1985 INTERVIEW NUMBER"                    ;
label variable ER30464         "SEQUENCE NUMBER                       85" ;
label variable ER30465         "RELATIONSHIP TO HEAD                  85" ;
label variable ER30469         "MARR PAIRS INDICATOR                  85" ;
label variable ER30498         "1986 INTERVIEW NUMBER"                    ;
label variable ER30499         "SEQUENCE NUMBER                       86" ;
label variable ER30500         "RELATIONSHIP TO HEAD                  86" ;
label variable ER30504         "MARR PAIRS INDICATOR                  86" ;
label variable ER30535         "1987 INTERVIEW NUMBER"                    ;
label variable ER30536         "SEQUENCE NUMBER                       87" ;
label variable ER30537         "RELATIONSHIP TO HEAD                  87" ;
label variable ER30541         "MARR PAIRS INDICATOR                  87" ;
label variable ER30570         "1988 INTERVIEW NUMBER"                    ;
label variable ER30571         "SEQUENCE NUMBER                       88" ;
label variable ER30572         "RELATION TO HEAD                      88" ;
label variable ER30576         "MARITAL INDICATOR-IND                 88" ;
label variable ER30606         "1989 INTERVIEW NUMBER"                    ;
label variable ER30607         "SEQUENCE NUMBER                       89" ;
label variable ER30608         "RELATION TO HEAD                      89" ;
label variable ER30612         "MARITAL INDICATOR-IND                 89" ;
label variable ER30642         "1990 INTERVIEW NUMBER"                    ;
label variable ER30643         "SEQUENCE NUMBER                       90" ;
label variable ER30644         "RELATION TO HEAD                      90" ;
label variable ER30648         "MARITAL INDICATOR-IND                 90" ;
label variable ER30689         "1991 INTERVIEW NUMBER"                    ;
label variable ER30690         "SEQUENCE NUMBER                       91" ;
label variable ER30691         "RELATION TO HEAD                      91" ;
label variable ER30695         "MARITAL INDICATOR-IND                 91" ;
label variable ER30733         "1992 INTERVIEW NUMBER"                    ;
label variable ER30734         "SEQUENCE NUMBER                       92" ;
label variable ER30735         "RELATION TO HEAD                      92" ;
label variable ER30739         "MARR PAIRS INDICATOR                  92" ;
label variable ER30806         "1993 INTERVIEW NUMBER"                    ;
label variable ER30807         "SEQUENCE NUMBER                       93" ;
label variable ER30808         "RELATION TO HEAD                      93" ;
label variable ER30812         "MARITAL PAIRS INDICATOR               93" ;
label variable ER33101         "1994 INTERVIEW NUMBER"                    ;
label variable ER33102         "SEQUENCE NUMBER                       94" ;
label variable ER33103         "RELATION TO HEAD                      94" ;
label variable ER33107         "MARITAL PAIRS INDICAT                 94" ;
label variable ER33201         "1995 INTERVIEW NUMBER"                    ;
label variable ER33202         "SEQUENCE NUMBER                       95" ;
label variable ER33203         "RELATION TO HEAD                      95" ;
label variable ER33207         "MARITAL PAIRS INDICATOR               95" ;
label variable ER33301         "1996 INTERVIEW NUMBER"                    ;
label variable ER33302         "SEQUENCE NUMBER                       96" ;
label variable ER33303         "RELATION TO HEAD                      96" ;
label variable ER33307         "MARITAL PAIRS INDICATOR               96" ;
label variable ER33401         "1997 INTERVIEW NUMBER"                    ;
label variable ER33402         "SEQUENCE NUMBER                       97" ;
label variable ER33403         "RELATION TO HEAD                      97" ;
label variable ER33407         "MARITAL PAIRS INDICATOR               97" ;
label variable ER33501         "1999 INTERVIEW NUMBER"                    ;
label variable ER33502         "SEQUENCE NUMBER                       99" ;
label variable ER33503         "RELATION TO HEAD                      99" ;
label variable ER33507         "MARITAL PAIRS INDICATOR               99" ;
label variable ER33601         "2001 INTERVIEW NUMBER"                    ;
label variable ER33602         "SEQUENCE NUMBER                       01" ;
label variable ER33603         "RELATION TO HEAD                      01" ;
label variable ER33607         "MARITAL PAIRS INDICATOR               01" ;
label variable ER33701         "2003 INTERVIEW NUMBER"                    ;
label variable ER33702         "SEQUENCE NUMBER                       03" ;
label variable ER33703         "RELATION TO HEAD                      03" ;
label variable ER33707         "MARITAL PAIRS INDICATOR               03" ;
label variable ER33801         "2005 INTERVIEW NUMBER"                    ;
label variable ER33802         "SEQUENCE NUMBER                       05" ;
label variable ER33803         "RELATION TO HEAD                      05" ;
label variable ER33807         "MARITAL PAIRS INDICATOR               05" ;
label variable ER33901         "2007 INTERVIEW NUMBER"                    ;
label variable ER33902         "SEQUENCE NUMBER                       07" ;
label variable ER33903         "RELATION TO HEAD                      07" ;
label variable ER33907         "MARITAL PAIRS INDICATOR               07" ;
label variable ER34001         "2009 INTERVIEW NUMBER"                    ;
label variable ER34002         "SEQUENCE NUMBER                       09" ;
label variable ER34003         "RELATION TO HEAD                      09" ;
label variable ER34007         "MARITAL PAIRS INDICATOR               09" ;
label variable ER34101         "2011 INTERVIEW NUMBER"                    ;
label variable ER34102         "SEQUENCE NUMBER                       11" ;
label variable ER34103         "RELATION TO HEAD                      11" ;
label variable ER34107         "MARITAL PAIRS INDICATOR               11" ;
label variable ER34201         "2013 INTERVIEW NUMBER"                    ;
label variable ER34202         "SEQUENCE NUMBER                       13" ;
label variable ER34203         "RELATION TO HEAD                      13" ;
label variable ER34207         "MARITAL PAIRS INDICATOR               13" ;
label variable ER34301         "2015 INTERVIEW NUMBER"                    ;
label variable ER34302         "SEQUENCE NUMBER                       15" ;
label variable ER34303         "RELATION TO HEAD                      15" ;
label variable ER34308         "MARITAL PAIRS INDICATOR               15" ;
label variable ER34501         "2017 INTERVIEW NUMBER"                    ;
label variable ER34502         "SEQUENCE NUMBER                       17" ;
label variable ER34503         "RELATION TO REFERENCE PERSON          17" ;
label variable ER34507         "MARITAL PAIRS INDICATOR               17" ;
label variable ER34701         "2019 INTERVIEW NUMBER"                    ;
label variable ER34702         "SEQUENCE NUMBER                       19" ;
label variable ER34703         "RELATION TO REFERENCE PERSON          19" ;
label variable ER34707         "MARITAL PAIRS INDICATOR               19" ;

**********************************************************************************************************

*Rename variables and switch to panel format
;

rename ER30001 intnum68;
rename ER30002 pernum68;
rename ER30003 rhead68;
rename ER30005 mpair68;

rename ER30463 intnum85;
rename ER30464 sn85;
rename ER30465 rhead85;
rename ER30469 mpair85;
rename ER30498 intnum86;
rename ER30499 sn86;
rename ER30500 rhead86;
rename ER30504 mpair86;
rename ER30535 intnum87;
rename ER30536 sn87;
rename ER30537 rhead87;
rename ER30541 mpair87;
rename ER30570 intnum88;
rename ER30571 sn88;
rename ER30572 rhead88;
rename ER30576 mpair88;
rename ER30606 intnum89;
rename ER30607 sn89;
rename ER30608 rhead89;
rename ER30612 mpair89;
rename ER30642 intnum90;
rename ER30643 sn90;
rename ER30644 rhead90;
rename ER30648 mpair90;
rename ER30689 intnum91;
rename ER30690 sn91;
rename ER30691 rhead91;
rename ER30695 mpair91;
rename ER30733 intnum92;
rename ER30734 sn92;
rename ER30735 rhead92;
rename ER30739 mpair92;
rename ER30806 intnum93;
rename ER30807 sn93;
rename ER30808 rhead93;
rename ER30812 mpair93;
rename ER33101 intnum94;
rename ER33102 sn94;
rename ER33103 rhead94;
rename ER33107 mpair94;
rename ER33201 intnum95;
rename ER33202 sn95;
rename ER33203 rhead95;
rename ER33207 mpair95;
rename ER33301 intnum96;
rename ER33302 sn96;
rename ER33303 rhead96;
rename ER33307 mpair96;
rename ER33401 intnum97;
rename ER33402 sn97;
rename ER33403 rhead97;
rename ER33407 mpair97;
rename ER33501 intnum99;
rename ER33502 sn99;
rename ER33503 rhead99;
rename ER33507 mpair99;
rename ER33601 intnum1;
rename ER33602 sn1;
rename ER33603 rhead1;
rename ER33607 mpair1;
rename ER33701 intnum3;
rename ER33702 sn3;
rename ER33703 rhead3;
rename ER33707 mpair3;
rename ER33801 intnum5;
rename ER33802 sn5;
rename ER33803 rhead5;
rename ER33807 mpair5;
rename ER33901 intnum7;
rename ER33902 sn7;
rename ER33903 rhead7;
rename ER33907 mpair7;
rename ER34001 intnum9;
rename ER34002 sn9;
rename ER34003 rhead9;
rename ER34007 mpair9;
rename ER34101 intnum11;
rename ER34102 sn11;
rename ER34103 rhead11;
rename ER34107 mpair11;
rename ER34201 intnum13;
rename ER34202 sn13;
rename ER34203 rhead13;
rename ER34207 mpair13;
rename ER34301 intnum15;
rename ER34302 sn15;
rename ER34303 rhead15;
rename ER34308 mpair15;
rename ER34501 intnum17;
rename ER34502 sn17;
rename ER34503 rhead17;
rename ER34507 mpair17;
rename ER34701 intnum19;
rename ER34702 sn19;
rename ER34703 rhead19;
rename ER34707 mpair19;

reshape long  mpair intnum rhead sn , i( intnum68 pernum68) j(year);

replace year =2000+year if year<60;
replace year =1900+year if year>60&year<=99;

keep intnum68 pernum68 mpair sn year intnum;
rename pernum68 pernum;
export delimited using "~/Dropbox/Data/PSID_MAIN/ind2011er/IndFileVertical.csv", replace;
