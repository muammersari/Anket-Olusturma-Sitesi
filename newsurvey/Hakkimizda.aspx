<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hakkimizda.aspx.cs" Inherits="newsurvey.Hakimizda" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
        <div id="Div1" runat="server" style="height: 50px; width: 100%; background-color: #663399; box-shadow: 0 0 5px 2px #663399;">
            <asp:ImageButton ID="ImageButton1" runat="server" Width="50px" Height="50px" title="Geri" ImageUrl="~/resimler/iconfinder_circle-arrow_back-previous-outline-stroke_763484.png" OnClick="ImageButton1_Click" />
        </div>
        <div style="text-align: center; margin-top: 2%;">
            <asp:Image ID="Image2" runat="server" src="resimler/pau.png" Width="265px" Height="150px" Style="text-align: center;" /><br />
            <label style="color: purple; font-size: xx-large;">YÖNETİM BİLİŞİM SİSTEMLERİ</label>

        </div>
        <div style="text-align: center; margin-top: 1%;">
            <div>
                <div style="width: 30%; height: 150px; border: 2px solid purple; display: inline-block; border-radius: 30px; vertical-align: top;">
                    <label style="color: purple; font-size: x-large; border-bottom-style: solid; border-bottom-color: purple;">KİŞİSEL BİLGİLER</label><br />
                    <br />
                    <label style="color: purple; font-size: large;">Muammer SARI</label><br />
                    <br />
                    <label style="color: purple; font-size: large;">sr_muammer@hotmail.com</label>
                </div>
                <div style="width: 30%; height: 150px; border: 2px solid purple; display: inline-block; border-radius: 30px; vertical-align: top; margin-left: 2%;">
                    <label style="color: purple; font-size: x-large; border-bottom-style: solid; border-bottom-color: purple;">DERS BİLGİLERİ</label><br />
                    <br />
                    <label style="color: purple; font-size: large;">Lisans Tezi Çalışması</label><br />
                    <br />
                    <label style="color: purple; font-size: large;">Web Tabanlı Sürekli Ölçeğe Dayalı Anket Oluşturma ve Yürütme Platformu</label>
                </div>

            </div>
            <div style="margin-top: 2%;">
                <div style="width: 30%; height: 150px; border: 2px solid purple; display: inline-block; border-radius: 30px; vertical-align: top;">
                    <label style="color: purple; font-size: x-large; border-bottom-style: solid; border-bottom-color: purple;">DANIŞMAN</label><br />
                    <br />
                    <label style="color: purple; font-size: large;">Prof. Dr. Selçuk Burak HAŞILOĞLU</label><br />
                    <br />


                </div>
                <div style="width: 30%; height: 150px; border: 2px solid purple; display: inline-block; border-radius: 30px; vertical-align: top; margin-left: 2%;">
                    <label style="color: purple; font-size: x-large; border-bottom-style: solid; border-bottom-color: purple;">DESTEK ALINAN ÖĞRETİM ELEMANLARI</label><br />
                    <br />
                    <label style="color: purple; font-size: large;">Dr. Öğr. Üyesi Çetin KALBURAN</label><br />
                    <label style="color: purple; font-size: large;">Öğr. Üyesi Erkan YEŞİL</label>
                </div>

            </div>

        </div>

        <%-- <div style="position: absolute; left: 30%; right: 30%; top: 75px; bottom: 0px; box-shadow: 0 0 5px 0px darkgreen; z-index: 2; background-color: whitesmoke; border-radius: 10px;">
            <div style="width: 100%; height: 50px; background-color: whitesmoke; text-align: center;">
                <div style="margin-top: 20%;">
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman';">PAMUKKALE ÜNİVERSİTESİ</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 7%;">YÖNETİM BİLİŞİM SİSTEMLERİ BÖLÜMÜ</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 7%;">MUAMMER SARI</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 1%;">sr_muammer@hotmail.com</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 7%;">LİSANS TEZİ</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 7%;">PROF. DR. SELÇUK BURAK HAŞILOĞLU</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 7%;">Dr. Öğr. Üyesi ÇETİN KALBURAN</div>
                    <div style="font-size: large; font-weight: bolder; font-family: 'Times New Roman'; margin-top: 7%;">Mayıs, 2019</div>
                </div>
            </div>
        </div>--%>
    </form>
</body>
</html>
