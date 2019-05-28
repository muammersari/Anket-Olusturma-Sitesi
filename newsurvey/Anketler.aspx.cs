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
    public partial class Anketler : System.Web.UI.Page
    {

        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");
        public static string kullanici = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kul_adi"] != null)
            {
                kullanici = Session["kul_adi"].ToString();
                hosgeldiniz.InnerText = "Hoşgeldiniz " + kullanici.ToString();
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
        public static ArrayList anketisimleri()
        {
            ArrayList anket_ismi = new ArrayList();
            ArrayList anket_idd = new ArrayList();
            ArrayList anket_id_isim = new ArrayList();
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select * from anket_tbl where kullanici_adi='" + kullanici.ToString() + "'", baglanti);
            SqlDataReader oku = komut.ExecuteReader();

            while (oku.Read())
            {
                anket_ismi.Add(oku["anket_ismi"].ToString());
                anket_idd.Add(oku["anket_id"].ToString());

            }
            oku.Close();
            baglanti.Close();
            for (int j = 0; j < anket_idd.Count; j++)
            {
                anket_id_isim.Add(anket_idd[j].ToString());
            }
            for (int j = 0; j < anket_ismi.Count; j++)
            {
                anket_id_isim.Add(anket_ismi[j].ToString());
            }
            return anket_id_isim;
        }
        [WebMethod]
        public static string anketsil(string anketid)
        {

            ArrayList soruidleri = new ArrayList();
            ArrayList secenekturleri = new ArrayList();
            baglanti.Open();

            SqlCommand komut = new SqlCommand("select * from sorular_tbl where anket_id='" + anketid + "'", baglanti);
            SqlDataReader oku = komut.ExecuteReader();

            while (oku.Read())
            {

                soruidleri.Add(oku["soru_id"]);
                secenekturleri.Add(oku["secenek_turu"]);
            }
            oku.Close();

            if (soruidleri.Count > 0)
            {
                for (int i = 0; i < soruidleri.Count; i++)
                {
                    var id = int.Parse(soruidleri[i].ToString());
                    if (secenekturleri[i].ToString() == "Onay Kutusu")
                    {
                        SqlCommand komut2 = new SqlCommand("delete from secenek_cb_tbl where soru_id='" + id + "'", baglanti);
                        komut2.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Çoktan Seçmeli")
                    {
                        SqlCommand komut4 = new SqlCommand("delete from secenek_rb_tbl where soru_id='" + id + "'", baglanti);
                        komut4.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Sürekli Ölçek")
                    {
                        SqlCommand komut6 = new SqlCommand("delete from secenek_so_tbl where soru_id='" + id + "'", baglanti);
                        komut6.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Çoktan Seçmeli Tablosu")
                    {
                        SqlCommand komut6 = new SqlCommand("delete from secenek_okt_tbl where soru_id='" + id + "'", baglanti);
                        komut6.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Sürekli Ölçek Tablosu")
                    {
                        SqlCommand komut6 = new SqlCommand("delete from secenek_sot_tbl where soru_id='" + id + "'", baglanti);
                        komut6.ExecuteNonQuery();
                        SqlCommand komut7 = new SqlCommand("delete from secenek_sot_aralik_tbl where soru_id='" + id + "'", baglanti);
                        komut7.ExecuteNonQuery();
                    }
                    //else if (secenekturleri[i].ToString() == "Açık Uçlu")
                    //{
                    //    SqlCommand komut11 = new SqlCommand("delete from kisa_yanit_tbl where soru_id='" + id + "'", baglanti);
                    //    komut11.ExecuteNonQuery();
                    //}
                    SqlCommand komut9 = new SqlCommand("delete from cevaplar_tbl where soru_id='" + id + "'", baglanti);
                    komut9.ExecuteNonQuery();
                }
            }
            SqlCommand komut10 = new SqlCommand("delete from sorular_tbl where anket_id='" + anketid + "'", baglanti);
            komut10.ExecuteNonQuery();
            SqlCommand komut8 = new SqlCommand("delete from anket_tbl where anket_id='" + anketid + "'", baglanti);
            komut8.ExecuteNonQuery();

            baglanti.Close();
            return anketid + " numaralı anket silindi.";

        }
        protected void cikis_Click(object sender, EventArgs e)
        {
            baglanti.Close();
            Session.Abandon();
            Response.Redirect("Anasayfa.aspx");
        }

        [WebMethod]
        public static void anket_kopya(string anket_id)
        {
            baglanti.Open();
            ArrayList anketbilgileri = new ArrayList();
            ArrayList sorular = new ArrayList();
            ArrayList yeni_sorular = new ArrayList();
            ArrayList secenekler = new ArrayList();
            SqlCommand komut = new SqlCommand("select * from anket_tbl where anket_id='" + anket_id + "'", baglanti);
            SqlDataReader oku = komut.ExecuteReader();
            oku.Read();
            anketbilgileri.Add(oku["anket_ismi"]);
            anketbilgileri.Add(oku["anket_aciklamasi"]);
            anketbilgileri.Add(oku["baslangic_tarihi"]);
            anketbilgileri.Add(oku["bitis_tarihi"]);
            oku.Close();
            SqlCommand anket_ekle = new SqlCommand("insert into anket_tbl(kullanici_adi,anket_ismi,anket_aciklamasi,baslangic_tarihi,bitis_tarihi) values(@kullanici_adi,@anket_ismi,@anket_aciklamasi,@baslangic_tarihi,@bitis_tarihi)", baglanti);
            anket_ekle.Parameters.Add("@kullanici_adi", kullanici.ToString().TrimEnd().TrimStart());
            anket_ekle.Parameters.Add("@anket_ismi","Kopya - "+ anketbilgileri[0].ToString());
            anket_ekle.Parameters.Add("@anket_aciklamasi", anketbilgileri[1].ToString());
            anket_ekle.Parameters.Add("@baslangic_tarihi", anketbilgileri[2].ToString());
            anket_ekle.Parameters.Add("@bitis_tarihi", anketbilgileri[3].ToString());
            anket_ekle.ExecuteNonQuery();
            SqlCommand yeni_anket_id = new SqlCommand("select max(anket_id) from anket_tbl where kullanici_adi ='" + kullanici + "'", baglanti);
            string yeni_anket_idsi = yeni_anket_id.ExecuteScalar().ToString();
            SqlCommand komut1 = new SqlCommand("select * from sorular_tbl where anket_id='" + anket_id + "'", baglanti);
            SqlDataReader oku1 = komut1.ExecuteReader();
            while (oku1.Read())
            {
                sorular.Add(oku1["soru_id"]);
                sorular.Add(oku1["soru"]);
                sorular.Add(oku1["soru_sirasi"]);
                sorular.Add(oku1["secenek_turu"]);
                sorular.Add(oku1["zorunlu_mu"]);
            }
            oku1.Close();
            for (int i = 0; i < sorular.Count; i += 5)
            {
                SqlCommand soru_ekle = new SqlCommand("insert into sorular_tbl(anket_id,soru,soru_sirasi,secenek_turu,zorunlu_mu) values(@anket_id,@soru,@soru_sirasi,@secenek_turu,@zorunlu_mu)", baglanti);
                soru_ekle.Parameters.Add("@anket_id", int.Parse(yeni_anket_idsi.ToString()));
                soru_ekle.Parameters.Add("@soru", sorular[i + 1].ToString());
                soru_ekle.Parameters.Add("@soru_sirasi", int.Parse(sorular[i + 2].ToString()));
                soru_ekle.Parameters.Add("@secenek_turu", sorular[i + 3].ToString());
                soru_ekle.Parameters.Add("@zorunlu_mu", sorular[i + 4].ToString());
                soru_ekle.ExecuteNonQuery();
            }
            SqlCommand komut2 = new SqlCommand("select * from sorular_tbl where anket_id='" + yeni_anket_idsi.ToString() + "'", baglanti);
            SqlDataReader oku2 = komut2.ExecuteReader();
            while (oku2.Read())
            {
                yeni_sorular.Add(oku2["soru_id"]);
                yeni_sorular.Add(oku2["soru"]);
                yeni_sorular.Add(oku2["soru_sirasi"]);
                yeni_sorular.Add(oku2["secenek_turu"]);
                yeni_sorular.Add(oku2["zorunlu_mu"]);
            }
            oku2.Close();
            for (int i = 0; i < yeni_sorular.Count; i += 5)
            {
                secenekler.Clear();
                if (sorular[i + 3].ToString() == "Onay Kutusu")
                {
                    SqlCommand komut3 = new SqlCommand("select * from secenek_cb_tbl where soru_id='" + sorular[i].ToString() + "'", baglanti);
                    SqlDataReader oku3 = komut3.ExecuteReader();
                    while (oku3.Read())
                    {
                        secenekler.Add(oku3["secenek_text"].ToString());
                    }
                    oku3.Close();
                    for (int j = 0; j < secenekler.Count; j++)
                    {
                        SqlCommand komut4 = new SqlCommand("insert into secenek_cb_tbl(soru_id,secenek_text) values(@soru_id,@secenek_text)", baglanti);
                        komut4.Parameters.Add("@soru_id", int.Parse(yeni_sorular[i].ToString()));
                        komut4.Parameters.Add("@secenek_text", secenekler[j].ToString());
                        komut4.ExecuteNonQuery();
                    }

                }
                else if (sorular[i + 3].ToString() == "Çoktan Seçmeli")
                {
                    SqlCommand komut3 = new SqlCommand("select secenek_text from secenek_rb_tbl where soru_id='" + sorular[i].ToString() + "'", baglanti);
                    SqlDataReader oku3 = komut3.ExecuteReader();
                    while (oku3.Read())
                    {
                        secenekler.Add(oku3["secenek_text"].ToString());
                    }
                    oku3.Close();
                    for (int j = 0; j < secenekler.Count; j++)
                    {
                        SqlCommand komut4 = new SqlCommand("insert into secenek_rb_tbl(soru_id,secenek_text) values(@soru_id,@secenek_text)", baglanti);
                        komut4.Parameters.Add("@soru_id", int.Parse(yeni_sorular[i].ToString()));
                        komut4.Parameters.Add("@secenek_text", secenekler[j].ToString());
                        komut4.ExecuteNonQuery();
                    }

                }
                else if (sorular[i + 3].ToString() == "Sürekli Ölçek")
                {
                    SqlCommand komut3 = new SqlCommand("select * from secenek_so_tbl where soru_id='" + sorular[i].ToString() + "'", baglanti);
                    SqlDataReader oku3 = komut3.ExecuteReader();
                    oku3.Read();
                    secenekler.Add(oku3["birinci_aralik"]);
                    secenekler.Add(oku3["ikinci_aralik"]);
                    secenekler.Add(oku3["birinci_secenek_text"]);
                    secenekler.Add(oku3["ikinci_secenek_text"]);
                    oku3.Close();
                    SqlCommand komut6 = new SqlCommand("insert into secenek_so_tbl(soru_id,birinci_aralik,ikinci_aralik,birinci_secenek_text,ikinci_secenek_text) values(@soru_id,@birinci_aralik,@ikinci_aralik,@birinci_secenek_text,@ikinci_secenek_text)", baglanti);
                    komut6.Parameters.Add("@soru_id", int.Parse(yeni_sorular[i].ToString()));
                    komut6.Parameters.Add("@birinci_aralik", secenekler[0].ToString());
                    komut6.Parameters.Add("@ikinci_aralik", secenekler[1].ToString());
                    komut6.Parameters.Add("@birinci_secenek_text", secenekler[2].ToString());
                    komut6.Parameters.Add("@ikinci_secenek_text", secenekler[3].ToString());
                    komut6.ExecuteNonQuery();
                }
                else if (sorular[i + 3].ToString() == "Sürekli Ölçek Tablosu")
                {
                    SqlCommand komut3 = new SqlCommand("select * from secenek_sot_aralik_tbl where soru_id='" + sorular[i].ToString() + "'", baglanti);
                    SqlDataReader oku3 = komut3.ExecuteReader();
                    oku3.Read();
                    secenekler.Add(oku3["birinci_aralik"]);
                    secenekler.Add(oku3["ikinci_aralik"]);
                    oku3.Close();
                    SqlCommand komut9 = new SqlCommand("insert into secenek_sot_aralik_tbl(soru_id,birinci_aralik,ikinci_aralik) values('" + int.Parse(yeni_sorular[i].ToString()) + "','" + secenekler[0].ToString() + "','" + secenekler[1].ToString() + "')", baglanti);
                    komut9.ExecuteNonQuery();
                    secenekler.Clear();
                    SqlCommand komut4 = new SqlCommand("select * from secenek_sot_tbl where soru_id='" + sorular[i].ToString() + "'", baglanti);
                    SqlDataReader oku4 = komut4.ExecuteReader();
                    while (oku4.Read())
                    {
                        secenekler.Add(oku4["secenek"]);

                    }
                    oku4.Close();
                    for (int j = 0; j < secenekler.Count; j++)
                    {
                        SqlCommand komut10 = new SqlCommand("insert into secenek_sot_tbl(soru_id,secenek) values('" + int.Parse(yeni_sorular[i].ToString()) + "','" + secenekler[j].ToString() + "')", baglanti);
                        komut10.ExecuteNonQuery();
                    }

                }
                else if (sorular[i + 3].ToString() == "Çoktan Seçmeli Tablosu")
                {
                    SqlCommand komut3 = new SqlCommand("select * from secenek_okt_tbl where soru_id='" + sorular[i].ToString() + "'", baglanti);
                    SqlDataReader oku3 = komut3.ExecuteReader();
                    while (oku3.Read())
                    {
                        secenekler.Add(oku3["secenek"].ToString());
                        secenekler.Add(oku3["satir_sutun"].ToString());
                        //secenekler.Add(oku3["secenek_id"].ToString());
                    }
                    oku3.Close();
                    for (int j = 0; j < secenekler.Count; j += 2)
                    {
                        SqlCommand komut8 = new SqlCommand("insert into secenek_okt_tbl(soru_id,secenek,satir_sutun) values('" + int.Parse(yeni_sorular[i].ToString()) + "','" + secenekler[j].ToString() + "','" + secenekler[j + 1].ToString() + "')", baglanti);
                        komut8.ExecuteNonQuery();
                    }
                }
            }
            baglanti.Close();
        }
    }
}