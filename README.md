# CSCI 540: HW02

## Data

- Open 'Food_Display_Table' in excel

- Go to File -> Options -> Advanced -> Editing Section

- Uncheck the “Use system separators” setting and put a comma in the “Decimal Separator” field.

- Save 'Food_Display_Table' excel file as 'CSV UTF-8' file. Resulting file will be semi-colon seperated.

## Running

start:

	docker run --rm -d -p 8080:8080 --volume "${PWD}:/mnt" --name hw2  adv-db/hbase

bash:

	docker exec -it hw2 bash

shell:

	docker exec -it hw2 hbase shell $1

stop:

	docker stop hw2


## Create table

	create 'foods', { NAME => 'fact',BLOOMFILTER => 'ROW',COMPRESSION => 'GZ', VERSIONS =>org.apache.hadoop.hbase.HConstants::ALL_VERSIONS}


## Load data:

	hbase shell /mnt/part1/load.rb


## Queries:

	hbase shell /mnt/part1/queries.rb

	get 'foods', '13110120', 'fact'