********************************************************************************
** 	TITLE		: 1_analysis.do
**	PROJECT		: A comparative economic growth analysis: developing and developed countries
**	PURPOSE		: Sampling for country selection
**	AUTHOR		: Md. Rajibul Alam
**	CONTACT		: rajibulalam@ymail.com
**	CREATED		: 1 August 2023 | Time: 8:20 pm
********************************************************************************
**#A. Setup
	clear all
	cap log close
	version 16
	set maxvar 32767
	set more off
	pause on
	set niceness 1
	set seed 12357
	set sortseed 12345678
//	set trace on 
//	set traced 1	
**#B. Dataset Open
/*
	import excel "../Data/90_Countries/latest_dataset/90_countries_new.xlsx", sheet("Data") firstrow
	
	*save 
	compress
	save "../Data/90_Countries/latest_dataset/90_countries_new.dta", replace
*/
	
	import excel "../Data/90_Countries/latest_dataset/IMF_capital_stock.xlsx", sheet("Dataset") firstrow
	
	drop kgov_n kpriv_n
	reshape wide tot_cap_stockinbillionsofno, i(ifscode country) j(year)
	
	foreach var of varlist _all {
    local newvar : subinstr local var "tot_cap_stockinbillionsof" "", all
    rename `var' `newvar'
	}
	gen tot_cap_stock="tot_cap_stock (in billions of nominal national currency)"
	ren no* YR*
	tostring YR*, replace force
	ren isocode CountryCode
	duplicates list CountryCode
	
	order ifscode country CountryCode income tot_cap_stock, first
	ren tot_cap_stock SeriesName
	ren country CountryName

 
	
	//merge 1:m CountryCode using "../Data/90_Countries/latest_dataset/90_countries_new.dta", keep(3) nogen
	append using "../Data/90_Countries/latest_dataset/90_countries_new.dta"
	gen country=1
	sort CountryName SeriesName
	drop ifscode income YR1960 YR1961 YR1962 YR1963 YR1964 YR1965 YR1966 YR1967 ///
			YR1968 YR1969 YR1970 YR1971 YR1972 YR1973 YR1974 YR1975 YR1976 YR1977 ///
			YR1978 YR1979 YR1980 c_id s_id
	drop if CountryName==""
	order SeriesCode, after(SeriesName)

	
	*Save 
	compress
	save "../Data/90_Countries/latest_dataset/90_countries_combine.dta", replace

	**import excel file from cleaned dataset
	import excel "../Data/90_Countries/latest_dataset/countries_cleaning.xlsx", sheet("Sheet1") firstrow clear
	
	**label countries by income level
	


	gen income_type=""
	replace income_type="Developing Countries" if country=="Albania"
	replace income_type="Developing Countries" if country=="Algeria"
	replace income_type="Developing Countries" if country=="Angola"
	replace income_type="Developing Countries" if country=="Argentina"
	replace income_type="Developed Countries" if country=="Australia"
	replace income_type="Developed Countries" if country=="Austria"
	replace income_type="Developing Countries" if country=="Azerbaijan"
	replace income_type="Developing Countries" if country=="Bangladesh"
	replace income_type="Developing Countries" if country=="Benin"
	replace income_type="Developing Countries" if country=="Bolivia"
	replace income_type="Developing Countries" if country=="Bosnia and Herzegovina"
	replace income_type="Developing Countries" if country=="Botswana"
	replace income_type="Developing Countries" if country=="Bulgaria"
	replace income_type="Developing Countries" if country=="Cambodia"
	replace income_type="Developing Countries" if country=="Cameroon"
	replace income_type="Developed Countries" if country=="Canada"
	replace income_type="Developed Countries" if country=="Chile"
	replace income_type="Developed Countries" if country=="China"
	replace income_type="Developing Countries" if country=="Costa Rica"
	replace income_type="Developing Countries" if country=="Cote d'Ivoire"
	replace income_type="Developed Countries" if country=="Croatia"
	replace income_type="Developing Countries" if country=="Cuba"
	replace income_type="Developed Countries" if country=="Czech Republic"
	replace income_type="Developing Countries" if country=="Ecuador"
	replace income_type="Developing Countries" if country=="Egypt, Arab Rep."
	replace income_type="Developed Countries" if country=="Finland"
	replace income_type="Developed Countries" if country=="France"
	replace income_type="Developing Countries" if country=="Gabon"
	replace income_type="Developing Countries" if country=="Georgia"
	replace income_type="Developed Countries" if country=="Germany"
	replace income_type="Developing Countries" if country=="Ghana"
	replace income_type="Developed Countries" if country=="Greece"
	replace income_type="Developed Countries" if country=="Greenland"
	replace income_type="Developing Countries" if country=="Guatemala"
	replace income_type="Developing Countries" if country=="Guyana"
	replace income_type="Developing Countries" if country=="Honduras"
	replace income_type="Developed Countries" if country=="Hungary"
	replace income_type="Developed Countries" if country=="Iceland"
	replace income_type="Developing Countries" if country=="India"
	replace income_type="Developing Countries" if country=="Indonesia"
	replace income_type="Developing Countries" if country=="Iran, Islamic Rep."
	replace income_type="Developing Countries" if country=="Iraq"
	replace income_type="Developed Countries" if country=="Italy"
	replace income_type="Developed Countries" if country=="Ireland"
	replace income_type="Developed Countries" if country=="Japan"
	replace income_type="Developing Countries" if country=="Jordan"
	replace income_type="Developing Countries" if country=="Kenya"
	replace income_type="Developed Countries" if country=="Latvia"
	replace income_type="Developing Countries" if country=="Libya"
	replace income_type="Developing Countries" if country=="Lithuania"
	replace income_type="Developing Countries" if country=="Malaysia"
	replace income_type="Developing Countries" if country=="Mauritania"
	replace income_type="Developing Countries" if country=="Mexico"
	replace income_type="Developing Countries" if country=="Mongolia"
	replace income_type="Developing Countries" if country=="Morocco"
	replace income_type="Developing Countries" if country=="Myanmar"
	replace income_type="Developing Countries" if country=="Nepal"
	replace income_type="Developed Countries" if country=="New Zealand"
	replace income_type="Developing Countries" if country=="Nicaragua"
	replace income_type="Developed Countries" if country=="Norway"
	replace income_type="Developed Countries" if country=="Oman"
	replace income_type="Developing Countries" if country=="Pakistan"
	replace income_type="Developed Countries" if country=="Panama"
	replace income_type="Developing Countries" if country=="Paraguay"
	replace income_type="Developing Countries" if country=="Peru"
	replace income_type="Developing Countries" if country=="Philippines"
	replace income_type="Developed Countries" if country=="Poland"
	replace income_type="Developed Countries" if country=="Portugal"
	replace income_type="Developed Countries" if country=="Romania"
	replace income_type="Developing Countries" if country=="Russian Federation"
	replace income_type="Developing Countries" if country=="Senegal"
	replace income_type="Developing Countries" if country=="Serbia"
	replace income_type="Developed Countries" if country=="Spain"
	replace income_type="Developing Countries" if country=="Sri Lanka"
	replace income_type="Developing Countries" if country=="Suriname"
	replace income_type="Developed Countries" if country=="Sweden"
	replace income_type="Developing Countries" if country=="Tanzania"
	replace income_type="Developing Countries" if country=="Thailand"
	replace income_type="Developing Countries" if country=="Tunisia"
	replace income_type="Developing Countries" if country=="Turkiye"
	replace income_type="Developing Countries" if country=="Turkmenistan"
	replace income_type="Developing Countries" if country=="Ukraine"
	replace income_type="Developed Countries" if country=="United Arab Emirates"
	replace income_type="Developed Countries" if country=="United Kingdom"
	replace income_type="Developed Countries" if country=="United States"
	replace income_type="Developed Countries" if country== "Uruguay"
	replace income_type="Developing Countries" if country=="Uzbekistan"
	replace income_type="Developing Countries" if country=="Vietnam"
	replace income_type="Developing Countries" if country=="Zambia"
	replace income_type="Developing Countries" if country=="Zimbabwe"
	replace income_type="Developing Countries" if income_type=="Developing Countries" 
	
	encode income_type, gen(income_type1)
	drop income_type
	rename income_type1 income_type
	drop income_type
	
	drop if cc=="UGA"
	drop if cc=="VUT"


	preserve 
		duplicates drop country, force
		keep c_id country
		gen sample=""
		export delimited "../Data/90_Countries/latest_dataset/sample_country.csv", replace
	restore

