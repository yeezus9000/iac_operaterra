# iac_operaterra

Det som trengs:

* En resource group for state storage account. Denne må hete `${project_name}-global"`
  * For å få denne koden til å funke med github actions må den hete `akseles-operaterra-global` eller så må man oppdatere terraform.yaml filen der dette er hardkodet inn (sorry)
    ![alt text](image-1.png)
* En vilkårlig navngitt state storage account, med en vilkårlig navngitt container, og begge disse lagret som secrets i github
* Diverse secrets, se skjermbilde:
    ![alt text](image.png)
