--Creator: Naomi Generoso Faustino (02/2019)
-- COMMENTS ARE ALWAYS IMPORTANT BECAUSE THEY HELP THE READER (CODE EXECUTER) WHAT HE NEEDS TO DO OR PAY ATTANTION

-- FIRST RULE - ALWAYS STATE IN THE BEGINNING WHAT THE READER (CODE EXECUTER) WILL NEED TO CHANGE 
-- REMEBER TO DO IT IN THE EXACT ORDER OF THE CODE
	
	-- 1º: Never forget to update all the dates of this code.
	
-- 1. Manipulating a raw data base
-- 1.1. Step 1: Getting access information, adding and transposing.
create table server.data_base1 as select
updatingdate
cast(code_id as bigint) as code_id, -- changing string to bigint (integer).
category_lvl1, 
category_lvl2,
amount_201802,
amount_201801,
amount_201712,
amount_201711,
	sum(amount_201802 + amount_201801 + amount_201712 + amount_201711) as sum_amount
		from 		(select
	-- Always keep the dates updated.
	case when code_id not in ('') then 20180221 -- doing this so i can know this what the day that i updated the database.
	else null
	end as updating_date,
	code_id,
	case when code_id not in ('') then 'ORIGIN' -- creating a colum so i can know this line category on level 1
	else null
	end as category_lvl1,
	category_lvl2,
	nvl (cast(amount_201802 as bigint), 0) as amount_201802, -- changing string to bigint (integer).
	nvl (cast(amount_201801 as bigint), 0) as amount_201801, -- changing string to bigint (integer).
	nvl (cast(amount_201712 as bigint), 0) as amount_201712, -- changing string to bigint (integer).
	nvl (cast(amount_201711 as bigint), 0) as amount_201711, -- changing string to bigint (integer).
		from(select
		code_id,
		category_lvl2,
	-- Always keep the dates updated.
		sum(group_map['201802']) as amount_201802, -- adding up as a column lines that has this reference
		sum(group_map['201801']) as amount_201801, -- adding up as a column lines that has this reference
		sum(group_map['201712']) as amount_201712, -- adding up as a column lines that has this reference
		sum(group_map['201711']) as amount_201711, -- adding up as a column lines that has this reference
	from (select
				code_id,
				category_lvl2,
				map(aaaamm_acess;amountacess) as group_map -- creating a map (ref;value) so i can develop the columns  refering to the dates inside aaaamm_acess
	from(select
			code_id, 
			aaaamm_acess,
			category_lvl2,
			count(category_lvl2) as amountacess -- counting amount of acess
		from (select 
					substr(post_evar22,1,9) as code_id, 
					substr(yearmonthday,1,6) as aaaamm_acess,
					case when something in ('') then 'categorytype1'
					else null
					end as category_lvl2
					from server.raw_data_base
					where something in () -- filtros
					and (20171101<=yearmonthday<=20180201) -- getting info only inside this range of dates
					and raw_codeid not in ('')) a 
			group by code_id, aaaamm_acess, category_lvl2
			order by code_id, category_lvl2)b) c group by code_id, category_lvl2)d)e
			group by updating_date, code_id, category_lvl1, category_lvl2, amount_201802, amount_201801, amount_201711, amount_201712;
		
-- 1.2. Performing a left join so I can getinformationg from other another datase
create table server.final_databe as select
a.*,
b.rcnt_acess,
b.old_acess,
from server.anotherdatabase as left join
(select 
	cast(code_id as bigint) as code_id, 
	category_lvl2,
	max(yearmonthday) as rcnt_acess, 
	min(yearmonthday) as old_acess,
		from(select
		substr(raw_codeid,1,9) as code_id, 
		yearmonthday,
					case when something in ('') then 'categorttype2'
					else null
					end as category_lvl2
					from server.anotherrawdatabase
					where something in () -- filtros
					and (20171101<=anomesdia<=20180201) 
					and raw_codeid not in ('')) a 		
			group by code_id, category_lvl2
			order by code_id, category_lvl2)
			as b on a.code_id=b.code_id and a.category_lvl2=b.category_lvl2;
			

			
-- You can  do this with different databases and then join them with a union all:

create table server.anotherdatabase2 as select
*
from(select *
from server.data_base0 as a union all select * from server.data_base1 as b union all select* from server.final_databe as c) as d
order by code_id, category_lvl2;

drop tabelitchas