package com.kayit.calisma;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import Utils.Db;
import Utils.kullaniciEnum;
import Utils.kullaniciPro;

@Controller
public class HomeController {

	Db db = new Db("kullanici_kayit", "root", "");

	// sayfa açýldýðýnda veritabaný bilgileri listeleniyor
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		List<kullaniciPro> kullaniciLs = kullaniciDoldur();
		if (kullaniciLs.size() > 0) {
			model.addAttribute("kullaniciLs", kullaniciLs);

		}

		return "home";
	}

	// kullanýcý ekleme iþlemi
	@ResponseBody
	@RequestMapping(value = "/kayitekle", method = RequestMethod.POST)
	public String ajaxkayit(Model model, kullaniciPro kp) {
		try {
			String query = "insert into kullanici values (null,?,?,?,?)";
			PreparedStatement prs = db.preConnect(query);
			prs.setString(1, kp.getAdi());
			prs.setString(2, kp.getSoyadi());
			prs.setString(3, kp.getMail());
			prs.setString(4, kp.getSifre());
			int sonuc = prs.executeUpdate();
			if (sonuc > 0) {

				String row = "<tr>\n" + "\n" + "								<td>" + kp.getAdi() + "</td>\n"
						+ "								<td>" + kp.getSoyadi() + "</td>\n"
						+ "								<td>" + kp.getMail() + "</td>\n"
						+ "							</tr>";

				return row;

			}
		} catch (Exception e) {
			System.err.println("ekleme baþarýsýz" + e);
		}

		return "";
	}
//veritabanýndan kullanýcý bilgileri sorgulama
	public List<kullaniciPro> kullaniciDoldur() {
		List<kullaniciPro> kullaniciLs = new ArrayList<kullaniciPro>();
		try {
			String query = "select * from kullanici";
			ResultSet rs = db.connect().executeQuery(query);

			while (rs.next()) {
				kullaniciPro kp = new kullaniciPro();
				kp.setId(rs.getInt("" + kullaniciEnum.id));
				kp.setAdi(rs.getString("" + kullaniciEnum.adi));
				kp.setSoyadi(rs.getString("" + kullaniciEnum.soyadi));

				kp.setMail(rs.getString("" + kullaniciEnum.mail));

				kp.setSifre(rs.getString("" + kullaniciEnum.sifre));

				kullaniciLs.add(kp);

			}
		} catch (Exception e) {
			System.err.println("kullanici doldurma hatasi :" + e);
		}

		return kullaniciLs;
	}
}