**#Keep countries (20 Developed and 40 Developing Countries)
	**Import sample country
	tempfile raw
	save `raw'
	insheet using "../Data/90_Countries/latest_dataset/sample_country_20.csv", clear names
	merge 1:m country using  `raw', nogen 
	
	keep if sample==1
	drop sample
	
	label def developed_status 1 "Developed Countries" 0 "Developing Countries", modify
	lab val developed_status developed_status
	
	xx
//	duplicates drop country , force
	
//	ta developed_status
	
**variable generation
	*net exports
	gen net_fdi = fdinf - fdout
	drop fdinf fdout v6
	drop tech_exp debt investment aid
	
/*
	keep if country=="Australia" | country=="Sweden" | country=="Poland" | ///
	country=="Croatia" | country== "Greenland" | country== "Greece" | ///
	country== "United Kingdom" | country=="United States" | country=="Ireland" | ///
	country=="Norway" | country=="Austria" | country=="Canada" | country=="Oman" | ///
	
	country=="France" | country=="Spain" | country=="Italy" | country=="Japan" | ///
	
	country=="New Zealand" | country=="Germany" | country=="Portugal" | ///
	
	country=="Indonesia" | country=="Guyana" | country=="Libya" | country=="Paraguay" | ///
	country=="Guatemala" | country=="China" | country=="Thailand" | country=="Iraq" | ///
	
	country=="Bulgaria" | country=="Serbia" | country=="Turkey" | country=="Cuba" | ///
	
	country=="Turkmenistan" | country=="Ecuador" | country=="Peru" | country=="Namibia" | ///
	
	country=="Malaysia" | country=="Iran" | country=="Mexico" | country=="Kazakhstan" | ///
	
	country=="Russia" | country=="Argentina" | country=="Senegal" | country=="Egypt" | ///
	
	country=="Tunisia" | country=="Bolivia" | country=="Bangladesh" | country=="Vietnam" | ///
	country=="Kenya" | country=="Uzbekistan" | country=="Mongolia" | country=="Zimbabwe" | ///
	country=="Pakistan" | country=="India" | country=="Myanmar" | country=="Cambodia" | ///
	country=="Sri Lanka" | country=="Ukraine" | country=="Algeria" | country=="Philippines"
	*Namibia Kazakhstan 
 */
	


	
	**#D. Data Save
		save "../../Data/Data/clean/dataset_without_percapita.dta", replace 
		
		
