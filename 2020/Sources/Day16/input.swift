let sampleInput = """
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
"""

let sampleInput2 = """
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
"""

let input = """
departure location: 43-237 or 251-961
departure station: 27-579 or 586-953
departure platform: 31-587 or 608-967
departure track: 26-773 or 784-973
departure date: 41-532 or 552-956
departure time: 33-322 or 333-972
arrival location: 30-165 or 178-965
arrival station: 31-565 or 571-968
arrival platform: 36-453 or 473-963
arrival track: 35-912 or 924-951
class: 39-376 or 396-968
duration: 31-686 or 697-974
price: 28-78 or 96-971
route: 32-929 or 943-955
row: 40-885 or 896-968
seat: 26-744 or 765-967
train: 46-721 or 741-969
type: 30-626 or 641-965
wagon: 48-488 or 513-971
zone: 34-354 or 361-973

your ticket:
151,71,67,113,127,163,131,59,137,103,73,139,107,101,97,149,157,53,109,61

nearby tickets:
680,418,202,55,792,800,896,801,312,252,721,702,24,112,608,837,98,222,797,364
876,910,289,816,873,280,791,313,641,15,719,587,353,366,617,710,565,419,339,621
869,683,645,185,121,51,670,401,308,213,54,150,813,264,330,50,444,825,837,368
244,131,561,851,165,270,78,573,818,869,946,370,527,866,655,816,146,792,431,431
626,744,334,482,185,797,770,723,532,475,441,62,837,657,412,106,404,433,577,439
610,514,611,681,156,854,838,126,524,710,518,193,744,857,258,642,12,273,192,221
215,408,404,344,319,720,403,434,885,248,707,195,672,312,809,855,118,529,673,439
103,402,226,678,711,212,843,806,358,436,342,257,98,401,527,831,524,401,275,709
429,906,336,77,146,122,179,295,251,529,487,858,901,71,417,477,458,474,154,786
903,313,919,564,904,853,673,373,209,408,825,516,441,818,474,773,556,848,151,229
96,861,791,620,929,256,587,211,250,684,420,258,365,96,104,653,368,528,784,817
898,866,669,867,901,618,575,210,498,265,413,556,190,376,624,818,295,294,431,649
50,346,807,717,850,820,791,561,486,752,414,669,927,72,205,117,137,564,744,799
600,109,553,712,141,649,929,799,204,788,310,71,926,197,348,293,103,667,67,907
369,60,369,443,209,220,453,853,525,231,155,412,4,161,576,852,856,898,119,829
420,272,878,835,449,359,678,236,664,579,158,908,264,620,286,699,838,354,519,906
331,716,527,851,431,297,57,70,109,102,195,346,901,372,818,210,223,554,800,50
912,715,194,876,927,96,827,943,445,438,79,799,885,563,904,142,254,519,883,815
858,554,559,194,840,867,434,825,946,443,663,654,258,924,617,412,916,263,269,619
412,808,836,128,67,928,985,742,827,199,800,924,277,281,52,769,707,784,518,345
398,408,187,164,438,720,813,366,345,449,979,266,902,376,905,259,428,74,53,56
308,520,425,339,430,279,847,417,308,118,772,1,659,302,305,612,522,623,209,52
680,205,199,842,309,563,520,340,609,787,118,140,827,418,149,485,795,22,531,225
521,862,352,410,674,317,59,222,529,586,838,979,876,96,946,810,792,436,224,811
112,306,194,802,319,339,659,137,312,234,294,701,288,130,847,397,22,715,576,70
225,68,221,56,844,179,854,181,310,620,71,208,850,585,417,254,876,830,908,98
435,929,398,830,283,925,749,178,204,58,650,144,707,876,352,372,126,370,803,844
182,842,804,858,354,823,684,22,76,617,396,73,835,521,149,203,851,853,215,716
233,178,770,847,440,336,520,816,873,818,588,835,251,882,698,397,310,270,133,872
509,221,402,766,801,837,485,900,672,652,647,311,292,773,856,430,185,183,407,927
124,870,133,420,865,338,196,318,119,742,430,102,555,915,815,154,835,807,180,803
368,259,784,111,226,117,835,150,354,69,340,676,767,141,537,445,134,164,571,790
879,616,419,449,261,78,522,265,348,832,393,264,704,806,902,838,811,651,680,125
406,396,161,517,900,261,803,63,339,60,906,62,842,785,121,861,262,867,700,242
898,641,654,560,859,231,397,252,477,157,681,186,477,194,420,282,153,914,611,866
813,20,771,655,408,864,851,260,874,949,431,901,143,251,879,449,718,515,435,852
710,56,218,785,211,713,711,438,626,64,583,215,741,165,315,911,191,297,333,686
431,218,299,274,773,201,405,907,673,287,930,911,315,103,481,488,677,808,276,193
662,907,796,401,409,812,182,485,854,477,702,831,262,855,999,527,212,318,854,681
213,653,734,363,615,453,218,906,405,770,199,191,221,681,767,272,210,682,200,179
375,832,786,316,452,809,908,218,488,875,190,712,482,678,66,726,424,948,75,363
575,831,402,860,333,315,524,587,402,531,714,520,57,568,430,103,828,800,313,179
810,101,209,741,837,818,56,915,292,947,943,318,165,701,788,851,366,55,622,418
914,834,72,372,879,352,142,708,834,667,191,609,117,162,268,481,576,836,346,188
667,620,767,269,311,884,275,332,56,155,901,797,798,642,907,482,61,612,366,906
853,944,802,987,337,136,664,795,562,56,587,475,349,407,785,833,272,197,658,76
181,180,56,265,561,333,235,161,361,704,612,623,703,748,525,702,622,564,855,109
865,160,289,530,805,821,515,799,265,224,262,677,904,858,811,22,217,699,614,804
787,299,882,294,989,444,284,401,717,102,398,432,433,285,342,488,699,741,662,845
274,556,342,270,616,114,214,586,62,435,552,718,813,194,721,686,15,912,821,310
833,97,123,151,203,234,436,264,125,329,787,481,342,435,622,855,833,312,798,714
219,475,819,115,265,269,431,138,452,149,625,433,300,553,105,218,907,347,856,596
429,658,114,274,789,849,212,7,304,281,744,60,614,906,366,189,653,448,164,291
58,766,409,707,659,68,182,861,597,370,671,407,57,615,787,642,128,376,555,290
662,432,146,300,228,561,819,539,677,369,348,680,363,208,720,587,336,157,841,397
870,150,556,206,442,199,980,299,527,449,437,216,52,577,210,181,119,844,113,800
293,299,816,96,949,215,724,333,165,896,298,649,564,552,190,860,836,312,829,474
104,226,201,482,713,681,141,925,741,201,450,274,718,877,915,56,230,786,787,475
134,134,477,369,354,665,164,258,949,111,523,869,481,636,928,209,851,430,527,702
826,73,74,732,74,863,488,237,96,683,334,212,873,873,670,624,879,845,301,354
784,228,566,101,899,474,400,232,795,676,216,837,452,744,340,876,361,706,60,805
650,872,275,642,371,676,841,683,619,620,625,683,123,767,202,441,274,416,445,940
279,136,878,619,838,416,319,102,420,253,112,142,223,336,927,403,945,443,624,358
271,622,97,865,517,202,908,178,570,448,52,284,649,260,270,427,372,62,798,769
356,69,74,480,59,884,744,523,555,720,574,483,131,211,409,194,401,153,682,767
929,184,710,772,909,818,267,677,513,222,513,563,72,530,371,4,810,403,68,264
789,446,418,843,184,657,325,903,553,117,857,118,290,773,320,516,828,251,905,122
420,832,526,401,204,483,300,422,837,550,361,452,855,259,717,149,896,335,259,618
412,178,129,624,60,929,310,530,295,354,275,353,114,927,254,4,160,451,668,835
226,831,110,76,573,201,655,609,21,656,64,614,154,273,898,315,618,183,513,315
161,842,295,823,835,207,99,147,528,98,830,928,410,368,269,360,818,210,844,299
59,900,515,246,487,844,703,122,909,821,190,275,271,653,577,144,165,345,131,144
864,437,115,567,120,671,99,51,875,875,404,552,817,613,857,572,650,50,270,183
526,233,771,563,802,766,220,553,684,60,344,814,560,826,148,570,400,52,422,187
338,948,443,144,705,126,874,438,412,478,636,73,102,698,412,820,218,681,345,311
448,336,136,785,298,153,99,113,365,311,881,861,278,190,314,811,213,726,854,478
341,402,719,812,647,679,610,446,164,858,370,436,608,219,263,7,74,719,134,575
108,815,307,658,845,144,855,308,20,708,336,785,815,433,220,434,704,884,236,123
283,416,97,846,163,769,339,164,54,77,820,768,75,219,148,859,770,943,731,107
477,879,632,682,376,703,307,427,269,71,766,480,945,403,53,255,907,264,119,449
932,375,479,905,155,672,182,848,477,479,484,236,375,338,150,709,698,375,186,794
849,141,709,158,161,342,564,847,262,623,665,147,213,198,759,621,744,823,853,709
727,788,294,826,182,189,421,793,642,345,235,292,137,703,901,425,309,334,834,410
157,122,524,524,673,656,858,129,668,308,421,854,848,806,477,616,556,359,844,478
798,672,806,530,408,793,281,901,300,812,432,573,138,20,98,346,133,274,408,794
124,209,55,561,260,620,617,777,668,124,414,658,659,348,877,842,75,197,430,863
211,922,946,486,292,879,678,162,267,403,156,744,766,430,310,849,303,479,709,865
316,368,668,254,514,209,443,150,128,421,183,479,62,909,730,126,372,289,130,608
197,237,824,844,514,428,828,221,206,578,311,434,702,279,153,338,854,113,879,751
794,766,838,417,198,148,558,532,302,664,519,483,828,294,578,931,426,121,528,165
676,664,712,257,743,670,703,264,115,842,857,163,611,798,221,408,573,525,462,909
644,708,620,878,843,280,841,847,839,824,376,609,556,811,316,548,486,414,898,657
530,253,787,302,516,202,117,259,69,618,450,233,944,900,528,453,723,697,432,641
519,413,683,475,708,345,612,572,269,57,685,199,666,320,147,770,263,186,357,133
186,441,66,283,227,344,349,874,855,137,210,224,422,77,939,705,403,904,790,524
152,303,611,665,103,614,181,827,867,131,488,866,770,514,340,372,882,288,835,776
181,743,361,201,513,107,427,181,573,568,427,288,827,477,418,809,148,374,429,430
72,737,201,333,865,846,405,284,526,448,791,142,448,59,624,705,646,484,713,403
290,121,812,103,232,708,374,473,60,640,322,415,669,712,58,304,117,702,363,849
656,336,613,838,404,820,944,232,315,643,557,625,54,623,415,897,426,868,916,126
133,110,102,949,561,146,937,481,678,884,187,769,198,741,906,204,680,899,801,482
397,707,194,998,226,789,612,255,375,882,354,399,478,765,125,840,679,825,587,316
218,839,664,903,900,863,354,800,529,931,319,183,202,836,773,56,432,516,587,644
398,578,100,532,56,446,704,297,182,134,853,160,319,161,634,881,657,669,619,876
321,227,434,711,420,115,847,608,868,848,478,853,487,550,576,519,586,320,104,270
436,530,862,518,826,301,609,804,401,106,532,104,210,255,812,229,237,648,569,743
217,472,946,912,293,869,65,788,661,898,823,673,654,486,162,231,815,310,513,841
298,426,880,336,586,405,314,866,677,653,460,233,78,135,425,710,269,179,427,344
874,404,98,564,435,665,720,103,945,870,990,741,125,265,553,197,773,571,165,846
659,808,652,697,134,641,340,192,450,580,837,575,643,115,876,710,165,863,339,820
610,713,107,195,553,72,465,407,410,296,257,868,275,213,643,445,435,785,345,159
475,418,927,316,430,842,874,764,63,861,337,412,823,213,587,154,350,216,139,417
532,479,525,407,624,117,699,334,272,183,348,162,191,742,303,152,96,288,810,545
150,152,156,743,451,699,587,290,182,361,263,308,348,455,682,160,803,97,225,868
229,764,307,792,883,905,698,716,65,872,621,317,701,851,904,401,184,826,530,824
447,822,133,345,644,299,819,269,806,181,244,613,813,579,704,152,161,806,844,312
622,312,742,222,875,835,520,883,920,899,702,793,716,519,652,449,803,621,369,337
235,614,850,211,416,217,103,744,825,185,886,808,553,252,770,116,252,220,429,787
944,869,293,576,825,58,22,859,162,266,342,562,525,74,902,527,153,475,361,926
654,826,576,292,468,872,222,286,196,220,252,349,99,766,54,720,903,124,618,480
219,76,254,642,127,292,56,475,934,928,181,162,427,451,348,60,815,152,697,925
428,885,473,878,625,299,824,835,787,115,57,927,461,180,236,865,653,225,704,364
399,322,987,482,316,825,113,473,875,885,642,441,869,149,565,719,929,912,440,860
421,58,122,522,520,435,344,614,68,2,154,861,406,127,682,684,261,400,348,800
111,798,528,439,560,683,203,704,644,290,909,645,668,443,128,528,313,641,932,519
106,113,437,863,925,674,477,857,423,945,528,345,162,312,676,469,273,906,478,514
446,360,787,364,51,252,104,406,577,529,373,852,436,801,189,297,662,811,124,226
187,185,872,680,420,368,810,608,100,906,787,565,684,936,484,320,611,665,117,794
891,617,124,145,819,475,410,409,819,310,612,798,336,702,859,901,864,336,66,903
270,103,307,665,643,348,154,823,816,108,193,145,715,274,576,320,762,113,303,134
476,717,419,62,73,851,658,369,230,871,254,882,667,884,513,665,402,213,189,923
72,211,288,579,871,465,62,558,674,809,106,519,199,320,147,278,217,108,808,99
863,265,214,53,710,50,859,677,697,277,782,435,686,257,337,661,845,274,906,309
806,56,911,936,74,76,185,112,874,335,710,766,397,768,75,376,76,513,833,51
311,626,356,140,654,522,823,61,668,398,523,370,279,65,132,897,859,697,148,809
305,149,664,340,909,858,291,448,273,469,808,341,267,707,877,406,648,523,649,436
429,62,300,616,884,515,292,448,406,361,872,204,641,250,403,424,435,284,858,228
156,297,209,830,125,129,206,150,134,443,509,429,896,404,882,613,770,155,418,122
868,336,877,702,117,917,114,563,298,318,812,259,721,451,416,574,285,527,418,520
717,443,59,528,272,902,126,646,806,698,662,123,305,671,147,224,52,181,785,580
407,236,621,443,198,230,355,295,578,586,864,562,527,335,840,451,900,838,657,531
659,147,608,768,372,865,78,618,868,835,915,374,785,371,296,101,224,293,97,312
949,318,301,873,407,125,864,356,279,660,292,71,715,902,255,854,876,354,901,209
708,107,773,829,228,765,179,676,685,359,409,473,101,217,288,842,576,266,575,233
822,660,911,870,442,108,558,511,76,375,713,159,666,283,271,851,619,683,110,474
312,524,711,340,704,620,789,409,403,146,736,905,282,577,320,475,340,440,650,309
534,871,709,148,274,903,476,230,786,556,157,101,798,288,51,744,362,362,415,524
673,423,146,771,844,911,568,833,189,397,207,63,769,835,852,220,216,220,307,860
401,871,484,143,713,812,349,716,431,219,765,338,525,826,792,104,451,78,757,649
280,101,563,356,128,532,789,666,515,529,766,374,183,224,721,902,794,857,262,787
133,617,573,140,103,50,847,227,910,990,681,233,559,441,641,905,799,150,909,867
168,200,839,361,202,146,680,257,475,552,927,307,515,203,832,74,216,552,192,343
478,622,664,671,338,697,473,232,222,372,876,99,868,360,625,831,428,420,280,340
55,907,345,864,433,430,155,312,864,397,411,426,52,261,487,673,561,477,138,568
855,366,57,473,102,300,451,265,880,905,173,300,341,480,352,947,911,139,617,879
309,433,651,526,411,702,73,701,300,313,402,307,481,796,578,309,113,299,624,469
802,310,461,138,862,337,370,117,857,422,823,346,100,609,617,529,705,151,198,668
881,484,521,520,623,112,254,883,754,517,608,927,804,299,73,368,316,700,160,879
949,810,744,335,414,683,52,891,179,307,680,806,674,255,662,122,768,661,899,487
135,623,482,52,335,486,116,592,833,901,444,140,310,108,256,102,848,148,474,451
796,194,433,545,477,710,108,139,426,712,713,222,398,808,54,281,675,306,911,140
834,769,761,203,62,870,212,104,398,771,150,397,817,870,418,270,618,698,525,373
339,814,257,721,335,786,348,61,879,363,263,289,515,840,288,865,282,770,97,630
333,234,118,259,267,120,443,134,664,222,62,12,199,436,877,624,300,294,943,804
277,308,809,363,303,119,919,354,139,858,425,669,119,70,403,182,678,410,72,196
519,195,252,179,656,182,398,262,679,565,3,522,272,903,928,525,116,614,255,56
859,67,102,75,51,852,68,526,889,877,202,876,340,57,414,844,372,666,878,281
193,697,835,116,312,626,660,333,72,312,56,642,259,196,73,163,77,529,630,218
828,948,404,78,127,422,435,408,846,767,787,145,453,331,214,641,528,872,522,661
77,414,578,468,285,269,255,291,867,424,660,704,655,232,187,675,670,253,575,56
520,528,564,58,14,222,280,288,650,256,698,613,138,713,363,59,354,853,526,336
290,902,236,483,52,158,636,796,571,948,700,924,223,55,421,217,296,308,343,318
809,905,373,340,530,646,344,71,67,517,357,430,341,337,796,98,115,366,817,523
215,806,313,293,357,348,76,334,345,878,562,827,908,573,788,289,236,53,433,207
776,608,561,428,827,319,621,553,199,284,412,658,335,440,571,147,302,621,54,884
53,710,578,642,624,579,321,474,436,211,304,57,850,267,472,227,785,795,876,574
151,556,909,619,320,847,451,624,978,529,370,315,254,195,137,907,420,428,948,819
411,706,399,183,411,262,53,721,271,443,678,677,872,251,221,58,311,664,320,722
134,119,187,527,69,517,201,371,346,832,664,208,151,884,358,307,668,651,114,296
577,567,449,401,879,372,523,710,863,310,802,182,708,527,518,701,421,821,162,440
587,824,442,426,791,553,677,682,265,805,865,718,837,811,569,253,179,398,900,720
681,844,482,885,352,262,713,578,627,841,473,794,108,154,215,409,446,96,835,479
752,477,196,792,302,429,441,906,62,299,419,232,829,703,396,278,791,670,396,289
614,51,252,701,118,178,56,163,432,920,237,374,518,268,791,259,344,237,255,518
585,481,949,572,904,833,153,337,75,944,476,70,850,898,699,624,838,61,403,118
314,882,524,926,148,127,265,293,556,781,660,484,420,668,311,473,124,255,652,160
445,5,260,142,557,258,263,100,110,284,715,878,443,555,853,423,608,398,117,200
877,806,946,868,208,529,487,230,125,253,127,814,367,740,408,449,814,182,790,841
819,925,211,815,192,685,136,706,558,141,148,903,178,3,68,615,362,61,625,707
185,69,518,336,304,716,449,165,80,116,318,805,103,282,70,372,699,114,113,672
851,704,309,678,98,563,807,57,133,134,828,138,282,62,348,763,861,340,561,283
862,883,123,867,616,192,772,932,72,207,276,527,621,258,337,515,947,667,339,432
901,868,825,614,106,865,479,227,433,269,198,375,861,182,51,247,473,697,526,532
285,705,266,479,646,296,287,633,302,710,153,408,165,158,576,54,75,191,515,351
849,685,101,180,75,786,55,156,370,151,347,702,903,55,843,583,554,217,298,433
344,586,262,228,766,709,348,643,699,518,443,626,417,614,837,23,114,203,787,488
57,259,788,341,230,273,197,581,608,134,514,528,107,102,214,347,621,680,609,446
103,284,195,634,855,113,652,315,279,98,101,50,312,642,125,525,447,319,681,293
847,445,531,292,347,60,677,159,196,839,746,56,220,441,851,158,573,280,652,908
404,205,271,50,532,801,879,246,218,119,906,827,253,475,516,114,828,843,422,133
279,876,997,859,124,52,673,831,345,483,579,478,306,869,790,707,104,849,97,877
518,623,801,923,204,698,850,333,532,287,414,126,821,196,298,785,765,949,204,525
943,875,711,365,559,75,448,814,813,420,681,841,669,781,521,294,611,793,908,199
564,75,442,146,10,646,322,881,897,707,120,808,147,474,795,701,50,647,367,578
162,76,846,72,203,287,209,205,782,441,135,296,285,574,66,105,528,744,198,202
657,558,230,159,118,800,647,295,836,908,144,280,232,13,440,72,868,855,205,365
334,773,656,648,806,808,649,287,133,432,332,797,717,282,220,822,798,104,641,475
150,287,401,157,146,788,376,648,339,261,527,212,668,660,267,877,356,352,195,819
809,112,104,289,829,109,843,352,283,506,96,679,424,677,713,852,514,678,52,708
929,645,186,104,805,414,908,646,584,647,224,438,303,143,664,619,812,705,284,519
630,350,191,341,350,108,767,208,399,685,185,480,268,791,654,649,219,909,795,268
871,812,400,748,205,515,209,849,707,836,838,318,207,206,71,435,648,647,474,557
118,865,294,189,948,284,479,429,542,110,612,837,190,54,706,145,433,609,256,678
184,836,486,441,137,867,658,710,768,373,786,662,903,370,154,300,120,742,296,983
288,482,319,371,829,291,283,826,118,477,216,928,226,652,829,291,796,574,134,332
265,279,445,165,704,525,349,64,207,125,548,437,273,257,773,226,224,770,714,162
697,815,292,708,13,558,418,437,262,139,288,710,796,561,99,199,711,373,808,669
909,662,834,530,644,436,181,297,128,600,288,322,614,478,300,367,303,810,119,313
703,925,810,100,788,316,946,97,652,231,570,152,101,163,274,486,414,656,677,793
885,346,322,679,256,853,929,803,154,179,163,369,641,898,611,7,805,130,129,424
568,669,424,924,947,157,792,682,413,819,449,129,530,284,320,50,280,574,72,438
107,834,68,576,304,284,224,996,910,425,115,276,441,160,260,271,518,825,234,421
142,646,789,187,451,120,840,219,109,734,305,767,711,525,822,432,833,284,188,720
314,744,103,131,520,703,829,147,439,187,880,882,532,857,100,211,576,619,206,12
796,852,844,203,787,815,301,134,732,310,142,840,948,826,867,852,815,625,57,811
868,273,164,612,572,563,257,795,288,305,662,155,686,183,671,995,563,717,261,334
667,118,65,201,428,309,803,664,443,574,849,429,804,341,424,327,74,720,370,514
56,259,742,438,683,317,481,460,441,819,165,133,100,882,578,946,676,113,139,448
616,112,878,830,225,158,70,207,457,790,625,741,672,572,305,310,226,125,611,254
83,282,198,859,813,817,267,254,353,709,614,317,53,51,422,860,520,111,232,318
63,146,666,194,834,277,366,531,623,230,998,310,184,198,651,269,421,564,431,339
467,202,347,652,473,279,685,572,133,520,302,142,235,484,528,900,164,643,803,286
819,196,653,118,616,193,192,765,652,608,707,234,864,608,4,876,523,870,513,716
156,743,21,370,304,576,425,259,268,430,305,717,370,410,617,233,646,259,615,871
452,620,51,132,648,430,902,906,261,924,559,318,258,126,203,635,189,145,697,769
697,846,130,325,555,233,127,820,137,844,856,669,810,268,826,74,814,677,681,843
439,827,68,69,439,560,830,568,185,621,854,429,278,416,261,841,903,116,478,189
924,810,909,425,251,617,425,644,135,231,129,159,851,402,522,918,205,586,97,52
111,142,149,419,437,450,372,446,217,440,660,686,851,202,648,991,840,269,206,700
303,822,146,474,112,75,712,321,712,626,720,220,334,63,947,645,624,467,812,446
196,409,771,530,96,51,221,885,330,867,815,949,826,338,485,791,58,370,853,199
"""
