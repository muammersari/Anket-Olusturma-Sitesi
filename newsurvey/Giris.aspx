<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Giris.aspx.cs" Inherits="newsurvey.Giris" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
        <div>
            <div id="gnl" runat="server" style="position: fixed; height: 100%; width: 100%; background-color: #e4fbbe;">

                <div id="Div1" runat="server" style="height: 125px; width: 100%; background-color: #663399;">
                  <%--  <div style="display: inline-block; width: 39%; height: 100%; font-size: xx-large; vertical-align: top; text-align: center; line-height: 10px; font: 450%/1.2 Helveltica;">
                        New Survey
                    </div>--%>
                    <div style="display: inline-block; width: 60%; height: 100%; vertical-align: top;">
                    </div>
                </div>
                <div id="Div2" runat="server" style="height: 100%; width: 100%; background-color: white; text-align:center;">
                   <%-- <div style="width: 50%; height: 100%; display: inline-block; text-align: center; vertical-align: top;">
                        <img style="margin-top: 10%; background-color: red;" src="resimler/anketresmi.jpg" />
                    </div>--%>
                    <div style="width: 40%; height: 100%; display: inline-block; text-align: center; vertical-align: top;">
                        <div style="width: auto; height: auto; margin: auto; margin-top: 100px; text-align: center;">

                            <table style="width: 100%; margin: auto; text-align: center; margin-top: 50px; padding: 20px; box-shadow: 0 0 5px 2px #663399;">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtkullanici_adi" runat="server" placeHolder="Kullanıcı Adı" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="txt_sifre" type="password"  runat="server" placeholder="Şifre" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"/>
                                        <%--<asp:TextBox ID="txt_sifre" runat="server" placeHolder="E-Mail" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" Text="Giriş Yap" Style="border: 1px solid #663399; font-weight:600; border-radius:20px; background-color: yellowgreen; margin-top: 15px; width: 100px; height: 35px;" OnClick="Button1_Click" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtmail" ErrorMessage="Lütfen Geçerli Bir E-Mail Adresi Giriniz !" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>
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
