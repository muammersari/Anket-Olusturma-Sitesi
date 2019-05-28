<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Anket_Duzenle.aspx.cs" Inherits="newsurvey.Anket_Duzenle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .soruolustur {
            background-color: #E6E6FA;
            border-radius: 50%;
        }

            .soruolustur:hover {
                background-color: #CCFFCC;
            }
    </style>
</head>
<body style="background-color: #CCCCCC; margin: 0 auto; overflow-y: scroll;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div id="Div1" runat="server" style="height: 125px; width: 100%; background-color: #663399;"></div>
        <div style="position: absolute; left: 20%; right: 20%; top: 75px; height: auto; box-shadow: 0 0 5px 0px darkgreen; z-index: 1; background-color: white; border-radius: 10px;">

            <div id="divtextarea" style="width: 95%; height: auto; margin: auto; margin-top: 100px; margin-bottom: 50px; text-align: center;">
            </div>

            <div id="divgenel" style="width: 95%; height: 100%; margin: auto; margin-top: 50px; margin-bottom: 50px; text-align: center;">
            </div>
            <div id="divsonuc" style="width: 70%; height: 100%; margin: auto; text-align: center;">
                <input type="button" value="Anketi Kaydet" id="btnanketitamamla" onclick="anketionayla()" style="cursor: pointer; width: 110px; height: 30px; margin: auto; text-align: center; margin-top: 20px; margin-bottom: 20px; display: none; border-radius: 5px; background-color: yellowgreen; box-shadow: 0 0 5px 1px greenyellow; font-weight: 700; outline: 0;" />
            </div>
        </div>
        <div style="cursor: pointer; left: 81%; top: 35%; width: 50px; height: auto; position: fixed; border: 1.5px solid gray; outline: 0; border-radius: 10px;">
            <div style="text-align: center; border-bottom-style: solid; border-bottom-width: 0.2px; border-bottom-color: gray; padding: 5px;">
                <input type="image" title="Soru Ekle" src="resimler/iconfinder_add_3855641.png" class="soruolustur" value="Soru Ekle" id="Button1" style="cursor: pointer; width: 35px; height: 35px; border-style: none; outline: 0;" />
            </div>
            <div style="text-align: center; padding: 5px;">
                <input type="image" title="Anket Başlangıç Ve Bitiş Tarihi" src="resimler/iconfinder_9_2958195.png" class="soruolustur" value="Soru Ekle" id="anketayari" style="cursor: pointer; width: 32px; height: 32px; border:2px solid #4f4f4f; outline: 0;" />
            </div>
        </div>
        <div id="div_anket_ayari" runat="server" style="display: none; text-align: center; z-index: 4; cursor: pointer; left: 85%; top: 50%; width: 14%; height: auto; position: fixed; border: 1.5px solid gray; outline: 0; border-radius: 10px;">
            <div style="width: 100%; height: auto; margin-top: 10px;">
                <input type="button" id="div_tarih_kapat" value="X" style="float: right; background-color: #CCCCCC; outline: 0; border-style: none;" /><br />
            </div>
            <div style="width: 100%; height: auto; text-align: center;">
                <input type="date" id="baslangic_tarihi" runat="server" style="width: 80%; height: 25px; margin-top: 2%;" placeholder="Başlangıç Tarihi" />
            </div>
            <div style="width: 100%; height: auto; text-align: center;">
                <input type="date" id="bitis_tarihi" runat="server" style="width: 80%; height: 25px; margin-top: 5%;" placeholder="Bitiş Tarihi" />
            </div>
            <div style="width: 100%; height: auto; text-align: center;">
                <input type="button" id="tarihikaydet" value="Kaydet" style="width: 65%; height: 30px; margin-top: 5%; margin-bottom: 5%;" />
            </div>
        </div>

    </form>
