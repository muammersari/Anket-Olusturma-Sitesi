<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sifremi_Unuttum.aspx.cs" Inherits="newsurvey.Sifremi_Unuttum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #a {
            color: #8b4513;
        }

            #a:hover {
                color: purple;
            }
    </style>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
        <div>
            <div id="gnl" runat="server" style="position: fixed; height: 100%; width: 100%; background-color: #e4fbbe;">
                
                <div id="Div1" runat="server" style="height: 125px; width: 100%; background-color: #663399;">
                    <%-- <div style="display: inline-block; width: 39%; height: 100%; font-size: xx-large; vertical-align: top; text-align: center; line-height: 10px; font: 450%/1.2 Helveltica;">
                        <a href="Anasayfa.aspx" style="font-style:italic;" id="a">New Survey</a>
                    </div>--%>
                    <div style="display: inline-block; width: 60%; height: 100%; vertical-align: top;">
                        <asp:ImageButton ID="ImageButton1" runat="server" title="Geri" style="margin-top:20px;" Width="50px" Height="50px" ImageUrl="~/resimler/iconfinder_circle-arrow_back-previous-outline-stroke_763484.png" OnClick="ImageButton1_Click" />  
                        
                    </div>
                </div>
                <div id="Div2" runat="server" style="height: 100%; width: 100%; background-color: white;">
                    <%-- <div style="width: 50%; height: 100%; display: inline-block; text-align: center; vertical-align: top;">
                        <img style="margin-top: 10%; background-color: red;" src="resimler/anketresmi.jpg" />
                    </div>--%>
                    <div style="width: 100%; height: 100%; display: inline-block; text-align: center;">
                        <div style="width: auto; height: auto; margin: auto; margin-top: 100px; text-align: center;">

                            <table style="width: 40%; margin: auto; text-align: center; margin-top: 50px; padding: 20px; box-shadow: 0 0 5px 2px #663399;">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtmail" runat="server" placeHolder="E-Mail" Style="border: 1px solid Black; width: 50%; height: 25px; text-align: center;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" Text="Gönder" Style="font-size: medium; border: 2px solid #663399; background-color: yellowgreen; border-radius: 20px; font-weight: 600; margin-top: 15px; width: 100px; height: 35px;" OnClick="Button1_Click" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtmail" ErrorMessage="Lütfen Geçerli Bir E-Mail Adresi Giriniz !" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
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