**#C. Data Analysis
	
	*declare dataset as panel series
	xtset c_id year	
	encode cc, gen (country_code)
	xtset country_code year	
	
/**# Drop all missing values
	drop if missing( gdp_pc )
	drop if missing(tot_cap_stock)
	drop if missing(labor)
	drop if missing(exp) 
	drop if missing(life)
	drop if missing(resc_rent)
	drop if missing(net_fdi)
	
*/
/** Generate missing values to make balance panel

	bysort c_id: ipolate gdp_pc year, gen(gdp_pc1)
	bysort c_id: ipolate tot_cap_stock year, gen(tot_cap_stock1)
	bysort c_id: ipolate labor year, gen(labor1)
	bysort c_id: ipolate exp year, gen(exp1)
	bysort c_id: ipolate life year, gen(life1)
	bysort c_id: ipolate resc_rent year, gen(resc_rent1)
	bysort c_id: ipolate net_fdi year, gen(net_fdi1)

	drop gdp_pc tot_cap_stock labor exp life resc_rent net_fdi
	
	
	rename gdp_pc1 gdp_pc 
	ren tot_cap_stock1 tot_cap_stock
	ren labor1 labor
	ren exp1 exp
	ren life1 life
	ren resc_rent1 resc_rent
	ren net_fdi1 net_fdi
	
	sort c_id year
	*/
	*log tranformation
	gen lgdp_pc			= log( gdp_pc)
	gen ltot_cap_stock 	= log( tot_cap_stock )
	gen llf 			= log( labor )
	gen lg_exp 			= log( exp )
	gen l_life 			= log(life)
	gen l_resc 			= log(resc)
	gen l_net_fdi		= log(net_fdi)
	

