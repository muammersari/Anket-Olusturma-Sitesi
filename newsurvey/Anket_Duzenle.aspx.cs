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
    public partial class Anket_Duzenle : System.Web.UI.Page
    {
        public static string kullanici = "";
        public static string anket_id_si = "";
        public static string anketid = "";
        public static ArrayList soru_idleri = new ArrayList();
        public static ArrayList soru_secenek_turleri = new ArrayList();
        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["kul_adi"] != null)
            {
                kullanici = Session["kul_adi"].ToString();
                if (Request.QueryString["anketidd"] != null)
                {
                    //anket_id_si = HttpContext.Current.Session["anket_id_si"].ToString();
                    anket_id_si = Request.QueryString["anketidd"].ToString();
                    baglanti.Close();
                }
                else
                {
                    baglanti.Close();
                    Response.Redirect("Anasayfa.aspx");
                }
            }
            else
            {
                baglanti.Close();
                Response.Redirect("Anasayfa.aspx");
            }

            form1.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
        }

        [WebMethod]
        public static ArrayList anket_ismi()
        {
            ArrayList anket_ismi_id = new ArrayList();
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select * from anket_tbl where anket_id='" + anket_id_si.ToString() + "'", baglanti);
            SqlDataReader oku = komut.ExecuteReader();
            //while (oku.Read())
            //{
            oku.Read();
            anket_ismi_id.Add(oku["anket_ismi"].ToString());
            anket_ismi_id.Add(oku["anket_aciklamasi"].ToString());
            anket_ismi_id.Add(oku["anket_id"].ToString());
            anket_ismi_id.Add(oku["baslangic_tarihi"].ToString());
            anket_ismi_id.Add(oku["bitis_tarihi"].ToString());
            //}
            oku.Close();
            baglanti.Close();
            return anket_ismi_id;
        }
        [WebMethod]
        public static ArrayList soru_secenekturu_ve_idleri()
        {
            ArrayList list = new ArrayList();
            soru_idleri.Clear();
            soru_secenek_turleri.Clear();
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select * from sorular_tbl where anket_id='" + anket_id_si.ToString() + "' order by soru_sirasi", baglanti);
            SqlDataReader oku = komut.ExecuteReader();
            while (oku.Read())
            {
                soru_idleri.Add(oku["soru_id"].ToString());
                soru_secenek_turleri.Add(oku["secenek_turu"].ToString());
                list.Add(oku["soru_id"]);
                list.Add(oku["soru"]);
                list.Add(oku["secenek_turu"]);
                list.Add(oku["zorunlu_mu"]);
            }
            oku.Close();
            baglanti.Close();
            return list;
        }
        [WebMethod]
        public static ArrayList secenekler()
        {
            ArrayList liste = new ArrayList();

            baglanti.Open();

            for (int i = 0; i < soru_idleri.Count; i++)
            {
                if (soru_secenek_turleri[i].ToString() == "Onay Kutusu")
                {
                    SqlCommand komut1 = new SqlCommand("select * from secenek_cb_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    SqlDataReader oku1 = komut1.ExecuteReader();
                    while (oku1.Read())
                    {
                        liste.Add(oku1["secenek_text"]);
                    }
                    oku1.Close();
                }
                else if (soru_secenek_turleri[i].ToString() == "Çoktan Seçmeli")
                {
                    SqlCommand komut2 = new SqlCommand("select * from secenek_rb_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    SqlDataReader oku2 = komut2.ExecuteReader();
                    while (oku2.Read())
                    {
                        liste.Add(oku2["secenek_text"]);
                    }
                    oku2.Close();
                }
                else if (soru_secenek_turleri[i].ToString() == "Sürekli Ölçek")
                {
                    SqlCommand komut3 = new SqlCommand("select * from secenek_so_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    SqlDataReader oku3 = komut3.ExecuteReader();
                    //while (oku3.Read())
                    //{
                    oku3.Read();
                    liste.Add(oku3["birinci_aralik"]);
                    liste.Add(oku3["ikinci_aralik"]);
                    liste.Add(oku3["birinci_secenek_text"]);
                    liste.Add(oku3["ikinci_secenek_text"]);
                    //}
                    oku3.Close();
                }
                else if (soru_secenek_turleri[i].ToString() == "Çoktan Seçmeli Tablosu")
                {
                    SqlCommand komut4 = new SqlCommand("select count(*) from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "' and satir_sutun ='satir'", baglanti);
                    int satir = int.Parse(komut4.ExecuteScalar().ToString());
                    SqlCommand komut5 = new SqlCommand("select count(*) from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "' and satir_sutun ='sutun'", baglanti);
                    int sutun = int.Parse(komut5.ExecuteScalar().ToString());
                    liste.Add(satir.ToString());
                    liste.Add(sutun.ToString());

                    SqlCommand komut6 = new SqlCommand("select * from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "' and satir_sutun ='satir'", baglanti);
                    SqlDataReader oku6 = komut6.ExecuteReader();
                    while (oku6.Read())
                    {
                        liste.Add(oku6["secenek"].ToString());
                    }
                    oku6.Close();
                    SqlCommand komut7 = new SqlCommand("select * from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "' and satir_sutun ='sutun'", baglanti);
                    SqlDataReader oku7 = komut7.ExecuteReader();
                    while (oku7.Read())
                    {
                        liste.Add(oku7["secenek"].ToString());

                    }
                    oku7.Close();
                }
                else if (soru_secenek_turleri[i].ToString() == "Sürekli Ölçek Tablosu")
                {
                    SqlCommand komut1 = new SqlCommand("select * from secenek_sot_aralik_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    SqlDataReader oku1 = komut1.ExecuteReader();
                    oku1.Read();
                    liste.Add(oku1["birinci_aralik"].ToString());
                    liste.Add(oku1["ikinci_aralik"].ToString());
                    oku1.Close();
                    SqlCommand komut6 = new SqlCommand("select * from secenek_sot_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    SqlDataReader oku6 = komut6.ExecuteReader();
                    while (oku6.Read())
                    {
                        liste.Add(oku6["secenek"].ToString());
                    }
                    oku6.Close();
                }
                else if (soru_secenek_turleri[i].ToString() == "Açık Uçlu")
                {
                    SqlCommand komut1 = new SqlCommand("select numerik_yazi from kisa_yanit_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    liste.Add(komut1.ExecuteScalar().ToString());
                }
            }
            baglanti.Close();
            return liste;

        }
        [WebMethod]
        public static ArrayList sorunun_secenek_sayisi()
        {
            ArrayList list1 = new ArrayList();
            baglanti.Open();
            for (int i = 0; i < soru_idleri.Count; i++)
            {
                if (soru_secenek_turleri[i].ToString() == "Onay Kutusu")
                {
                    SqlCommand komut1 = new SqlCommand("select count(*) from secenek_cb_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    list1.Add(komut1.ExecuteScalar().ToString());
                }
                else if (soru_secenek_turleri[i].ToString() == "Çoktan Seçmeli")
                {
                    SqlCommand komut2 = new SqlCommand("select count(*) from secenek_rb_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    list1.Add(komut2.ExecuteScalar().ToString());
                }
                else if (soru_secenek_turleri[i].ToString() == "Sürekli Ölçek")
                {
                    SqlCommand komut3 = new SqlCommand("select count(*) from secenek_so_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    list1.Add(int.Parse(komut3.ExecuteScalar().ToString()) + 3);
                }
                else if (soru_secenek_turleri[i].ToString() == "Çoktan Seçmeli Tablosu")
                {
                    SqlCommand komut4 = new SqlCommand("select count(*) from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    list1.Add((int.Parse(komut4.ExecuteScalar().ToString()) + 2).ToString());

                }
                else if (soru_secenek_turleri[i].ToString() == "Sürekli Ölçek Tablosu")
                {
                    SqlCommand komut5 = new SqlCommand("select count(*) from secenek_sot_tbl where soru_id='" + soru_idleri[i].ToString() + "'", baglanti);
                    list1.Add((int.Parse(komut5.ExecuteScalar().ToString()) + 2).ToString());
                }
                else if (soru_secenek_turleri[i].ToString() == "Açık Uçlu")
                {
                    list1.Add("1");
                }
            }
            baglanti.Close();
            return list1;
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
                    SqlCommand komut7 = new SqlCommand("insert into secenek_okt_tbl(soru_id,secenek,satir_sutun) values('" + int.Parse(soruid.ToString()) + "','" + secenekler[i].ToString() + "','satir')", baglanti);
                    komut7.ExecuteNonQuery();
                }
                int sutun = int.Parse(secenekler[0].ToString()) + int.Parse(secenekler[1].ToString()) + 2;
                for (int i = int.Parse(secenekler[0].ToString()) + 2; i < sutun; i++)
                {
                    SqlCommand komut8 = new SqlCommand("insert into secenek_okt_tbl(soru_id,secenek,satir_sutun) values('" + int.Parse(soruid.ToString()) + "','" + secenekler[i].ToString() + "','sutun')", baglanti);
                    komut8.ExecuteNonQuery();
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

        [WebMethod]
        public static void anketsil()
        {

            ArrayList soruidleri = new ArrayList();
            ArrayList secenekturleri = new ArrayList();
            baglanti.Open();

            SqlCommand komut = new SqlCommand("select * from sorular_tbl where anket_id='" + anket_id_si.ToString() + "'", baglanti);
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
                        SqlCommand komut2 = new SqlCommand("delete from secenek_cb_tbl where soru_id='" + id.ToString() + "'", baglanti);
                        komut2.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Çoktan Seçmeli")
                    {
                        SqlCommand komut4 = new SqlCommand("delete from secenek_rb_tbl where soru_id='" + id.ToString() + "'", baglanti);
                        komut4.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Sürekli Ölçek")
                    {
                        SqlCommand komut6 = new SqlCommand("delete from secenek_so_tbl where soru_id='" + id.ToString() + "'", baglanti);
                        komut6.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Çoktan Seçmeli Tablosu")
                    {
                        SqlCommand komut6 = new SqlCommand("delete from secenek_okt_tbl where soru_id='" + id.ToString() + "'", baglanti);
                        komut6.ExecuteNonQuery();
                    }
                    else if (secenekturleri[i].ToString() == "Sürekli Ölçek Tablosu")
                    {
                        SqlCommand komut6 = new SqlCommand("delete from secenek_sot_tbl where soru_id='" + id.ToString() + "'", baglanti);
                        komut6.ExecuteNonQuery();
                        SqlCommand komut7 = new SqlCommand("delete from secenek_sot_aralik_tbl where soru_id='" + id.ToString() + "'", baglanti);
                        komut7.ExecuteNonQuery();
                    }
                    else
                    {

                    }

                    SqlCommand komut9 = new SqlCommand("delete from cevaplar_tbl where soru_id='" + id.ToString() + "'", baglanti);
                    komut9.ExecuteNonQuery();
                }
            }
            SqlCommand komut10 = new SqlCommand("delete from sorular_tbl where anket_id='" + anket_id_si.ToString() + "'", baglanti);
            komut10.ExecuteNonQuery();
            SqlCommand komut8 = new SqlCommand("delete from anket_tbl where anket_id='" + anket_id_si.ToString() + "'", baglanti);
            komut8.ExecuteNonQuery();
            baglanti.Close();
        }
        [WebMethod]
        public static string anketlink_id()
        {
            //SqlCommand komut = new SqlCommand("select max(anket_id) from anket_tbl where kullanici_adi='" + kullanici.ToString() + "'", baglanti);
            
            return anketid.ToString();
        }
    }
}