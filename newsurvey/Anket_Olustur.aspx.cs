using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace newsurvey
{
    public partial class Anket_Olustur : System.Web.UI.Page
    {
        public static string kullanici = "";
        public static string anketid = "";

        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kul_adi"] != null)
            {
                kullanici = Session["kul_adi"].ToString();
                baglanti.Close();
            }
            else
            {
                baglanti.Close();
                Response.Redirect("Anasayfa.aspx");
            }
            form1.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
        }
       
        [WebMethod]
        public static void anket_ismi_ekle_ve_anket_id_bul(string anketismi, string txtanketaciklamasi, string anket_baslangic_tarihi, string anket_bitis_tarihi)
        {
            baglanti.Open();
            SqlCommand komutekle = new SqlCommand("insert into anket_tbl(kullanici_adi,anket_ismi,anket_aciklamasi,baslangic_tarihi,bitis_tarihi) values(@kullanici_adi,@anket_ismi,@anket_aciklamasi,@baslangic_tarihi,@bitis_tarihi)", baglanti);
            komutekle.Parameters.Add("@kullanici_adi", kullanici.ToString().TrimEnd().TrimStart());
            komutekle.Parameters.Add("@anket_ismi", anketismi.ToString());
            komutekle.Parameters.Add("@anket_aciklamasi", txtanketaciklamasi.ToString());
            komutekle.Parameters.Add("@baslangic_tarihi", anket_baslangic_tarihi.ToString());
            komutekle.Parameters.Add("@bitis_tarihi", anket_bitis_tarihi.ToString());
            komutekle.ExecuteNonQuery();
            SqlCommand komut1 = new SqlCommand("select max(anket_id) from anket_tbl where kullanici_adi='" + kullanici.ToString() + "'", baglanti);
            anketid = komut1.ExecuteScalar().ToString();
            baglanti.Close();
        }
        [WebMethod]
        public static string VeriTabaninaEkle(string anketismi, string soru, string secenekturu, string sorusirasi, ArrayList secenekler, string zorunlu_mu)
        {
            baglanti.Open();
            SqlCommand komut2 = new SqlCommand("insert into sorular_tbl(anket_id,soru,soru_sirasi,secenek_turu,zorunlu_mu) values(@anket_id,@soru,@soru_sirasi,@secenek_turu,@zorunlu_mu)", baglanti);
            komut2.Parameters.Add("@anket_id", int.Parse(anketid.ToString()));
            komut2.Parameters.Add("@soru", soru.ToString().TrimEnd().TrimStart());
            komut2.Parameters.Add("@soru_sirasi", int.Parse(sorusirasi.ToString()));
            komut2.Parameters.Add("@secenek_turu", secenekturu.ToString());
            komut2.Parameters.Add("@zorunlu_mu", zorunlu_mu.ToString());
            komut2.ExecuteNonQuery();

            SqlCommand komut3 = new SqlCommand("select soru_id from sorular_tbl where anket_id='" + anketid.ToString() + "' and soru='" + soru.ToString().TrimStart().TrimEnd() + "' and secenek_turu='" + secenekturu.ToString() + "' and soru_sirasi='" + sorusirasi.ToString() + "'", baglanti);
            string soruid = komut3.ExecuteScalar().ToString();
            if (secenekturu == "Onay Kutusu")
            {
                for (int i = 0; i < secenekler.Count; i++)
                {
                    SqlCommand komut4 = new SqlCommand("insert into secenek_cb_tbl(soru_id,secenek_text) values(@soru_id,@secenek_text)", baglanti);
                    komut4.Parameters.Add("@soru_id", int.Parse(soruid.ToString()));
                    komut4.Parameters.Add("@secenek_text", secenekler[i].ToString());
                    komut4.ExecuteNonQuery();
                }
            }
            else if (secenekturu == "Çoktan Seçmeli")
            {
                for (int i = 0; i < secenekler.Count; i++)
                {
                    SqlCommand komut5 = new SqlCommand("insert into secenek_rb_tbl(soru_id,secenek_text) values(@soru_id,@secenek_text)", baglanti);
                    komut5.Parameters.Add("@soru_id", int.Parse(soruid.ToString()));
                    komut5.Parameters.Add("@secenek_text", secenekler[i].ToString());
                    komut5.ExecuteNonQuery();
                }

            }
            else if (secenekturu == "Sürekli Ölçek")
            {

                SqlCommand komut6 = new SqlCommand("insert into secenek_so_tbl(soru_id,birinci_aralik,ikinci_aralik,birinci_secenek_text,ikinci_secenek_text) values(@soru_id,@birinci_aralik,@ikinci_aralik,@birinci_secenek_text,@ikinci_secenek_text)", baglanti);
                komut6.Parameters.Add("@soru_id", int.Parse(soruid.ToString()));
                komut6.Parameters.Add("@birinci_aralik", secenekler[0].ToString());
                komut6.Parameters.Add("@ikinci_aralik", secenekler[1].ToString());
                komut6.Parameters.Add("@birinci_secenek_text", secenekler[2].ToString());
                komut6.Parameters.Add("@ikinci_secenek_text", secenekler[3].ToString());
                komut6.ExecuteNonQuery();

            }
            else if (secenekturu == "Çoktan Seçmeli Tablosu")
            {
                int satir = int.Parse(secenekler[0].ToString()) + 2;
                for (int i = 2; i < satir; i++)
                {
                    if (i != satir - 1)
                    {
                        SqlCommand komut7 = new SqlCommand("insert into secenek_okt_tbl(soru_id,secenek,satir_sutun) values('" + int.Parse(soruid.ToString()) + "','" + secenekler[i].ToString() + "','satir')", baglanti);
                        komut7.ExecuteNonQuery();
                    }
                }
                int sutun = int.Parse(secenekler[0].ToString()) + int.Parse(secenekler[1].ToString()) + 2;
                for (int i = int.Parse(secenekler[0].ToString()) + 2; i < sutun; i++)
                {
                    if (i != sutun - 1)
                    {
                        SqlCommand komut8 = new SqlCommand("insert into secenek_okt_tbl(soru_id,secenek,satir_sutun) values('" + int.Parse(soruid.ToString()) + "','" + secenekler[i].ToString() + "','sutun')", baglanti);
                        komut8.ExecuteNonQuery();
                    }
                }
            }
            else if (secenekturu == "Sürekli Ölçek Tablosu")
            {
                SqlCommand komut9 = new SqlCommand("insert into secenek_sot_aralik_tbl(soru_id,birinci_aralik,ikinci_aralik) values('" + int.Parse(soruid.ToString()) + "','" + secenekler[0].ToString() + "','" + secenekler[1].ToString() + "')", baglanti);
                komut9.ExecuteNonQuery();
                int satir1 = int.Parse(secenekler[2].ToString()) + 3;
                for (int i = 3; i < satir1; i++)
                {
                    if (i != satir1 - 1)
                    {
                        SqlCommand komut10 = new SqlCommand("insert into secenek_sot_tbl(soru_id,secenek) values('" + int.Parse(soruid.ToString()) + "','" + secenekler[i].ToString() + "')", baglanti);
                        komut10.ExecuteNonQuery();
                    }
                }

            }
            else if (secenekturu == "Açık Uçlu")
            {
                SqlCommand komut5 = new SqlCommand("insert into kisa_yanit_tbl(soru_id,numerik_yazi) values(@soru_id,@numerik_yazi)", baglanti);
                komut5.Parameters.Add("@soru_id", int.Parse(soruid.ToString()));
                komut5.Parameters.Add("@numerik_yazi", secenekler[0].ToString());
                komut5.ExecuteNonQuery();
            }
            baglanti.Close();
            return sorusirasi.ToString();
        }

   

    }
}