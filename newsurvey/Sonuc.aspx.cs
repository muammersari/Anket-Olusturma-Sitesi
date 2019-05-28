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
    public partial class Sonuc : System.Web.UI.Page
    {
        public static string anket_id = "";
        public static SqlConnection baglanti = new SqlConnection("Data Source=.;Initial Catalog=survey_db;Integrated Security=True");


        protected void Page_Load(object sender, EventArgs e)
        {

            form1.Attributes.Add("onkeydown", "return (event.keyCode!=13);");
            if (Request.QueryString["anketidd"] != null)
            {
                //anket_id_si = HttpContext.Current.Session["anket_id_si"].ToString();
                anket_id = Request.QueryString["anketidd"].ToString();
                baglanti.Close();
            }
            else
            {
                baglanti.Close();
                Response.Redirect("Anasayfa.aspx");
            }
            ArrayList soruid_list = new ArrayList();
            ArrayList soru_list = new ArrayList();
            ArrayList secenekturu_list = new ArrayList();
            ArrayList okt_sutun = new ArrayList();
            ArrayList rb_secenek = new ArrayList();
            baglanti.Open();
            SqlCommand komut1 = new SqlCommand("select * from sorular_tbl where anket_id ='" + anket_id.ToString() + "' order by soru_sirasi", baglanti);
            SqlDataReader oku1 = komut1.ExecuteReader();
            while (oku1.Read())
            {
                soruid_list.Add(oku1["soru_id"]);
                soru_list.Add(oku1["soru"]);
                secenekturu_list.Add(oku1["secenek_turu"]);
            }
            oku1.Close();

            Table tablo = new Table();
            tablo.ID = "headerTable";
            tablo.Style["margin"] = "auto";
            TableRow tr = new TableRow();
            TableRow tr1 = new TableRow();

            ArrayList yanitlayiciid = new ArrayList();
            ArrayList baslama_bitis_tarihi = new ArrayList();

            SqlCommand komut2 = new SqlCommand("select distinct * from yanitlayici_tbl where anket_id='" + anket_id.ToString() + "' ", baglanti);
            SqlDataReader oku2 = komut2.ExecuteReader();
            while (oku2.Read())
            {
                yanitlayiciid.Add(oku2["yanitlayici_id"].ToString());
                baslama_bitis_tarihi.Add(oku2["baslangic_tarihi"].ToString());
                baslama_bitis_tarihi.Add(oku2["bitis_tarihi"].ToString());
            }
            oku2.Close();
            int sayacbaslabitir = 0;
            if (yanitlayiciid.Count > 0)
            {
                for (int k = 0; k < yanitlayiciid.Count; k++)
                {
                    //SqlCommand komut5 = new SqlCommand("select count(*) from cevaplar_tbl where yanitlayici_id ='" + yanitlayiciid[k].ToString() + "' and secenek_id='" + secenekler_list[j + 1].ToString() + "' and soru_id='" + soru_list[i].ToString() + "'", baglanti);
                    //int a = int.Parse(komut5.ExecuteScalar().ToString());
                    TableRow tr2 = new TableRow();


                    for (int i = 0; i < soru_list.Count; i++)
                    {
                        rb_secenek.Clear();
                        okt_sutun.Clear();
                        int colspan = 0;
                        ArrayList secenekler_list = new ArrayList();
                        if (secenekturu_list[i].ToString() == "Onay Kutusu")
                        {
                            SqlCommand komut3 = new SqlCommand("select * from secenek_cb_tbl where soru_id ='" + soruid_list[i].ToString() + "'", baglanti);
                            SqlDataReader oku3 = komut3.ExecuteReader();
                            while (oku3.Read())
                            {
                                secenekler_list.Add(oku3["secenek_text"].ToString());
                                secenekler_list.Add(oku3["secenek_id"].ToString());

                            }
                            oku3.Close();
                            colspan = int.Parse(secenekler_list.Count.ToString());
                        }
                        else if (secenekturu_list[i].ToString() == "Çoktan Seçmeli")
                        {
                            SqlCommand komut4 = new SqlCommand("select * from secenek_rb_tbl where soru_id ='" + soruid_list[i].ToString() + "'", baglanti);
                            SqlDataReader oku4 = komut4.ExecuteReader();
                            while (oku4.Read())
                            {
                                secenekler_list.Add(oku4["secenek_text"].ToString());
                                secenekler_list.Add(oku4["secenek_id"].ToString());
                                rb_secenek.Add(oku4["secenek_text"].ToString());
                            }
                            oku4.Close();
                            colspan = int.Parse(secenekler_list.Count.ToString());
                        }
                        else if (secenekturu_list[i].ToString() == "Sürekli Ölçek")
                        {
                            SqlCommand komut5 = new SqlCommand("select * from secenek_so_tbl where soru_id ='" + soruid_list[i].ToString() + "'", baglanti);
                            SqlDataReader oku5 = komut5.ExecuteReader();
                            oku5.Read();
                            //while (oku5.Read())
                            //{
                            secenekler_list.Add(oku5["birinci_secenek_text"].ToString() + " - " + oku5["ikinci_secenek_text"].ToString() + " ( " + oku5["birinci_aralik"].ToString() + " - " + oku5["ikinci_aralik"].ToString() + " )");
                            //}
                            oku5.Close();
                            colspan = 2;
                        }
                        else if (secenekturu_list[i].ToString() == "Çoktan Seçmeli Tablosu")
                        {
                            SqlCommand komut6 = new SqlCommand("select * from secenek_okt_tbl where soru_id ='" + soruid_list[i].ToString() + "' and satir_sutun='satir' order by secenek_id", baglanti);
                            SqlDataReader oku6 = komut6.ExecuteReader();
                            while (oku6.Read())
                            {
                                secenekler_list.Add(oku6["secenek"].ToString());
                                secenekler_list.Add(oku6["secenek_id"].ToString());
                            }
                            oku6.Close();
                            colspan = int.Parse(secenekler_list.Count.ToString());

                            SqlCommand komut14 = new SqlCommand("select * from secenek_okt_tbl where soru_id ='" + soruid_list[i].ToString() + "' and satir_sutun='sutun' order by secenek_id", baglanti);
                            SqlDataReader oku14 = komut14.ExecuteReader();
                            while (oku14.Read())
                            {
                                okt_sutun.Add(oku14["secenek"].ToString());
                            }
                            oku14.Close();
                        }
                        else if (secenekturu_list[i].ToString() == "Sürekli Ölçek Tablosu")
                        {
                            SqlCommand komut7 = new SqlCommand("select * from secenek_sot_tbl where soru_id ='" + soruid_list[i].ToString() + "' order by secenek_id", baglanti);
                            SqlDataReader oku7 = komut7.ExecuteReader();
                            while (oku7.Read())
                            {
                                secenekler_list.Add(oku7["secenek"].ToString());
                                secenekler_list.Add(oku7["secenek_id"].ToString());
                            }
                            oku7.Close();
                            colspan = int.Parse(secenekler_list.Count.ToString());
                        }

                        if (k == 0)
                        {
                            if (i == 0)
                            {

                                TableCell tdyanitlayici_id = new TableCell();
                                tdyanitlayici_id.Style["border"] = "1px solid black";
                                tdyanitlayici_id.Style[" background-color"] = "khaki";
                                tdyanitlayici_id.ColumnSpan = (colspan / 2);
                                tdyanitlayici_id.Text = "Katılımcı Id";
                                tdyanitlayici_id.Style["text-align"] = "center";
                                tdyanitlayici_id.Style["padding"] = "5px";
                                tr.Cells.Add(tdyanitlayici_id);
                                tablo.Rows.Add(tr);

                                TableCell tdyanitlayici_id1 = new TableCell();
                                tdyanitlayici_id1.Style["border"] = "1px solid black";
                                tdyanitlayici_id1.Style[" background-color"] = "khaki";
                                tdyanitlayici_id1.ColumnSpan = (colspan / 2);
                                tdyanitlayici_id1.Text = " ";
                                tdyanitlayici_id1.Style["text-align"] = "center";
                                tdyanitlayici_id1.Style["padding"] = "5px";
                                tr1.Cells.Add(tdyanitlayici_id1);
                                tablo.Rows.Add(tr1);

                                TableCell tdbaslangic = new TableCell();
                                tdbaslangic.Style["border"] = "1px solid black";
                                tdbaslangic.Style[" background-color"] = "khaki";
                                tdbaslangic.ColumnSpan = (colspan / 2);
                                tdbaslangic.Text = "Anket Başlama Zamanı";
                                tdbaslangic.Style["text-align"] = "center";
                                tdbaslangic.Style["padding"] = "5px";
                                tr.Cells.Add(tdbaslangic);
                                tablo.Rows.Add(tr);

                                TableCell tdbaslangic1 = new TableCell();
                                tdbaslangic1.Style["border"] = "1px solid black";
                                tdbaslangic1.Style[" background-color"] = "khaki";
                                tdbaslangic1.ColumnSpan = (colspan / 2);
                                tdbaslangic1.Text = " ";
                                tdbaslangic1.Style["text-align"] = "center";
                                tdbaslangic1.Style["padding"] = "5px";
                                tr1.Cells.Add(tdbaslangic1);
                                tablo.Rows.Add(tr1);

                                TableCell tdbitis = new TableCell();
                                tdbitis.Style["border"] = "1px solid black";
                                tdbitis.Style[" background-color"] = "khaki";
                                tdbitis.ColumnSpan = (colspan / 2);
                                tdbitis.Text = "Anket Bitiş Zamanı";
                                tdbitis.Style["text-align"] = "center";
                                tdbitis.Style["padding"] = "5px";
                                tr.Cells.Add(tdbitis);
                                tablo.Rows.Add(tr);

                                TableCell tdbitis1 = new TableCell();
                                tdbitis1.Style["border"] = "1px solid black";
                                tdbitis1.Style[" background-color"] = "khaki";
                                tdbitis1.ColumnSpan = (colspan / 2);
                                tdbitis1.Text = " ";
                                tdbitis1.Style["text-align"] = "center";
                                tdbitis1.Style["padding"] = "5px";
                                tr1.Cells.Add(tdbitis1);
                                tablo.Rows.Add(tr1);
                            }

                            TableCell td = new TableCell();
                            td.Style["border"] = "1px solid black";
                            td.Style[" background-color"] = "khaki";
                            td.ColumnSpan = (colspan / 2);
                            td.Text = soru_list[i].ToString();
                            td.Style["text-align"] = "center";
                            td.Style["padding"] = "5px";
                            tr.Cells.Add(td);
                            tablo.Rows.Add(tr);
                            if (secenekler_list.Count > 0)
                            {
                                int sayac = 1;
                                for (int j = 0; j < secenekler_list.Count; j += 2)
                                {

                                    TableCell td1 = new TableCell();
                                    td1.Style["border"] = "1px solid black";
                                    td1.Style[" background-color"] = "khaki";
                                    //td1.Text = secenekler_list[j].ToString();
                                    td1.Style["text-align"] = "center";
                                    td1.Style["padding"] = "5px";
                                    tr1.Cells.Add(td1);
                                    tablo.Rows.Add(tr1);
                                    if (secenekturu_list[i].ToString() == "Çoktan Seçmeli")
                                    {
                                        td1.Text = secenekler_list[j].ToString() + " ( " + sayac.ToString() + " )";

                                    }
                                    else if (secenekturu_list[i].ToString() == "Çoktan Seçmeli Tablosu")
                                    {
                                        td1.Text = (i + 1) + "." + (sayac) + " - " + secenekler_list[j].ToString();
                                    }
                                    else
                                    {
                                        td1.Text = secenekler_list[j].ToString();
                                    }
                                    sayac++;

                                }
                            }
                            else
                            {
                                TableCell td1 = new TableCell();
                                td1.Style["border"] = "1px solid black";
                                td1.Text = " ";
                                td1.Style[" background-color"] = "khaki";
                                td1.Style["text-align"] = "center";
                                td1.Style["padding"] = "5px";
                                tr1.Cells.Add(td1);
                                tablo.Rows.Add(tr1);
                            }

                        }

                        if (i == 0)
                        {
                            TableCell tdyanitlayici_id2 = new TableCell();
                            tdyanitlayici_id2.Style["border"] = "1px solid black";
                            //tdyanitlayici_id2.Style[" background-color"] = "khaki";
                            tdyanitlayici_id2.ColumnSpan = (colspan / 2);
                            tdyanitlayici_id2.Text = yanitlayiciid[k].ToString();
                            tdyanitlayici_id2.Style["text-align"] = "center";
                            tdyanitlayici_id2.Style["padding"] = "5px";
                            tr2.Cells.Add(tdyanitlayici_id2);
                            tablo.Rows.Add(tr2);

                            TableCell tdbaslangic2 = new TableCell();
                            tdbaslangic2.Style["border"] = "1px solid black";
                            //tdbaslangic2.Style[" background-color"] = "khaki";
                            tdbaslangic2.ColumnSpan = (colspan / 2);
                            tdbaslangic2.Text = baslama_bitis_tarihi[sayacbaslabitir].ToString();
                            tdbaslangic2.Style["text-align"] = "center";
                            tdbaslangic2.Style["padding"] = "5px";
                            tr2.Cells.Add(tdbaslangic2);
                            tablo.Rows.Add(tr2);

                            TableCell tdbitiş2 = new TableCell();
                            tdbitiş2.Style["border"] = "1px solid black";
                            //tdbitiş2.Style[" background-color"] = "khaki";
                            tdbitiş2.ColumnSpan = (colspan / 2);
                            tdbitiş2.Text = baslama_bitis_tarihi[sayacbaslabitir + 1].ToString();
                            tdbitiş2.Style["text-align"] = "center";
                            tdbitiş2.Style["padding"] = "5px";
                            tr2.Cells.Add(tdbitiş2);
                            tablo.Rows.Add(tr2);
                            if (k % 2 != 0)
                            {
                                tdyanitlayici_id2.Style[" background-color"] = "LightCyan";
                                tdbaslangic2.Style[" background-color"] = "LightCyan";
                                tdbitiş2.Style[" background-color"] = "LightCyan";

                            }
                        }
                        if (secenekturu_list[i].ToString() == "Sürekli Ölçek")
                        {
                            SqlCommand komut8 = new SqlCommand("select count(*) from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "'", baglanti);
                            int syc1 = int.Parse(komut8.ExecuteScalar().ToString());
                            TableCell td2 = new TableCell();
                            td2.Style["border"] = "1px solid black";
                            td2.Style["text-align"] = "center";
                            td2.Style["padding"] = "5px";
                            td2.Style["height"] = "20px"; ;

                            if (k % 2 != 0)
                            {
                                td2.Style[" background-color"] = "LightCyan";
                            }
                            if (syc1 > 0)
                            {
                                SqlCommand komut81 = new SqlCommand("select cevap from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "'", baglanti);
                                td2.Text = komut81.ExecuteScalar().ToString();
                            }
                            else
                            {
                                td2.Text = " ";
                            }


                            tr2.Cells.Add(td2);
                            tablo.Rows.Add(tr2);
                        }
                        else if (secenekturu_list[i].ToString() == "Onay Kutusu")
                        {
                            for (int m = 0; m < secenekler_list.Count; m += 2)
                            {
                                SqlCommand komut9 = new SqlCommand("select count(*) from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "' and  secenek_id='" + secenekler_list[m + 1].ToString() + "'", baglanti);
                                int syc2 = int.Parse(komut9.ExecuteScalar().ToString());
                                TableCell td2 = new TableCell();
                                td2.Style["border"] = "1px solid black";
                                td2.Style["text-align"] = "center";
                                td2.Style["padding"] = "5px";
                                td2.Style["height"] = "20px"; ;
                                if (k % 2 != 0)
                                {
                                    td2.Style[" background-color"] = "LightCyan";
                                }
                                if (syc2 > 0)
                                {
                                    td2.Text = "1";
                                }
                                else
                                {
                                    td2.Text = "0";
                                }
                                tr2.Cells.Add(td2);
                                tablo.Rows.Add(tr2);

                            }
                        }
                        else if (secenekturu_list[i].ToString() == "Çoktan Seçmeli")
                        {
                            SqlCommand komut10 = new SqlCommand("select count(*) from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "'", baglanti);
                            int syc3 = int.Parse(komut10.ExecuteScalar().ToString());
                            TableCell td2 = new TableCell();
                            td2.ColumnSpan = colspan / 2;
                            td2.Style["border"] = "1px solid black";
                            td2.Style["text-align"] = "center";
                            td2.Style["padding"] = "5px";
                            td2.Style["height"] = "20px"; ;
                            if (k % 2 != 0)
                            {
                                td2.Style[" background-color"] = "LightCyan";
                            }
                            if (syc3 > 0)
                            {
                                SqlCommand komut101 = new SqlCommand("select cevap from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "'", baglanti);
                                //td2.Text = komut101.ExecuteScalar().ToString();
                                int indexno = rb_secenek.IndexOf(komut101.ExecuteScalar().ToString());
                                td2.Text = (indexno + 1).ToString();
                            }
                            else
                            {
                                td2.Text = " ";
                            }
                            tr2.Cells.Add(td2);
                            tablo.Rows.Add(tr2);
                        }
                        else if (secenekturu_list[i].ToString() == "Açık Uçlu")
                        {
                            SqlCommand komut13 = new SqlCommand("select count(*) from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "'", baglanti);
                            int syc4 = int.Parse(komut13.ExecuteScalar().ToString());
                            TableCell td2 = new TableCell();
                            td2.ColumnSpan = colspan / 2;
                            td2.Style["border"] = "1px solid black";
                            td2.Style["text-align"] = "center";
                            td2.Style["padding"] = "5px";
                            td2.Style["height"] = "20px"; ;
                            if (k % 2 != 0)
                            {
                                td2.Style[" background-color"] = "LightCyan";
                            }
                            if (syc4 > 0)
                            {
                                SqlCommand komut131 = new SqlCommand("select cevap from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "'", baglanti);
                                td2.Text = komut131.ExecuteScalar().ToString();
                            }
                            else
                            {
                                td2.Text = " ";
                            }
                            tr2.Cells.Add(td2);
                            tablo.Rows.Add(tr2);
                        }
                        else if (secenekturu_list[i].ToString() == "Çoktan Seçmeli Tablosu")
                        {
                            for (int m = 0; m < secenekler_list.Count; m += 2)
                            {
                                SqlCommand komut11 = new SqlCommand("select count(*) from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "' and  secenek_id='" + secenekler_list[m + 1].ToString() + "'", baglanti);
                                int syc5 = int.Parse(komut11.ExecuteScalar().ToString());
                                TableCell td2 = new TableCell();
                                td2.Style["border"] = "1px solid black";
                                td2.Style["text-align"] = "center";
                                td2.Style["padding"] = "5px";
                                td2.Style["height"] = "20px"; ;
                                if (k % 2 != 0)
                                {
                                    td2.Style[" background-color"] = "LightCyan";
                                }
                                if (syc5 > 0)
                                {
                                    SqlCommand komut111 = new SqlCommand("select cevap from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "' and  secenek_id='" + secenekler_list[m + 1].ToString() + "'", baglanti);
                                    //td2.Text = komut111.ExecuteScalar().ToString();
                                    int indexno1 = okt_sutun.IndexOf(komut111.ExecuteScalar().ToString());
                                    td2.Text = (indexno1 + 1).ToString();
                                }
                                else
                                {
                                    td2.Text = " ";
                                }
                                tr2.Cells.Add(td2);
                                tablo.Rows.Add(tr2);
                            }
                        }
                        else if (secenekturu_list[i].ToString() == "Sürekli Ölçek Tablosu")
                        {
                            for (int m = 0; m < secenekler_list.Count; m += 2)
                            {
                                SqlCommand komut12 = new SqlCommand("select count(*) from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "' and  secenek_id='" + secenekler_list[m + 1].ToString() + "'", baglanti);
                                int syc6 = int.Parse(komut12.ExecuteScalar().ToString());
                                TableCell td2 = new TableCell();
                                td2.Style["border"] = "1px solid black";
                                td2.Style["text-align"] = "center";
                                td2.Style["padding"] = "5px";
                                td2.Style["height"] = "20px"; ;
                                if (k % 2 != 0)
                                {
                                    td2.Style[" background-color"] = "LightCyan";
                                }
                                if (syc6 > 0)
                                {
                                    SqlCommand komut121 = new SqlCommand("select cevap from cevaplar_tbl where soru_id='" + soruid_list[i].ToString() + "' and yanitlayici_id='" + yanitlayiciid[k].ToString() + "' and  secenek_id='" + secenekler_list[m + 1].ToString() + "'", baglanti);
                                    td2.Text = komut121.ExecuteScalar().ToString();
                                }
                                else
                                {
                                    td2.Text = " ";
                                }
                                tr2.Cells.Add(td2);
                                tablo.Rows.Add(tr2);
                            }
                        }
                    }
                    sayacbaslabitir += 2;
                }
            }
            else
            {
                Label2.Text = "Anketinize Katılım Sağlanmamıştır. Katılım Sağlandığında Anket Sonuçlarını Buradan Görebilirsiniz.";
            }
            baglanti.Close();
            div1.Controls.Add(tablo);


            System.Web.HttpBrowserCapabilities myBrowserCaps = Request.Browser;
            if (((System.Web.Configuration.HttpCapabilitiesBase)myBrowserCaps).IsMobileDevice)
            {

                Label1.Text = "Mobil cihazdan giriş yapıldı.Excel Raporu Alırken Modilde Düzgün Çalışmayabilir.Lütefen Bilgisayardan ve" + "\n" + "internet explorer haricindeki tarayıcılardan çıktı alınız.";
            }
            else
            {
                if (yanitlayiciid.Count > 0)
                {
                    Label cevaplayicisayisi = new Label();
                    cevaplayicisayisi.Text = "Ankete Katılım Sağlayan Kişi Sayisi : " + yanitlayiciid.Count.ToString();
                    div1.Controls.Add(cevaplayicisayisi);
                    Button btnexcel = new Button();
                    btnexcel.Text = "Excel Raporu Al";
                    btnexcel.ID = "excelrapor";
                    div2.Controls.Add(btnexcel);
                }
                Label1.Text = "";
            }
        }
    }
}