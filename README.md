PGourmet

http://frdcsa.org/frdcsa/internal/pgourmet

Prototype Gourmet

Gourmet prototype

Rather than try to engineer the entire Gourmet system at once, a task
which proved too difficult, we have focused instead in building a toy
system that nonetheless can serve to feed us in the mean time.  This
formalizes the interface, making the previous bottlenecks of data
extraction much easier because the target is there.

Here is a sample trace of the very initial meal planning.  Everything
is simplified for the sake of implentation at this point.  To wit:
quantities are simply by serving; there is no ability to make recipes
that have subrecipes (for instance making milk from instant milk in
order to have cereal with milk); the only nutrition value from the
database being considered is the dubious "nutr_val" scalar; and so on.
On the other hand, it is actually already a usable system, factoring
in how often something has been eaten, etc.  Although it is not yet
interactive.  A major requirement is a good functioning
inventory-management system. A good start.

<pre>
/var/lib/myfrdcsa/codebases/internal/pgourmet $ ./pgourmet -l
Loading data/barcodes
Loading data/inventory
Loading data/recipes
Loading data/substitutions
Loading data/nutrition
Loading data/palatability
Barcode		Qty	Srv	Name
----------------------------------------
041565000579	1	57	pace picante sauce
086600009889	1	20	bumble bee solid white albacore in water
043000220726	1	37	kraft minute white rice
021000774746	1	15	velveeta shells and cheese original
029700524906	1	65	idahoan mashed potatoes
041449003153	2	160	krusteaz buttermilk complete pancake mix
024000163084	8	28	delmonte sweet peas
043000495674	1	32	stove top stuffing mix for chicken
030034101602	1	6	giant eagle condensed soup cream of mushroom
024000162728	1	42	delmonte cut green beans
039400015987	8	28	bush's original baked beans
036200014011	3	30	ragu traditional pasta sauce
026825009097	1	16	gia russa elbow macaroni
030000438831	1	55	quaker instant oatmeal
015300439801	3	9	rice a roni creamy 4cheese
027000441107	11	77	hunt's manwhich sloppy joe sauce
030034017262	1	6	giant eagle vegetable juice from concentrate
086600008103	1	25	bumble bee chunck light tuna in water
024000163022	8	28	del monte whole kernel corn
745042141518	1	150	royal basmati rice
050000232550	1	87	carnation instant nonfat dry milk
041789002113	26	52	ramen chicken flavor
051500240908	2	70	jif creamy peanut butter
000000000000	1	1000	water
015300430235	4	12	rice a roni chicken flavor
681131889711	1	25	member's mark
681131811996	2	96	bakers and chefs elbow macaroni
016000854307	1	35	general mills triple pack - lucky charms trix cocoa puffs
681131812160	6	48	angel hair spaghetti
644209397181	1	31	mrs. butterworths original syrup
----------------------------------------
Date:	20051004090000
Meal:	cereal
NutVal:	39.1
Score:	1.30333333333333
----------------------------------------
Date:	20051004130000
Meal:	macaroni
NutVal:	14.2
Score:	0.473333333333333
----------------------------------------
Date:	20051004170000
Meal:	cereal
NutVal:	39.1
Score:	0.803333333333333
----------------------------------------
Date:	20051005090000
Meal:	pancakes
NutVal:	10.1
Score:	0.336666666666667
----------------------------------------
Date:	20051005130000
Meal:	ramen
NutVal:	9.3
Score:	0.31
----------------------------------------
Date:	20051005170000
Meal:	cereal
NutVal:	39.1
Score:	0.547777777777778
----------------------------------------
Date:	20051006090000
Meal:	macaroni
NutVal:	14.2
Score:	0.233333333333333
----------------------------------------
Date:	20051006130000
Meal:	rice
NutVal:	2.06
Score:	0.216666666666667
----------------------------------------
Date:	20051006170000
Meal:	cereal
NutVal:	39.1
Score:	0.0672222222222223
----------------------------------------
Date:	20051007090000
Meal:	pancakes
NutVal:	10.1
Score:	0.0866666666666667
----------------------------------------
Date:	20051007130000
Meal:	ramen
NutVal:	9.3
Score:	0.0322222222222222
----------------------------------------
Date:	20051007170000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	0
----------------------------------------
Date:	20051008090000
Meal:	cereal
NutVal:	39.1
Score:	0.105102040816327
----------------------------------------
Date:	20051008130000
Meal:	macaroni
NutVal:	14.2
Score:	0.117749433106576
----------------------------------------
Date:	20051008170000
Meal:	rice
NutVal:	2.06
Score:	-0.069047619047619
----------------------------------------
Date:	20051009090000
Meal:	pancakes
NutVal:	10.1
Score:	-0.184166666666667
----------------------------------------
Date:	20051009130000
Meal:	cereal
NutVal:	39.1
Score:	-0.223030724686569
----------------------------------------
Date:	20051009170000
Meal:	ramen
NutVal:	9.3
Score:	-0.137530491486535
----------------------------------------
Date:	20051010090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-0.36734693877551
----------------------------------------
Date:	20051010130000
Meal:	macaroni
NutVal:	14.2
Score:	-0.225512455256045
----------------------------------------
Date:	20051010170000
Meal:	rice
NutVal:	2.06
Score:	-0.457232084155161
----------------------------------------
Date:	20051011090000
Meal:	cereal
NutVal:	39.1
Score:	-0.108008323726914
----------------------------------------
Date:	20051011130000
Meal:	pancakes
NutVal:	10.1
Score:	-0.303432268217815
----------------------------------------
Date:	20051011170000
Meal:	ramen
NutVal:	9.3
Score:	-0.528695474802443
----------------------------------------
Date:	20051012090000
Meal:	macaroni
NutVal:	14.2
Score:	-0.804456468216564
----------------------------------------
Date:	20051012130000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-0.637755102040816
----------------------------------------
Date:	20051012170000
Meal:	cereal
NutVal:	39.1
Score:	-0.352123984921604
----------------------------------------
Date:	20051013090000
Meal:	rice
NutVal:	2.06
Score:	-0.709617055106066
----------------------------------------
Date:	20051013130000
Meal:	pancakes
NutVal:	10.1
Score:	-0.729153911353698
----------------------------------------
Date:	20051013170000
Meal:	ramen
NutVal:	9.3
Score:	-0.823676854416743
----------------------------------------
Date:	20051014090000
Meal:	macaroni
NutVal:	14.2
Score:	-0.799495265267339
----------------------------------------
Date:	20051014130000
Meal:	cereal
NutVal:	39.1
Score:	-0.643895087423915
----------------------------------------
Date:	20051014170000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-0.888888888888889
----------------------------------------
Date:	20051015090000
Meal:	rice
NutVal:	2.06
Score:	-1.18349558261896
----------------------------------------
Date:	20051015130000
Meal:	pancakes
NutVal:	10.1
Score:	-1.02785152706876
----------------------------------------
Date:	20051015170000
Meal:	ramen
NutVal:	9.3
Score:	-1.10572286455724
----------------------------------------
Date:	20051016090000
Meal:	cereal
NutVal:	39.1
Score:	-0.951465658451256
----------------------------------------
Date:	20051016130000
Meal:	macaroni
NutVal:	14.2
Score:	-0.746188204291044
----------------------------------------
Date:	20051016170000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-1.42753382683582
----------------------------------------
Date:	20051017090000
Meal:	rice
NutVal:	2.06
Score:	-1.34601917849723
----------------------------------------
Date:	20051017130000
Meal:	pancakes
NutVal:	10.1
Score:	-1.31052072899553
----------------------------------------
Date:	20051017170000
Meal:	cereal
NutVal:	39.1
Score:	-1.26637159108654
----------------------------------------
Date:	20051018090000
Meal:	ramen
NutVal:	9.3
Score:	-1.04930855508292
----------------------------------------
Date:	20051018130000
Meal:	macaroni
NutVal:	14.2
Score:	-1.27287931529646
----------------------------------------
Date:	20051018170000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-1.75515423208796
----------------------------------------
Date:	20051019090000
Meal:	rice
NutVal:	2.06
Score:	-1.78271187980997
----------------------------------------
Date:	20051019130000
Meal:	cereal
NutVal:	39.1
Score:	-1.58533469034798
----------------------------------------
Date:	20051019170000
Meal:	pancakes
NutVal:	10.1
Score:	-1.20874119495406
----------------------------------------
Date:	20051020090000
Meal:	ramen
NutVal:	9.3
Score:	-1.62510334741541
----------------------------------------
Date:	20051020130000
Meal:	macaroni
NutVal:	14.2
Score:	-1.5822108863579
----------------------------------------
Date:	20051020170000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-2.05213333356162
----------------------------------------
Date:	20051021090000
Meal:	cereal
NutVal:	39.1
Score:	-1.90679677412131
----------------------------------------
Date:	20051021130000
Meal:	rice
NutVal:	2.06
Score:	-1.63996579482929
----------------------------------------
Date:	20051021170000
Meal:	pancakes
NutVal:	10.1
Score:	-1.82120994610451
----------------------------------------
Date:	20051022090000
Meal:	ramen
NutVal:	9.3
Score:	-1.9461133669954
----------------------------------------
Date:	20051022130000
Meal:	macaroni
NutVal:	14.2
Score:	-1.86676001126267
----------------------------------------
Date:	20051022170000
Meal:	cereal
NutVal:	39.1
Score:	-2.22991495201396
----------------------------------------
Date:	20051023090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-1.86971517528853
----------------------------------------
Date:	20051023130000
Meal:	rice
NutVal:	2.06
Score:	-2.291882327185
----------------------------------------
Date:	20051023170000
Meal:	pancakes
NutVal:	10.1
Score:	-2.14715986167185
----------------------------------------
Date:	20051024090000
Meal:	ramen
NutVal:	9.3
Score:	-2.23636371951288
----------------------------------------
Date:	20051024130000
Meal:	macaroni
NutVal:	14.2
Score:	-2.1450961498406
----------------------------------------
Date:	20051024170000
Meal:	cereal
NutVal:	39.1
Score:	-1.68281369069127
----------------------------------------
Date:	20051025090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-2.56169174884783
----------------------------------------
Date:	20051025130000
Meal:	rice
NutVal:	2.06
Score:	-2.47694384072339
----------------------------------------
Date:	20051025170000
Meal:	pancakes
NutVal:	10.1
Score:	-2.4388034987751
----------------------------------------
Date:	20051026090000
Meal:	ramen
NutVal:	9.3
Score:	-2.51824158622088
----------------------------------------
Date:	20051026130000
Meal:	macaroni
NutVal:	14.2
Score:	-2.42122974120992
----------------------------------------
Date:	20051026170000
Meal:	cereal
NutVal:	39.1
Score:	-1.82542548710921
----------------------------------------
Date:	20051027090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-2.90225107893239
----------------------------------------
Date:	20051027130000
Meal:	rice
NutVal:	2.06
Score:	-2.91972769040171
----------------------------------------
Date:	20051027170000
Meal:	pancakes
NutVal:	10.1
Score:	-2.72119031706334
----------------------------------------
Date:	20051028090000
Meal:	ramen
NutVal:	9.3
Score:	-2.79684590487513
----------------------------------------
Date:	20051028130000
Meal:	macaroni
NutVal:	14.2
Score:	-2.69641254751451
----------------------------------------
Date:	20051028170000
Meal:	cereal
NutVal:	39.1
Score:	-2.04803049984429
----------------------------------------
Date:	20051029090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-3.20043340579368
----------------------------------------
Date:	20051029130000
Meal:	rice
NutVal:	2.06
Score:	-3.20405940498819
----------------------------------------
Date:	20051029170000
Meal:	pancakes
NutVal:	10.1
Score:	-2.99999378470296
----------------------------------------
Date:	20051030090000
Meal:	ramen
NutVal:	9.3
Score:	-3.0738737381534
----------------------------------------
Date:	20051030130000
Meal:	macaroni
NutVal:	14.2
Score:	-2.97112974073072
----------------------------------------
Date:	20051030170000
Meal:	cereal
NutVal:	39.1
Score:	-2.2943672541198
----------------------------------------
Date:	20051031090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-3.48689074020953
----------------------------------------
Date:	20051031130000
Meal:	rice
NutVal:	2.06
Score:	-3.48426339166334
----------------------------------------
Date:	20051031170000
Meal:	pancakes
NutVal:	10.1
Score:	-3.27709080470169
----------------------------------------
Date:	20051101090000
Meal:	ramen
NutVal:	9.3
Score:	-3.35003212163201
----------------------------------------
Date:	20051101130000
Meal:	macaroni
NutVal:	14.2
Score:	-3.24559835801404
----------------------------------------
Date:	20051101170000
Meal:	cereal
NutVal:	39.1
Score:	-2.55088310089129
----------------------------------------
Date:	20051102090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-3.76862638832752
----------------------------------------
Date:	20051102130000
Meal:	rice
NutVal:	2.06
Score:	-3.61444962746093
----------------------------------------
Date:	20051102170000
Meal:	pancakes
NutVal:	10.1
Score:	-3.55325804146312
----------------------------------------
Date:	20051103090000
Meal:	ramen
NutVal:	9.3
Score:	-3.62566321362805
----------------------------------------
Date:	20051103130000
Meal:	macaroni
NutVal:	14.2
Score:	-3.51992588826729
----------------------------------------
Date:	20051103170000
Meal:	cereal
NutVal:	39.1
Score:	-2.81272829769052
----------------------------------------
Date:	20051104090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-4.04799987466066
----------------------------------------
Date:	20051104130000
Meal:	rice
NutVal:	2.06
Score:	-3.89150264250085
----------------------------------------
Date:	20051104170000
Meal:	pancakes
NutVal:	10.1
Score:	-3.82886851083549
----------------------------------------
Date:	20051105090000
Meal:	ramen
NutVal:	9.3
Score:	-3.90095134001864
----------------------------------------
Date:	20051105130000
Meal:	macaroni
NutVal:	14.2
Score:	-3.79416974403728
----------------------------------------
Date:	20051105170000
Meal:	cereal
NutVal:	39.1
Score:	-3.07773494086182
----------------------------------------
Date:	20051106090000
Meal:	velvetta shells &amp; cheese
NutVal:	?
Score:	-4.32601379035556
----------------------------------------
Date:	20051106130000
Meal:	rice
NutVal:	2.06
Score:	-4.16785448987924
----------------------------------------
Date:	20051106170000
Meal:	pancakes
NutVal:	10.1
Score:	-4.10412150712316
----------------------------------------
Date:	20051107090000
Meal:	ramen
NutVal:	9.3
Score:	-4.17600412938991
----------------------------------------
Date:	20051107130000
Meal:	macaroni
NutVal:	14.2
Score:	-4.06836241707919
----------------------------------------
Date:	20051107170000
Meal:	cereal
NutVal:	39.1
Score:	-3.34478402905801
----------------------------------------
Date:	20051108090000
Meal:	rice
NutVal:	2.06
Score:	-5.89978239077132
----------------------------------------
Date:	20051108130000
Meal:	pancakes
NutVal:	10.1
Score:	-5.84961251547397
----------------------------------------
Date:	20051108170000
Meal:	ramen
NutVal:	9.3
Score:	-5.935690662023
----------------------------------------
Date:	20051109090000
Meal:	macaroni
NutVal:	14.2
Score:	-5.84174267796667
----------------------------------------
Date:	20051109130000
Meal:	cereal
NutVal:	39.1
Score:	-5.12763194484001
----------------------------------------
Date:	20051109170000
Meal:	rice
NutVal:	2.06
Score:	-6.48813140665581
----------------------------------------
Date:	20051110090000
Meal:	pancakes
NutVal:	10.1
Score:	-6.4399438346699
----------------------------------------
Date:	20051110130000
Meal:	ramen
NutVal:	9.3
Score:	-6.52855756984638
----------------------------------------
Date:	20051110170000
Meal:	macaroni
NutVal:	14.2
Score:	-6.43668446398874
----------------------------------------
Date:	20051111090000
Meal:	cereal
NutVal:	39.1
Score:	-5.72109863688486
----------------------------------------
Date:	20051111130000
Meal:	rice
NutVal:	2.06
Score:	-6.91875699556372
----------------------------------------
Date:	20051111170000
Meal:	pancakes
NutVal:	10.1
Score:	-6.87104150486782
----------------------------------------
Date:	20051112090000
Meal:	ramen
NutVal:	9.3
Score:	-6.9606178903413
----------------------------------------
Date:	20051112130000
Meal:	macaroni
NutVal:	14.2
Score:	-6.86928435102424
----------------------------------------
Date:	20051112170000
Meal:	cereal
NutVal:	39.1
Score:	-6.15121061617552
----------------------------------------
Date:	20051113090000
Meal:	rice
NutVal:	2.06
Score:	-7.44931879261361
----------------------------------------
Date:	20051113130000
Meal:	pancakes
NutVal:	10.1
Score:	-7.25365966273691
----------------------------------------
Date:	20051113170000
Meal:	ramen
NutVal:	9.3
Score:	-7.34373187572343
----------------------------------------
Date:	20051114090000
Meal:	cereal
NutVal:	39.1
Score:	-9.6782971596646
----------------------------------------
Date:	20051114130000
Meal:	rice
NutVal:	2.06
Score:	-10.9864993275151
----------------------------------------
Date:	20051114170000
Meal:	pancakes
NutVal:	10.1
Score:	-10.8169526371873
----------------------------------------
Date:	20051115090000
Meal:	ramen
NutVal:	9.3
Score:	-10.9334578995498
----------------------------------------
Date:	20051115130000
Meal:	cereal
NutVal:	39.1
Score:	-10.6915453534501
----------------------------------------
Date:	20051115170000
Meal:	rice
NutVal:	2.06
Score:	-11.9961974902249
----------------------------------------
Date:	20051116090000
Meal:	pancakes
NutVal:	10.1
Score:	-11.8313943669297
----------------------------------------
Date:	20051116130000
Meal:	ramen
NutVal:	9.3
Score:	-11.9529400380335
----------------------------------------
Date:	20051116170000
Meal:	cereal
NutVal:	39.1
Score:	-11.3466875805895
----------------------------------------
Date:	20051117090000
Meal:	rice
NutVal:	2.06
Score:	-12.6486466450673
----------------------------------------
Date:	20051117130000
Meal:	pancakes
NutVal:	10.1
Score:	-12.4856005133351
----------------------------------------
Date:	20051117170000
Meal:	ramen
NutVal:	9.3
Score:	-12.6091790515785
----------------------------------------
Date:	20051118090000
Meal:	cereal
NutVal:	39.1
Score:	-11.8898026304499
----------------------------------------
Date:	20051118130000
Meal:	rice
NutVal:	2.06
Score:	-13.1902454761935
----------------------------------------
Date:	20051118170000
Meal:	pancakes
NutVal:	10.1
Score:	-13.0280438980414
----------------------------------------
Date:	20051119090000
Meal:	ramen
NutVal:	9.3
Score:	-13.152724231054
----------------------------------------
Date:	20051119130000
Meal:	cereal
NutVal:	39.1
Score:	-12.3838526267404
----------------------------------------
Date:	20051119170000
Meal:	rice
NutVal:	2.06
Score:	-13.6835993555718
----------------------------------------
Date:	20051120090000
Meal:	pancakes
NutVal:	10.1
Score:	-13.5218544003345
----------------------------------------
Date:	20051120130000
Meal:	ramen
NutVal:	9.3
Score:	-13.6472319280854
----------------------------------------
Date:	20051120170000
Meal:	cereal
NutVal:	39.1
Score:	-12.8520171926014
----------------------------------------
Date:	20051121090000
Meal:	rice
NutVal:	2.06
Score:	-14.1515997995448
----------------------------------------
Date:	20051121130000
Meal:	pancakes
NutVal:	10.1
Score:	-13.9901141399577
----------------------------------------
Date:	20051121170000
Meal:	ramen
NutVal:	9.3
Score:	-14.1159765397751
----------------------------------------
Date:	20051122090000
Meal:	cereal
NutVal:	39.1
Score:	-13.3048228016201
----------------------------------------
Date:	20051122130000
Meal:	rice
NutVal:	2.06
Score:	-14.6045825610442
----------------------------------------
Date:	20051122170000
Meal:	pancakes
NutVal:	10.1
Score:	-14.4432441553044
----------------------------------------
Date:	20051123090000
Meal:	ramen
NutVal:	9.3
Score:	-14.569465829351
----------------------------------------
Date:	20051123130000
Meal:	cereal
NutVal:	39.1
Score:	-13.7477501823366
----------------------------------------
Date:	20051123170000
Meal:	rice
NutVal:	2.06
Score:	-15.0479053423508
----------------------------------------
Date:	20051124090000
Meal:	pancakes
NutVal:	10.1
Score:	-14.8866458006969
----------------------------------------
Date:	20051124130000
Meal:	ramen
NutVal:	9.3
Score:	-15.0131460509226
----------------------------------------
Date:	20051124170000
Meal:	cereal
NutVal:	39.1
Score:	-14.1839406038042
----------------------------------------
Date:	20051125090000
Meal:	rice
NutVal:	2.06
Score:	-15.3366295518665
----------------------------------------
Date:	20051125130000
Meal:	pancakes
NutVal:	10.1
Score:	-15.3234050121909
----------------------------------------
Date:	20051125170000
Meal:	ramen
NutVal:	9.3
Score:	-15.4501287575534
----------------------------------------
Date:	20051126090000
Meal:	cereal
NutVal:	39.1
Score:	-14.6153271351848
----------------------------------------
Date:	20051126130000
Meal:	rice
NutVal:	2.06
Score:	-15.9166357295404
----------------------------------------
Date:	20051126170000
Meal:	pancakes
NutVal:	10.1
Score:	-15.7554170806565
----------------------------------------
Date:	20051127090000
Meal:	ramen
NutVal:	9.3
Score:	-15.8823249480968
----------------------------------------
Date:	20051127130000
Meal:	rice
NutVal:	2.06
Score:	-25.227928440873
----------------------------------------
Date:	20051127170000
Meal:	ramen
NutVal:	9.3
Score:	-49.8181819950458
----------------------------------------
Date:	20051128090000
Meal:	rice
NutVal:	2.06
Score:	-52.9379041214819
----------------------------------------
Date:	20051128130000
Meal:	ramen
NutVal:	9.3
Score:	-57.8109755963776
----------------------------------------
Date:	20051128170000
Meal:	rice
NutVal:	2.06
Score:	-59.5105559085243
----------------------------------------
Date:	20051129090000
Meal:	ramen
NutVal:	9.3
Score:	-61.5678609629521
----------------------------------------
Date:	20051129130000
Meal:	rice
NutVal:	2.06
Score:	-62.7482214556556
----------------------------------------
Date:	20051129170000
Meal:	ramen
NutVal:	9.3
Score:	-63.9591452838997
----------------------------------------
Date:	20051130090000
Meal:	rice
NutVal:	2.06
Score:	-65.0446617365686
----------------------------------------
Date:	20051130130000
Meal:	ramen
NutVal:	9.3
Score:	-65.7526578762936
----------------------------------------
Date:	20051130170000
Meal:	rice
NutVal:	2.06
Score:	-66.5580628491541
----------------------------------------
Date:	20051201090000
Meal:	ramen
NutVal:	9.3
Score:	-67.2340934200598
----------------------------------------
Date:	20051201130000
Meal:	rice
NutVal:	2.06
Score:	-68.1079094541002
----------------------------------------
Date:	20051201170000
Meal:	ramen
NutVal:	9.3
Score:	-68.5327979352334
----------------------------------------
Date:	20051202090000
Meal:	rice
NutVal:	2.06
Score:	-69.2070167024712
----------------------------------------
Date:	20051202130000
Meal:	ramen
NutVal:	9.3
Score:	-69.7155241055111
----------------------------------------
Date:	20051202170000
Meal:	rice
NutVal:	2.06
Score:	-70.3543928009134
----------------------------------------
Date:	20051203090000
Meal:	ramen
NutVal:	9.3
Score:	-70.8201089189204
----------------------------------------
Date:	20051203130000
Meal:	rice
NutVal:	2.06
Score:	-71.4336933295449
----------------------------------------
Date:	20051203170000
Meal:	ramen
NutVal:	9.3
Score:	-71.869566831307
----------------------------------------
Date:	20051204090000
Meal:	rice
NutVal:	2.06
Score:	-72.4644323332636
----------------------------------------
Date:	20051204130000
Meal:	ramen
NutVal:	9.3
Score:	-72.8786879958925
----------------------------------------
Date:	20051204170000
Meal:	rice
NutVal:	2.06
Score:	-73.6072988328674
----------------------------------------
Date:	20051205090000
Meal:	ramen
NutVal:	9.3
Score:	-73.8574057484766
----------------------------------------
Date:	20051205130000
Meal:	rice
NutVal:	2.06
Score:	-74.5749035933143
----------------------------------------
Date:	20051205170000
Meal:	ramen
NutVal:	9.3
Score:	-74.8126370233313
----------------------------------------
Date:	20051206090000
Meal:	rice
NutVal:	2.06
Score:	-75.5212975194226
----------------------------------------
Date:	20051206130000
Meal:	ramen
NutVal:	9.3
Score:	-75.7493458159196
----------------------------------------
Date:	20051206170000
Meal:	rice
NutVal:	2.06
Score:	-76.3028582962902
----------------------------------------
Date:	20051207090000
Meal:	ramen
NutVal:	9.3
Score:	-76.6711867824087
----------------------------------------
Date:	20051207130000
Meal:	rice
NutVal:	2.06
Score:	-77.2188321520474
----------------------------------------
Date:	20051207170000
Meal:	ramen
NutVal:	9.3
Score:	-77.5809102436654
----------------------------------------
Date:	20051208090000
Meal:	rice
NutVal:	2.06
Score:	-78.1236777785819
----------------------------------------
Date:	20051208130000
Meal:	ramen
NutVal:	9.3
Score:	-78.4806256982382
----------------------------------------
Date:	20051208170000
Meal:	rice
NutVal:	2.06
Score:	-79.1672918986086
----------------------------------------
Date:	20051209090000
Meal:	ramen
NutVal:	9.3
Score:	-79.3719783006463
----------------------------------------
Date:	20051209130000
Meal:	rice
NutVal:	2.06
Score:	-80.0551614398923
----------------------------------------
Date:	20051209170000
Meal:	ramen
NutVal:	9.3
Score:	-80.2562700734497
----------------------------------------
Date:	20051210090000
Meal:	rice
NutVal:	2.06
Score:	-80.9364687566538
----------------------------------------
Date:	20051210130000
Meal:	ramen
NutVal:	9.3
Score:	-81.1345450341636
----------------------------------------
Date:	20051210170000
Meal:	rice
NutVal:	2.06
Score:	-81.6641659818162
----------------------------------------
Date:	20051211090000
Meal:	ramen
NutVal:	9.3
Score:	-82.0076501734001
----------------------------------------
Date:	20051211130000
Meal:	rice
NutVal:	2.06
Score:	-82.6830285889377
----------------------------------------
Date:	20051211170000
Meal:	rice
NutVal:	2.06
Score:	-252.545059706787
----------------------------------------
Date:	20051212090000
Meal:	rice
NutVal:	2.06
Score:	-290.549694648106
----------------------------------------
Date:	20051212130000
Meal:	rice
NutVal:	2.06
Score:	-307.054766097555
----------------------------------------
Date:	20051212170000
Meal:	rice
NutVal:	2.06
Score:	-316.486916268749
----------------------------------------
Date:	20051213090000
Meal:	rice
NutVal:	2.06
Score:	-323.186037317017
----------------------------------------
Date:	20051213130000
Meal:	rice
NutVal:	2.06
Score:	-328.156914990958
----------------------------------------
Date:	20051213170000
Meal:	rice
NutVal:	2.06
Score:	-332.203169543703
----------------------------------------
Date:	20051214090000
Meal:	rice
NutVal:	2.06
Score:	-335.515004092476
----------------------------------------
Date:	20051214130000
Meal:	rice
NutVal:	2.06
Score:	-338.728035516573
----------------------------------------
Date:	20051214170000
Meal:	rice
NutVal:	2.06
Score:	-341.366761623927
----------------------------------------
Date:	20051215090000
Meal:	rice
NutVal:	2.06
Score:	-343.950012721713
----------------------------------------
Date:	20051215130000
Meal:	rice
NutVal:	2.06
Score:	-346.380020118589
----------------------------------------
Date:	20051215170000
Meal:	rice
NutVal:	2.06
Score:	-348.691742444223
----------------------------------------
Date:	20051216090000
Meal:	rice
NutVal:	2.06
Score:	-351.058253569223
----------------------------------------
Date:	20051216130000
Meal:	rice
NutVal:	2.06
Score:	-353.054002594453
----------------------------------------
Date:	20051216170000
Meal:	rice
NutVal:	2.06
Score:	-355.136864807083
----------------------------------------
Date:	20051217090000
Meal:	rice
NutVal:	2.06
Score:	-357.169475782995
----------------------------------------
Date:	20051217130000
Meal:	rice
NutVal:	2.06
Score:	-359.160124612226
----------------------------------------
Date:	20051217170000
Meal:	rice
NutVal:	2.06
Score:	-361.115367223416
----------------------------------------
Date:	20051218090000
Meal:	rice
NutVal:	2.06
Score:	-363.040456987332
----------------------------------------
Date:	20051218130000
Meal:	rice
NutVal:	2.06
Score:	-364.939653066027
----------------------------------------
Date:	20051218170000
Meal:	rice
NutVal:	2.06
Score:	-366.816445151533
----------------------------------------
Date:	20051219090000
Meal:	rice
NutVal:	2.06
Score:	-368.673719888401
----------------------------------------
Date:	20051219130000
Meal:	rice
NutVal:	2.06
Score:	-370.513885895587
----------------------------------------
Date:	20051219170000
Meal:	rice
NutVal:	2.06
Score:	-372.338968921182
----------------------------------------
Date:	20051220090000
Meal:	rice
NutVal:	2.06
Score:	-374.150685133424
----------------------------------------
Date:	20051220130000
Meal:	rice
NutVal:	2.06
Score:	-375.950498191619
----------------------------------------
Date:	20051220170000
Meal:	rice
NutVal:	2.06
Score:	-377.739664135423
----------------------------------------
Date:	20051221090000
Meal:	rice
NutVal:	2.06
Score:	-379.519267021582
----------------------------------------
Date:	20051221130000
Meal:	rice
NutVal:	2.06
Score:	-381.290247459222
----------------------------------------
Date:	20051221170000
Meal:	rice
NutVal:	2.06
Score:	-383.053425641722
----------------------------------------
Date:	20051222090000
Meal:	rice
NutVal:	2.06
Score:	-384.809520075075
----------------------------------------
Date:	20051222130000
Meal:	rice
NutVal:	2.06
Score:	-386.55916291272
----------------------------------------
Date:	20051222170000
Meal:	rice
NutVal:	2.06
Score:	-388.302912593407
----------------------------------------
Date:	20051223090000
Meal:	rice
NutVal:	2.06
Score:	-390.041264319874
----------------------------------------
Date:	20051223130000
Meal:	rice
NutVal:	2.06
Score:	-391.774658797002
----------------------------------------
Date:	20051223170000
Meal:	rice
NutVal:	2.06
Score:	-393.503489557783
----------------------------------------
Date:	20051224090000
Meal:	rice
NutVal:	2.06
Score:	-395.228109136554
----------------------------------------
Date:	20051224130000
Meal:	rice
NutVal:	2.06
Score:	-396.948834295806
----------------------------------------
Date:	20051224170000
Meal:	rice
NutVal:	2.06
Score:	-398.66595047177
----------------------------------------
Date:	20051225090000
Meal:	rice
NutVal:	2.06
Score:	-400.37971557178
----------------------------------------
Date:	20051225130000
Meal:	rice
NutVal:	2.06
Score:	-402.090363231176
----------------------------------------
Date:	20051225170000
Meal:	rice
NutVal:	2.06
Score:	-403.79810561748
----------------------------------------
Date:	20051226090000
Meal:	rice
NutVal:	2.06
Score:	-405.50313585368
----------------------------------------
Date:	20051226130000
Meal:	rice
NutVal:	2.06
Score:	-407.205630119713
----------------------------------------
Date:	20051226170000
Meal:	rice
NutVal:	2.06
Score:	-408.905749480965
----------------------------------------
Date:	20051227090000
Meal:	rice
NutVal:	2.06
Score:	-410.603641484346
----------------------------------------
Date:	20051227130000
Meal:	rice
NutVal:	2.06
Score:	-412.299441555737
----------------------------------------
Date:	20051227170000
Meal:	rice
NutVal:	2.06
Score:	-413.993274227089
----------------------------------------
Date:	20051228090000
Meal:	rice
NutVal:	2.06
Score:	-415.685254216958
----------------------------------------
Date:	20051228130000
Meal:	rice
NutVal:	2.06
Score:	-417.375487384541
----------------------------------------
Date:	20051228170000
Meal:	rice
NutVal:	2.06
Score:	-419.064071574172
----------------------------------------
Date:	20051229090000
Meal:	rice
NutVal:	2.06
Score:	-420.751097364704
----------------------------------------
Date:	20051229130000
Meal:	rice
NutVal:	2.06
Score:	-422.436648736071
----------------------------------------
Date:	20051229170000
Meal:	rice
NutVal:	2.06
Score:	-424.120803663536
----------------------------------------
Date:	20051230090000
Meal:	rice
NutVal:	2.06
Score:	-425.803634648617
----------------------------------------
Date:	20051230130000
Meal:	rice
NutVal:	2.06
Score:	-427.485209194462
----------------------------------------
Date:	20051230170000
Meal:	rice
NutVal:	2.06
Score:	-429.165590232333
----------------------------------------
Date:	20051231090000
Meal:	rice
NutVal:	2.06
Score:	-430.844836504993
----------------------------------------
Date:	20051231130000
Meal:	rice
NutVal:	2.06
Score:	-432.523002911989
----------------------------------------
Date:	20051231170000
Meal:	rice
NutVal:	2.06
Score:	-434.200140821204
----------------------------------------
Date:	20060101090000
Meal:	rice
NutVal:	2.06
Score:	-435.87629835045
----------------------------------------
Date:	20060101130000
Meal:	rice
NutVal:	2.06
Score:	-437.551520622439
----------------------------------------
Date:	20060101170000
Meal:	rice
NutVal:	2.06
Score:	-439.225849996008
----------------------------------------
Date:	20060102090000
Meal:	rice
NutVal:	2.06
Score:	-440.899326276167
----------------------------------------
Date:	20060102130000
Meal:	rice
NutVal:	2.06
Score:	-442.57198690518
----------------------------------------
Date:	20060102170000
Meal:	rice
NutVal:	2.06
Score:	-444.243867136679
----------------------------------------
Date:	20060103090000
Meal:	rice
NutVal:	2.06
Score:	-445.915000194526
----------------------------------------
Date:	20060103130000
Meal:	rice
NutVal:	2.06
Score:	-447.585417417977
----------------------------------------
Date:	20060103170000
Meal:	rice
NutVal:	2.06
Score:	-449.255148394496
----------------------------------------
Date:	20060104090000
Meal:	rice
NutVal:	2.06
Score:	-450.924221081455
----------------------------------------
Date:	20060104130000
Meal:	rice
NutVal:	2.06
Score:	-452.592661917766
----------------------------------------
Date:	20060104170000
Meal:	rice
NutVal:	2.06
Score:	-454.260495926424
----------------------------------------
Date:	20060105090000
Meal:	rice
NutVal:	2.06
Score:	-455.927746808809
----------------------------------------
Date:	20060105130000
Meal:	rice
NutVal:	2.06
Score:	-457.594437031512
----------------------------------------
Date:	20060105170000
Meal:	rice
NutVal:	2.06
Score:	-459.260587906376
----------------------------------------
Date:	20060106090000
Meal:	rice
NutVal:	2.06
Score:	-460.926219664348
----------------------------------------
Date:	20060106130000
Meal:	rice
NutVal:	2.06
Score:	-462.591351523719
----------------------------------------
Date:	20060106170000
Meal:	rice
NutVal:	2.06
Score:	-464.256001753219
----------------------------------------
Date:	20060107090000
Meal:	rice
NutVal:	2.06
Score:	-465.920187730439
----------------------------------------
Date:	20060107130000
Meal:	rice
NutVal:	2.06
Score:	-467.583925995964
----------------------------------------
Date:	20060107170000
Meal:	rice
NutVal:	2.06
Score:	-469.247232303587
----------------------------------------
Date:	20060108090000
Meal:	rice
NutVal:	2.06
Score:	-470.91012166693
----------------------------------------
Date:	20060108130000
Meal:	rice
NutVal:	2.06
Score:	-472.572608402778
----------------------------------------
Date:	20060108170000
Meal:	rice
NutVal:	2.06
Score:	-474.234706171379
----------------------------------------
Date:	20060109090000
Meal:	rice
NutVal:	2.06
Score:	-475.896428013969
----------------------------------------
Date:	20060109130000
Meal:	rice
NutVal:	2.06
Score:	-477.557786387735
----------------------------------------
Date:	20060109170000
Meal:	rice
NutVal:	2.06
Score:	-479.218793198428
----------------------------------------
Date:	20060110090000
Meal:	rice
NutVal:	2.06
Score:	-480.879459830793
----------------------------------------
Date:	20060110130000
Meal:	rice
NutVal:	2.06
Score:	-482.539797177007
----------------------------------------
Date:	20060110170000
Meal:	rice
NutVal:	2.06
Score:	-484.199815663249
----------------------------------------
Date:	20060111090000
Meal:	rice
NutVal:	2.06
Score:	-485.859525274576
----------------------------------------
Date:	20060111130000
Meal:	rice
NutVal:	2.06
Score:	-487.518935578199
----------------------------------------
Date:	20060111170000
Meal:	rice
NutVal:	2.06
Score:	-489.1780557453
Barcode		Qty	Srv	Name
----------------------------------------
041565000579	1	57	pace picante sauce
086600009889	1	20	bumble bee solid white albacore in water
043000220726	1	0	kraft minute white rice
021000774746	1	0	velveeta shells and cheese original
029700524906	1	65	idahoan mashed potatoes
041449003153	2	129	krusteaz buttermilk complete pancake mix
024000163084	8	28	delmonte sweet peas
043000495674	1	32	stove top stuffing mix for chicken
030034101602	1	6	giant eagle condensed soup cream of mushroom
024000162728	1	42	delmonte cut green beans
039400015987	8	28	bush's original baked beans
036200014011	3	9	ragu traditional pasta sauce
026825009097	1	1	gia russa elbow macaroni
030000438831	1	55	quaker instant oatmeal
015300439801	3	9	rice a roni creamy 4cheese
027000441107	11	77	hunt's manwhich sloppy joe sauce
030034017262	1	6	giant eagle vegetable juice from concentrate
086600008103	1	25	bumble bee chunck light tuna in water
024000163022	8	28	del monte whole kernel corn
745042141518	1	41	royal basmati rice
050000232550	1	52	carnation instant nonfat dry milk
041789002113	26	0	ramen chicken flavor
051500240908	2	70	jif creamy peanut butter
000000000000	1	750	water
015300430235	4	12	rice a roni chicken flavor
681131889711	1	25	member's mark
681131811996	2	6	bakers and chefs elbow macaroni
016000854307	1	0	general mills triple pack - lucky charms trix cocoa puffs
681131812160	6	48	angel hair spaghetti
644209397181	1	0	mrs. butterworths original syrup
</pre>