#!bin/bash
#Savvas Georgiou 5037
 #Gia ./tool.sh
am=5037
   if [ $# = 0 ]
     then echo $am
    exit
  fi
 #Arxikopoiisi metavlitwn kai flags parametrwn
i=0;#counter 1
j=0;#counter 2
let param=$#;#athroisma parametrwn
id=0
ided=0;#Gia to id pou tha epe3ergastei
ideg=0;#Gia to id pou tha dwthei
coloumned=0;#stili gia to edit
valueed=0;#nea timi sto edit
file=0;#parametros arxeiou
bornsince=0
bornuntil=0
date=0;#date,dateA,dateB gia tis sugkriseis
dateA=0
dateB=0
filef=N;#flag gia -f
idf=N;#flag gia -id
firstn=N;#flag gia --firstname
lastn=N;#flag gia --lastname
bornsincef=N;#flag gia --born-since
bornuntilf=N;#flag gia --born-until
browsers=N;#flag gia --browsers
editfile=N;#flag gia --edit

while [ $i -le $param ];do
#diladi while i<=param less or equal

#gia to -f
  if [ ${!i} = "-f" ];then
  filef=Y;#allazei to flag gia prosvasi sto arxeio
  let j=i+1;#counter gia na paei stin epomeni parametro
  let file=$j;#anathetei thesi sto filename
  fi

#gia to -id
  if [ ${!i} = "-id" ];then
  idf=Y;#allazei to flag tou id
  let z=i+1
  let id=$z;#thesi id
  let id={!id};#anathesi tou id
  fi

#gia to --firstnames
  if [ ${!i} = "--firstnames" ];then
  firstn=Y;#Allazei to glag tou firstnames
  fi

#gia to --lastnames
  if[ ${!i} = "--lastnames" ];then
  lastn=Y;#allazei to flag gia lastnames
  fi

#gia to --born-since
  if[ ${!i} = "--born-since" ];then
  bornsincef=Y;#allagi flag tou --born-since
  let bornsince=i+1;#i epomeni parametros tha einai to date
  bornsince=${!bornsince};#anathesi imerominias stin metavliti
  fi

#gia to --born-until
  if[ ${!i} = "--born-until" ];then
  bornuntilf=Y;#allagi flag tou --born-until
  let bornuntil=i+1;#i epomeni parametros tha einai to date
  bornuntil=${!bornuntil};#anathesi imerominias stin metavliti
  fi

#gia to --browsers
  if[ ${!i} = "--browsers" ];then
  browsers=Y;#allazei to flag gia tin parametro --browsers
  fi

#gia to --edit
  if[ ${!i} = "--edit" ];then
  editfile=Y;#allazei to flag gia to --edit
  let j=i+1;#epomeni parametros id
  ided=${!j}
  let j++;#epomeni parametros coloumn
  coloumned=${!j}
  let j++;#epomeni parametros value
  valueed=${!j}
  fi
 let i++;#epomeni parametros
done

#Xrisimopoiw ta flags me sunthikes -a AND gia ta erwtimata
#A
  if[ $filef == Y -a $idf == N -a $firstn == N -a $lastn == N $bornsincef == N -a $bornuntilf == N $browsers == N -a editfile == N ];then
	  awk '/^#/ {next} {print $0}'${!file}
	  # '/^#/{next} {print $0}' gia na min tupwsei ta sxolia
	  exit;
  fi

  #B
  if[ $filef == Y -a $idf == Y -a $firstn == N -a $lastn == N $bornsincef == N -a $bornuntilf == N $browsers == N -a editfile == N ];then
	  awk -F "|" -v ideg="$id" '{if (ideg==$1) print $3,$2,$5}' ${!file};
	  #-F '|' einai to format pou einai domimeno to arxeio kai tha tupwsei tin stili 3,2,5
	  exit;
  fi

#C
 if[ $filef == Y -a $idf == N -a $firstn == Y -a $lastn == N $bornsincef == N -a $bornuntilf == N $browsers == N -a editfile == N ];then
	 awk -F "|" '/^#/ {next} {print $3}' ${!file} | sort | uniq;
	 #sort gia alfarithmitiki seira kai sort gia mono diakrita
	 exit;
 fi

 #D
  if[ $filef == Y -a $idf == N -a $firstn == N -a $lastn == Y $bornsincef == N -a $bornuntilf == N $browsers == N -a editfile == N ];then
        awk -F "|" '/^#/ {next} {print $2}' ${!file} | sort | uniq;
	#opws pio panw alla edw tupwnei tin stili me to epitheto
	exit;
fi

#E
#mono gia to --born-since
 if[ $filef == Y -a $idf == N -a $firstn == N -a $lastn == N $bornsincef == Y -a $bornuntilf == N $browsers == N -a editfile == N ];then
	 awk -F "|" -v date="$bornsince" '/^#/{next} {if (date -le $5) print $0}' ${!file};
	#ektupwnei eggrafes opou date =< stilis 5
	 exit;
 fi
#mono gia to --born-until
 if[ $filef == Y -a $idf == N -a $firstn == N -a $lastn == N $bornsincef == N -a $bornuntilf == Y $browsers == N -a editfile == N ];then
         awk -F "|" -v date="$bornuntil" '/^#/{next} {if (date -ge $5) print $0}' ${!file};
	 #ektupwnei eggrafes opou date => stilis 5
	 exit;
 fi
#kai gia ta 2
 if[ $filef == Y -a $idf == N -a $firstn == N -a $lastn == N $bornsincef == Y -a $bornuntilf == Y $browsers == N -a editfile == N ];then
	 awk -F "|" -v dateA="$bornsince" -v dateB="$bornuntil" '/^#/ {next} {if (dateA -le $5) if (dateB -ge $5) print $0}' ${!FILE}
	 #sundiasdos twn entolvn awk apo pio panw
	 exit;
 fi
 #F
if[ $filef == Y -a $idf == N -a $firstn == N -a $lastn == N $bornsincef == N -a $bornuntilf ==N $browsers == Y -a editfile == N ];then
	awk -F "|" '/^#/ {next} {A[$8]++}END {for(i in A) print i,A[i]}' ${!FILE} | sort;
       #Pinakas A stili 8 opou i einai to onoma tou browser
exit;
fi

