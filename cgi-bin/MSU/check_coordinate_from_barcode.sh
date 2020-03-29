#!/bin/bash
check_coordinate () {
        barcode_validation=`sudo /opt/butler_server/erts-9.3.3.6/bin/escript /home/gor/rpc_call.escript gridinfo search_by "[[{'barcode', 'equal', \""$1"\"}], 'key']." | grep -oP '\[\K[^\]]+'`
        echo "<br>"
        echo "Your given barcode is: $1"
        echo "<br>"
        if [ ! -n "$barcode_validation" ];
        then
            echo "You have type wrong barcode"    
        else
            echo "Checking for coordinate"
            barcode_details=`sudo /opt/butler_server/erts-9.3.3.6/bin/escript /home/gor/rpc_call.escript gridinfo search_by "[[{'barcode', 'equal', \""$1"\"}], 'key']."`
            echo "<br>"
	    echo "<br>"
	    echo "<br>"
	    echo $barcode_details
        fi
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Check for coordinate from barcode</title>'
echo '</head>'
echo '<body style="background-color:#B8B8B8">'

echo '<img src="https://scmtech.in/assets/images/grey.png" style="position:fixed; TOP:5px; LEFT:850px; WIDTH:400px; HEIGHT:80px;"></img>'
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "Type Barcode for which you want coordinate"
echo "<br>"
  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
		  '<tr><td>Barcode</TD><TD><input type="text" name="Barcode" size=12></td></tr>'\
           '</tr></table>'

  echo '<br><input type="submit" value="SUBMIT">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.
  echo "$QUERY_STRING<br>"
  echo "<br>"
  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
     # No looping this time, just extract the data you are looking for with sed:
     XX=`echo "$QUERY_STRING" | sed -n 's/^.*Barcode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
  
     echo "Barcode: " $XX
     echo '<br>'
     check_coordinate $XX
  fi
echo '</body>'
echo '</html>'

exit 0
