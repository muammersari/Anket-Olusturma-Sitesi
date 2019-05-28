<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Anketler.aspx.cs" Inherits="newsurvey.Anketler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .classkopyala {
            background-color: lightgray;
            font-size: medium;
            color: black;
            border: 1px solid darkgreen;
            border-radius: 5px;
        }

            .classkopyala:hover {
                border-radius: 10px;
                background-color: #D8BFD8;
                /*border:1px solid darkgreen;*/
                border-bottom-style: solid;
                border-bottom-color: #636c85;
            }

        #hosgeldiniz {
            font: 110%/1.2 Helvetica;
            color: white;
        }

            #hosgeldiniz:hover {
                font: 113%/1.2 Helvetica;
                color: #D8BFD8;
            }

        #anketegit {
            background-color: #beb8b8;
        }

            #anketegit:hover {
                border-radius: 50%;
                background-color: #999999;
            }

        #btn {
            background-color: #F5F5F5;
            font-size: medium;
            color: black;
            border-style: none;
            border-radius: 5px;
        }

            #btn:hover {
                border-radius: 10px;
                background-color: #D8BFD8;
                /*border:1px solid darkgreen;*/
                border-bottom-style: solid;
                border-bottom-color: #663399;
            }

        .dropbtn {
            background-color: #663399;
            color: white;
            /*padding: 10px;*/
            margin-top: 10px;
            margin-right: 20px;
            width: 30px;
            height: 30px;
            border: none;
            cursor: pointer;
            outline: 0;
        }

        /*.dropbtn:hover {
                width: 32px;
                height: 32px;
            }*/

        .dropdown {
            position: relative;
            display: inline-block;
        }


        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            margin-right: 25px;
            border: 1px solid darkgreen;
        }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                text-align: center;
            }

        #cikis {
            background-color: white;
        }

        .dropdown-content a:hover {
            background-color: #CCCCCC;
        }

        .dropdown-content #cikis:hover {
            background-color: #CCCCCC;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
</head>
<body style="margin: 0 auto; background-color: #beb8b8; overflow-y: scroll;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div style="width: 100%; height: 100%;">
            <div style="width: 100%; height: 100px; background-color: #663399; box-shadow: 0 0 10px 4px gray;">
                <div class="dropdown" style="float: right; vertical-align: top; height: 50px;">
                    <input type="image" class="dropbtn" id="imagebuton" onclick="return false;" src="resimler/user-128.png" />
                    <div class="dropdown-content">
                        <a href="Hakkimizda.aspx" style="font-size: medium;">Hakkımızda</a>
                        <a href="Sifre_Degistir.aspx" style="font-size: medium;">Şifre Değiştir</a>
                        <asp:Button ID="cikis" runat="server" Text="Çıkış Yap" Style="font-size: medium; border-style: none; width: 100%; padding: 16px; cursor: pointer;" OnClick="cikis_Click" />
                    </div>
                </div>
                <label runat="server" id="hosgeldiniz" style="float: right; margin-right: 15px; padding: 16px; vertical-align: top;"></label>
            </div>
            <div id="genel" style="min-height: 80%; border-radius: 10px; position: absolute; left: 10%; right: 10%; top: 75px; background-color: #CCCCCC; text-align: center; border: 1px solid darkgreen; padding: 1%; box-shadow: 0 0 10px 1px gray;">
                <input type="image" title="Anket Oluştur" id="anketegit" class="aa" onclick="git()" src="resimler/iconfinder_add_3855641.png" style="cursor: pointer; left: 92.5%; top: 83%; width: 75px; height: 75px; position: fixed; border-style: none; outline: 0;" />
            </div>
        </div>
    </form>
