create domain StringM as varchar(100);

create domain StringM_not_null as StringM
	check (value is not null);
	
create domain Civico_not_null as StringM
	check (isCivico(value) and value is not null );

drop type if exists Euro;

create domain Euro as real
	check (value >= 0);
	
create type Ind as (
	via StringM_not_null,
	civico Civico_not_null
);

create domain IntegerGZ as integer
	check(value > 0);
	
create domain IntegerGEZ as integer
	check(value >= 0);

create domain CF as varchar(16)
	check(isCF(value));
