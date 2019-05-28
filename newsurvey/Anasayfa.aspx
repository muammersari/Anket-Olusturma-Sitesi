<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Anasayfa.aspx.cs" Inherits="newsurvey.Anasayfa" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .a {
            color: #8b4513;
        }

            .a:hover {
                color: purple;
            }

        #sifre_unuttum {
            color: white;
            font-size: medium;
        }

            #sifre_unuttum:hover {
                font-size: large;
                color: darkred;
            }
    </style>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
        <div>
            <div id="gnl" runat="server" style="position: fixed; height: 100%; width: 100%; background-color: #e4fbbe;">

                <div runat="server" style="height: 125px; width: 100%; background-color: #663399;">
                    <%-- <div style="display: inline-block; width: 39%; height: 100%; font-size: xx-large; vertical-align: top; text-align: center; line-height: 10px; font: 450%/1.2 Helveltica;">
                        <a href="Anasayfa.aspx" style="font-style: italic;" class="a">New Survey</a>
                    </div>--%>
                    <div style="display: inline-block; width: 100%; height: 100%; vertical-align: top;">
                        <table style="margin-top: 40px; float: right; margin-right: 50px;">
                            <tr>
                                <td>
                                    <input type="text" placeholder="Kullanıcı Adı veya E-Mail" runat="server" style="width: 200px; height: 25px;" id="txtkullaniciadigir" />
                                </td>
                                <td>
                                    <input id="txtsifregir" type="password" runat="server" placeholder="Şifre" style="width: 200px; height: 25px;" />
                                </td>
                                <td>
                                    <asp:Button ID="Button2" runat="server" Text="Giriş" Style="border: 1px solid #8b4513; font-size: large; color: purple; border-radius: 5px; width: 80px; height: 25px; font-size: large;" OnClick="Button2_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center; float:left;" colspan="3"><a href="Sifremi_Unuttum.aspx" id="sifre_unuttum">Şifremi Unuttum</a></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:Label ID="lbluyari1" runat="server" style="color:#ff1100;"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div runat="server" style="height: 100%; width: 100%; background-color: white; text-align: center;">
                    <%--    <div style="width: 50%; height: 100%; display: inline-block; text-align: center; vertical-align: top;">
                        <img style="margin-top: 10%; background-color: red;" src="resimler/anketresmi.jpg" />
                    </div>--%>
                    <div style="width: 49%; height: 100%; display: inline-block; text-align: center; vertical-align: top;">
                        <div style="color: black; font-size: xx-large; margin-top: 50px; margin-bottom: 25px; border-bottom-style: double; border-bottom-color: purple;">YENİ KAYIT</div>
                        <div style="width: auto; height: auto; margin: auto; text-align: center;">

                            <table style="width: 100%; margin: auto; text-align: center; padding: 20px; box-shadow: 0 0 5px 2px #663399;">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtadi" runat="server" placeHolder="Ad" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtsoyadi" runat="server" placeHolder="Soyad" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtkullaniciadi" runat="server" placeHolder="Kullanıcı Adı" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtmail" runat="server" placeHolder="E-Mail" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="txtsifre" type="password" runat="server" placeholder="Şifre" style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;" />
                                        <%--<asp:TextBox ID="txtsifre" runat="server" placeHolder="Şifre" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="txtsifretekrar" type="password" runat="server" placeholder="Şifre Tekrar" style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;" />
                                        <%--<asp:TextBox ID="txtsifretekrar" runat="server" placeHolder="Şifre Tekrar" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" Text="Kayıt Ol" Style="border: 2px solid #8b4513; color: #663399; font-size: medium; font-weight: 600; border-radius: 20px; background-color: yellowgreen; margin-top: 15px; width: 100px; height: 35px;" OnClick="Button1_Click" />
                                    </td>
                                </tr>

                            </table>

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtmail" ErrorMessage="Lütfen Geçerli Bir E-Mail Adresi Giriniz !" Style="color: red;" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            <br />
                            <asp:Label ID="Label1" runat="server" Style="font-size: x-large;"></asp:Label>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </form>
</body>
</html>
