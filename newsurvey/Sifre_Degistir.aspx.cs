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
    public partial class Sifre_Degistir : System.Web.UI.Page
    {
        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kul_adi"] == null)
            {
                baglanti.Close();
                Response.Redirect("Anasayfa.aspx");

            }
          
        }

        protected void btnsifreyenile_Click(object sender, EventArgs e)
        {
             baglanti.Open();
            SqlCommand komut = new SqlCommand("select sifre from kullanici_bilgileri_tbl where kullanici_adi='" + Session["kul_adi"].ToString() + "'", baglanti);
            string sifre = komut.ExecuteScalar().ToString();
            if (sifre.ToString().TrimEnd().TrimStart() == txteskisifre.Text.ToString().TrimStart().TrimEnd())
            {
                if (txtyenisifre.Text.TrimEnd().TrimStart().Length > 7)
                {
                    if (txtyenisifre.Text.TrimEnd().TrimStart().ToString() == txtyenisifretekrar.Text.TrimEnd().TrimStart().ToString())
                    {

                        SqlCommand komut1 = new SqlCommand("update kullanici_bilgileri_tbl set sifre='" + txtyenisifre.Text.ToString() + "' where kullanici_adi='" + Session["kul_adi"].ToString() + "'", baglanti);
                        komut1.ExecuteNonQuery();
                        lbluyari.Style["color"] = "green";
                        lbluyari.Text = "Şifreniz Başarı İle Değiştirilmiştir ";
                        baglanti.Close();
                        Session.Abandon();
                        Response.Redirect("Anasayfa.aspx");

                    }
                    else
                    {
                        lbluyari.Style["color"] = "red";
                        lbluyari.Text = "Şifreyi Tekrar Girerken Yanlış Girdiniz !";
                    }
                }
                else
                {
                    lbluyari.Text = "En Az 8 En Fazla 20 Karekter Kullanabilirsiniz !";
                }
            }
            else
            {

                lbluyari.Style["color"] = "red";
                lbluyari.Text = "Eski Şifrenizi Yanlış Girdiniz !";

            }
            baglanti.Close();
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            baglanti.Close();
            Response.Redirect("Anasayfa.aspx");
        }
    }
}