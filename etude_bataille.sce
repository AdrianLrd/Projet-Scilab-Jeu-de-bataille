
// Deux lignes utiles à mettre au début de chaque script :
xdel(winsid());                 // ferme toutes les fenetres a chaque nouvel appel du script
clear;                          // nettoie toutes les variables a chaque nouvel appel du script
mode(0);                        // pour que le script se comporte comme une console (pas de point virgule => affichage du résultat) 


exec('C:\Users\Adrian\Desktop\Projet Maths\bataille_fonctions.sci',-1)


function [moy] = moyliste(jeu1)
    t=length(jeu1);
    m=0;
    i=1;
    while t>0 //Tant que t est supérieur a 0 avec t la taille du jeu1
        m=m+jeu1(i); //Fais une liste avec toutes les valeur de jeu1
        i=i+1;
        t=t-1;
    end
    m=m/length(jeu1); //Fais sa moyenne en divisant les valeur de jeu1 et sa longueur
    moy = m; //Retourne moy
endfunction

function [moyg] = bestmoy(moyx,moyy)
    
    if(moyx>moyy) then //Compare si moyx est plus grand que moyy
        moyg(1)="jeu1"; //si c'est le cas la moyenne gagnante est jeu1
    else moyg(1)="jeu2"; // sinon c'est jeu2
    end
    
endfunction

function [gagnant, moyg] = etude1(jeu1, jeu2)
    moyx = 0;
    moyy = 0;
    moyx = moyliste(jeu1);//Fais le moyenne du jeux jeu1 et retourne sa moyenne en moyx
    moyy = moyliste(jeu2);//Fais le moyenne du jeux jeu2 et retourne sa moyenne en moyy
    
    moyg =[];
    [moyg] = bestmoy(moyx,moyy);//calcul la plus grosse moyenne des deux
    
    gagnant = [];
    temps = [];
    
    [gagnant,temps] = bataille(jeu1,jeu2);//Fais le jeux d'une bataille
    
    
    
    
    
endfunction

function [mgg] = compteur(cptmoyg)
    i=1;
    x=0;
    y=0;
    while i<length(cptmoyg)+1
        if(cptmoyg(1) == "jeu1") then//Si la valeur dans cptmoyg est jeu1
            x=x+1; //on incrémente x de 1
        else y =y +1; //sinon y
        end
        i = i+1;
    end
    if(x>y) then //on compare x et y, si x est plus grand
        mgg ="jeu1"; // on retour jeu1
    else mgg ="jeu2"; //sinon jeu2
    end 
    
endfunction

function testetude1(x)
    gagnant = [];
    moyg = [];
    cptmoyg = [];
    mgg = [];
    jeu1 = [];
    jeu2 = [];
    j1g = 0;
    j2g = 0;
    
    i=0;
    while i<x
        //Tant que i est inférieur a la valeur définie par l'utilisateur
        [jeu1, jeu2]=distribetude();//Dsitribution normal du jeu
        [gagnant, moyg] = etude1(jeu1, jeu2);//On fais notre etude en calculant les meilleurs moyennes
        cptmoyg($+1) = moyg; // on met toutes les valeur des moyennes dans cptmoyg
        if (gagnant == 1) then //compteur pour savoir combien de fois gagner le jeu1 et jeu2
            j1g = j1g+1;
        else j2g = j2g +1;
        end
        i = i+1
    end
    
    [mgg] = compteur(cptmoyg) //Compteur qui calcul quelle moyenne entre jeu1 et jeu2 a eu le plus de fois un meilleur jeu
    
    printf("\nNombre de parties :%d\nPaquet avec la moyenne gagnante : %s\nNombre de fois jeu1 gagnant : %d\nNombre de fois jeu2 gagnant : %d\n",x, mgg, j1g,j2g)
    
endfunction


