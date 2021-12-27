#/env/bin/sh
# simple scipt that check your Ukrainian Tax Debt as Private Enterpreneur that pays no VAT
# usage:
# ./check-your-tax-debt.sh 2021 # where 2021 -is year you are interested in - might be current year for example
set -axv

[[ ! -n "$1" ]] && echo "Please provide Year for Tax check"&& exit 1

a="https://cabinet.tax.gov.ua/ws/public_api/ta/splatp?year=$1"

# curl Private API with pretty-print output in JSON format
curl $a -X GET \
-H 'Content-Type: application/json' \
                -H 'Authorization:' <inser your AUth strimg here > '\
                 -H 'Accept: application/json' | jq
                 