</body>
</html>
<script>




    function islem() {
        return false;
    }
    function git() {
        window.open("Anket_Olustur.aspx");
        return false;
    }

    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
    var link = document.createElement("div");
    link.id = "link_div";
    link.style.borderRadius = "5px";
    link.style.position = "fixed";
    link.style.left = "35%";
    link.style.top = "40%";
    link.style.right = "35%";
    link.style.height = "20%";
    link.style.width = "35%";
    link.style.backgroundColor = "lightgray";
    link.style.border = "1px solid darkgreen";
    link.style.display = "none";
    link.style.zIndex = 4;
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
    //kopyala.style.backgroundColor = "lightgray";

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
    closebtn2.style.marginRight = closebtn2.width;
    closebtn2.onclick = function () {
        link.style.display = "none";
    }
    var dv2 = document.createElement("div");
    dv2.style.width = "100%";
    dv2.style.height = "50px";
    dv2.style.backgroundColor = "lightgray";
    dv2.appendChild(closebtn2);
    link.appendChild(dv2);
    link.appendChild(txt_link);
    link.appendChild(kopyala);
    form1.appendChild(link);

    var tablo = document.createElement("table");
    tablo.style.width = "99%";
    tablo.cellPadding = "2";
    var satir = document.createElement("tr");
    var sutun1 = document.createElement("td");
    sutun1.innerHTML = "No";
    sutun1.style.textAlign = "center";
    sutun1.style.width = "7%";
    sutun1.style.borderBottom = "2px solid darkgreen";
    sutun1.style.paddingBottom = "20px";
    sutun1.style.font = "140%/1.2 arial,serif";

    var sutun2 = document.createElement("td"); sutun2
    sutun2.innerHTML = "Anket İsmi";
    sutun2.style.width = "63%";
    sutun2.style.fontSize = "large";
    sutun2.style.borderBottom = "2px solid darkgreen";
    sutun2.style.font = "140%/1.2 arial,serif";

    satir.appendChild(sutun1);
    satir.appendChild(sutun2);
    tablo.appendChild(satir);
    genel.appendChild(tablo);

    PageMethods.anketisimleri(islemBasarili, islemHatali);
    function islemBasarili(sonuc) {
        if (sonuc.length == 0) {
            //genel.innerHTML += "<br/><br/>Kayıtlı Anketiniz Bulunmamaktadır. Anket Oluşturmak İçin Sağ Alt Taraftaki + Butonuna Basınız...";
            var bos_ise = document.createElement("label");
            bos_ise.innerHTML = "<br/><br/>Kayıtlı Anketiniz Bulunmamaktadır.<br/><br/> Anket Oluşturmak İçin Sağ Alt Taraftaki&nbsp;&nbsp;";
            bos_ise.style.fontSize = "xx-large";
            bos_ise.style.verticalAlign = "baseline";
            bos_ise.style.font = "170%/1.2 arial,serif";
            genel.appendChild(bos_ise);
            var resim = document.createElement("input");
            resim.type = "image";
            resim.src = "resimler/iconfinder_add_3855641.png";
            resim.style.width = "50px";
            resim.style.verticalAlign = "baseline";
            resim.disabled = "true";
            genel.appendChild(resim);
            var bos_ise1 = document.createElement("label");
            bos_ise1.innerHTML = "&nbsp;&nbsp;Butonuna Basınız...";
            bos_ise1.style.fontSize = "xx-large";
            bos_ise1.style.verticalAlign = "baseline";
            bos_ise1.style.font = "200%/1.2 arial,serif";
            genel.appendChild(bos_ise1);


        }
        else {
            var a = sonuc.length / 2;
            for (var i = 0; i < sonuc.length / 2; i++) {

                var satir1 = document.createElement("tr");
                satir1.id = "satir1" + i.toString();
                satir1.className = i.toString();
                var sutun_anket_id = document.createElement("td");
                sutun_anket_id.style.width = "7%";
                sutun_anket_id.style.textAlign = "center";

                var sutun_anket_ismi = document.createElement("td");
                sutun_anket_ismi.style.width = "63%";
                sutun_anket_ismi.style.textAlign = "center";

                var sutun_anket_sil = document.createElement("td");
                sutun_anket_sil.style.width = "4%";
                sutun_anket_sil.style.textAlign = "center";

                var sutun_anket_sonuc = document.createElement("td");
                sutun_anket_sonuc.style.width = "4%";
                sutun_anket_sonuc.style.textAlign = "center";

                var sutun_anket_gor = document.createElement("td");
                sutun_anket_gor.style.width = "4%";
                sutun_anket_gor.style.textAlign = "center";

                var sutun_anket_link = document.createElement("td");
                sutun_anket_link.style.width = "4%";
                sutun_anket_link.style.textAlign = "center";

                var sutun_anket_düzenle = document.createElement("td");
                sutun_anket_düzenle.style.width = "4%";
                sutun_anket_düzenle.style.textAlign = "center";

                var sutun_kopya_anket = document.createElement("td");
                sutun_kopya_anket.style.width = "4%";
                sutun_kopya_anket.style.textAlign = "center";
                satir1.appendChild(sutun_anket_id);
                satir1.appendChild(sutun_anket_ismi);
                satir1.appendChild(sutun_anket_sil);
                satir1.appendChild(sutun_anket_sonuc);
                satir1.appendChild(sutun_anket_gor);
                satir1.appendChild(sutun_anket_link);
                satir1.appendChild(sutun_anket_düzenle);
                satir1.appendChild(sutun_kopya_anket);




                var anket_id_text = document.createElement("textarea");
                anket_id_text.disabled = "true";
                anket_id_text.style.resize = "none";
                anket_id_text.id = "anket_id_text" + i.toString();
                anket_id_text.style.textAlign = "center";
                anket_id_text.style.outline = "0";
                anket_id_text.style.width = "98%";
                anket_id_text.style.borderStyle = "none";
                anket_id_text.style.fontWeight = "600";
                anket_id_text.style.fontSize = "medium";
                anket_id_text.style.color = "black";
                anket_id_text.value = sonuc[i].toString();
                anket_id_text.style.backgroundColor = "#F5F5F5";
                anket_id_text.style.borderRadius = "6px";
                sutun_anket_id.appendChild(anket_id_text);


                var anket_ismi_text = document.createElement("textarea");
                anket_ismi_text.disabled = "true";
                anket_ismi_text.style.resize = "none";
                anket_ismi_text.id = "anket_ismi_text" + i.toString();
                anket_ismi_text.style.outline = "0";
                anket_ismi_text.style.borderStyle = "none";
                anket_ismi_text.style.width = "95%";
                anket_ismi_text.style.padding = "1%";
                anket_ismi_text.value = sonuc[i + parseInt(a)].toString();
                anket_ismi_text.style.fontWeight = "700";
                anket_ismi_text.style.fontSize = "medium";
                anket_ismi_text.style.color = "black";
                anket_ismi_text.style.backgroundColor = "#F5F5F5";
                anket_ismi_text.style.borderRadius = "6px";
                sutun_anket_ismi.appendChild(anket_ismi_text);



                var anket_gor = document.createElement("input");
                anket_gor.id = "btn";
                anket_gor.className = i.toString();
                anket_gor.setAttribute("type", "image");
                anket_gor.src = "resimler/iconfinder_eye_1814102.png";
                anket_gor.style.backgroundColor = "#CCCCCC";
                anket_gor.style.height = "30px";
                anket_gor.style.width = "90%";
                anket_gor.title = "Anketi Gör";
                anket_gor.onclick = function () {
                    var clss1 = this.className;
                    var anketid1 = document.getElementById("anket_id_text" + clss1.toString()).value;
                    window.open("Anket.aspx?anketidd=" + anketid1.toString() + "");
                    return false;
                }
                sutun_anket_gor.appendChild(anket_gor);

                var anket_sonuc = document.createElement("input");
                anket_sonuc.id = "btn";
                anket_sonuc.setAttribute("type", "image");
                anket_sonuc.className = i.toString();
                anket_sonuc.src = "resimler/iconfinder_table-accept_60039.png";
                anket_sonuc.style.height = "30px";
                anket_sonuc.style.width = "90%";
                anket_sonuc.style.backgroundColor = "#CCCCCC";
                anket_sonuc.title = "Yanıtları";
                anket_sonuc.onclick = function () {
                    var clss2 = this.className;
                    var anketid2 = document.getElementById("anket_id_text" + clss2.toString()).value;
                    window.open("Sonuc.aspx?anketidd=" + anketid2.toString() + "");
                    return false;
                }
                sutun_anket_sonuc.appendChild(anket_sonuc);

                var anket_sil = document.createElement("input");
                anket_sil.id = "btn";
                anket_sil.className = i.toString();
                anket_sil.setAttribute("type", "image");
                anket_sil.src = "resimler/iconfinder_basket_1814090.png";
                anket_sil.style.height = "30px";
                anket_sil.title = "SİL";
                anket_sil.style.width = "90%";
                anket_sil.style.backgroundColor = "#CCCCCC";
                anket_sil.onclick = function () {
                    var clss = this.className;
                    var anketid = document.getElementById("anket_id_text" + clss.toString()).value;
                    var ansver = confirm("Anketiniz Silinsin mi ?");
                    if (ansver) {
                        PageMethods.anketsil(anketid, islemBasarili1, islemHatali1);
                        function islemBasarili1(sonuc1) {
                            $("#satir1" + clss.toString()).remove();
                            alert(sonuc1);
                            PageMethods.anketisimleri(islemBasarili2, islemHatali2);
                            function islemBasarili2(sonuc2) {
                                if (sonuc2.length == 0) {
                                    //genel.innerHTML += "<br/><br/>Kayıtlı Anketiniz Bulunmamaktadır. Anket Oluşturmak İçin Sağ Alt Taraftaki ' + ' Butonuna Basınız...";
                                    var bos_ise = document.createElement("label");
                                    bos_ise.innerHTML = "<br/><br/>Kayıtlı Anketiniz Bulunmamaktadır.<br/><br/> Anket Oluşturmak İçin Sağ Alt Taraftaki&nbsp;&nbsp;";
                                    bos_ise.style.fontSize = "xx-large";
                                    bos_ise.style.verticalAlign = "baseline";
                                    bos_ise.style.font = "250%/1.2 arial,serif";
                                    genel.appendChild(bos_ise);
                                    var resim = document.createElement("input");
                                    resim.type = "image";
                                    resim.src = "resimler/iconfinder_add_3855641.png";
                                    resim.style.width = "50px";
                                    resim.style.verticalAlign = "baseline";
                                    resim.disabled = "true";
                                    genel.appendChild(resim);
                                    var bos_ise1 = document.createElement("label");
                                    bos_ise1.innerHTML = "&nbsp;&nbsp;Butonuna Basınız...";
                                    bos_ise1.style.fontSize = "xx-large";
                                    bos_ise1.style.verticalAlign = "baseline";
                                    bos_ise1.style.font = "250%/1.2 arial,serif";
                                    genel.appendChild(bos_ise1);
                                }
                            }
                            function islemHatali2(sonuc2) {
                                alert("burda");
                            }

                        }
                        function islemHatali1(sonuc1) {
                            alert('Bir hata oluştu sil.');
                        }
                        return false;
                    }
                    else {
                        return false;
                    }
                }
                sutun_anket_sil.appendChild(anket_sil);

                var link_al = document.createElement("input");
                link_al.id = "btn";
                link_al.className = i.toString();
                link_al.type = "image";
                link_al.src = "resimler/iconfinder_270_Connect_global_link_user_3990123.png";
                link_al.style.height = "30px";
                link_al.style.width = "90%";
                link_al.title = "Anket Bağlantı Linki";
                link_al.style.backgroundColor = "#CCCCCC";
                link_al.onclick = function () {
                    document.getElementById("link_div").style.display = "block";
                    var clss = this.className;
                    var anketid = document.getElementById("anket_id_text" + clss.toString()).value;
                    document.getElementById("txtlink").value = "http://newsrvy-001-site1.etempurl.com/Anket.aspx?anketidd=" + anketid.toString();
                    //document.getElementById("txtlink").value = "http://localhost:1607/anket.aspx?anketidd=" + anketid.toString();
                    return false;
                }
                sutun_anket_link.appendChild(link_al);

                var kopya_anket_olustur = document.createElement("input");
                kopya_anket_olustur.id = "btn";
                kopya_anket_olustur.className = i.toString();
                kopya_anket_olustur.setAttribute("type", "image");
                kopya_anket_olustur.src = "resimler/iconfinder_simpline_4_2305586.png";
                kopya_anket_olustur.style.backgroundColor = "#CCCCCC";
                kopya_anket_olustur.title = "Kopya Oluştur";
                kopya_anket_olustur.style.height = "30px";
                kopya_anket_olustur.style.width = "90%";
                kopya_anket_olustur.onclick = function () {
                    var clss1 = this.className;
                    var anketid2 = document.getElementById("anket_id_text" + clss1.toString()).value;
                    PageMethods.anket_kopya(anketid2.toString(), basarili, basarisiz);
                    function basarili() {
                        location.reload();
                    }
                    function basarisiz() {
                        alert("Anket Kopyası Alınırken Hata Oluştu. Lütfen Daha Sonra Deneyiniz !");
                    }
                    //window.open("Anket_Düzenle.aspx?anketidd=" + anketid2.toString() + "");
                    return false;
                }

                sutun_kopya_anket.appendChild(kopya_anket_olustur);

                var anket_düzenle = document.createElement("input");
                anket_düzenle.id = "btn";
                anket_düzenle.className = i.toString();
                anket_düzenle.setAttribute("type", "image");
                anket_düzenle.src = "resimler/iconfinder_edit-document-note-writing-review_3209355.png";
                anket_düzenle.style.backgroundColor = "#CCCCCC";
                anket_düzenle.title = "Düzenle";
                anket_düzenle.style.height = "30px";
                anket_düzenle.style.width = "90%";
                anket_düzenle.onclick = function () {
                    var clss1 = this.className;
                    var anketid2 = document.getElementById("anket_id_text" + clss1.toString()).value;
                    var ansver = confirm("Anketi Düzenlediğinizde Eski Verileriniz Ve Anket Sonuçlarınız Kaybolacaktır.Anket Kopyasını Oluşturup Üstünde Düzenleme Yaparsanız Eski Verileriniz Aynı Şekilde Duracaktır.Yinede Devam Etmek İster misiniz ?");
                    if (ansver) {
                        window.open("Anket_Duzenle.aspx?anketidd=" + anketid2.toString() + "");
                        return false;
                    }
                    else {
                        return false;
                    }
                }

                sutun_anket_düzenle.appendChild(anket_düzenle);
                //if (i % 2 != 0) {
                //    anket_id_text.style.backgroundColor = "lightgreen";
                //    anket_ismi_text.style.backgroundColor = "lightgreen";
                //    anket_sil.style.backgroundColor = "lightgreen";
                //    link_al.style.backgroundColor = "lightgreen";
                //    anket_gor.style.backgroundColor = "lightgreen";
                //    anket_cevap.style.backgroundColor = "lightgreen";
                //    anket_düzenle.style.backgroundColor = "lightgreen";
                //}
                tablo.appendChild(satir1);
                genel.appendChild(tablo);
                if (anket_ismi_text.scrollHeight > anket_ismi_text.clientHeight) {
                    anket_ismi_text.style.height = anket_ismi_text.scrollHeight + "px";
                }
            }
        }
    }
    function islemHatali(sonuc) {
        alert('Bir hata oluştu anket.');
    }

</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">    </script>
<script type="text / javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"> </script>
<script src="js/main.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.4.2.min.js"></script>
