# cabinet-tax-gov-ua-API-curl
Quick bash/curl/oneliner to check if there is Tax Debt in your cabinet

### 0. Extarct your AUTH data from Chrome Developers Tools after successful authentication on https://cabinet.tax.gov.ua/ on cabinet.tax.gov.ua with pb<your-tax-id>.jks or Key6.dat.
  it should look like this:
  ```
  oauth/token?grant_type=password&username=<your-tax-id-twice>&password=
  MIINEQYJKoZIhvcNAQcCoIINAjCCDP4CAQExDjAMBgoqhiQCAQEBAQIBMBkGCSqGSIb3DQEHAaAMBAoyNzMyMDA5MDE0oIIFdjCCBXIwggUaoAMCAQICFCtsffmjiR2hBAAAAPMMWwCEGnoCMA0GCyqGJAIBAQEBAwEBMIHxMWswaQYDVQQKDGLQkNCa0KbQhtCe0J3QldCg0J3QlSDQotCe0JLQkNCg0JjQodCi0JLQniDQmtCe0JzQldCg0KbQhtCZ0J3QmNCZINCR0JDQndCaIMKr0J/QoNCY0JLQkNCi0JHQkNCd0JrCuzERMA8GA1UECwwI0JDQptCh0JoxNDAyBgNVBAMMK9CQ0KbQodCaINCQ0KIg0JrQkSDCq9Cf0KDQmNCS0JDQotCR0JDQndCawrsxGTAXBgNVBAUMEFVBLTE0MzYwNTcwLTIwMTgxCzAJBgNVBAYTAlVBMREwDwYDVQQHDAjQmtC40ZfQsjAeFw0yMTA5MDgwODQ2NTVaFw0yMjA5MDgyMDU5NTlaMIH9MSIwIAYDVQQKDBnQpNCG0JfQmNCn0J  < skipped  a lot >  0YzQvdC40Lkg0L7RgNCz0LDQvTEZMBcGA1UEBQwQVUEtMDAwMTU2MjItMjAxNzELMAkGA1UEBhMCVUExETAPBgNVBAcMCNCa0LjRl9CyAhQ9tz578NV1sgIAAAABAAAAqAAAADANBgsqhiQCAQEBAQMBAQRAPgrTd1T940Ci9uy4e8DTYx+1ewD39bk/Ct5leb+vKwGnqqpP023gZOlZoCpsQeZVX/n6XQdix3Yrj3vbQ6+KITANBgsqhiQCAQEBAQMBAQRAZ11aQsO+3Sl8qHla7WDbSYFtp8T/U8MSjbBhgNqv5QJWVW6lGtqOWu+/kftPdi5H3wH4/WddiwTIC/UuIPScSg==```
### 1. check if that is valdid by 
```echo <MIIME xjbsjbjbjbjj> | base64 -d 
```
  - output should contain some Ukrainian text about tax id owner
### 2. curl the following URL and paste authorization string into -d Authorization " " header
```
  curl https://cabinet.tax.gov.ua-H 'Content-Type: application/json' \
                -H 'Authorization:' < put your Athorization string here >' \
                -H 'Accept: application/json' | jq 
```
###  if you would like to extract any filed - filter in jq with .[0].payerName (or other JSON key):
```
  | jq .[0].payerName
```
