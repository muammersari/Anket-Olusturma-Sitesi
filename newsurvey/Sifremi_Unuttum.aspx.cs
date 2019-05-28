using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Net.Mail;
using System.Net;
using System.IO;

namespace newsurvey
{
    public partial class Sifremi_Unuttum : System.Web.UI.Page
    {
        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            form1.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
            if (Session["kul_adi"] != null)
            {
                baglanti.Close();
                Response.Redirect("Anketler.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int sayac = 0;
            baglanti.Open();
            //Random rnd = new Random();
            //int sifre = rnd.Next(1000000, 9999999);

            SqlCommand komut = new SqlCommand("select * from kullanici_bilgileri_tbl where e_mail='" + txtmail.Text.TrimEnd().TrimStart().ToString() + "' and aktif='"+true+"'", baglanti);
            SqlDataReader oku = komut.ExecuteReader();
            while (oku.Read())
            {
                SmtpClient sc = new SmtpClient();
                sc.Port = 587;
                sc.Host = "smtp.gmail.com";
                sc.EnableSsl = true;
                sc.Timeout = 50000;

                sc.Credentials = new NetworkCredential("***@gmail.com", "*şifre**");

                MailMessage mail = new MailMessage();
                mail.IsBodyHtml = true;
                mail.From = new MailAddress("***@gmail.com", "survey.com");
                mail.To.Add(txtmail.Text.ToString().TrimEnd().TrimStart());
                mail.Subject = "Şifreniz";

                mail.Body = "<br/>kullanıcı Adı :" + oku["kullanici_adi"] + "<br/><br/>" + "e_posta Adresi :" + oku["e_mail"] + "<br/><br/>" + "şifre :" + oku["sifre"];
                sc.Send(mail);
                sayac++;
                baglanti.Close();
                Response.Redirect("Anasayfa.aspx");
            }
            if (sayac == 0)
            {
                Label1.Text = "Bu E-posta Adresi Kayıtlı Değil !";
            }
            else
            {
                Label1.Style["color"] = "green";
                Label1.Text = "Şifreniz E-Posta Adresinize Gönderilmiştir";
            }
            oku.Close();
            baglanti.Close();
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            baglanti.Close();
            Response.Redirect("Anasayfa.aspx");
        }
    }
}