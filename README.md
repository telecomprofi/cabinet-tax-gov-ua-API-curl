# cabinet-tax-gov-ua-API-curl

Quick bash/curl/oneliner to check if there is Tax Debt in your cabinet


### 0. Extarct your AUTH data from Chrome Developers Tools after successful authentication on https://cabinet.tax.gov.ua/ on cabinet.tax.gov.ua with pb<your-tax-id>.jks or Key6.dat.
  it should look like below - notice it starts with 'MIINE' and ends with '==':
```
  oauth/token?grant_type=password&username=<your-tax-id-twice>&password=
  MIINEQYJKoZIhvcNAQcCoIINAjCCDP4CAQExDjAMBgoqhiQCAQEBAQIBMBkGCSqGSIb3DQEHAaAMBAoyNzMyMDA5MDE0oIIFdjCCBXIwggUaoAMCAQICFCtsffmjiR2hBAAAAPMMWwCEGnoCMA0GCyqGJAIBAQEBAwEBMIHxMWswaQYDVQQKDGLQkNCa0KbQhtCe0J3QldCg0J3QlSDQotCe0JLQkNCg0JjQodCi0JLQniDQmtCe0JzQldCg0KbQhtCZ0J3QmNCZINCR0JDQndCaIMKr0J/QoNCY0JLQkNCi0JHQkNCd0JrCuzERMA8GA1UECwwI0JDQptCh0JoxNDAyBgNVBAMMK9CQ0KbQodCaINCQ0KIg0JrQkSDCq9Cf0KDQmNCS0JDQotCR0JDQndCawrsxGTAXBgNVBAUMEFVBLTE0MzYwNTcwLTIwMTgxCzAJBgNVBAYTAlVBMREwDwYDVQQHDAjQmtC40ZfQsjAeFw0yMTA5MDgwODQ2NTVaFw0yMjA5MDgyMDU5NTlaMIH9MSIwIAYDVQQKDBnQpNCG0JfQmNCn0J  < skipped  a lot >  0YzQvdC40Lkg0L7RgNCz0LDQvTEZMBcGA1UEBQwQVUEtMDAwMTU2MjItMjAxNzELMAkGA1UEBhMCVUExETAPBgNVBAcMCNCa0LjRl9CyAhQ9tz578NV1sgIAAAABAAAAqAAAADANBgsqhiQCAQEBAQMBAQRAPgrTd1T940Ci9uy4e8DTYx+1ewD39bk/Ct5leb+vKwGnqqpP023gZOlZoCpsQeZVX/n6XQdix3Yrj3vbQ6+KITANBgsqhiQCAQEBAQMBAQRAZ11aQsO+3Sl8qHla7WDbSYFtp8T/U8MSjbBhgNqv5QJWVW6lGtqOWu+/kftPdi5H3wH4/WddiwTIC/UuIPScSg==
```

  ### 1. check if that is valid Auth string by  decoding it with base64 cli tool
  
```
echo <MIINE kjhdkjbjhho xjbsjb> | base64 -d 

```
  output of base64 should contain some Ukrainian text about the tax id owner (since it is concatenation of your TaxID signed by your digital Ceritficate and then encoded in base64)
  
 ### 2. curl or create GET in Postman the following URL and paste authorization string into -d Authorization " " header
