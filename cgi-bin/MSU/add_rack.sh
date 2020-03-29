#!/bin/bash
Add_new_rack () {
    echo "Creating a new rack"
    echo "<br>"
    echo '<pre>'
    sudo /opt/butler_server/erts-9.3.3.6/bin/escript /home/gor/rpc_call.escript butler_rack_functions add_new_rack_easy "[<<\"$1\">>,$3,\""$2"\",\""$4"\"]." 
    echo '</pre>'
}
echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Add New Rack</title>'
echo '</head>'
echo '<body style="background-color:#B8B8B8">'

echo '<img src="https://scmtech.in/assets/images/grey.png" style="position:fixed; TOP:5px; LEFT:850px; WIDTH:400px; HEIGHT:80px;"></img>'
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"
echo "<br>"

  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>Rack_ID</TD><TD><input type="number" name="Rack_ID" size=12></td></tr>'\
      '<tr><td>Barcode</TD><TD><input type="text" name="Barcode" size=12></td></tr>'\
      '<tr><td>Direction</TD><TD><input type="number" name="Direction" size=12></td></tr>'\
      '<tr><td>Rack_type</TD><TD><input type="text" name="Rack_type" size=12></td></tr>'\
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
     XX=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){1}.*/\2/'`
     YY=`echo "$QUERY_STRING" | sed -n 's/^.*Barcode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     ZZ=`echo "$QUERY_STRING" | sed -r 's/([^0-9]*([0-9]*)){4}.*/\2/'`
     AA=`echo "$QUERY_STRING" | sed -n 's/^.*Rack_type=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
   
     
     echo "Rack_ID: " $XX
     echo '<br>'
     echo "Barcode: " $YY
     echo '<br>'
     echo "Direction: " $ZZ
     echo '<br>'
     echo "Rack_type: " $AA
     echo '<br>'
     Add_new_rack $XX $YY $ZZ $AA
     
     
  fi
echo '</body>'
echo '</html>'

exit 0