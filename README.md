# Chromium-StoreLeak
This repository contains a basic Proof of Concept for the StoreLeak vulnerability in Chromium-based browsers.
## Description
The StorLeak vulnerability is a sensitive information exposure vulnerability in Chromium-based browsers, which Google did not approve. It was not approved as it is not part of the scope relevant to Chromium. However, it can still be used to target victims and compromise accounts.
## Usage
### Import the script
In PowerShell, load the script:
```powershell
Import-Module .\ChromiumStoreLeak.ps1
```
### Basic Usage
To run the script against Session Storage, run the following:
```powershell
Invoke-ChromiumStoreLeak -Browser <Browser> -Storage Session
```
To run the script against Local Storage, run the following:
```powershell
Invoke-ChromiumStoreLeak -Browser <Browser> -Storage Local
```
### Save Information in Log Files
The script also provides an option to store the output to a file for later review:
```powershell
Invoke-ChromiumStoreLeak -Browser  <Browser> -Storage <Storage> -OutFile '.\storage-log.txt'
```
## Disclaimer
This tool is intended solely for use on machines that you own or have explicit permission to test. Unauthorised usage without consent is illegal and strictly prohibited.
By using this tool, you agree to comply with all relevant laws and your organization's security policies. The authors are not responsible for misuse or any damage caused by this tool.
## License
MIT License<br>
Author: Idabian