*first difference to make stationary
	
	gen dgdp_pc	= d.gdp_pc
	gen dtot_cap_stock 	= d.tot_cap_stock
	gen dlabor 			= d.labor
	gen dexp 			= d.exp
	gen dlife 			= d.life
	gen dresc 			= d.resc
	gen dnet_fdi		= d.net_fdi


	**#D. Data Save
		save "../../Data/Data/clean/dataset_without_percapita.dta", replace 
		//export excel dataset_without_percapita.xlsx, firstrow(varlabels)



	
**	LM-test (lagrange multiplier test)
** Hypothesis of LM test: variance across entities is zero (no significance difference accoss unit, no panel efffect)


*******************************For Developing****************************
 u "../../Data/Data/clean/dataset_without_percapita.dta", clear
	keep if developed_status==0	
	
	
	*****************panel unit root test***********************
	
*##Step 1: Define the data as panel data in STATA
	xtset c_id year

*##Step 2: Run the unit root test(s) "on level" data in STATA
	xtunitroot ips lgdp_pc
	

		*without trend at level
		
		xtunitroot ips gdp_pc, lags(1) 				
		xtunitroot ips tot_cap_stock, lags(1) 
		xtunitroot ips labor, lags(1)
		xtunitroot ips exp, lags (1)
		xtunitroot ips life, lags  (1)
		xtunitroot ips resc, lags (1)
		xtunitroot ips net_fdi, lags (1) 	
	
	
	*******************************For Developed****************************
 u "../../Data/Data/clean/dataset_without_percapita.dta", clear
	keep if developed_status==1
	
	
	*****************panel unit root test***********************
	
*##Step 1: Define the data as panel data in STATA
	xtset c_id year

*##Step 2: Run the unit root test(s) "on level" data in STATA
	

		*without trend at level
		
		xtunitroot ips gdp_pc, lags(1) 				
		xtunitroot ips tot_cap_stock, lags(1) 
		xtunitroot ips labor, lags(1)
		xtunitroot ips exp, lags (1)
		xtunitroot ips life, lags  (1)
		xtunitroot ips resc, lags (1)
		xtunitroot ips net_fdi, lags (1) 
	
	
	
	
	
 
		*with trend at level
		
		xtunitroot ips gdp_pc, trend lags(1) 					
		xtunitroot ips tot_cap_stock , trend lags(1)
		xtunitroot ips labor, trend lags(1)
		xtunitroot ips exp, trend lags(1)
		xtunitroot ips life, trend lags(1)
		xtunitroot ips resc, trend lags(1)
		xtunitroot ips net_fdi, trend lags(1)

