using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace newsurvey
{
    public partial class Giris : System.Web.UI.Page
    {
        string kod = "";

        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            Button1.Attributes.Add("onclick", " this.disabled = true; this.value = 'Giriş Yap';" + ClientScript.GetPostBackEventReference(Button1, null) + ";");
            if (Request.QueryString["kod"] != null)
            {
                kod = Request.QueryString["kod"].ToString();
            }
            baglanti.Close();
            form1.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select count(*) from kullanici_bilgileri_tbl where kullanici_adi='" + txtkullanici_adi.Text.ToString().TrimStart().TrimEnd() + "' and sifre ='" + txt_sifre.Value.ToString().TrimEnd().TrimStart() + "' and e_mail_kodu='"+kod.ToString()+"' and aktif='false' ", baglanti);
            int sayac = int.Parse(komut.ExecuteScalar().ToString());
            if (sayac > 0)
            {
                SqlCommand komut1 = new SqlCommand("update kullanici_bilgileri_tbl set aktif='true' where kullanici_adi='" + txtkullanici_adi.Text.ToString().TrimEnd().TrimStart() + "'", baglanti);
                komut1.ExecuteNonQuery();
                baglanti.Close();
                Session["kul_adi"] = txtkullanici_adi.Text.TrimStart().TrimEnd().ToString();
                Session["giris"] = "true";
                Response.Redirect("Anketler.aspx");
            }
            else
            {
                baglanti.Close();
                Label1.Text = "Lütfen Kullanıcı Adınızı, Şifreni Gİrdiğinizden ve E-Mail Adresinizdeki Linke Tıklayıp <br/> hesabınızı aktif edip etmediğinizden emin olunuz <br/> Eğer Aktif Ettiyseniz Yukarıdaki Giriş Yap Butonuna Tıklayarak Giriş Yapabilirsiniz !";
            }
        }
    }
}