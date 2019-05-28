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
    public partial class Anket : System.Web.UI.Page
    {
        public static string anket_id_si = "";
        public static ArrayList soru_idleri = new ArrayList();
        public static ArrayList soru_secenek_turleri = new ArrayList();
        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");

        public static string yanitlayici_idsi = "1";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["anketidd"] != null)
            {
                //anket_id_si = HttpContext.Current.Session["anket_id_si"].ToString();
                baglanti.Close();
                anket_id_si = Request.QueryString["anketidd"].ToString();
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

                    SqlCommand komut6 = new SqlCommand("select * from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "' and satir_sutun ='sutun'", baglanti);
                    SqlDataReader oku6 = komut6.ExecuteReader();
                    while (oku6.Read())
                    {
                        liste.Add(oku6["secenek"].ToString());
                    }
                    oku6.Close();
                    SqlCommand komut7 = new SqlCommand("select * from secenek_okt_tbl where soru_id='" + soru_idleri[i].ToString() + "' and satir_sutun ='satir'", baglanti);
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
        public static void yanitlayici_id(string baslama,string bitis)
        {
            baglanti.Open();
            SqlCommand komut = new SqlCommand("select count(*) from yanitlayici_tbl", baglanti);
            if (int.Parse(komut.ExecuteScalar().ToString()) > 0)
            {
                SqlCommand com = new SqlCommand("select max(yanitlayici_id) from yanitlayici_tbl", baglanti);
                yanitlayici_idsi = com.ExecuteScalar().ToString();
            }
            else
            {
                yanitlayici_idsi = "1";
            }
            SqlCommand komut2 = new SqlCommand("insert into yanitlayici_tbl(anket_id,yanitlayici_id,baslangic_tarihi,bitis_tarihi) values(@ai,@yi,@baslama,@bitis)", baglanti);
            komut2.Parameters.Add("@ai", int.Parse(anket_id_si.ToString()));
            komut2.Parameters.Add("@yi", int.Parse(yanitlayici_idsi.ToString()) + 1);
            komut2.Parameters.Add("@baslama", baslama.ToString());
            komut2.Parameters.Add("@bitis", bitis.ToString());
            komut2.ExecuteNonQuery();
            baglanti.Close();

        }

        [WebMethod]
        public static void cevaplari_ekle(ArrayList cevaplar, string soru_id)
        {

            baglanti.Open();
            SqlCommand komut1 = new SqlCommand("select secenek_turu from sorular_tbl where soru_id='" + soru_id.ToString() + "'", baglanti);
            string scnkturu = komut1.ExecuteScalar().ToString();
            if (cevaplar.Count > 0)
            {
                for (int i = 0; i < cevaplar.Count; i++)
                {
                    string secenek_id = "";

                    if (scnkturu == "Onay Kutusu")
                    {
                        SqlCommand komut2 = new SqlCommand("select secenek_id from secenek_cb_tbl where soru_id='" + soru_id.ToString() + "' and secenek_text ='" + cevaplar[i].ToString() + "'", baglanti);
                        secenek_id = komut2.ExecuteScalar().ToString();
                    }
                    else if (scnkturu == "Çoktan Seçmeli")
                    {
                        SqlCommand komut2 = new SqlCommand("select secenek_id from secenek_rb_tbl where soru_id='" + soru_id.ToString() + "' and secenek_text ='" + cevaplar[i].ToString() + "'", baglanti);
                        secenek_id = komut2.ExecuteScalar().ToString();
                    }
                    else if (scnkturu == "Çoktan Seçmeli Tablosu")
                    {
                        SqlCommand komut2 = new SqlCommand("select secenek_id from secenek_okt_tbl where soru_id='" + soru_id.ToString() + "' and secenek ='" + cevaplar[i].ToString() + "'", baglanti);
                        secenek_id = komut2.ExecuteScalar().ToString();
                        i += 1;
                    }
                    else if (scnkturu == "Sürekli Ölçek Tablosu")
                    {
                        SqlCommand komut2 = new SqlCommand("select secenek_id from secenek_sot_tbl where soru_id='" + soru_id.ToString() + "' and secenek ='" + cevaplar[i].ToString() + "'", baglanti);
                        secenek_id = komut2.ExecuteScalar().ToString();
                        i += 1;
                    }
                    else if (scnkturu == "Açık Uçlu")
                    {
                        secenek_id = "00";
                    }
                    else
                    {
                        secenek_id = "00";
                    }
                    SqlCommand komutekle = new SqlCommand("insert into cevaplar_tbl(yanitlayici_id,soru_id,cevap,secenek_id) values(@yanitlayici_id,@soru_id,@cevap,@secenek_id)", baglanti);
                    komutekle.Parameters.Add("@yanitlayici_id", int.Parse(yanitlayici_idsi) + 1);
                    komutekle.Parameters.Add("@soru_id", soru_id.ToString());
                    komutekle.Parameters.Add("@cevap", cevaplar[i].ToString());
                    komutekle.Parameters.Add("@secenek_id", secenek_id.ToString());
                    komutekle.ExecuteNonQuery();
                }
            }
            else
            {
                SqlCommand komutekle = new SqlCommand("insert into cevaplar_tbl(yanitlayici_id,soru_id,cevap,secenek_id) values(@yanitlayici_id,@soru_id,@cevap,@secenek_id)", baglanti);
                komutekle.Parameters.Add("@yanitlayici_id", int.Parse(yanitlayici_idsi) + 1);
                komutekle.Parameters.Add("@soru_id", " ");
                komutekle.Parameters.Add("@cevap", " ");
                komutekle.Parameters.Add("@secenek_id", " ");
                komutekle.ExecuteNonQuery();
            }

            baglanti.Close();
        }
    }
}