#!/usr/bin/bash

file=`echo $1 | sed 's/\(.*\)\.\(.*\)/\1/'`
ext=`echo $1 | sed 's/.*\.\(.*\)/\1/'`
if [ ! -f $1 ]; then
	if [ $ext = "pl" ]; then
		echo "#!/usr/bin/perl " > $1
	elif [ $ext = "py" ]; then
	        echo "#!/usr/bin/python " > $1
	elif [ $ext = "c" ]; then
	        echo "#include<stdio.h>" >> $1
		echo -e "int main()\n{ \n\n} " >> $1
	elif [ $ext = "sql" ]; then
	        echo "WHENEVER SQLERROR EXIT 1 " > $1
	        echo "SET SERVEROUTPUT ON" >> $1
	        echo "SET PAGESIZE 0" >> $1
	        echo "SET FEEDBACK OFF" >> $1
	        echo "SET VERIFY OFF" >> $1
	        echo "SET HEADING OFF" >> $1
	        echo -e "\n\nDECLARE\n\n\n" >> $1
	        echo -e "BEGIN\n\n\n" >> $1
	        echo -e "END;\n/" >> $1
	else
		echo "#!/usr/bin/bash" > $1

	fi
fi

while [ 1 ];
do
   	vi $1
   	chmod 755 $1
	if [ $ext = "java" ]; then
		javac $1
		[ $? -eq 0 ] && java $file
	elif [ $ext = "c" ]; then
	       gcc $1
	       [ $? -eq 0 ] && ./a.exe
	elif [ $ext = "sql" ]; then
	        sqlplus  -s sys/unix11@xe as sysdba @$1 <<EOF
		exit
EOF
	else
        	./$1
	fi
   	read dummy
done