xx		
		
	**# at first difference	
		*with trend 
		xtunitroot ips dgdp_pc 			 , trend
		xtunitroot ips dtot_cap_stock 	 , trend
		xtunitroot ips dlabor			 , trend
		xtunitroot ips dexp 			 , trend
		xtunitroot ips dlife 			 , trend 
		xtunitroot ips dresc 			 , trend
		xtunitroot ips dnet_fdi			 , trend
		
		*without trend at first difference
		xtunitroot ips dgdp_pc		  
		xtunitroot ips dtot_cap_stock 	  
		xtunitroot ips dlabor				  
		xtunitroot ips dexp 			  
		xtunitroot ips dfdinf			   
		xtunitroot ips dfdout 			  
		xtunitroot ips dlife 			   			  
		xtunitroot ips dresc 
		xtunitroot ips dnet_fdi	


	****Johansen conintegration

		vecrank lgdp ltot_cap_stock llf lg_exp l_tech_exp l_resc l_fdinf l_fdout, trend(constant) max
*/

	*Cobb-doglus production function estimation 
	*(LogA= constant term, alpha= coefficient of labor force,
	**beta= coefficient of capital stock )
	
	*for developing countries
	xtreg lgdp_pc ltot_cap_stock llf lg_exp l_life l_resc l_net_fdi ///
	if developed_status==0
		
	*for developed countries
	xtreg lgdp_pc ltot_cap_stock llf lg_exp l_life l_resc l_net_fdi ///
	if developed_status==1
	
				
xx
**** ****************Dataset with per capita variables**********************************
***************************************************************************************	
	u "../../Data/Data/clean/dataset_without_percapita.dta", clear 

	**gen variables
	
	gen cap_stock_pc = tot_cap_stock/labor
	gen exp_pc = exp/labor
	gen life_pc = life/labor
	gen resc_rent_pc = resc_rent/labor 
	gen net_fdi_pc = net_fdi/labor
	
	save "../../Data/Data/clean/dataset_with_percapita.dta", replace 
xx	
**#C. Data Cleaning
	*Reshape Panel Data
	/* Description: 
		
	
	
	reshape long yr, i(c_id s_id) j(year)
	drop SeriesName
	drop SeriesCode 
	reshape wide yr, i(c_id year) j(s_id)
	drop country
	rename CountryName country
	rename CountryCode cc
	move country year
	move cc year
	drop yr13
*/
	
	/***Label Variables

	label variable yr1 "Central government debt, total (current LCU)"
	rename yr1 debt 
	 
	label variable yr2 "Exports of goods and services (current US$)"
	rename yr2 exp
	
	label variable yr3 "Foreign direct investment, net inflows (% of GDP)"
	rename yr3 fdinf
	
	label variable yr4 "Foreign direct investment, net outflows (% of GDP)"
	rename yr4 fdout
	
	label variable yr5 "GDP per capita (current US$)"
	rename yr5 gdp_pc
	
	label variable yr6 "High-technology exports (% of manufactured exports)"
	rename yr6 tech_exp
	
	label variable yr7 "Labor force, total"
	rename yr7 labor
	
	label variable yr8 "Life expectancy at birth, total (years)"
	rename yr8 life
	
	label variable yr9 "Net investment in nonfinancial assets (% of GDP)"
	rename yr9 investment
	
	label variable yr10 "Net official aid received (current US$)"
	rename yr10 aid
	
	label variable yr11 "total capital stock (in billions of nominal national currency)"
	rename yr11 tot_cap_stock
	
	label variable yr12 "Total natural resources rents (% of GDP)"
	rename yr12 resc_rent
	
	order c_id country cc year gdp_pc tot_cap_stock labor exp tech_exp fdinf fdout life debt investment aid resc_rent
	
	*Save 
	compress
	save "../Data/90_Countries/latest_dataset/90_countries_cleaned.dta", replace
	
	*/

	
	
	
	
	
/*
	*Define the text you want to remove
	local to_remove "tot_cap_stockinbillionsof"

	*Loop through all the variables and remove the text
	foreach var of varlist * {
		local new_varname : subinstr local var "${to_remove}", "", .
		rename `var' `new_varname'
	}
	
	foreach var of varlist _all {
	loc label : var lab `var'
	loc newla = subinstr("`label'", "tot_cap_stockinbillionsof", "", .)
	label variable `var' "`newla'"
	}
*/