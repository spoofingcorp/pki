---
marp: true
theme: ssr
markdown.marp.enableHtml: true
class:
#-   invert


---
<style>

img[alt~="center"] {
  display: block;
  margin: 0 auto;
}

</style>

<!-- _class: titre -->


# Certificats

---
<!-- _class: EnAvant -->



# Objectif des certificats
*  ## **La confiance !** 

---
## La confiance 

### Les clefs de la confiance

* Authentification de l'éméteur
* Authentification du recepteur
* Confidentialité 
* intégrité 

---
## La confiance 

### Les clefs de la confiance

- Authentification de l'éméteur
- Authentification du recepteur
- Confidentialité 
- intégrité 

### A prendre en compte : 

* Vitesse de traitement 


---
<!-- _class: i1t2 -->

### Cryptographie Symétrique 

![](./Images/CryptoSym.png)

![](Images/blanc.drawio.png)
![](Images/blanc.drawio.png)



<!--  Confidentialité / vitesse traitement-->

---
<!-- _class: i1t2 -->

### Cryptographie Symétrique 

![](./Images/CryptoSym.png)

![](Images/blanc.drawio.png)

![opacity:0.3 blur:2px](Images/emeteur.png)
![](Images/confidentialite.png)
![opacity:0.3 blur:2px](Images/integrite.png)
![opacity:0.3 blur:2px](Images/destinataire.png)
![](Images/vitesstTraitement.png)


<!--  Confidentialité / vitesse traitement-->


--- 
<!-- _class: i1t2 -->

### Cryptographie Asymétrique

![](Images/CryptoAsym.png)

![](Images/blanc.drawio.png)


<!-- confidentialité / authentification du destinataire  -->

--- 
<!-- _class: i1t2 -->

### Cryptographie Asymétrique

![](Images/CryptoAsym.png)

![opacity:0.3 blur:2px](Images/emeteur.png)
![](Images/confidentialite.png)
![opacity:0.3 blur:2px](Images/integrite.png)
![](Images/destinataire.png)
![opacity:0.3 blur:2px](Images/vitesstTraitement.png)



<!-- confidentialité / authentification du destinataire  -->


--- 
<!-- _class: i1t2 -->

### Fonction de hachage

![](Images/Hache.png)

![](Images/blanc.drawio.png)

<!-- intégrité  -->

--- 
<!-- _class: i1t2 -->

### Fonction de hachage

![](Images/Hache.png)

![opacity:0.3 blur:2px](Images/emeteur.png)
![opacity:0.3 blur:2px](Images/confidentialite.png)
![](Images/integrite.png)
![opacity:0.3 blur:2px](Images/destinataire.png)
![opacity:0.3 blur:2px](Images/vitesstTraitement.png)


<!-- intégrité  -->


--- 
<!-- _class: i1t2 -->

### Asymétrique + Symétrique

![](Images/CryptoAsym+Sym.png)

![](Images/blanc.drawio.png)

<!-- Confidentialité, Authen dest, vitesse Traitement -->

--- 
<!-- _class: i1t2 -->

### Asymétrique + Symétrique

![](Images/CryptoAsym+Sym.png)

![opacity:0.3 blur:2px](Images/emeteur.png)
![](Images/confidentialite.png)
![opacity:0.3 blur:2px](Images/integrite.png)
![](Images/destinataire.png)
![](Images/vitesstTraitement.png)


<!-- Confidentialité, Authen dest, vitesse Traitement -->


---
<!-- _class: i1t2 -->

### Signature (Hachage + Asymétrique)

![](./Images/Cryptohache+asym.png)

![](Images/blanc.drawio.png)

<!-- Authen Emeteur, intégrité -->

---
<!-- _class: i1t2 -->

### Signature (Hachage + Asymétrique)

![](./Images/Cryptohache+asym.png)

![](Images/emeteur.png)
![opacity:0.3 blur:2px](Images/confidentialite.png)
![](Images/integrite.png)
![opacity:0.3 blur:2px](Images/destinataire.png)
![opacity:0.3 blur:2px](Images/vitesstTraitement.png)

<!-- Authen Emeteur, intégrité -->


---
<!-- _class: i1t2 -->


### Signature, authentification et Chiffrement

![](Images/SignAUthentChiffrement.png)

![](Images/blanc.drawio.png)


<!-- Authent emeteur, recepteur, confidentialité intégrité citesse traitement-->

---
<!-- _class: i1t2 -->


### Signature, authentification et Chiffrement

![](Images/SignAUthentChiffrement.png)

![](Images/blanc.drawio.png)

![](Images/emeteur.png)
![](Images/confidentialite.png)
![](Images/integrite.png)
![](Images/destinataire.png)
![](Images/vitesstTraitement.png)


<!-- Authent emeteur, recepteur, confidentialité intégrité citesse traitement-->

---
<!-- _class: titre -->

## **PKI**
### **P**ublic **K**ey **I**nfrastructure 
### Infrastructure à clées publiques

---
# SSL / TLS 

## **T**ransport **L**ayer **S**ecurity

#### Remplace SSL (**S**ocket **S**ecure **L**ayer) : 

- **Authentification** du serveur
- **Confidentialité** des données échangées 
- **intégrité** des données échangées

## Actuelement TLS v 1.3

<!--
On confond souvant les deux dans le langage "courant" 

 SSL : inialement devellopé pour le navigateur netscape 
Compatibilité ascendante : En début de connexion, nego de la meilleurs version du protocole dispo

-->

---
# Certificat  

## Contenue d'un certificat (SSL/TLS) : 
- Nom de domaine
- Autorité de certification
- Date d'émission
- Date d'expiration
- Clé publique
- Version SSL/TLS
- Signature numérique de l'autorité de certification


<!-- 
Rappel : Signature = chiffrement du hache avec une clef privée.


-->
---
<!-- _class: EnAvant -->
# Certificat autosigné 

* ### **Signature du certificat avec la clef privée de l'émeteur** 
* #### Certificat + Clé privée = Identité numérique

<!-- 

-->
---
# Certificat autosigné 
## **Inconvénient** : 
* Implique de posséder la clef public
* Nécéssite de faire confiance à l'émeteur
* Perte de la clée privée => compromission.

---
# Certificat autosigné 
## **Inconvénient** : 
- Implique de posséder la clef public
- Nécéssite de faire confiance à l'émeteur
- Perte de la clée privée => compromission.
<BR><BR>
## ➢ Difficilement gérable à grande échelle
  


---
# CA : **C**ertification **A**uthority

Initiation d'une connexion sécurisée par SSL Autorité de certification (CA - Certificate authority) 
![](Images/ca.png)

![](Images/ca2.png)


### Authorité de certification 
- Tiers de confiance 
- gére les certificats
- peut gérer les identités numérique
- Signe les certificats 
- signe la CRL (**C**ertificate **R**evocation **L**ist)

<!-- id num = certif plus clef privée -->
## Confiance dans la CA

---

