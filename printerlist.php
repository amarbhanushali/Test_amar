<HTML>

<BODY>
<h1> Printer List </h1>
<?php

//-- PHP version  PHP Version 5.5.19

/* detect locally shared printer */
var_dump(printer_list(PRINTER_ENUM_LOCAL | PRINTER_ENUM_SHARED));
?>

<script language="JavaScript">
var WshNetwork = new ActiveXObject("WScript.Network");
var oPrinters  = WshNetwork.EnumPrinterConnections();

for (var i=0; i<oPrinters.Count(); i+=2) {

      var printer_port = oPrinters.Item(i);
      var printer_name = oPrinters.Item(i+1);
      alert("Printer " + printer_name + " attached to Port " + printer_port );

}
</script>
</BODY>
</HTML>