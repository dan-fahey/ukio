ukio_2015.csv: 2015detailedioatsbb18.R 2015detailedioatsbb18.xlsx
	./$<

%.xlsx: %.xls
	libreoffice --convert-to xlsx $< --headless

2015detailedioatsbb18.xls:
	wget -O $@ https://www.ons.gov.uk/file?uri=%2feconomy%2fnationalaccounts%2fsupplyandusetables%2fdatasets%2fukinputoutputanalyticaltablesdetailed%2f2015detailed/2015detailedioatsbb18.xls

clean:
	rm -f *.xls *.xlsx *.csv