```
  curl 'https://cabinet.tax.gov.ua/ws/public_api/ta/splatp?year=2021' -H 'Content-Type: application/json' \
                -H 'Authorization:' < put your Athorization string here >' \
                -H 'Accept: application/json' | jq 
```
###  3. if you would like to extract any filed - filter in jq with .[0].payerName (or other JSON key):
```
  | jq .[0].payerName
```

  Response contains array of two set of fields - one for "Єдиний Податок" and the second one for "Єдиний Соціальний внесок" for chosen year (?
  To understand if you do not have a tax debt check following fileds.
  In general filds  "narah0": and  "splbd0": should be equal
  and there should not be (0) of debtAll:0
  
  
### 4.  How does API respose look like:
```
  [
    {
        "idpmnt": "<some id skipped>",
        "yearoper": 2021,
        "cSti": <skipped>,
        "nameSti": "ГУ ДПС У ЛЬВІВСЬКІЙ ОБЛ. (ШЕВЧЕНКІВСЬКИЙ Р-Н М.ЛЬВОВА)",
        "facemode": 2,              # Your Taxation group I believe as Private Enterpreneur
        "tinS": "<your tax id>",
        "payerName": "ПЕТРЕНКО ПЕТРО ПЕТРОВИЧ",
        "plat1": "<skipped>",
        "shot": <skiped>,
        "st": 1,
        "budgetTin": <skipped>,
        "budgetPayerName": "ГОЛОВНЕ УДКСУ У ЛЬВІВСЬКІЙ ОБЛАСТІ",
        "budgetMfo": <skipped>,
        "budgetBankName": "Казначейство України(ел. адм. подат.)",
        "budgetAccount": null,
        "budgetAccountIban": "UA000000 skipped",
        "namePlt": "ЄДИНИЙ ПОДАТОК З ФIЗИЧНИХ ОСIБ",
        "narah0": <$$$$$.$$>,       # how much Tax office believs you have to pay based on your income & tax code
        "splbd0": <$$$$.$$>,        # how much did you pay in UAH
        "povbd0": 0,
        "penia0": 0,
        "nedoim0": 0,
        "perepl0": <$$$$.$$>,        # How much have you over paid
        "sldpn0": 0,
        "debtAll": 0,
        "narahFuture": 0,
        "narahEnd": <$$$$.$$>,
        "splbdEnd": <$$$$$.$$>,
        "povbdEnd": 0,
        "peniaEnd": 0,
        "nedoimEnd": 0,
        "pereplEnd": <$$$$.$$>,
        "debtAllEnd": 0,
        "dateSpl": null,
        "paType": 0
    },
    {
        "idpmnt": "Some id goes here ",
        "yearoper": 2021,
        "cSti": <some id>,
        "nameSti": "ГУ ДПС У ЛЬВІВСЬКІЙ ОБЛ. (ШЕВЧЕНКІВСЬКИЙ Р-Н М.ЛЬВОВА)",
        "facemode": 2,
        "tinS": "<Your Tax ID will be here>",
        "payerName": "ПЕТРЕНКО ПЕТРО ПЕТРОВИЧ",
        "plat1": "Skipped",
        "shot": <skipped>,
        "st": 0,
        "budgetTin": <skiped>,
        "budgetPayerName": "ГОЛОВНЕ УПРАВЛІННЯ ДПС У ЛЬВІВСЬКІЙ ОБЛАСТІ",
        "budgetMfo": <skipped>,
        "budgetBankName": "Казначейство України(ел. адм. подат.)",
        "budgetAccount": null,
        "budgetAccountIban": "UA<skipped",
        "namePlt": "ДЛЯ ФIЗ.ОСIБ - ПIДПР, У Т.Ч. ЯКI ОБРАЛИ СПР. СИСТ. ОПОДАТК.ТА ОСIБ, ЯКI ПРОВОДЯТЬ НЕЗАЛЕЖНУ ПРОФ. ДI",
        "narah0": 0,
        "splbd0": <$$$$>,
        "povbd0": 0,
        "penia0": 0,
        "nedoim0": 0,
        "perepl0": <$$$$>,
        "sldpn0": 0,
        "debtAll": 0,
        "narahFuture": 0,
        "narahEnd": 0,
        "splbdEnd": <$$$$>,
        "povbdEnd": 0,
        "peniaEnd": 0,
        "nedoimEnd": 0,
        "pereplEnd": <$$$$.$$>,
        "debtAllEnd": 0,
        "dateSpl": null,
        "paType": 4
    }
]
  
```
  
  
  
  
  
  
