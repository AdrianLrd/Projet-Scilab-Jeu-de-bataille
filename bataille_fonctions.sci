//2.1 Distribution des cartes

function [x, y] = distribue()
    paquetdecarte = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 10 10 10 10 11 11 11 11 12 12 12 12 13 13 13 13];
    //Liste avec un jeu de carte de 54 cartes
    z= input("Distribution normal: (0) Paquet different: (1) Distribution differente: (2)")
    //Menu pour choisir sa distribution
    if z==0 then
        //Si le choix est distribution normal
        x = 1:26;
        y = 1:26;
        //Taille entre 1 et 26 cartes des jeux
        i=1
        while i ~=27
            sol = grand(1,1,"uin",1,52);
            //Tire un chiffre entre 1 et 52
            if paquetdecarte(1, sol) ~= 0 then
                x(1,i) = paquetdecarte(1, sol);
                paquetdecarte(1, sol) = 0;
                i= i+1;
                //Ajout des cartes dans x
            end
        end
        j = 1;
        while j ~=27
            sol = grand(1,1,"uin",1,52);
            //Tire un chiffre entre 1 et 52
            if paquetdecarte(1, sol) ~= 0 then
                y(1,j) = paquetdecarte(1, sol);
                paquetdecarte(1, sol) = 0;
                j = j + 1;
                //Ajout des cartes dans y
            end
        end
    elseif z==1
        //Si le choxi est paquet plus petit
        w=input("Nombre de cartes a distribuer (paire)")
        
        x = 1:w/2;
        y = 1:w/2;
        //Taille des jeu diviser en fonction de la taille demander
        i=1
        while i ~=(w/2)+1
            //Tant que i est different de la taille maximal du jeux +1 car on initialise i à 1
            sol = grand(1,1,"uin",1,52);
            if paquetdecarte(1, sol) ~= 0 then
                x(1,i) = paquetdecarte(1, sol);
                paquetdecarte(1, sol) = 0;
                i= i+1;
                //Ajout de cartes dans le jeux x
            end
        end
        j = 1;
        while j ~=(w/2)+1
            //Tant que i est different de la taille maximal du jeux +1 car on initialise i à 1
            sol = grand(1,1,"uin",1,52);
            if paquetdecarte(1, sol) ~= 0 then
                y(1,j) = paquetdecarte(1, sol);
                paquetdecarte(1, sol) = 0;
                j = j + 1;
                //Ajout de cartes dans le jeux y
            end
        end
    else
        //Si distribution differente
        w=input("Nombre de cartes joueur 1 : ")
        k=input("Nombre de cartes joueur 2 : ")
        x = 1:w;
        y = 1:k;
        //La taille max est definie par l'utilisateur
        i=1
        while i ~=w+1
            sol = grand(1,1,"uin",1,52);
            if paquetdecarte(1, sol) ~= 0 then
                x(1,i) = paquetdecarte(1, sol);
                paquetdecarte(1, sol) = 0;
                i= i+1;
                //Ajout de cartes dans le jeux x
            end
        end
        j = 1;
        while j ~=k+1
            sol = grand(1,1,"uin",1,52);
            if paquetdecarte(1, sol) ~= 0 then
                y(1,j) = paquetdecarte(1, sol);
                paquetdecarte(1, sol) = 0;
                j = j + 1;
                //Ajout de cartes dans le jeux y
            end
        end
    end
endfunction

function [gagnant,temps]= bataille(x,y)
    temps =0;
    gagnant = 0;
    while(x ~=[] && y ~= [])
        //Tant que x et y ne sont pas vide
        if(x(1)>y(1)) then 
            //Si x gagne
            x=[x,x(1),y(1)];
            //ajout des premiers elements de x et y dans x
            x(1)=[];
            y(1)=[];
            //suppression des premiers elements de x et y
            temps = temps +1;
            //Nombre de tour +1
        elseif(x(1)<y(1))
            //Si y gagne
            y=[y,y(1),x(1)];
            //ajout des premiers elements de x et y dans y
            x(1)=[];
            y(1)=[];
            //suppression des premiers elements de x et y
            temps = temps +1;
            //Nombre de tour +1
       else
        hasard =[1 2]
           s = sample(1, hasard)
           //tire au hasard 1 choix entre 1 et 2
           if s==1 then
               //Si x est tire
               x=[x,x(1),y(1)];
               //ajout des premiers elements de x et y dans x
               x(1)=[];
               y(1)=[];
               //suppression des premiers elements de x et y
               temps = temps +1;
               //Nombre de tour +1
            else
                //Si y est tire
                y=[y,y(1),x(1)];
                //ajout des premiers elements de x et y dans y
                x(1)=[];
                y(1)=[];
                //suppression des premiers elements de x et y
                temps = temps +1;
                //Nombre de tour +1
            end
        end
     end
     if(x == [])then
         //Si le jeu x est vide
         gagnant = 2;
     else gagnant = 1;
 end;
            
endfunction

function [x, y] = distribetude() //Reprend le code de la distribution normal au dessus
    paquetdecarte = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 10 10 10 10 11 11 11 11 12 12 12 12 13 13 13 13];
    x = 1:26;
    y = 1:26;
    i=1
    while i ~=27
        sol = grand(1,1,"uin",1,52);
        if paquetdecarte(1, sol) ~= 0 then
            x(1,i) = paquetdecarte(1, sol);
            paquetdecarte(1, sol) = 0;
            i= i+1;
        end
     end
     j = 1;
     while j ~=27
         sol = grand(1,1,"uin",1,52);
         if paquetdecarte(1, sol) ~= 0 then
             y(1,j) = paquetdecarte(1, sol);
             paquetdecarte(1, sol) = 0;
             j = j + 1;
         end
     end
endfunction


function test()
    j1= 0;
    j2=0;
    for i= 1 : 5
        
        [jeu1,jeu2]=distribue(); //Distribution du paquet dans jeu1 et jeu2
        [gagnant,temps]= bataille(jeu1,jeu2); //Une partie commence
       
        printf("\nGagnant de la partie n°%d : %d\nTour : %d\n",i,gagnant,temps)
       
        printf("\n============\n")
        if gagnant==1 then
            j1 = j1 + 1;
        else
            j2 = j2 + 1;
         end;
    end;
    printf("\nPartie gagnées :\nJeu1 : %d\nJeu2 : %d\n",j1,j2);

endfunction
