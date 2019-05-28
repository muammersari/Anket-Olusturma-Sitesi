<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Anket.aspx.cs" Inherits="newsurvey.Anket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div id="genel_anket_goruntule">
            <div id="ust_anket_goruntule" style="width: 100%; height: 150px; background-color: #663399;"></div>
            <div id="alt_anket_goruntule" style="position: absolute; left: 20%; right: 20%; top: 75px; height: auto; box-shadow: 0 0 10px 1px #663399; z-index: 1; background-color: white; margin-bottom: 25px; display: inline;"></div>
        </div>

    </form>
</body>
</html>
<script>
    var ankete_baslama_tarihi = new Date();

    document.addEventListener('input', function (event) {
        if (event.target.tagName.toLowerCase() !== 'textarea') return;
        autoExpand(event.target);
    }, false)
    var autoExpand = function (field) {

        // Reset field height
        field.style.height = 'inherit';

        // Get the computed styles for the element
        var computed = window.getComputedStyle(field);

        // Calculate the height
        var height = parseInt(computed.getPropertyValue('border-top-width'), 10)
                     + parseInt(computed.getPropertyValue('padding-top'), 10)
                     + field.scrollHeight
                     + parseInt(computed.getPropertyValue('padding-bottom'), 10)
                     + parseInt(computed.getPropertyValue('border-bottom-width'), 10);

        field.style.height = height + 'px';

    };
    var a = new Array();
    var b = new Array();
    var id = new Array();
    var sayac = 0;
    var sayac1 = 0;
    var sayac2 = 0;
    var sayac3 = 0;
    var sayac4 = 0;
    var sayac5 = 0;
    var namee = 0;
    var sayac9 = 0;
    var divler_id = new Array();
    PageMethods.anket_ismi(islemBasarili, islemHatali);
    function islemBasarili(sonuc) {
        PageMethods.soru_secenekturu_ve_idleri(islemBasarili1, islemHatali1);
        function islemBasarili1(sonuc1) {
            PageMethods.secenekler(islemBasarili2, islemHatali2);
            function islemBasarili2(sonuc2) {
                PageMethods.sorunun_secenek_sayisi(islemBasarili3, islemHatali3);
                function islemBasarili3(sonuc3) {
                    if (sayac == 0) {
                        var tarih_kontrol = "dogru";
                        var mesaj = "";
                        var simdiki_tarih = new Date();
                        //var simdiki_tarih1 = new Date(simdiki_tarih.getFullYear(),simdiki_tarih.getMonth(),simdiki_tarih.getDate());
                        if (sonuc[3].toString() != "-") {
                            var baslangic = new Date(sonuc[3].toString());
                            var baslangic1 = new Date(baslangic.getFullYear(), baslangic.getMonth(), baslangic.getDate());
                            var bitis = new Date(sonuc[4].toString());
                            var bitis1 = new Date(bitis.getFullYear(), bitis.getMonth(), bitis.getDate());
                            alert(baslangic1);
                            if (simdiki_tarih >= baslangic1 && simdiki_tarih <= bitis1) {
                                tarih_kontrol = "dogru";
                            } else {
                                mesaj = "Anketi Doldurmak İçin " + sonuc[3].toString() + " saat: 00.00 ile " + sonuc[4].toString() + " saat: 00.00 Tarihleri Arasında İşlem Yapabilirsiniz !";
                                tarih_kontrol = "yanlis";
                            }
                        }
                        if (tarih_kontrol == "yanlis") {
                            alert(mesaj);
                            window.close();
                        }
                        else {

                            for (var i = 0; i < sonuc1.length; i++) {
                                a.push(sonuc1[i].toString());
                            }
                            for (var i = 0; i < sonuc2.length; i++) {
                                b.push(sonuc2[i].toString());
                            }
                            var div_anket_baslik = document.createElement("div");
                            div_anket_baslik.style.height = "auto";
                            div_anket_baslik.style.width = "80%";
                            div_anket_baslik.style.margin = "auto";
                            div_anket_baslik.style.marginTop = "75px";
                            alt_anket_goruntule.appendChild(div_anket_baslik);
                            var baslik_txt = document.createElement("textarea");
                            baslik_txt.innerText = sonuc[0].toString();
                            baslik_txt.style.width = "100%";
                            baslik_txt.disabled = "true";
                            baslik_txt.style.resize = "none";
                            baslik_txt.style.outline = "0";
                            baslik_txt.style.borderLeftStyle = "none";
                            baslik_txt.style.borderTopStyle = "none";
                            baslik_txt.style.borderRightStyle = "none";
                            baslik_txt.style.borderBottomStyle = "none";
                            baslik_txt.style.borderBottomWidth = "1px";
                            baslik_txt.style.backgroundColor = "white";
                            baslik_txt.style.font = "180%/1.2  Helvetica";
                            baslik_txt.style.color = "black";


                            var aciklama_txt = document.createElement("textarea");
                            aciklama_txt.innerText = sonuc[1].toString();
                            aciklama_txt.style.width = "100%";
                            aciklama_txt.disabled = "true";
                            aciklama_txt.style.resize = "none";
                            aciklama_txt.style.outline = "0";
                            aciklama_txt.style.borderLeftStyle = "none";
                            aciklama_txt.style.borderTopStyle = "none";
                            aciklama_txt.style.borderRightStyle = "none";
                            aciklama_txt.style.borderBottomStyle = "none";
                            aciklama_txt.style.borderBottomWidth = "0.5px";
                            aciklama_txt.style.backgroundColor = "white";
                            aciklama_txt.style.font = "100%/1.2  Helvetica";
                            aciklama_txt.style.color = "black";
                            aciklama_txt.style.marginTop = "1%";

                            var zorunlu_baslik = document.createElement("label");
                            zorunlu_baslik.style.color = "red";
                            zorunlu_baslik.innerHTML = "NOT: '*' İşareti Olan Sorular Boş Geçilemez !";

                            div_anket_baslik.appendChild(baslik_txt);
                            div_anket_baslik.appendChild(aciklama_txt);
                            div_anket_baslik.appendChild(zorunlu_baslik);
                            if (baslik_txt.scrollHeight > baslik_txt.clientHeight) {
                                baslik_txt.style.height = baslik_txt.scrollHeight + "px";
                            }
                            if (aciklama_txt.scrollHeight > aciklama_txt.clientHeight) {
                                aciklama_txt.style.height = aciklama_txt.scrollHeight + "px";
                            }
                            var sorusirasii = 1;
                            for (var i = 0; i < a.length; i += 4) {
                                sayac9++;
                                var div_anket_goster_genel = document.createElement("div");
                                div_anket_goster_genel.style.height = "auto";
                                div_anket_goster_genel.style.width = "90%";
                                div_anket_goster_genel.style.margin = "auto";
                                div_anket_goster_genel.style.paddingBottom = "20px";

                                div_anket_goster_genel.style.marginTop = "30px";
                                div_anket_goster_genel.style.marginBottom = "30px";
                                if (i != a.length - 4) {
                                    div_anket_goster_genel.style.border = "0.5px solid #663399";
                                    div_anket_goster_genel.style.borderLeftStyle = "none";
                                    div_anket_goster_genel.style.borderTopStyle = "none";
                                    div_anket_goster_genel.style.borderRightStyle = "none";
                                }

                                var div_anket_goster_ust = document.createElement("div");
                                div_anket_goster_ust.style.height = "auto";
                                div_anket_goster_ust.style.width = "90%";
                                div_anket_goster_ust.style.margin = "auto";
                                div_anket_goster_ust.id = "ust" + i.toString();;
                                //div_anket_goster_ust.style.border = "1px solid red";


                                var div_anket_goster_orta = document.createElement("div");
                                div_anket_goster_orta.style.height = "auto";
                                div_anket_goster_orta.style.width = "90%";
                                div_anket_goster_orta.style.margin = "auto";
                                div_anket_goster_orta.id = "orta" + i.toString();
                                //div_anket_goster_orta.style.border = "1px solid red";


                                var div_anket_goster_alt = document.createElement("div");
                                div_anket_goster_alt.style.height = "auto";
                                div_anket_goster_alt.style.width = "90%";
                                div_anket_goster_alt.style.margin = "auto";
                                div_anket_goster_alt.style.marginTop = "20px";
                                div_anket_goster_alt.id = "alt" + i.toString();
                                //div_anket_goster_alt.style.border = "20px solid red";
                                //div_anket_goster_alt.style.padding = "4%";

                                divler_id.push(div_anket_goster_ust.id.toString());
                                divler_id.push(div_anket_goster_orta.id.toString());
                                divler_id.push(div_anket_goster_alt.id.toString());

                                div_anket_goster_genel.appendChild(div_anket_goster_ust);
                                div_anket_goster_genel.appendChild(div_anket_goster_orta);
                                div_anket_goster_genel.appendChild(div_anket_goster_alt);
                                alt_anket_goruntule.appendChild(div_anket_goster_genel);

                                var soru_txt = document.createElement("textarea");
                                soru_txt.innerText = sorusirasii.toString() + "- " + a[i + 1].toString();
                                soru_txt.style.width = "100%";
                                soru_txt.disabled = "true";
                                soru_txt.style.resize = "none";
                                soru_txt.style.outline = "0";
                                //soru_txt.style.borderLeftStyle = "none";
                                //soru_txt.style.borderTopStyle = "none";
                                //soru_txt.style.borderRightStyle = "none";
                                //soru_txt.style.borderBottomColor = "darkgray";
                                soru_txt.style.borderStyle = "none";
                                soru_txt.style.borderBottomWidth = "1px";
                                soru_txt.style.backgroundColor = "white";
                                soru_txt.style.color = "black";
                                soru_txt.style.font = "25px arial,serif";
                                //var kelime_uzunluğu = Math.floor(parseInt(soru_txt.value.length.toString()) / 55);
                                //if (soru_txt.value.length <= 55) {
                                //    soru_txt.style.height = "30px";
                                //} else {
                                //    soru_txt.style.height = (kelime_uzunluğu * 30) + "px";
                                //}
                                if (a[i + 3].toString() == "evet") {
                                    var zorunlu_soru = document.createElement("label");
                                    zorunlu_soru.style.color = "red";
                                    zorunlu_soru.innerHTML = "* Zorunlu";
                                    div_anket_goster_ust.appendChild(zorunlu_soru);
                                }

                                div_anket_goster_ust.appendChild(soru_txt);
                                if (soru_txt.scrollHeight > soru_txt.clientHeight) {
                                    soru_txt.style.height = soru_txt.scrollHeight + "px";
                                }

                                if (a[i + 2].toString() == "Onay Kutusu") {
                                    var gidecegiyer = sayac1 + parseInt(sonuc3[sayac2]);
                                    var tablo = document.createElement("table");
                                    tablo.style.borderStyle = "none";
                                    for (var j = sayac1; j < gidecegiyer; j++) {
                                        var satir = document.createElement("tr");
                                        var sutun1 = document.createElement("td");
                                        var sutun2 = document.createElement("td");
                                        var cb_secenek = document.createElement("input");
                                        cb_secenek.setAttribute("type", "checkbox");
                                        cb_secenek.style.width = "20px";
                                        cb_secenek.style.height = "20px";
                                        sutun1.appendChild(cb_secenek);
                                        var cb_lbl = document.createElement("label");
                                        cb_lbl.style.font = "20px arial,serif";
                                        cb_lbl.innerHTML = b[sayac1].toString();
                                        sutun2.appendChild(cb_lbl);
                                        satir.appendChild(sutun1);
                                        satir.appendChild(sutun2);
                                        tablo.appendChild(satir);
                                        div_anket_goster_alt.appendChild(tablo);
                                        sayac1++;
                                    }
                                } else if (a[i + 2].toString() == "Çoktan Seçmeli") {
                                    tablo = document.createElement("table");
                                    tablo.style.borderStyle = "none";
                                    var gidecegiyer = sayac1 + parseInt(sonuc3[sayac2]);
                                    for (var j = sayac1; j < gidecegiyer; j++) {
                                        var satir = document.createElement("tr");
                                        var sutun1 = document.createElement("td");
                                        var sutun2 = document.createElement("td");
                                        var rb_secenek = document.createElement("input");
                                        rb_secenek.setAttribute("type", "radio");
                                        rb_secenek.name = "radiobtn" + sayac5;
                                        rb_secenek.style.width = "20px";
                                        rb_secenek.style.height = "20px";
                                        sutun1.appendChild(rb_secenek);

                                        var rb_lbl = document.createElement("label");
                                        rb_lbl.style.font = "20px arial,serif";
                                        rb_lbl.innerHTML = b[sayac1].toString();
                                        sutun2.appendChild(rb_lbl);
                                        satir.appendChild(sutun1);
                                        satir.appendChild(sutun2);
                                        tablo.appendChild(satir);
                                        div_anket_goster_alt.appendChild(tablo);
                                        sayac1++;
                                    }
                                    sayac5++;

                                } else if (a[i + 2].toString() == "Sürekli Ölçek") {
                                    //var gidecegiyer = sayac1 + 4;
                                    var gidecegiyer = sayac1 + parseInt(sonuc3[sayac2]);
                                    var tablo = document.createElement("table");
                                    //tablo.id = "aaa";
                                    var satir = document.createElement("tr");
                                    //satir.id = "aaassss" + sayac1.toString();
                                    var sutun1 = document.createElement("td");
                                    sutun1.style.width = "20%";
                                    var sutun2 = document.createElement("td");
                                    sutun2.style.width = "60%";
                                    //sutun2.style.margin = "auto";
                                    //sutun2.style.textAlign = "center";
                                    var sutun3 = document.createElement("td");
                                    sutun3.style.width = "20%";
                                    var satir1 = document.createElement("tr");
                                    var sutun4 = document.createElement("td");
                                    var sutun5 = document.createElement("td");
                                    //sutun5.style.float = "left";
                                    //sutun5.style.textAlign = "center";
                                    //sutun5.style.border = "1px solid black";
                                    sutun2.id = "stn5";
                                    var sutun6 = document.createElement("td");


                                    var so_1 = document.createElement("textarea");
                                    so_1.innerText = b[sayac1 + 2].toString();
                                    so_1.style.width = "95%";
                                    so_1.disabled = "true";
                                    so_1.style.resize = "none";
                                    so_1.style.outline = "0";
                                    so_1.style.borderStyle = "none";
                                    so_1.style.backgroundColor = "white";
                                    so_1.style.color = "black";
                                    so_1.style.font = "15px arial,serif";
                                    so_1.style.margin = "auto";
                                    so_1.style.textAlign = "center";
                                    sutun1.appendChild(so_1);

                                    //sutun2.style.border = "1px solid black";
                                    var so_2 = document.createElement("textarea");
                                    so_2.innerText = b[sayac1 + 3].toString();
                                    so_2.style.width = "95%";
                                    so_2.disabled = "true";
                                    so_2.style.resize = "none";
                                    so_2.style.marginLeft
                                    so_2.style.outline = "0";
                                    so_2.style.borderStyle = "none";
                                    so_2.style.backgroundColor = "white";
                                    so_2.style.color = "black";
                                    so_2.style.font = "15px arial,serif";
                                    so_2.style.margin = "auto";
                                    so_2.style.textAlign = "center";
                                    sutun3.appendChild(so_2);

                                    satir.appendChild(sutun1);
                                    satir.appendChild(sutun2);
                                    satir.appendChild(sutun3);
                                    tablo.appendChild(satir);
                                    var lbll = document.createElement("Label");
                                    lbll.id = "demo" + sayac1.toString();
                                    lbll.style.width = "100px";
                                    lbll.style.height = "100px";
                                    sutun2.appendChild(lbll);
                                    sutun2.innerHTML += "<br/><input type='range' min='" + parseInt(b[sayac1]) + "' max='" + parseInt(b[sayac1 + 1]) + "' style='width:97%; margin-top:10px;'  class='slider' id='myRange" + sayac1.toString() + "' onchange='fun(" + sayac1.toString() + ")'  onmouseup='fun(" + sayac1.toString() + ")' onmousedown='fun(" + sayac1.toString() + ")'/>";

                                    //sutun2.innerHTML += "<br/><Label id='demo" + sayac1.toString() + "' style='width:100px; height:60px; border:1px solid black; border-radius:50%;'></Label>";
                                    satir1.appendChild(sutun4);
                                    satir1.appendChild(sutun5);
                                    satir1.appendChild(sutun6);
                                    tablo.appendChild(satir1);
                                    div_anket_goster_alt.appendChild(tablo);
                                    if (so_1.scrollHeight > so_1.clientHeight) {
                                        so_1.style.height = so_1.scrollHeight + "px";
                                    }
                                    if (so_2.scrollHeight > so_2.clientHeight) {
                                        so_2.style.height = so_2.scrollHeight + "px";
                                    }

                                    sayac1 += 4;
                                    //alert(sutun5.clientWidth);
                                }
                                else if (a[i + 2].toString() == "Çoktan Seçmeli Tablosu") {
                                    //for (var j = 0; j < b.length; j++) {
                                    //    alert(b[j].toString());
                                    //}
                                    var gidecegiyer = sayac1 + parseInt(sonuc3[sayac2]);
                                    var str = parseInt(b[sayac1].toString());
                                    var stn = parseInt(b[sayac1 + 1].toString());
                                    var tablo = document.createElement("table");
                                    tablo.id = "tablo" + sayac1.toString();
                                    tablo.style.width = "100%";
                                    div_anket_goster_alt.appendChild(tablo);
                                    sayac1 += 2;
                                    //var genislik = Math.floor(30 / (stn));
                                    var genislik = (tablo.clientWidth*0.4)/stn;
                                    for (var t = 0; t < (str + 1) ; t++) {
                                        var tr = document.createElement("tr");
                                        tr.id = "tr" + sayac1.toString();
                                        for (var j = 0; j < stn + 1; j++) {
                                            if (t == 0) {
                                                if (j == 0) {
                                                    var td = document.createElement("td");
                                                    td.innerHTML = " ";
                                                    td.style.width = tablo.clientWidth * 0.5 + "px";
                                                    //td.style.padding = "1%";
                                                    tr.appendChild(td);
                                                    tablo.appendChild(tr);
                                                }
                                                else {
                                               
                                                    var td1 = document.createElement("td");
                                                    //td1.innerHTML = b[sayac1].toString();
                                                    //td1.id = "td1_id" + sayac1.toString();
                                                    //td1.style.width = genislik + "px";
                                                    td1.style.border = "1px solid black";
                                                    //td1.style.padding = "1%";
                                                    td1.style.verticalAlign = "bottom";
                                                    var stntxt = document.createElement("textarea");
                                                    stntxt.style.width = genislik + "px";
                                                    stntxt.innerText = b[sayac1].toString();
                                                    stntxt.style.resize = "none";
                                                    stntxt.style.overflow = "hidden";
                                                    stntxt.style.borderStyle = "none";
                                                    stntxt.style.textAlign = "center";
                                                    stntxt.style.font = "20px arial,serif";
                                                    stntxt.disabled = "true";
                                                    stntxt.style.backgroundColor = "white";
                                                    stntxt.style.color = "black";
                                                    td1.appendChild(stntxt);
                                                    tr.appendChild(td1);
                                                    tablo.appendChild(tr);
                                                    if (stntxt.scrollHeight > stntxt.clientHeight) {
                                                        stntxt.style.height = stntxt.scrollHeight + "px";
                                                    }
                                                    sayac1++;
                                                }
                                            }
                                            else {
                                                if (j == 0) {

                                                    var td2 = document.createElement("td");
                                                    //td2.innerHTML = sayac9 + "." + (t) + "-" + b[sayac1].toString();
                                                    //td2.style.width = tablo.clientWidth * 0.6 + "px";
                                                    td2.style.border = "1px solid black";
                                                    //td2.style.padding = "1%";

                                                    var strtxt = document.createElement("textarea");
                                                    strtxt.style.width = tablo.clientWidth * 0.50 + "px";
                                                    //strtxt.innerText = sayac9 + "." + (t) + "-" + b[sayac1].toString();
                                                    strtxt.innerText = b[sayac1].toString();
                                                    strtxt.style.resize = "none";
                                                    strtxt.style.overflow = "hidden";
                                                    strtxt.style.outline = 0;
                                                    strtxt.style.borderStyle = "none";
                                                    strtxt.style.textAlign = "center";
                                                    strtxt.style.font = "20px arial,serif";
                                                    //strtxt.disabled = "true";
                                                    strtxt.style.backgroundColor = "white";
                                                    strtxt.style.color = "black";
                                                    td2.appendChild(strtxt);
                                                    tr.appendChild(td2);
                                                    tablo.appendChild(tr);
                                                    if (strtxt.scrollHeight > strtxt.clientHeight) {
                                                        strtxt.style.height = strtxt.scrollHeight + "px";
                                                    }
                                                    sayac1++;
                                                   
                                                }
                                                else {
                                                    var td3 = document.createElement("td");
                                                    td3.style.width = genislik + "px";
                                                    td3.style.border = "1px solid black";
                                                    //td3.style.padding = "1%";
                                                    td3.style.textAlign = "center";
                                                    tr.appendChild(td3);
                                                    var radiobtn = document.createElement("input");
                                                    radiobtn.type = "radio";
                                                    radiobtn.style.color = "green";
                                                    radiobtn.name = "radio" + namee.toString();
                                                    radiobtn.style.width = "20px";
                                                    radiobtn.style.height = "20px";
                                                    td3.appendChild(radiobtn);
                                                    tablo.appendChild(tr);
                                                }
                                            }
                                        }
                                        tablo.appendChild(tr);
                                        

                                     
                                     
                                        namee++;
                                    }

                                }
                                else if (a[i + 2].toString() == "Sürekli Ölçek Tablosu") {
                                    var gidecegiyer = sayac1 + parseInt(sonuc3[sayac2]);
                                    var minimum = parseInt(b[sayac1].toString());
                                    var maksimum = parseInt(b[sayac1 + 1].toString());
                                    var tablo1 = document.createElement("table");
                                    tablo1.id = "tablo" + sayac1.toString();
                                    tablo1.style.width = "100%";
                                    div_anket_goster_alt.appendChild(tablo1);
                                    sayac1 += 2;
                                    for (var j = sayac1; j < gidecegiyer; j++) {
                                        var tr1 = document.createElement("tr");
                                        tr1.id = "trid" + sayac1.toString();
                                        var td4 = document.createElement("td");
                                        td4.innerHTML = b[sayac1].toString();
                                        td4.style.width = "35%";
                                        td4.style.border = "1px solid gray";
                                        td4.style.padding = "1%";
                                        td4.style.font = "20px arial,serif";
                                        tr1.appendChild(td4);
                                        var td5 = document.createElement("td");
                                        td5.style.width = "65%";
                                        td5.style.border = "1px solid gray";
                                        td5.style.padding = "2%";
                                        var lbll1 = document.createElement("Label");
                                        lbll1.id = "demo" + sayac1.toString();
                                        //lbll1.style.border = "1px solid black";
                                        lbll1.style.padding = "1%";
                                        td5.appendChild(lbll1);
                                        td5.innerHTML +="<br/>"+minimum+"<input type='range' style='margin-top:10px; width:80%;' min='" + minimum + "' max='" + maksimum + "'  class='slider' id='myRange" + sayac1.toString() + "' onchange='fun(" + sayac1.toString() + ")'  onmouseup='fun(" + sayac1.toString() + ")' onmousedown='fun(" + sayac1.toString() + ")'/>"+maksimum+" ";

                                        lbll1.style.fontSize = "medium";
                                        tr1.appendChild(td5);
                                        tablo1.appendChild(tr1);
                                        sayac1++;
                                    }
                                } else if (a[i + 2].toString() == "Açık Uçlu") {
                                    var kisayanit = document.createElement("textarea");
                                    kisayanit.style.outline = "0";
                                    kisayanit.style.outline = "0";
                                    kisayanit.style.fontSize = "large";
                                    kisayanit.style.overflow = "hidden";
                                    kisayanit.rows = 1;
                                    kisayanit.style.resize = "none";
                                    kisayanit.style.width = "85%";
                                    kisayanit.style.borderLeftStyle = "none";
                                    kisayanit.style.borderRightStyle = "none";
                                    kisayanit.style.borderTopStyle = "none";
                                    kisayanit.style.borderBottomColor = "lightslategray";
                                    kisayanit.style.backgroundColor = "white";
                                    kisayanit.style.font = "20px arial,serif";
                                    kisayanit.placeholder = "kısa metin";
                                    if (b[sayac1].toString() =="numerik") {
                                        kisayanit.onkeydown = function () {
                                            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 188) {
                                                // burda bir şey olmuyor.
                                            }
                                            else {
                                                // rakam değilse işlemi durdur.
                                                if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                                                    event.preventDefault();
                                                }
                                            }
                                        }
                                    }
                                
                                    div_anket_goster_alt.appendChild(kisayanit);
                                    sayac1++;
                                }
                                sayac2++;
                                sorusirasii++;

                            }
                            sayac++;

                            var div_onayla_btn = document.createElement("div");
                            div_onayla_btn.style.margin = "auto";
                            div_onayla_btn.style.textAlign = "center";
                            div_onayla_btn.style.marginTop = "10%";
                            //div_onayla_btn.style.backgroundColor = "red";

                            var btn_anket_sonucunu_kaydet = document.createElement("input");
                            btn_anket_sonucunu_kaydet.type = "button";
                            btn_anket_sonucunu_kaydet.id = "onayla";
                            btn_anket_sonucunu_kaydet.value = "ONAYLA";
                            btn_anket_sonucunu_kaydet.style.margin = "auto";

                            div_onayla_btn.appendChild(btn_anket_sonucunu_kaydet);
                            div_anket_goster_genel.appendChild(div_onayla_btn);

                            $("#onayla").click(function () {
                                var sayac7 = 0;
                                var sayac8 = 1;
                                var anket_onaylansin_mi = "evet";
                                for (var i = 0; i < divler_id.length; i += 3) {
                                    var cevapverilmismi = 0;
                                    var cevapverilmismi_array = new Array();
                                    if (sonuc1[sayac7 + 2].toString() == "Onay Kutusu") {
                                        for (var j = 0; j < $("#" + divler_id[i + 2].toString() + " input:checkbox").length ; j++) {
                                            if ($("#" + divler_id[i + 2].toString() + " input:checkbox").eq(j).attr("checked")) {
                                                cevapverilmismi++;
                                                j = $("#" + divler_id[i + 2].toString() + " input:checkbox").length;
                                            }
                                        }
                                    } else if (sonuc1[sayac7 + 2].toString() == "Çoktan Seçmeli") {
                                        for (var j = 0; j < $("#" + divler_id[i + 2].toString() + " input:radio").length ; j++) {
                                            if ($("#" + divler_id[i + 2].toString() + " input:radio").eq(j).attr("checked")) {
                                                cevapverilmismi++;
                                                j = $("#" + divler_id[i + 2].toString() + " input:radio").length;
                                            }
                                        }
                                    }
                                    else if (sonuc1[sayac7 + 2].toString() == "Sürekli Ölçek") {
                                        if ($("#" + divler_id[i + 2].toString() + " label").text().length > 0) {
                                            cevapverilmismi++;
                                        }
                                    }
                                    else if (sonuc1[sayac7 + 2].toString() == "Çoktan Seçmeli Tablosu") {

                                        var ilktrid = $("#" + divler_id[i + 2].toString() + " tr").eq(0).attr("id").toString();
                                        for (var j = 1; j < $("#" + divler_id[i + 2].toString() + " tr").length ; j++) {
                                            var trid = $("#" + divler_id[i + 2].toString() + " tr").eq(j).attr("id").toString();
                                            for (var k = 0; k < $("#" + trid.toString() + " input:radio").length ; k++) {
                                                if ($("#" + trid.toString() + " input:radio").eq(k).attr("checked")) {
                                                    cevapverilmismi++;
                                                    k = $("#" + trid.toString() + " input:radio").length;
                                                }
                                            }
                                            if (cevapverilmismi > 0) {
                                                cevapverilmismi_array.push("evet");
                                            }
                                            else {
                                                cevapverilmismi_array.push("hayır");
                                            }
                                            cevapverilmismi = 0;
                                        }
                                    }
                                    else if (sonuc1[sayac7 + 2].toString() == "Sürekli Ölçek Tablosu") {
                                        for (var j = 0; j < $("#" + divler_id[i + 2].toString() + " tr").length ; j++) {
                                            var trid = $("#" + divler_id[i + 2].toString() + " tr").eq(j).attr("id").toString();
                                            if ($("#" + trid.toString() + " label").text().length > 0) {
                                                cevapverilmismi_array.push("evet");
                                            }
                                            else {
                                                cevapverilmismi_array.push("hayır");
                                            }
                                        }
                                    }
                                    else if (sonuc1[sayac7 + 2].toString() == "Açık Uçlu") {
                                        if ($("#" + divler_id[i + 2].toString() + " textarea").val().trimEnd().trimStart().length > 0) {
                                            cevapverilmismi++;
                                        }
                                    }
                                    if (sonuc1[sayac7 + 2].toString() == "Çoktan Seçmeli Tablosu" || sonuc1[sayac7 + 2].toString() == "Sürekli Ölçek Tablosu") {
                                        if (a[sayac7 + 3].toString() == "evet") {
                                            for (var m = 0; m < cevapverilmismi_array.length; m++) {
                                                if (cevapverilmismi_array[m].toString() == "hayır") {
                                                    anket_onaylansin_mi = "hayır";
                                                    alert((sayac8) + "." + (m + 1) + "Numaralı soruyu cevaplamadınız !");
                                                    m = cevapverilmismi_array.length;
                                                    i = divler_id.length;
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        if (a[sayac7 + 3].toString() == "evet") {
                                            if (cevapverilmismi == 0) {
                                                anket_onaylansin_mi = "hayır";
                                                alert(((i / 3) + 1) + ". soruyu cevaplamadınız !");
                                                i = divler_id.length;
                                            }
                                        }
                                    }
                                    sayac7 += 4;
                                    sayac8++;
                                }

                                if (anket_onaylansin_mi == "evet") {
                                    var cevap = new Array();
                                    var sayac6 = 0;
                                    var anket_bitis_tarihi = new Date();

                                    PageMethods.yanitlayici_id(ankete_baslama_tarihi, anket_bitis_tarihi, basarili, basarisiz);
                                    function basarili() {
                                        for (var i = 0; i < divler_id.length; i += 3) {
                                            if (sonuc1[sayac6 + 2].toString() == "Onay Kutusu") {
                                                for (var j = 0; j < $("#" + divler_id[i + 2].toString() + " input:checkbox").length ; j++) {
                                                    if ($("#" + divler_id[i + 2].toString() + " input:checkbox").eq(j).attr("checked")) {
                                                        cevap.push($("#" + divler_id[i + 2].toString() + " label").eq(j).text());
                                                    }
                                                }
                                            } else if (sonuc1[sayac6 + 2].toString() == "Çoktan Seçmeli") {
                                                for (var j = 0; j < $("#" + divler_id[i + 2].toString() + " input:radio").length ; j++) {
                                                    if ($("#" + divler_id[i + 2].toString() + " input:radio").eq(j).attr("checked")) {
                                                        cevap.push($("#" + divler_id[i + 2].toString() + " label").eq(j).text());
                                                        //j = $("#" + divler_id[i + 2].toString() + " input:radio").length;
                                                    }
                                                }
                                            }
                                            else if (sonuc1[sayac6 + 2].toString() == "Sürekli Ölçek") {
                                                if ($("#" + divler_id[i + 2].toString() + " label").text().length > 0) {
                                                    cevap.push($("#" + divler_id[i + 2].toString() + " label").text());
                                                }
                                            }
                                            else if (sonuc1[sayac6 + 2].toString() == "Çoktan Seçmeli Tablosu") {

                                                var ilktrid = $("#" + divler_id[i + 2].toString() + " tr").eq(0).attr("id").toString();
                                                for (var j = 1; j < $("#" + divler_id[i + 2].toString() + " tr").length ; j++) {
                                                    var trid = $("#" + divler_id[i + 2].toString() + " tr").eq(j).attr("id").toString();
                                                    for (var k = 0; k < $("#" + trid.toString() + " input:radio").length ; k++) {
                                                        if ($("#" + trid.toString() + " input:radio").eq(k).attr("checked")) {
                                                            cevap.push($("#" + trid.toString() + " textarea").eq(0).text().toString());
                                                            cevap.push($("#" + ilktrid.toString() + " textarea").eq(k).text().toString());
                                                        }
                                                    }
                                                }
                                            }
                                            else if (sonuc1[sayac6 + 2].toString() == "Sürekli Ölçek Tablosu") {
                                                for (var j = 0; j < $("#" + divler_id[i + 2].toString() + " tr").length ; j++) {
                                                    var trid = $("#" + divler_id[i + 2].toString() + " tr").eq(j).attr("id").toString();
                                                    if ($("#" + trid.toString() + " label").text().length > 0) {
                                                        cevap.push($("#" + trid.toString() + " td").eq(0).text().toString());
                                                        cevap.push($("#" + trid.toString() + " label").text().toString());
                                                    }
                                                }
                                            }
                                            else if (sonuc1[sayac6 + 2].toString() == "Açık Uçlu") {
                                                cevap.push($("#" + divler_id[i + 2].toString() + " textarea").val().toString());
                                            }
                                            PageMethods.cevaplari_ekle(cevap, sonuc1[sayac6].toString(), sss, sss1);
                                            function sss() {
                                            }
                                            function sss1() {
                                                alert("Hata Oluştu !");
                                            }
                                            cevap.splice(0, cevap.length);
                                            sayac6 += 4;
                                            if (i +3== divler_id.length) {
                                                alert("Sonuclar Kaydedildi. Ankete Katıldığınız İçin Teşekkür Ederiz.");
                                                window.location = "Anasayfa.aspx";
                                                //window.close();
                                            }
                                        }
                                    }
                                    function basarisiz() {
                                        alert("Hata Oluştu");
                                    }

                                }
                            });
                        }
                    }
                }
                function islemHatali3(sonuc3) {
                    alert("işlem hatalı çıktı 3");
                }
            }
            function islemHatali2(sonuc2) {
                alert("işlem hatalı çıktı 2");
            }
        }
        function islemHatali1(sonuc1) {
            alert("işlem hatalı çıktı 1");
        }
    }
    function islemHatali(sonuc) {
        alert("işlem hatalı çıktı 0");

    }
    function fun(aa) {
        //var bbb = document.getElementById("stn5").clientWidth - 2;
        //var fark = document.getElementById("myRange" + a.toString()).max - document.getElementById("myRange" + a.toString()).min;
        slider = document.getElementById("myRange" + aa.toString());
        output = document.getElementById("demo" + aa.toString());
        output.innerHTML = slider.value;
        //var kacsol = ((slider.value) - document.getElementById("myRange" + a.toString()).min) * ((bbb) / (fark));
        //if (slider.value > document.getElementById("myRange" + a.toString()).max - 3) {
        //    kacsol -= 20;
        //}
        //alert(bbb.toString()+" " + slider.clientWidth);
        slider.oninput = function () {
            output.innerHTML = slider.value;
            var val = slider.value;
            var thumbwidth = 35;
            var pos = (val - document.getElementById("myRange" + aa.toString()).min) / (document.getElementById("myRange" + aa.toString()).max - document.getElementById("myRange" + aa.toString()).min);
            var thumbCorrect = thumbwidth * (pos - 0.5) * -1;
            var titlepos = Math.round((pos * slider.clientWidth) - thumbwidth / 4 + thumbCorrect);
            $("#demo" + aa.toString()).css({ "margin-left": titlepos });
            //alert(titlepos.toString());

        }
    }
</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">    </script>
<script type="text / javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"> </script>
<script src="js/main.js"></script>
