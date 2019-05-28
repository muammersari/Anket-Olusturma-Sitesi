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
    public partial class Anasayfa : System.Web.UI.Page
    {
        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            baglanti.Close();
            Button2.Attributes.Add("onclick", " this.disabled = true; this.value = 'Giriş';" + ClientScript.GetPostBackEventReference(Button2, null) + ";");

            if (Session["kul_adi"] != null)
            {
                baglanti.Close();
                Response.Redirect("Anketler.aspx");
            }

            form1.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select count(*) from kullanici_bilgileri_tbl where kullanici_adi='" + txtkullaniciadi.Text.ToString() + "'", baglanti);
            int sayac = int.Parse(komut.ExecuteScalar().ToString());
            SqlCommand komut1 = new SqlCommand("select count(*) from kullanici_bilgileri_tbl where e_mail='" + txtmail.Text.ToString() + "'", baglanti);
            int sayac1 = int.Parse(komut1.ExecuteScalar().ToString());
            if (sayac1 == 0)
            {
                if (sayac == 0)
                {
                    if (txtadi.Text.Length < 201 && txtadi.Text.Length > 0)
                    {
                        if (txtsoyadi.Text.Length < 201 && txtsoyadi.Text.Length > 0)
                        {
                            if (txtkullaniciadi.Text.Length < 51 && txtkullaniciadi.Text.Length > 0)
                            {
                                if (txtsifre.Value.TrimEnd().TrimStart().Length < 21 && txtsifre.Value.TrimEnd().TrimStart().Length > 7 && txtsifretekrar.Value.TrimEnd().TrimStart().Length < 21 && txtsifretekrar.Value.TrimEnd().TrimStart().Length > 7)
                                {
                                    if (txtsifre.Value.TrimEnd().TrimStart().ToString() == txtsifretekrar.Value.TrimEnd().TrimStart().ToString())
                                    {
                                        if (txtmail.Text.Length < 201)
                                        {
                                            SqlCommand komutekle = new SqlCommand("insert into kullanici_bilgileri_tbl(kullanici_adi,isim,soyisim,e_mail,sifre,e_mail_kodu,aktif) values(@kuladi,@ad,@soyad,@e_mail,@sifre,@e_mail_kodu,@aktif)", baglanti);
                                            komutekle.Parameters.Add("@kuladi", txtkullaniciadi.Text.ToString());
                                            komutekle.Parameters.Add("@ad", txtadi.Text.ToString());
                                            komutekle.Parameters.Add("@soyad", txtsoyadi.Text.ToString());
                                            komutekle.Parameters.Add("@sifre", txtsifre.Value.ToString());
                                            komutekle.Parameters.Add("@e_mail", txtmail.Text.ToString().TrimEnd().TrimStart());
                                            Random rnd = new Random();
                                            int kod = rnd.Next(1000000, 9999999);
                                            komutekle.Parameters.Add("@e_mail_kodu", kod.ToString());
                                            komutekle.Parameters.Add("@aktif", "false");
                                            komutekle.ExecuteNonQuery();
                                            SmtpClient sc = new SmtpClient();
                                            sc.Port = 587;
                                            sc.Host = "smtp.gmail.com";
                                            sc.EnableSsl = true;
                                            sc.Timeout = 50000;

                                            sc.Credentials = new NetworkCredential("***@gmail.com", "*şifre*");

                                            MailMessage mail = new MailMessage();
                                            mail.IsBodyHtml = true;
                                            mail.From = new MailAddress("***@gmail.com", "MySurvey");
                                            mail.To.Add(txtmail.Text.ToString().TrimEnd().TrimStart());
                                            mail.Subject = "Aktivasyon Maili";
                                            mail.Body = "Merhaba " + txtadi.Text.ToString() + " " + txtsoyadi.Text.ToString() + "" +
                                           " MySurvey.com kayıt sistemine hoşgeldiniz. Bu ileti aşağıdaki hesabın başarılı bir şekilde oluştuğunu doğrular.<br/>" +
                                           " Kullanıcı Adınız :" + txtkullaniciadi.Text.ToString() + "<br/> E-posta :" + txtmail.Text.ToString().TrimEnd().TrimStart() + "<br/>" +
                                           " Hesabınız ile ilgili işlemlere devam edebilmek için aşağıdaki linke tıklayarak hesabınızı aktif etmelisiniz.<br/>" +
                                           "<a href=\"http://newsrvy-001-site1.etempurl.com//Giris.aspx?kod=" + kod.ToString() + "\">Hesabınızı Aktif Etmek İçin Tıklayınız</a>";

                                            sc.Send(mail);
                                            Label1.Style["color"] = "green";
                                            Label1.Text = "Kaydınız oluşturulmuştur. Lütfen Mailinize Gelen Linke Tıklayıp Hesabınızı Aktif Hale Getiriniz";
                                        }
                                        else
                                        {
                                            Label1.Style["color"] = "red";
                                            Label1.Text = "En Fazla 200 Karekterli mail Adrsi Girebilirsiniz ";
                                        }

                                    }
                                    else
                                    {
                                        Label1.Text = "Şifreyi Takrar Girerken Yanlış Girdiniz";
                                    }
                                }
                                else
                                {
                                    Label1.Style["color"] = "red";
                                    Label1.Text = "En Az 8 ve En Fazla 20 Karekterli Şifre Oluşturabilirsiniz ";
                                }
                            }
                            else
                            {
                                Label1.Style["color"] = "red";
                                Label1.Text = "En Fazla 50 Karekterli Kullanıcı Adı Oluşturabilirsiniz ";
                            }
                        }
                        else
                        {
                            Label1.Style["color"] = "red";
                            Label1.Text = "En Fazla 200 Karekterli Soyisim Oluşturabilirsiniz ";
                        }
                    }
                    else
                    {
                        Label1.Style["color"] = "red";
                        Label1.Text = "En Fazla 200 Karekterli İsim Oluşturabilirsiniz ";
                    }

                }
                else
                {
                    Label1.Style["color"] = "red";
                    Label1.Text = "Bu Kullanıcı Adı Kullanılmaktadır";
                }
            }
            else
            {
                Label1.Style["color"] = "red";
                Label1.Text = "Bu Mail Adresi Kullanımda.Başka Bir Mail Adresi Giriniz";
            }

            baglanti.Close();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            baglanti.Open();
            SqlCommand komut = new SqlCommand("select count(*) from kullanici_bilgileri_tbl where (kullanici_adi='" + txtkullaniciadigir.Value.ToString().TrimEnd().TrimStart() + "' Or e_mail='" + txtkullaniciadigir.Value.ToString().TrimEnd().TrimStart() + "') and sifre='" + txtsifregir.Value.ToString().TrimStart().TrimEnd() + "' and aktif='true'", baglanti);
            int sayac = int.Parse(komut.ExecuteScalar().ToString());
            if (sayac > 0)
            {
                SqlCommand komut1 = new SqlCommand("select count(*) from kullanici_bilgileri_tbl where e_mail='" + txtkullaniciadigir.Value.ToString().TrimEnd().TrimStart() + "'", baglanti);
                int sayac1 = int.Parse(komut1.ExecuteScalar().ToString());
                if (sayac1 > 0)
                {
                    SqlCommand komut2 = new SqlCommand("select kullanici_adi from kullanici_bilgileri_tbl where e_mail='" + txtkullaniciadigir.Value.ToString().TrimEnd().TrimStart() + "'", baglanti);
                    string kullaniciadi = komut2.ExecuteScalar().ToString();
                    Session["kul_adi"] = kullaniciadi.ToString();
                }
                else
                {
                    Session["kul_adi"] = txtkullaniciadigir.Value.TrimStart().TrimEnd().ToString();
                }
                Session["giris"] = "true";
                baglanti.Close();
                Response.Redirect("Anketler.aspx");
            }
            else
            {
                lbluyari1.Text = "Kullanıcı Adı veya Şifre Yanlış !";
            }
            baglanti.Close();
        }
    }
}