function [E, V, o] = etude2(tempspartie)
    E = 0;
    E2 = 0;
    i=1;
    y=1;
    T=tabul(tempspartie)
    Nb=length(T(:,1));
    while i<(length(T(:,1))+1)
        E = E + T(i,1)*T(i,2)/Nb; // Multiplie la valeur de i et sont nombre d'occurence
        i=i+1;
    end
    //Calcul de l'Esperance
    
    while y<length(T(:,1))+1
        E2 = E2 + (T(y,1)^2)*T(y,2)/Nb; // Multiplie la valeur de i au carré et sont nombre d'occurence
        y=y+1;
    end
    //Calcul de l'Esperance au carré 
    
    V= E2 - E^2 //Calcul de la Variance
    
    o = sqrt(V); //Calcul de l'écart type
    
endfunction

function testetude2(x)
    tempspartie = []
    temps= [];
    jeu1 = [];
    jeu2 = [];
    V= 0; //Variance
    o = 0;//Ecart type
    E = 0;//Esperance
    tabproba = [];
    pxi = 0;
    i=1;
    while i<x+1
        //Fais l'étude pour x nombres de parti definie par l'utilisateur
        [jeu1, jeu2]=distribetude(); //Distribution normal
        [gagnant,temps] = bataille(jeu1,jeu2); //Bataille normal
        tempspartie(i)= temps; //met dans tempspartie toutes les valeurs de temps
        i=i+1;
    end
    
    [E, V, o] = etude2(tempspartie); //Calcul l'Esperance, la variance et l'écart type du temps des parties
    
    printf("Espérance : %d\nVariance : %d\nEcart Type : %d",E, V, o);
    
endfunction

function [moyn] = moy(tempspartie)
    n=length(tempspartie)
   moyn=sum(tempspartie)/n //Somme des valeur dans tempsartie diviser par sa longueur 
endfunction

function [interval1, interval2] = intervalle(moyn, conf, o, tempspartie)
    interval1 = 0;
    interval2 = 0;
    nbpartie= length(tempspartie);
    
    interval1 = moyn - (conf *(o/(sqrt(nbpartie)))); //mouyn est la moyenne, conf est la valeur qui correspond au niveau de confiance et o l'ecart-type
    interval2 = moyn + (conf *(o/(sqrt(nbpartie))));
    //Calcul de l'intervalle de confiance 
endfunction

function testetude3(x)
    tempspartie = []
    temps= [];
    jeu1 = [];
    jeu2 = [];
    interval1 = 0;
    interval2 = 0;
    conf =0;
    moyn =0;
    i=0;
     while i<x
        //Fais l'étude pour x nombres de parti definie par l'utilisateur
        [jeu1, jeu2]=distribetude(); //Distribution normal
        [gagnant,temps] = bataille(jeu1,jeu2); //Bataille normal
        tempspartie($+1)= temps; //met dans tempspartie toutes les valeurs de temps
        i=i+1;
    end
    
    [moyn] = moy(tempspartie); //Calcul de la moyenne des parties
    
    [E, V, o] = etude2(tempspartie); //Calcul Esperance, la variance et l'écart type du temps des parties
    w= input("Intervalle de confiance a 95% (0) Intervalle de confiance a 98% (1)")
    if w==0 then
        conf=1,96; // z = 1,96 car intervalle de confiance 95%
        [interval1, interval2] = intervalle(moyn, conf, o, tempspartie) // Calcul les deux intervalle avec un niveau de confiance a 95%
        printf("Avec un intervalle de confiance a 95, on a un intervalle [%.2f;%.2f]",interval1, interval2);
    else 
        conf=2,58; // z = 2,58 car intervalle de confiance 98%
        [interval1, interval2] = intervalle(moyn, conf, o, tempspartie)// Calcul les deux intervalle avec un niveau de confiance a 98%
        printf("Avec un intervalle de confiance a 98, on a un intervalle [%.2f;%.2f]",interval1, interval2);
    end
    
    
endfunction

p= input("Nombre de partie à tester :")
c= input("Etude 1 ?(0) ----- Etude 2 ?(1) ----- Etude 3 ?(2) ----- Stop ? (3)")
if c==0 then
    testetude1(p);
end
if c==1 then
    testetude2(p);
end
if c==2 then
    testetude3(p);
else break;
end
