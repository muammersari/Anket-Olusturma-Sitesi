<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sonuc.aspx.cs" Inherits="newsurvey.Sonuc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <asp:Label ID="Label2" runat="server" Style="font-size: x-large; margin: auto; text-align: center;"></asp:Label>
        <div id="div1" runat="server" style="margin: auto; text-align: center;"></div>
        <div id="div2" style="margin: auto; text-align: center; margin-top: 3%;" runat="server">
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
<script>

    document.getElementById("excelrapor").onclick = function () {
        var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
        var textRange; var j = 0;
        tab = document.getElementById('headerTable'); // id of table

        for (j = 0 ; j < tab.rows.length ; j++) {
            tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
            //tab_text=tab_text+"</tr>";
        }

        tab_text = tab_text + "</table>";
        tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
        tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
        tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

        while (tab_text.indexOf('ç') != -1) tab_text = tab_text.replace('ç', '&ccedil;');
        while (tab_text.indexOf('ğ') != -1) tab_text = tab_text.replace('ğ', '&#287;');
        while (tab_text.indexOf('ı') != -1) tab_text = tab_text.replace('ı', '&#305;');
        while (tab_text.indexOf('ö') != -1) tab_text = tab_text.replace('ö', '&ouml;');
        while (tab_text.indexOf('ş') != -1) tab_text = tab_text.replace('ş', '&#351;');
        while (tab_text.indexOf('ü') != -1) tab_text = tab_text.replace('ü', '&uuml;');

        while (tab_text.indexOf('Ç') != -1) tab_text = tab_text.replace('Ç', '&Ccedil;');
        while (tab_text.indexOf('Ğ') != -1) tab_text = tab_text.replace('Ğ', '&#286;');
        while (tab_text.indexOf('İ') != -1) tab_text = tab_text.replace('İ', '&#304;');
        while (tab_text.indexOf('Ö') != -1) tab_text = tab_text.replace('Ö', '&Ouml;');
        while (tab_text.indexOf('Ş') != -1) tab_text = tab_text.replace('Ş', '&#350;');
        while (tab_text.indexOf('Ü') != -1) tab_text = tab_text.replace('Ü', '&Uuml;');
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE");

        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
        {
            alert("İnternet Explorer'dan alınan excel düzgün çalışmaz.Düzgün Çalışması için Google Chrome'dan Excel Raporu Alınız ' ");
            //txtArea1.document.open("txt/html", "replace");
            //txtArea1.document.write(tab_text);
            //txtArea1.document.close();
            //txtArea1.focus();
            //sa = txtArea1.document.execCommand("SaveAs", true, "Say Thanks to Sumit.xls");
        }
        else                 //other browser not tested on IE 11
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));

        //return (sa);
    }

</script>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="src/jquery.table2excel.js"></script>
<script src="https://cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"> </script>