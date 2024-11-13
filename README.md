# iac oblig 2

## Hvilke data trengs på forhånd

For å deploye infrastrukturen trengs en subscription, tenant, og client id, samt en client secret (passord). Disse kan lagres som GitHub secrets (anbefales virkelig virkelig) eller fylles ut (hardkodes) i terraform.yaml og global.yaml hvis man ønsker å kjøre GitHub workflows ved en fork eller noe sånt. Det samme gjelder for `STORAGE_ACCOUNT_NAME` som er en eller annen vilkårlig SA som brukes for persistent storage for state. Denne må ha en `STORAGE_ACCOUNT_CONTAINER` som må navngis som en secret eller i terraform.yaml (eller manuelt hvis du kjører alt fra kommandolinjen.) Man kan bruke SA og container man har fra før, eller lese neste kapittel for hvordan å generere dette selv.

```yaml
env:
  ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID || '' }}
  ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID || '' }}
  ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID || '' }}
  ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET || '' }}
  STORAGE_ACCOUNT_NAME: ${{ secrets.STORAGE_ACCOUNT_NAME || '' }}
  # ^ trengs å fylles ut
  # v forhåndsutfylt med forventede verdier, og eksempler hvis man ikke vil lage resten av secrets
  STORAGE_ACCOUNT_CONTAINER: ${{ secrets.STORAGE_ACCOUNT_CONTAINER || 'tfstate' }}
  PROJECT_NAME: ${{ secrets.PROJECT_NAME || 'akseles-operaterra' }}
  GLOBAL_RESOURCE_GROUP: ${{ secrets.GLOBAL_RESOURCE_GROUP || 'akseles-operaterra-global' }}
  DATABASE_ADMIN_USER: ${{ secrets.DATABASE_ADMIN_USER || '4dm1n157r470r' }}
  DATABASE_ADMIN_PASSWORD: ${{ secrets.DATABASE_ADMIN_PASSWORD || '4-v3ry-53cr37-p455w0rd' }}

```

Fra oppgaveteksten: "NOTE! It should be written so flexible that learning assistant or teacher could deploy this resources based on small changes, like change subscription ID." Sorry jeg ser ingen trygg måte å deploye denne koden uten bruk av GitHub secrets når vi også har fått beskjed av TIM om å ikke under noen omstendigheter lagre azure sensitive data sammen med prosjektkoden...

## Lage ny storage account

`global/main.tf` tar inn argumenter, lager en SA og container, og skriver de ut til brukeren som output. Scriptet er ment å kun kjøres ved behov. En workflow (`.github/global.yaml`) med manuell trigger kan kjøres fra GitHub eller man kan kjøre apply `global/main.tf` manuelt fra kommandolinjen. Ta vare på output da dette brukes av CI/CD workflowen `.github/terraform.yaml`.

## CI/CD

Miljøet er designet for å iveretas i tre branches (prod/staging/dev) med en workflow som trigges på push til hver branch. Først vil relevante filer formateres, lintes og security screenes* og hvis de består vil infrastrukturen implementeres i et miljø uavhengig av de andre for denne branchen**. Dev og staging auto applies mens prod settes i et GitHub environment, der man kan sette opp regler som bestemmer hvordan utrullingen håndteres. Jeg har slått på at en navngitt bruker (meg) må godkjenne før endringen settes igang.

\* Jeg har skrudd av exit code 1 on error for security screeningen fordi jeg ikke klarte å bestå helt uten videre. Det er en oppgave for meg en gang jeg har betydelig mer tid, men POC er tilstede, og bygd inn i arbeidsflyten. Screeningen gjøres likevel, og man kan lese resultatet i loggen, men stopper ikke deployment.

\** State for alle branches skrives til individuelle filer i en global storage account container, så det er persistent uavhengig av hvor/hvem/når branchen pushes. Hver branch har et live miljø med persistent state uansett.

![alt text](image.png)

Overse commit-navnet (lol) men på [mitt offentlige repo](https://github.com/yeezus9000/iac_operaterra/actions/runs/11820921895) kan man se pipelines som har kjørt og lese loggene hvis det er noe tvil om at workflowen funker osv.

## tfvars

Det ligger tre separate tfvars filer, som har de fleste variabelverdien kommentert vekk. Har beholdt én for demonstration purposes. CI/CD scriptet leser *nødvendige* variabler, og alle relevante variabler får tildelt default values i `deployments/variables.tf`, men CI/CD workflowen leser også var-file så man kan overskrive default verdiene (som demonstrert i tfvar filene).

## Hvorfor valgt denne mappestrukturen

Med en god CI/CD pipeline (jeg har fått til *en* pipeline, ikke nødvendigvis god) gir strukturen med alle filer i samme mappe men egne tfvars filer en veldig god oversikt over infrastrukturen du jobber med. Det er et stort WYSIWYG preg over det, med kunnskap om "hvis det funker i dev vil det svært sannsynligvis funke i prod også" og alt utvikleren må tenke på er å pushe branchen videre til staging, og videre til prod. Jeg er stor fan av systemet og føler det gir veldig oversikt. Jeg har ikke helt knekt koden med hva global/main.tf kunne hatt til potensiale. Jeg har brukt det for å opprette et global state storage område som er viktig for utviklingsledelsen, og jeg forstår det kan brukes til "ressurser som deles mellom alle branches" men jeg sliter med å se for meg infrasturktur vi ønsker å dele mellom alle branches? Separasjon er litt name of the game syns jeg.

## Utfordinger

Livet har mange utfordringer, tidsfrister og fantasi er noen av dem. Jeg jobbet litt framlengs, så baklengs, og til slutt gjorde jeg om hele prosjektet når jeg innså jeg spant i gjørma. Med prosjektfilene jeg leverer har jeg kun deployed med CI/CD workflowen. Som vil si at jeg har utviklet den workflowen paralellt med den faktiske infrastrukturen i prosjektet, og alle tester og deployments har vært ganske "tungvint" å dra igang. I tillegg har jeg rundt 200 uleste eposter om pipelines som feilet.

## Veien videre

Jeg tror ikke jeg er helt i mål egentlig. Jeg har jo ikke en app som funker med noe faktisk kode i seg, og jeg har ikke testet load balancing (eller helt forstått om jeg har fått de opp på beina) men ingenting feiler når jeg deployer plan, og alle ressursene dukker opp i azure portal når scriptene er ferdig. Alle modulene skulle være delt inn i egne subnet uten at jeg helt vet om "oppdragsgiver" ønsker seg dette, men uansett satt jeg meg fast, og det er det litt vanlig at jeg gjør. Så main.tf sender subnet_id til alle modulene men ingen av dem bruker de egentlig til noe. Det ville vært det neste jeg dunket hodet mot veggen på hvis jeg skulle fortsette.

Oppgaven er veldig interessant og jeg skulle gjerne drevet mer med det nå, men innleveringsfristen er farlig nær, så jeg tror jeg legger det fra meg. Jeg har heller ikke gjort noen skikkelige outputs fra depolyments mappa, men "jeg vet at jeg må outputte der for å få tilgang til det i konsollen" osv.
