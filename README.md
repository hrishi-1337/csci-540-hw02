# CSCI 540: HW02

## Data

- Open 'Food_Display_Table' and 'Foods_Needing_Condiments_Table' in excel

- Go to File -> Options -> Advanced -> Editing Section

- Uncheck the “Use system separators” setting and put a comma in the “Decimal Separator” field.

- Save them in 'CSV UTF-8' format. Resulting files will be semi-colon seperated.

- Save the .csv files in /data folder within csci-540-hw02

## Running

start:

	docker run --rm -d -p 8080:8080 --volume "${PWD}:/mnt" --name hw2  adv-db/hbase

bash:

	docker exec -it hw2 bash

shell:

	docker exec -it hw2 hbase shell $1

stop:

	docker stop hw2

## Part 1:

Run below commands in bash

### Create table

	hbase shell /mnt/part1/create.rb


### Load data:

	hbase shell /mnt/part1/load.rb


### Queries:

	hbase shell /mnt/part1/query.rb

## Part 2:

### Create table

	hbase shell /mnt/part2/create.rb


### Load data:

	hbase shell /mnt/part2/load.rb


### Queries:

	hbase shell /mnt/part2/query.rb