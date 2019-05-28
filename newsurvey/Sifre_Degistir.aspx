<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sifre_Degistir.aspx.cs" Inherits="newsurvey.Sifre_Degistir" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
               <asp:ImageButton ID="ImageButton1" runat="server" Width="50px" Height="50px" title="Geri" ImageUrl="~/resimler/iconfinder_circle-arrow_back-previous-outline-stroke_763484.png" OnClick="ImageButton1_Click" />

   <div style="width: auto; height: auto; margin: auto; margin-top: 120px; text-align: center;">
        <table style="width: 30%; height: auto; margin: auto; text-align: center; padding: 2%; box-shadow: 0 0 8px 2px #663399; border:1px solid darkgreen;">

            <tr>
                <td>
                    <asp:TextBox ID="txteskisifre" runat="server" Width="90%" Height="25px" placeHolder="Eski Şifre" style="text-align:center;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtyenisifre" runat="server" placeHolder="Yeni Şifre" Width="90%" Height="25px" style="text-align:center;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtyenisifretekrar" runat="server" placeHolder="Yeni Şifre Tekrar" Width="90%" Height="25px" style="text-align:center;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnsifreyenile" runat="server" Width="45%" Height="35px" Text="Şifreyi Değiştir" Style="font-weight:600; background-color:yellowgreen; border:2px solid #663399; border-radius:15px; margin-top: 15px;" OnClick="btnsifreyenile_Click" />

                </td>
            </tr>

        </table>
        <br />
        <br />

        <asp:Label ID="lbluyari" runat="server"></asp:Label>
        <br />
    </div>
    </form>
</body>
</html>