</body>
</html>
<script>
  
    var anket_baslangic_tarihi = "-";
    var anket_bitis_tarihi = "-";
    document.getElementById("anketayari").onclick = function () {
        div_anket_ayari.style.display = "block";
        return false;
    }
    document.getElementById("div_tarih_kapat").onclick = function () {
        div_anket_ayari.style.display = "none";
        return false;
    }
    document.getElementById("tarihikaydet").onclick = function () {
        //var baslangic = new Date(document.getElementById("baslangic_tarihi").value.t);
        //var baslangic1 = new Date(baslangic.getFullYear(),baslangic.getMonth(),baslangic.getDay());
        //alert(baslangic);

        if (document.getElementById("baslangic_tarihi").value.length > 1 && document.getElementById("bitis_tarihi").value.length > 1) {
            var baslangic = new Date(document.getElementById("baslangic_tarihi").value.toString());
            //var bas = new Date(baslangic.getFullYear(),baslangic.getMonth(), baslangic.getDate());
            var bitis = new Date(document.getElementById("bitis_tarihi").value.toString());
            var simdi = new Date();
            var bugün = new Date(simdi.getFullYear(), simdi.getMonth(), simdi.getDate());
            if (baslangic >= bugün) {
                var snc = new Date(baslangic - bitis);
                var snc1 = (snc / 1000 / 60 / 60 / 24) * -1;
                if (snc1 > 0) {
                    anket_baslangic_tarihi = document.getElementById("baslangic_tarihi").value.toString();
                    anket_bitis_tarihi = document.getElementById("bitis_tarihi").value.toString();
                    div_anket_ayari.style.display = "none";
                }
                else {
                    document.getElementById("baslangic_tarihi").value = "";
                    document.getElementById("bitis_tarihi").value = "";
                    anket_baslangic_tarihi = "-";
                    anket_bitis_tarihi = "-";
                    anket_bitis_tarihi = document.getElementById("bitis_tarihi").value.toString();
                    alert("Başlangıç Tarihini Bitiş Tarihinden Sonraki Tarih yada Aynı Tarihi Seçemezsiniz !");
                }
            }
            else {
                document.getElementById("baslangic_tarihi").value = "";
                document.getElementById("bitis_tarihi").value = "";
                alert("Öceki Tarihi Seçemezsiniz !");
            }
        }
        else {
            document.getElementById("baslangic_tarihi").value = "";
            document.getElementById("bitis_tarihi").value = "";
            alert("Lütfen Tarih Bilgilerini Tam Giriniz !");
        }
    }




    document.getElementById("Button1").onclick = function () {
        soruekle("", "", "", "", "", "hayır");
        return false;
    }
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
    var c = new Array();
    var sayac = 0;
    var divler = new Array();
    var div_idleri = new Array();

    var sayac5 = 0;
    var sayac6 = 0;
    var sayac7 = 0;
    var sayac9 = 0;
    var divid = 0;
    var baslangic_yeri = 0;
    var sayac10 = 0;
    PageMethods.anket_ismi(islemBasarili, islemHatali);
    function islemBasarili(sonuc) {
        PageMethods.soru_secenekturu_ve_idleri(islemBasarili1, islemHatali1);
        function islemBasarili1(sonuc1) {
            PageMethods.secenekler(islemBasarili2, islemHatali2);
            function islemBasarili2(sonuc2) {
                PageMethods.sorunun_secenek_sayisi(islemBasarili3, islemHatali3);
                function islemBasarili3(sonuc3) {
                    if (sayac == 0) {
                        if (sonuc[3].length > 1) {
                            document.getElementById("baslangic_tarihi").value = sonuc[3].toString();
                            document.getElementById("bitis_tarihi").value = sonuc[4].toString();
                            anket_baslangic_tarihi = document.getElementById("baslangic_tarihi").value.toString();
                            anket_bitis_tarihi = document.getElementById("bitis_tarihi").value.toString();
                        }
                        for (var i = 0; i < sonuc1.length; i++) {
                            a.push(sonuc1[i].toString());
                        }
                        for (var i = 0; i < sonuc2.length; i++) {
                            b.push(sonuc2[i].toString());
                        }
                        for (var i = 0; i < sonuc3.length; i++) {
                            c.push(sonuc3[i].toString());
                        }

                        anket_islemleri(sonuc[0].toString(), sonuc[1].toString());
                        var sayac1 = 0;
                        var gidecegi_yer = 0;
                        for (var i = 0; i < a.length; i += 4) {
                            //if (a[i + 2].toString() != "Açık Uçlu") {
                                gidecegi_yer += parseInt(c[sayac1].toString());
                                sayac1++;
                            //}
                            soruekle(a[i + 1], a[i + 2], a[i + 3], gidecegi_yer, "evet");
                        }
                        sayac++;
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

    function anket_islemleri(isim, aciklama) {
        var txtanketismi1 = document.createElement("textarea");
        txtanketismi1.id = "txtanketismi";
        txtanketismi1.style.resize = "none";
        txtanketismi1.style.width = "80%";
        txtanketismi1.style.borderLeftStyle = "none";
        txtanketismi1.style.borderRightStyle = "none";
        txtanketismi1.style.borderTopStyle = "none";
        txtanketismi1.style.borderBottomColor = "lightslategray";
        txtanketismi1.style.borderBottomWidth = "2px";
        txtanketismi1.style.fontSize = "large";
        txtanketismi1.style.outline = "0";
        txtanketismi1.style.overflow = "hidden";
        txtanketismi1.rows = 1;
        txtanketismi1.style.verticalAlign = "right";
        txtanketismi1.style.font = "160%/1.2  Helvetica";
        txtanketismi1.style.verticalAlign = "top";
        if (isim.toString() == "") {
            txtanketismi1.placeholder = "Anket Başlığı";
        } else {
            txtanketismi1.innerHTML = isim.toString();
        }
        var txtanket_aciklamasi = document.createElement("textarea");
        txtanket_aciklamasi.id = "txtanketaciklamasi";
        txtanket_aciklamasi.style.resize = "none";
        txtanket_aciklamasi.style.width = "80%";
        txtanket_aciklamasi.style.borderLeftStyle = "none";
        txtanket_aciklamasi.style.borderRightStyle = "none";
        txtanket_aciklamasi.style.borderTopStyle = "none";
        txtanket_aciklamasi.style.borderBottomColor = "lightslategray";
        txtanket_aciklamasi.style.borderBottomWidth = "0.5px";
        txtanket_aciklamasi.style.fontSize = "large";
        txtanket_aciklamasi.style.outline = "0";
        txtanket_aciklamasi.style.overflow = "hidden";
        txtanket_aciklamasi.rows = 1;
        txtanket_aciklamasi.style.font = "90%/1.2  Helvetica";
        txtanket_aciklamasi.style.verticalAlign = "top";
        txtanket_aciklamasi.style.marginTop = "20px";
        if (aciklama.toString() == "") {
            txtanket_aciklamasi.placeholder = "Anket Açıklaması";
        } else {
            txtanket_aciklamasi.innerHTML = aciklama.toString();
        }
        divtextarea.appendChild(txtanketismi1);
        divtextarea.appendChild(txtanket_aciklamasi);
    }
    function soruekle(soru, secenekturu, zorunluu_mu, gidecegiyer, vt_mi) {

        var div_genel_alt = document.createElement("div");
        div_genel_alt.style.height = "auto";
        div_genel_alt.style.margin = "auto";
        div_genel_alt.style.marginTop = "15px";
        div_genel_alt.style.boxShadow = "0 0 5px 2px #663399";
        div_genel_alt.style.padding = "5px";

        var sayac = $('#divgenel div').length;

        if (div_idleri.length == 0) {
            divid = 0;
        } else {
            divid = div_idleri[div_idleri.length - 1].toString();
        }
        div_genel_alt.id = "divgenelalt" + (parseInt(divid) + 1);
        var divust = document.createElement("div");
        divust.id = "divust" + (parseInt(divid) + 1);
        divust.className = (parseInt(divid) + 1);
        divust.style.padding = "5px";
        divust.style.height = "auto";
        divust.style.margin = "auto";
        divust.style.boxShadow = "0 0 5px 2px lightgray";
        divust.style.marginTop = "5px";

        var divalt = document.createElement("div");
        divalt.id = "divalt" + (parseInt(divid) + 1);
        divalt.className = (parseInt(divid) + 1);
        divalt.style.padding = "5px";
        divalt.style.height = "auto";
        divalt.style.margin = "auto";
        divalt.style.marginTop = "5px";

        var divsoru_ayar = document.createElement("div");
        divsoru_ayar.id = "divsoru_ayar" + (parseInt(divid) + 1);
        divsoru_ayar.className = (parseInt(divid) + 1);
        divsoru_ayar.style.height = "25px";
        divsoru_ayar.style.margin = "auto";
        divsoru_ayar.style.marginTop = "5px";
        divsoru_ayar.style.borderTopStyle = "solid";
        divsoru_ayar.style.borderTopWidth = "1px";
        divsoru_ayar.style.borderTopColor = "gray";

        div_genel_alt.appendChild(divust);
        div_genel_alt.appendChild(divalt);
        div_genel_alt.appendChild(divsoru_ayar);

        divsoru_ayar.innerHTML = "";
        var zorunlumu = document.createElement("input");
        zorunlumu.type = "checkbox";
        zorunlumu.style.width = "20px";
        zorunlumu.style.height = "20px";
        zorunlumu.style.verticalAlign = "bottom";
        zorunlumu.style.float = "right";
        zorunlumu.style.marginRight = "11%";
        zorunlumu.style.lineHeight = "25px";

        var labelzorunlumu = document.createElement("label");
        labelzorunlumu.innerHTML = "Gerekli";
        labelzorunlumu.style.verticalAlign = "bottom";
        labelzorunlumu.style.float = "right";
        labelzorunlumu.style.marginRight = "10px";
        labelzorunlumu.style.lineHeight = "25px";
        if (zorunluu_mu.toString() == "evet") {
            zorunlumu.checked = true;
        }
        divsoru_ayar.appendChild(zorunlumu);
        divsoru_ayar.appendChild(labelzorunlumu);
        if (secenekturu.toString() == "Açık Uçlu") {
            var zorunlumu1 = document.createElement("input");
            zorunlumu1.type = "checkbox";
            zorunlumu1.style.width = "20px";
            zorunlumu1.style.height = "20px";
            zorunlumu1.style.verticalAlign = "bottom";
            zorunlumu1.style.float = "right";
            zorunlumu1.style.marginRight = "4%";
            zorunlumu1.style.lineHeight = "25px";

            var labelzorunlumu1 = document.createElement("label");
            labelzorunlumu1.innerHTML = "Sadece Numerik Değer Girilsin";
            labelzorunlumu1.style.verticalAlign = "bottom";
            labelzorunlumu1.style.float = "right";
            labelzorunlumu1.style.marginRight = "10px";
            labelzorunlumu1.style.lineHeight = "25px";

            if (b[baslangic_yeri].toString() =="numerik") {
                zorunlumu1.checked = true;
            }
            divsoru_ayar.appendChild(zorunlumu1);
            divsoru_ayar.appendChild(labelzorunlumu1);
        }

        var cb = document.createElement("select");
        cb.id = "select" + (parseInt(divid) + 1);
        cb.style.height = "30px";
        cb.style.backgroundColor = "#CCCCFF";
        cb.style.borderStyle = "none";
        cb.style.outline = "0";
        cb.style.width = "23";
        cb.style.margin = "auto";
        cb.style.textAlign = "center";
        cb.style.marginRight = "2%";
        var opt = document.createElement("option");
        opt.text = "Seçiniz";
        opt.value = "0";
        var opt1 = document.createElement("option");
        opt1.text = "Onay Kutusu";
        opt1.value = "1";
        var opt2 = document.createElement("option");
        opt2.text = "Çoktan Seçmeli";
        opt2.value = "2";
        var opt3 = document.createElement("option");
        opt3.text = "Sürekli Ölçek";
        opt3.value = "3";
        var opt4 = document.createElement("option");
        opt4.text = "Çoktan Seçmeli Tablosu";
        opt4.value = "4";
        var opt5 = document.createElement("option");
        opt5.text = "Sürekli Ölçek Tablosu";
        opt5.value = "5";
        var opt6 = document.createElement("option");
        opt6.text = "Açık Uçlu";
        opt6.value = "6";
        cb.options.add(opt);
        cb.options.add(opt1);
        cb.options.add(opt2);
        cb.options.add(opt3);
        cb.options.add(opt4);
        cb.options.add(opt5);
        cb.options.add(opt6);
      
        for (var i = 0; i < gidecegiyer; i++) {
        }
        var ilk_deger;
        cb.onclick = function () {
            ilk_deger = cb[cb.selectedIndex].text;
        }
        cb.onchange = function () {
            var secilen_deger = cb[cb.selectedIndex].text;
            if (secilen_deger != ilk_deger) {
                divalt.innerHTML = "";
                divsoru_ayar.innerHTML = "";
                var zorunlumu = document.createElement("input");
                zorunlumu.type = "checkbox";
                zorunlumu.style.width = "20px";
                zorunlumu.style.height = "20px";
                zorunlumu.style.verticalAlign = "bottom";
                zorunlumu.style.float = "right";
                zorunlumu.style.marginRight = "11%";
                zorunlumu.style.lineHeight = "25px";

                var labelzorunlumu = document.createElement("label");
                labelzorunlumu.innerHTML = "Gerekli";
                labelzorunlumu.style.verticalAlign = "bottom";
                labelzorunlumu.style.float = "right";
                labelzorunlumu.style.marginRight = "10px";
                labelzorunlumu.style.lineHeight = "25px";
                //if (zorunluu_mu.toString() == "evet") {
                //    zorunlumu.checked = true;
                //}
                divsoru_ayar.appendChild(zorunlumu);
                divsoru_ayar.appendChild(labelzorunlumu);

                secenek_turu_al(divalt.id.toString(), secilen_deger.toString(), "", "hayır");

                if (secilen_deger.toString() == "Açık Uçlu") {
                    var zorunlumu1 = document.createElement("input");
                    zorunlumu1.type = "checkbox";
                    zorunlumu1.style.width = "20px";
                    zorunlumu1.style.height = "20px";
                    zorunlumu1.style.verticalAlign = "bottom";
                    zorunlumu1.style.float = "right";
                    zorunlumu1.style.marginRight = "4%";
                    zorunlumu1.style.lineHeight = "25px";

                    var labelzorunlumu1 = document.createElement("label");
                    labelzorunlumu1.innerHTML = "Sadece Numerik Değer Girilsin";
                    labelzorunlumu1.style.verticalAlign = "bottom";
                    labelzorunlumu1.style.float = "right";
                    labelzorunlumu1.style.marginRight = "10px";
                    labelzorunlumu1.style.lineHeight = "25px";

                    divsoru_ayar.appendChild(zorunlumu1);
                    divsoru_ayar.appendChild(labelzorunlumu1);
                }
            }
        }
        var txtsoru = document.createElement("textarea");
        txtsoru.id = "soru" + (parseInt(divid) + 1);
        txtsoru.style.borderLeftStyle = "none";
        txtsoru.style.borderTopStyle = "none";
        txtsoru.style.borderRightStyle = "none";
        txtsoru.style.resize = "none";
        txtsoru.style.borderBottomColor = "lightslategray";
        txtsoru.style.borderBottomWidth = "1.5px";
        txtsoru.style.outline = "0";
        txtsoru.style.width = "50%";
        txtsoru.style.fontSize = "large";
        txtsoru.style.overflow = "hidden";
        txtsoru.style.marginRight = "2%";
        txtsoru.style.verticalAlign = "top";
        txtsoru.rows = 1;
        txtsoru.style.font = "125%/1.2  Helvetica";
        if (vt_mi.toString() == "hayır") {
            txtsoru.placeholder = "Soru";
        } else {
            txtsoru.innerHTML = soru.toString();
        }
        var soru_sil = document.createElement("input");
        soru_sil.setAttribute("type", "button");
        soru_sil.value = "x";
        soru_sil.id = (parseInt(divid) + 1);;
        soru_sil.style.height = "35px";
        soru_sil.style.width = "35px";
        soru_sil.style.lineHeight = "30px";
        soru_sil.style.fontSize = "x-large";
        soru_sil.style.borderRadius = "30%";
        soru_sil.style.border = "1px solid gray";
        soru_sil.style.backgroundColor = "white";
        soru_sil.style.borderStyle = "none";
        soru_sil.style.boxShadow = " 0 0 5px 2px gray";
        soru_sil.style.outline = "0";
        soru_sil.style.font = "125%/1.2  Helvetica";
        soru_sil.onclick = function () {
            sorusil(this.id.toString());
        }
        divust.appendChild(txtsoru);
        divust.appendChild(cb);
        divust.appendChild(soru_sil);


        divler.push(divust.id.toString());
        divler.push(divsoru_ayar.id.toString());
        divler.push(divalt.id.toString());
        div_idleri.push(parseInt(divid) + 1);

        divgenel.appendChild(div_genel_alt);
        document.getElementById("btnanketitamamla").style.display = "block";
        if (vt_mi.toString() == "evet") {
            if (secenekturu == "Onay Kutusu") {
                cb.value = "1";
            }
            else if (secenekturu == "Çoktan Seçmeli") {
                cb.value = "2";
            }
            else if (secenekturu == "Sürekli Ölçek") {
                cb.value = "3";
            }
            else if (secenekturu == "Çoktan Seçmeli Tablosu") {
                cb.value = "4";
            }
            else if (secenekturu == "Sürekli Ölçek Tablosu") {
                cb.value = "5";
            }
            else if (secenekturu == "Açık Uçlu") {
                cb.value = "6";
            }
            secenek_turu_al(divalt.id.toString(), secenekturu.toString(), gidecegiyer.toString(), "evet");
        } else {
            secenek_turu_al(divalt.id.toString(), secenekturu.toString(), "", "hayır");
            window.scrollTo(0, 10000);
        }
        

    }

    function secenek_turu_al(divalt, secilen_deger, gidecegiyer, vt_mi) {

        sayac9++;
        if (secilen_deger.toString() == "Onay Kutusu") {
            var divsecenek = document.createElement("div");
            divsecenek.style.margin = "auto";
            divsecenek.style.textAlign = "center";
            divsecenek.id = "divsecenek3" + sayac9.toString();
            divsecenek.style.padding = "1%";
            divsecenek.style.height = "auto";

            var a = document.createElement("textarea");
            a.id = "secenektext3" + sayac9.toString();
            a.value = "Secenek Ekle";
            a.style.borderLeftStyle = "none";
            a.style.borderRightStyle = "none";
            a.style.borderTopStyle = "none";
            a.style.borderBottomColor = "lightslategray";
            a.style.borderBottomWidth = "1.25px";
            a.style.resize = "none";
            a.style.outline = "0";
            a.style.width = "70%";
            a.style.marginRight = "4.5%";
            a.style.fontSize = "large";
            a.style.overflow = "hidden";
            a.style.font = "100%/1.2  Helvetica";
            a.rows = 1;
            a.readOnly = "true";
            a.onclick = function () {
                secenekekle(divalt.toString(), divsecenek.id.toString(), "sabit", "yok");
            }
            divsecenek.appendChild(a);
            document.getElementById(divalt.toString()).appendChild(divsecenek);
            if (vt_mi.toString() == "evet") {
                for (var i = baslangic_yeri; i < gidecegiyer; i++) {
                    secenekekle(divalt.toString(), divsecenek.id.toString(), "sabit", b[i].toString());
                    baslangic_yeri++;
                }
            }

        } else if (secilen_deger.toString() == "Çoktan Seçmeli") {
            sayac9++;

            var divsecenek = document.createElement("div");
            divsecenek.style.margin = "auto";
            divsecenek.style.textAlign = "center";
            divsecenek.id = "divsecenek4" + sayac9.toString();
            divsecenek.style.padding = "1%";
            divsecenek.style.height = "auto";

            var a = document.createElement("textarea");
            a.id = "secenektext4" + sayac9.toString();
            a.value = "Secenek Ekle";
            a.style.borderLeftStyle = "none";
            a.style.borderRightStyle = "none";
            a.style.borderTopStyle = "none";
            a.style.borderBottomColor = "lightslategray";
            a.style.borderBottomWidth = "1.25px";
            a.style.resize = "none";
            a.style.outline = "0";
            a.style.width = "70%";
            a.style.marginRight = "4.5%";
            a.style.fontSize = "large";
            a.style.overflow = "hidden";
            a.rows = 1;
            a.style.font = "100%/1.2  Helvetica";
            a.readOnly = "true";
            a.onclick = function () {
                secenekekle(divalt.toString(), divsecenek.id.toString(), "sabit", "yok");
            }
            divsecenek.appendChild(a);
            document.getElementById(divalt.toString()).appendChild(divsecenek);

            if (vt_mi.toString() == "evet") {
                for (var i = baslangic_yeri; i < gidecegiyer; i++) {
                    secenekekle(divalt.toString(), divsecenek.id.toString(), "sabit", b[i].toString());
                    baslangic_yeri++;
                }
            }

        } else if (secilen_deger == "Sürekli Ölçek") {
            if (vt_mi.toString() == "evet") {
                document.getElementById(divalt.toString()).innerHTML += "<br/>Min : <input type='text' class='araliktext' value='" + b[baslangic_yeri].toString() + "' id='textaralık1-" + (parseInt(divid) + 1) + "' style='width:50px;'/>&nbsp;  ---------  &nbsp;Maks : <input type='text' value='" + b[baslangic_yeri + 1].toString() + "' class='araliktext' id='textaralık2-" + (parseInt(divid) + 1) + "' style='width:50px;'/><br/><br/> <input type='text' id='sosecenektext1-" + (parseInt(divid) + 1) + "' value='" + b[baslangic_yeri + 2].toString() + "' style='width:80%;'/><br/><br/><input type='text' id='sosecenektext2-" + (parseInt(divid) + 1) + "' value='" + b[baslangic_yeri + 3].toString() + "' style='width:80%;'/> <br/><br/>";
                baslangic_yeri += 4;
            } else {
                document.getElementById(divalt.toString()).innerHTML += "<br/>Min : <input type='text' class='araliktext' value='0' id='textaralık1-" + (parseInt(divid) + 1) + "' style='width:50px;'/>&nbsp;  ---------  &nbsp;Maks : <input type='text' value='100' class='araliktext' id='textaralık2-" + (parseInt(divid) + 1) + "' style='width:50px;'/><br/><br/> <input type='text' placeHolder='Sol Uç Etiket' id='sosecenektext1-" + (parseInt(divid) + 1) + "' style='width:80%;'/><br/><br/><input type='text'placeHolder='Sağ Uç Etiket' id='sosecenektext2-" + (parseInt(divid) + 1) + "' style='width:80%;'/> <br/><br/>";
            }
            $(".araliktext").keyup(function () {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                    this.style.font = "125%/1.2 Helvetica";
                }
            });

        } else if (secilen_deger == "Açık Uçlu") {
            var kisayanit = document.createElement("input");
            kisayanit.type = "text";
            kisayanit.disabled = "true";
            kisayanit.style.width = "70%";
            kisayanit.style.borderLeftStyle = "none";
            kisayanit.style.borderRightStyle = "none";
            kisayanit.style.borderTopStyle = "none";
            kisayanit.style.borderBottomColor = "lightslategray";
            kisayanit.style.backgroundColor = "white";
            kisayanit.value = "kısa metin";
            kisayanit.style.font = "100%/1.2  Helvetica";
            document.getElementById(divalt.toString()).appendChild(kisayanit);
            if (vt_mi.toString() == "evet") {
                baslangic_yeri++;
            }
        }
        else if (secilen_deger == "Çoktan Seçmeli Tablosu") {
            sayac6++;
            sayac5++;
            var divsol1 = document.createElement("Panel");
            divsol1.style.width = "50%";
            divsol1.style.height = "auto";
            divsol1.id = "divsolbes" + sayac5.toString();
            divsol1.style.display = "inline-block";
            divsol1.style.verticalAlign = "top";
            divsol1.style.marginTop = "10px";

            document.getElementById(divalt.toString()).appendChild(divsol1);

            var divsag2 = document.createElement("Panel");
            divsag2.style.width = "50%";
            divsag2.style.height = "auto";
            divsag2.id = "divsagalti" + sayac5.toString();
            divsag2.style.display = "inline-block";
            divsag2.style.verticalAlign = "top";
            divsag2.style.marginTop = "10px";

            document.getElementById(divalt.toString()).appendChild(divsag2);

            //#########################################################  DİV SOL İÇİN EKLENEN BÖLÜM  ####################################################################

            var divsatir_sabit1 = document.createElement("div");
            divsatir_sabit1.style.width = "100%";
            divsatir_sabit1.style.height = "auto";
            divsatir_sabit1.id = "sabitbes" + sayac5.toString();
            divsatir_sabit1.style.marginTop = "3%";

            var txt_sabit1 = document.createElement("input");
            txt_sabit1.type = "text";
            txt_sabit1.value = "Satır Ekle";
            txt_sabit1.style.borderLeft = "none";
            txt_sabit1.style.borderTop = "none";
            txt_sabit1.style.borderRight = "none";
            txt_sabit1.style.borderBottomWidth = "1.25px";
            txt_sabit1.style.borderColor = "lightslategray";
            txt_sabit1.style.width = "70%";
            txt_sabit1.style.height = "30px";
            txt_sabit1.style.marginRight = "7.4%";
            txt_sabit1.style.outline = "0";
            txt_sabit1.style.resize = "none";
            txt_sabit1.autocomplete = "off";
            txt_sabit1.style.font = "100%/1.2  Helvetica";
            txt_sabit1.readOnly = "true";
            txt_sabit1.onclick = function () {
                secenekekle(divsol1.id.toString(), divsatir_sabit1.id.toString(), "sabit", "yok");
            }
            divsatir_sabit1.appendChild(txt_sabit1);
            divsol1.appendChild(divsatir_sabit1);

            //##############################################################  DİV SAĞ İÇİN EKLENEN BÖLÜM  ####################################################################################

            var divsatir_sabit2 = document.createElement("div");
            divsatir_sabit2.style.width = "100%";
            divsatir_sabit2.style.height = "auto";
            divsatir_sabit2.id = "sabitalti" + sayac6.toString();
            divsatir_sabit2.style.marginTop = "3%";

            var txt_sabit2 = document.createElement("input");
            txt_sabit2.type = "text";
            txt_sabit2.value = "Sütun Ekle";
            txt_sabit2.style.borderLeft = "none";
            txt_sabit2.style.borderTop = "none";
            txt_sabit2.style.borderRight = "none";
            txt_sabit2.style.borderBottomWidth = "1.25px";
            txt_sabit2.style.borderColor = "lightslategray";
            txt_sabit2.style.width = "70%";
            txt_sabit2.style.height = "30px";
            txt_sabit2.style.marginRight = "7.4%";
            txt_sabit2.style.outline = "0";
            txt_sabit2.style.resize = "none";
            txt_sabit2.autocomplete = "off";
            txt_sabit2.style.font = "100%/1.2  Helvetica";
            txt_sabit2.readOnly = "true";
            txt_sabit2.onclick = function () {
                secenekekle(divsag2.id.toString(), divsatir_sabit2.id.toString(), "sabit", "yok");
            }
            divsatir_sabit2.appendChild(txt_sabit2);
            divsag2.appendChild(divsatir_sabit2);
            if (vt_mi.toString() == "evet") {
                var satir = parseInt(b[baslangic_yeri].toString());
                var sutun = parseInt(b[baslangic_yeri + 1].toString());
                baslangic_yeri += 2;
                for (var i = 0; i < satir ; i++) {
                    secenekekle(divsol1.id.toString(), divsatir_sabit1.id.toString(), "sabit", b[baslangic_yeri].toString());
                    baslangic_yeri++;
                }
                for (var i = 0; i < sutun ; i++) {
                    secenekekle(divsag2.id.toString(), divsatir_sabit2.id.toString(), "sabit", b[baslangic_yeri].toString());
                    baslangic_yeri++;
                }
            }

            //############################################################################################################################
        } else if (secilen_deger == "Sürekli Ölçek Tablosu") {
            sayac7++;
            var divyatay = document.createElement("Panel");
            divyatay.style.width = "100%";
            divyatay.style.height = "auto";
            divyatay.id = "divyatay2" + sayac7.toString();
            divyatay.style.marginBottom = "2%";

            if (vt_mi.toString() == "evet") {
                divyatay.innerHTML += "<br/>Min : <input type='text' class='araliktext' id='textaralık1-" + 0 + "' value='" + b[baslangic_yeri].toString() + "' style='width:50px;'/>&nbsp; --------- &nbsp;Maks : <input type='text' value='" + b[baslangic_yeri + 1].toString() + "' class='araliktext' id='textaralık2-" + 0 + "' style='width:50px;'/>";
            } else {
                divyatay.innerHTML += "<br/>Min : <input type='text' class='araliktext' id='textaralık1-" + 0 + "' value='0' style='width:50px;'/>&nbsp; --------- &nbsp;Maks : <input type='text' value='100' class='araliktext' id='textaralık2-" + 0 + "' style='width:50px;'/>";
            }
            document.getElementById(divalt.toString()).appendChild(divyatay);

            document.getElementById(divalt.toString()).innerHTML += "<br/>";
            $(".araliktext").keyup(function () {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                    this.style.font = "100%/1.2  Helvetica";
                }
            });

            var divsol3 = document.createElement("Panel");
            divsol3.style.width = "100%";
            divsol3.style.height = "auto";
            divsol3.id = "divsolyedi" + sayac7.toString();
            divsol3.style.display = "inline-block";
            divsol3.style.verticalAlign = "top";
            divsol3.style.marginTop = "2%";

            document.getElementById(divalt.toString()).appendChild(divsol3);

            //#########################################################  DİV SOL İÇİN EKLENEN BÖLÜM  ####################################################################


            var divsatir_sabit3 = document.createElement("div");
            divsatir_sabit3.style.width = "100%";
            divsatir_sabit3.style.height = "auto";
            divsatir_sabit3.id = "sabityedi" + sayac7.toString();

            var txt_sabit3 = document.createElement("input");
            txt_sabit3.type = "text";
            txt_sabit3.value = "Satır Ekle";
            txt_sabit3.style.borderLeft = "none";
            txt_sabit3.style.borderTop = "none";
            txt_sabit3.style.borderRight = "none";
            txt_sabit3.style.borderColor = "lightslategray";
            txt_sabit3.style.borderBottomWidth = "1.25px";
            txt_sabit3.style.width = "70%";
            txt_sabit3.style.height = "30px";
            txt_sabit3.style.outline = "0";
            txt_sabit3.style.resize = "none";
            txt_sabit3.autocomplete = "off";
            txt_sabit3.style.marginRight = "4.50%";
            txt_sabit3.style.font = "100%/1.2  Helvetica";
            txt_sabit3.readOnly = "true";
            txt_sabit3.onclick = function () {
                secenekekle(divsol3.id.toString(), divsatir_sabit3.id.toString(), "sabit", "yok");
            }

            divsatir_sabit3.appendChild(txt_sabit3);
            divsol3.appendChild(divsatir_sabit3);
            if (vt_mi.toString() == "evet") {
                baslangic_yeri += 2;
                for (var i = baslangic_yeri; i < gidecegiyer ; i++) {
                    secenekekle(divsol3.id.toString(), divsatir_sabit3.id.toString(), "sabit", b[baslangic_yeri].toString());
                    baslangic_yeri++;
                }
            }
        }
    }


    function sorusil(divid) {
        $("#divust" + divid).remove();
        $("#divsoru_ayar" + divid).remove();
        $("#divalt" + divid).remove();
        $("#divgenelalt" + divid).remove();
        for (var i = 0; i < divler.length; i++) {
            if (divler[i].toString() == "divust" + divid.toString()) {
                divler.splice(i, 1);
            }
            if (divler[i].toString() == "divsoru_ayar" + divid.toString()) {
                divler.splice(i, 1);
            }
            if (divler[i].toString() == "divalt" + divid.toString()) {
                divler.splice(i, 1);
            }
        }
        for (var i = 0; i < div_idleri.length; i++) {
            if (div_idleri[i] == divid) {
                div_idleri.splice(i, 1);
            }
        }
    }



    var nereyeeklenecek;
    function secenekekle(divalt_idd, divscnk, sabitmi, vt_secenek) {
        sayac9++;

        var divsecenek = document.createElement("div");
        divsecenek.style.margin = "auto";
        divsecenek.style.textAlign = "center";
        divsecenek.id = "divsecenek5" + sayac9.toString();
        divsecenek.className = sayac9.toString();
        divsecenek.style.padding = "5px";
        divsecenek.style.height = "auto";
        divsecenek.style.verticalAlign = "text-left";

        var a = document.createElement("textarea");
        a.id = "secenektext5" + sayac9.toString();
        a.style.borderLeftStyle = "none";
        a.style.borderRightStyle = "none";
        a.style.borderTopStyle = "none";
        a.style.borderBottomColor = "lightslategray";
        a.style.borderBottomWidth = "1.25px";
        a.style.resize = "none";
        a.className = sayac9.toString();
        a.style.outline = "0";
        a.style.width = "70%";
        a.style.fontSize = "large";
        a.style.overflow = "hidden";
        a.rows = 1;
        a.style.verticalAlign = "top";
        a.style.font = "100%/1.2  Helvetica";
        a.onkeydown = function () {
            if (event.keyCode == 13) {
                nereyeeklenecek = a.className.toString();
                secenekekle(divalt_idd, nereyeeklenecek, "sabit değil", "yok");
            }
        }
        if (vt_secenek.toString() != "yok") {
            a.innerText = vt_secenek.toString();
        }
        var b = document.createElement("input");
        b.setAttribute("type", "button");
        b.id = "btnseceneksil5" + sayac9.toString();
        b.className = sayac9.toString();
        b.value = "X";
        b.style.marginLeft = "1%";
        b.style.borderStyle = "none";
        b.style.backgroundColor = "white";
        b.style.fontSize = "large";
        b.style.color = "gray";
        b.style.verticalAlign = "top";
        b.style.outline = "0";
        b.onclick = function () {
            $("#" + divsecenek.id.toString()).remove();
        }

        divsecenek.appendChild(a);
        divsecenek.appendChild(b);
        $("#" + divalt_idd.toString()).append(divsecenek);

        if (sabitmi.toString() == "sabit") {
            $("#" + divsecenek.id.toString()).insertBefore("#" + divscnk.toString());
            a.focus();

        } else {
            $("#" + divsecenek.id.toString()).insertAfter("#divsecenek5" + divscnk.toString());
            a.focus();
        }
    }







    function anketionayla() {

        var sayac11 = 0;
        var secenekler = new Array();
        var anketismi = document.getElementById("txtanketismi").value;
        var anketaciklamasi = document.getElementById("txtanketaciklamasi").value;


        var sorusayisi = divler.length / 3;
        var sorusirasi = 1;
        if (divler.length > 0) {
            for (var i = 0; i < divler.length; i += 3) {
                var varmi = "devam";
                secenekler.splice(0, secenekler.length);
                var soru = $("#" + divler[i].toString() + " textarea").val();
                var secenek_turu = $("#" + divler[i].toString() + " :selected").text();
                if (secenek_turu == "Onay Kutusu" || secenek_turu == "Çoktan Seçmeli" || secenek_turu == "Çoktan Seçmeli Tablosu" || secenek_turu == "Sürekli Ölçek Tablosu") {
                    var dongu1 = $("#" + divler[i + 2].toString() + " textarea").length;
                    for (var j = 0; j < dongu1; j++) {
                        secenekler.push($("#" + divler[i + 2].toString() + " textarea").eq(j).val());
                    }
                } else if (secenek_turu == "Sürekli Ölçek") {
                    for (var j = 0; j < $("#" + divler[i + 2].toString() + " input:text").length; j++) {
                        secenekler.push($("#" + divler[i + 2].toString() + " input:text").eq(j).val());
                    }
                } else if (secenek_turu == "Açık Uçlu") {
                    secenekler.push(" ");
                }
                //else if (secenek_turu == "Çoktan Seçmeli Tablosu" || secenek_turu == "Sürekli Ölçek Tablosu") {
                //    for (var j = 0; j < $("#" + divler[i + 2].toString() + " textarea").length; j++) {
                //        secenekler.push($("#" + divler[i + 2].toString() + " textarea").eq(j).val());
                //    }
                //}

                var esitmi = new Array();
                var secenekbosmu = 0;

                for (var k = 0; k < secenekler.length; k++) {
                    if (secenekler.length > 1) {
                        a = secenekler[k].toString();
                        for (var m = k + 1; m < secenekler.length; m++) {
                            if (a.toString() == secenekler[m].toString()) {
                                esitmi.push("esit");
                            }
                        }
                    }
                    if (secenek_turu != "Açık Uçlu") {
                        if (secenekler[k].length == 0) {
                            secenekbosmu++;
                        }
                    }

                    if (secenek_turu == "Sürekli Ölçek Tablosu" || secenek_turu == "Sürekli Ölçek") {
                        if (parseFloat(secenekler[0]) >= parseFloat(secenekler[1])) {
                            varmi = "kucuk";
                        }
                        if (secenekler[0].length == 0 || secenekler[1].length == 0) {
                            varmi = "bos";
                        }
                    }
                }


                if (anketismi.length > 0) {
                    if (anketaciklamasi.length > 0) {
                        if (soru.length > 0) {
                            if (secenek_turu == "Onay Kutusu" || secenek_turu == "Çoktan Seçmeli" || secenek_turu == "Sürekli Ölçek" || secenek_turu == "Çoktan Seçmeli Tablosu" || secenek_turu == "Sürekli Ölçek Tablosu" || secenek_turu == "Açık Uçlu") {
                                if (secenekler.length > 0) {
                                    if (secenekbosmu == 0) {
                                        if (varmi == "devam") {
                                            if (esitmi.length == 0) {
                                                sayac11++;
                                            }
                                            else {
                                                alert("" + sorusirasi + ". Soruda Aynı Seçeneği İki Defa Yazdınız. !");
                                            }
                                        }
                                        else if (varmi == "kucuk") {
                                            alert("" + sorusirasi + ". Soruda 1. Aralığı 2. Aralıktan Küçük Giriniz !");
                                        }
                                        else {
                                            alert("" + sorusirasi + ". Soruda Aralığı Boş Girdiniz !");
                                        }
                                    }
                                    else {
                                        alert("" + sorusirasi + ". Soruda Seceneği Boş Bıraktınız !");
                                    }
                                }
                                else {
                                    alert("" + sorusirasi + ". Soruya Seçenek Eklemediniz !");
                                }
                            }
                            else {
                                alert("" + sorusirasi + ". Sorunun Seçenek Türünü Seçiniz !");
                            }
                        }
                        else {
                            alert("" + sorusirasi + ". Soruyu Boş Bıraktınız.Lütfen Düzeltiniz !");
                        }
                    }
                    else {
                        alert("Lütfen Anket Açıklaması Giriniz");
                    }
                }
                else {
                    alert("Lütfen Anket İsmini Giriniz !");
                }

                sorusirasi++;
            }

            sorusirasi = 1;

            if (sayac11 == sorusayisi && sayac11 > 0) {
                PageMethods.anket_ismi_ekle_ve_anket_id_bul(anketismi, anketaciklamasi, anket_baslangic_tarihi, anket_bitis_tarihi, islemBasarili3, islemHatali3);
                function islemBasarili3() {
                    for (var i = 0; i < divler.length; i += 3) {
                        var secenekler1 = new Array();
                        var zorunlu_mu = "";
                        var numerik_mi = "";

                        var soru1 = $("#" + divler[i].toString() + " textarea").val();
                        var secenek_turu1 = $("#" + divler[i].toString() + " :selected").text();


                        if (secenek_turu1 == "Açık Uçlu") {
                            if ($("#" + divler[i + 1].toString() + " input:checkbox").eq(1).attr("checked")) {
                                numerik_mi = "numerik";
                            } else {
                                numerik_mi = "yazi";
                            }
                            if ($("#" + divler[i + 1].toString() + " input:checkbox").eq(0).attr("checked")) {
                                zorunlu_mu = "evet";
                            } else {
                                zorunlu_mu = "hayır";
                            }
                        } else {
                            if ($("#" + divler[i + 1].toString() + " input:checkbox").eq(0).attr("checked")) {
                                zorunlu_mu = "evet";
                            } else {
                                zorunlu_mu = "hayır";
                            }
                        }


                        //if ($("#" + divler[i + 1].toString() + " input:checkbox").eq(0).attr("checked")) {
                        //    zorunlu_mu = "evet";
                        //} else {
                        //    zorunlu_mu = "hayır";
                        //}
                        if (secenek_turu1 == "Onay Kutusu" || secenek_turu1 == "Çoktan Seçmeli") {
                            var dongu2 = $("#" + divler[i + 2].toString() + " textarea").length;
                            for (var j = 0; j < dongu2 ; j++) {
                                if (dongu2 - 1 != j) {
                                    secenekler1.push($("#" + divler[i + 2].toString() + " textarea").eq(j).val());
                                }
                            }
                        } else if (secenek_turu1 == "Sürekli Ölçek") {
                            for (var j = 0; j < $("#" + divler[i + 2].toString() + " input:text").length; j++) {
                                secenekler1.push($("#" + divler[i + 2].toString() + " input:text").eq(j).val());
                            }
                        } else if (secenek_turu1 == "Çoktan Seçmeli Tablosu") {
                            secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(0).attr("id").toString() + " textarea").length.toString());
                            secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(1).attr("id").toString() + " textarea").length.toString());
                            for (var j = 0; j < 2; j++) {
                                for (var k = 0; k < parseInt(secenekler1[j].toString()) ; k++) {
                                    secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(j).attr("id").toString() + " textarea").eq(k).val().toString());
                                }
                            }
                        } else if (secenek_turu1 == "Sürekli Ölçek Tablosu") {
                            secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(0).attr("id").toString() + " input:text").eq(0).val().toString());
                            secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(0).attr("id").toString() + " input:text").eq(1).val().toString());
                            secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(1).attr("id").toString() + " textarea").length.toString());
                            for (var k = 0; k < parseInt(secenekler1[2].toString()) ; k++) {
                                secenekler1.push($("#" + $("#" + divler[i + 2].toString() + " Panel").eq(1).attr("id").toString() + " textarea").eq(k).val().toString());
                            }
                        } else if (secenek_turu1 == "Açık Uçlu") {
                            secenekler1.push(numerik_mi);
                        }
                        PageMethods.VeriTabaninaEkle(anketismi, soru1, secenek_turu1, sorusirasi, secenekler1, zorunlu_mu, islemBasarili2, islemHatali2);
                        function islemBasarili2(sonuc2) {
                            if (sorusayisi.toString() == sonuc2.toString()) {
                                divler.splice(0, divler.length);
                                div_idleri.splice(0, div_idleri.length);
                                divgenel.innerHTML = "";
                                document.getElementById("txtanketismi").value = "";
                                document.getElementById("txtanketaciklamasi").value = "";
                                document.getElementById("btnanketitamamla").style.display = "none";
                                PageMethods.anketsil(ib, ih);
                                function ib() {
                                    alert("Anketiniz Başarıyla Kaydedildi.");
                                    window.opener.location = "Anketler.aspx";
                                    PageMethods.anketlink_id(ib1, ih1);
                                    function ib1(id) {
                                        document.getElementById("link_div").style.display = "block";
                                        document.getElementById("txtlink").value = "http://msari14-001-site1.dtempurl.com/Anket.aspx?anketidd=" + id.toString();
                                        //document.getElementById("txtlink").value = "http://localhost:1607/anket.aspx?anketidd=" + sonuc.toString();
                                    }
                                    function ih1(id) {
                                        alert("hata oluştu");
                                    }
                                }
                                function ih() {
                                }
                              
                            }
                        }
                        function islemHatali2(sonuc2) {

                            alert("Hata Oluştu 1");
                        }
                        sorusirasi++;
                    }
                }
                function islemHatali3() {
                    alert("Hata oluştu 3");
                }
            }
        }
        else {
            alert("Lütfen Soru Oluşturunuz !");
        }

    }
    var link = document.createElement("div");
    link.id = "link_div";
    link.style.borderRadius = "10px";
    link.style.position = "fixed";
    link.style.left = "25%";
    link.style.top = "40%";
    link.style.right = "25%";
    link.style.height = "20%";
    link.style.width = "50%";
    link.style.backgroundColor = "lightgray";
    link.style.border = "1px solid darkgreen";
    link.style.display = "none";
    link.style.zIndex = 5;
    link.style.boxShadow = "0 0 8px 2px gray";

    var txt_link = document.createElement("input");
    txt_link.id = "txtlink";
    txt_link.type = "text";
    txt_link.style.width = "77%";
    txt_link.style.height = "30px";
    txt_link.style.marginLeft = "1%";
    txt_link.style.backgroundColor = "lightgray";
    txt_link.style.borderStyle = "none";
    txt_link.style.border = "1px solid gray";
    txt_link.style.font = font = "130%/1.2  Helvetica";
    txt_link.style.verticalAlign = "top";
    txt_link.style.borderLeft = "none";
    txt_link.style.borderTop = "none";
    txt_link.style.borderRight = "none";
    txt_link.style.borderBottomWidth = "2px";
    txt_link.style.outline = "0";



    var kopyala = document.createElement("input");
    kopyala.type = "button";
    kopyala.className = "classkopyala";
    kopyala.value = "Kopyala";
    kopyala.style.width = "18%";
    kopyala.style.height = "35px";
    kopyala.style.marginLeft = "1%";
    kopyala.style.verticalAlign = "top";
    kopyala.style.fontSize = "large";
    kopyala.style.borderRadius = "5px";
    kopyala.style.outline = 0;
    kopyala.style.backgroundColor = "lightgray";

    kopyala.onclick = function () {
        txt_link.select();
        document.execCommand("copy");
    }
    var closebtn2 = document.createElement("input");
    closebtn2.setAttribute("type", "button");
    closebtn2.value = "x";
    closebtn2.style.borderStyle = "none";
    closebtn2.style.fontSize = "x-large";
    closebtn2.style.outline = 0;
    closebtn2.style.backgroundColor = "lightgray";
    closebtn2.style.float = "right";
    closebtn2.style.marginRight = "7px";

    closebtn2.onclick = function () {
        link.style.display = "none";
    }
    var baslik = document.createElement("label");
    baslik.innerHTML = "Bağlantı Adresi";
    baslik.style.fontSize = "x-large";
    baslik.style.outline = 0;
    baslik.style.color = "#663399";
    baslik.style.backgroundColor = "lightgray";
    baslik.style.marginLeft = "40%";
    baslik.style.borderBottomStyle = "solid";
    baslik.style.borderBottomColor = "#663399";
    baslik.style.font = "20px arial,serif";
    baslik.style.borderBottomWidth = "2px";


    var dv2 = document.createElement("div");
    dv2.style.width = "100%";
    dv2.style.height = "50px";
    dv2.style.marginTop = "7px";
    dv2.style.backgroundColor = "lightgray";
    dv2.appendChild(closebtn2);
    dv2.appendChild(baslik);
    link.appendChild(dv2);
    link.appendChild(txt_link);
    link.appendChild(kopyala);
    form1.appendChild(link);
</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">    </script>
<script type="text / javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"> </script>
<script src="js/main.js"></script>
