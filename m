Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782173911C0
	for <linux-hardening@vger.kernel.org>; Tue,  4 Aug 2026 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821481; cv=none; b=gAQjuCeQNfF1LICXW27YxiYEQD2pZy58EkfZDFvgbrkVq3C9aSTQAYagaYXD64n0NxUkuw6lIBbVA0Oc0R2u3d03I6bqATj/cCEwWTVFYl+IU/5Pe8210WmLBkf2Ax44thSZETHDXTcMu858Otb+S0QUuuAMBTIwr7awcrBcEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821481; c=relaxed/simple;
	bh=OZborBjVtztBA+NCttZFRTnfO3YY4Hp0AeEdbBqM/XI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iaBYqdXYtBpRn64LGFTpk1aihNZjCmrdp9Cx4PuyWadv7wDdCJ3avwbyB8eS4l8RY1ZRr/NDChTokA0WT1mq+bPFGVdDp7MRKh53k21Lnlv5I9J5QHh/rTn+iJkQ5FLoVCpbpg0I8B+VOl51S79gSNwboOHAcEX0PP0kcmMBqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PE6AqPnM; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PE6AqPnM"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6688a2dceb8so2677358d50.3
        for <linux-hardening@vger.kernel.org>; Mon, 03 Aug 2026 22:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821477; x=1786426277;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZborBjVtztBA+NCttZFRTnfO3YY4Hp0AeEdbBqM/XI=;
        b=RDvyfr2qcWhtaTCHtIpraYIuO6C/M3+MpdmOe2y+8ucg8ECSAVPknX4Qa+Ep4bGVSi
         E1NYF7HAZCURu47gyDF69DS917CeV4veu+bIAoC8z4FR4VtIIC/290Gt4FWy8nNzLMNm
         AcNzDoMsNHlgSA4jaeQ0RPPlLI6RwyvjOUXp5a5pW1PURS0VjXBu5mTTBO4xm3e2TwPz
         +67wJfrPfW8gmB6KaFYOqZtJPNjw2WsdsVkQTShr6ilrMEsrx13NKCxI3TX4s/VWwBcY
         DZqiHdG7vYM5YTI00NCXxk387wkFB0GSaO84ZEAcLUKKLXvmL6CFWzlDM/ishS5Jj/Zy
         8GqA==
X-Forwarded-Encrypted: i=1; AHgh+RoEs7n/KqLZAG6eOLJSB2fMrkniTLR7cShIMZvet6HoQuA9ehhY5loUvAix7X2cMgkzNbc4sOm+ul4t1aTOVOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqE6vR+MAPMIWznc2/iI6iKtfzMPIV5mWyLV/TnyW2I+Qk98qM
	IgA6wMBjuelaDZRpL+8c39HRhSx0YjsPvTQwUVSkXSftrbBTtzI9FERbK69FGQyzKrUUDv26cUz
	wYFNrkD+BKmSk4z5mNDrCmYccNvhWAV8z4uHgbd3x3LlvbZfCMfb627nJgjTzP2m6H+FTFm4N2Q
	tLInVt//9cpVcaNDaxFRMiRDP+kuhXbXd8NSL90xE5SIeLhGBaIV9o1FKN8OztFhIhwMXU8+2mS
	n88N3vQWlJtpvjv8J+NcdEsSw==
X-Gm-Gg: AR+sD119w565CV6DpPAjvHsEy1090BZEIdcPcnT4ka2savzhWf5K9vLJ4cNtmHZ8KUu
	AzE9JOxsj1DGyDZbJDB/f6y3CNxI90L9125hduHAkhIDK1pbWZEa9Wopt9zEDa0K6v+uPwpkf8S
	8hBlHrPibMl1Ybel2R6maa1tbDEhd04haYsxijeM+fZ6auVqIgo1nf4y77MMOXokgc1O4uYlqNF
	fZM0HB+TI3vwKGln8J+Dr2ghsO/oULEYOTvfmW89fTkfa4ER9Byb+qXYZwXD4Wyxl7eF7+yRaYK
	R2ygs0vBVAefs4s11bvWrokRPMD8qTwhvHjbRMJwah5UvjiTFtPaMMe76ZzbI1MENDrSKDr+cVh
	1KbOLQevfshWRwaKm8JaKEQ1ajnFaFVNbxGeDpibKQoTL+pLlGeCbsrup/3ymkKCCzzz6ZE27sn
	MNbgTBm47SpaQp9gVXC/o4jhLEoNHFRbY2JEQsJA==
X-Received: by 2002:a05:690e:168e:b0:667:a284:2280 with SMTP id 956f58d0204a3-6694f15d861mr15111402d50.31.1785821477170;
        Mon, 03 Aug 2026 22:31:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66948ea7383sm532372d50.11.2026.08.03.22.31.17
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2026 22:31:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so398100885a.3
        for <linux-hardening@vger.kernel.org>; Mon, 03 Aug 2026 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785821476; x=1786426276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZborBjVtztBA+NCttZFRTnfO3YY4Hp0AeEdbBqM/XI=;
        b=PE6AqPnMKbxnrvAHadBcH3S7L2avb5ipkQf8BkeVJ/pNGcoDrXVxz9BEERgRz6Z+QW
         xCYvLtB+SzJpD7t5kDX+hUXtHaPGDeqyJZ85pxAePiQXJW1Qg7ogALV/WoQxsXEr7Qsh
         7PmjpAhFVhhBW2Qzzim4DUvyrBw7hI885utpQ=
X-Forwarded-Encrypted: i=1; AHgh+RrRuykFp6xtAN7+b6OhfbTuHv2eRi+TpQ5bHP40pZZcY2tH0mWEcGOSUvCbdWCtaiuDSkwaDvEqHTbThGvL5LQ=@vger.kernel.org
X-Received: by 2002:a05:620a:6cce:b0:92e:6637:da3 with SMTP id af79cd13be357-934a0a89bbamr2095009785a.38.1785821476576;
        Mon, 03 Aug 2026 22:31:16 -0700 (PDT)
X-Received: by 2002:a05:620a:6cce:b0:92e:6637:da3 with SMTP id
 af79cd13be357-934a0a89bbamr2095007385a.38.1785821476182; Mon, 03 Aug 2026
 22:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nigel Kirkland <nigel.kirkland@broadcom.com>
Date: Mon, 3 Aug 2026 22:30:38 -0700
X-Gm-Features: AUfX_myGXX5W3REfL264Nbb0W3-b9x12DtYfbfC7REXUEikMWgZY0REbx80F3cE
Message-ID: <CAJcBD+GEbM9BGMHGF2B6q3XNdr=4hLuU4bWV_Os0_P1B5c06YQ@mail.gmail.com>
Subject: Subject: [PATCH 0/5] scsi: lpfc: Remove all strlcat() uses
To: Ian Bridges <icb@fastmail.org>, Paul Ely <paul.ely@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Nigel Kirkland <nigel.kirkland@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c339aa065831f68b"

--000000000000c339aa065831f68b
Content-Type: text/plain; charset="UTF-8"

Looks good, thank you

Reviewed-by: Nigel Kirkland <nigel.kirkland@broadcom.com>

--000000000000c339aa065831f68b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
jYSlgy5DSdwOHRopf+pv+QS0X7yv1IY0zvc3MdBwIA64y6S7wLpr5F7gdUrq8Fl5LCjVgxPQ/Ty2
3P2tfeP2KcMiZJZkxM0a8fTBL3BNZvoUkrCJ0+9OLtDTeYyGpPJCe1uXfRQsdHlCWqvRLQectwvK
gVO8kkq10hxpHIoL4D7ReRqd0IGu2Q/sLEa8soR9l/4kzT7cqtRw2ObwRa5Lrpoj3ncE0GE8NQT/
VZNnTJUtoV7zM0Rsp9sMBHWLpuvkIS5e9TbhFVRiDRl96AsCAwEAAaOCAd8wggHbMA4GA1UdDwEB
/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5
BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIz
MGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4
MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmww
JgYDVR0RBB8wHYEbbmlnZWwua2lya2xhbmRAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUF
BwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBThLteltIFAS7A/
sfVsQLkdu4rgaTANBgkqhkiG9w0BAQsFAAOCAgEAwJtA5Pst35/Z9Nq5qDfm2rXaz7h6wJWU5wqm
vVNO7qrNHFh9begX48kQA+L7rAViQkSZN518XXiXR+UyHLNS3wd44P13KPs4lMrfLKXqlGeD+VlX
Ax80pTsBA4y/0afIdFnIXqYT/EN0sHqlFtA/LjPo6rypmSNk17RrM6x0HlcHH52eJmxjntyTr/9z
blGf2VLGucQTBG6Bu6ATQuRV4h1SE40+9B1OVuPyiVMvedp4NgUMsx18K7eAvyrA9kDZcSuA69tO
aeB3nyuCyvayferpiA93m1sjIODoTkqQ9aH/I0n+B2rib5eeqMT61//fmEwRFFBHcP+QjiFrxbFY
e58YwBCOm+0AMj51ScI6rOT9geQuEK7vMP9+N7Sub0/7L69T/BTuz4kG5cFppnKXUL/9NfADDowH
IDhP42JB9i8PLQZ0MxlMLxhtGSF/3h6PJUV8Qd6o2Bi6QSO2g3MXG8pvKUK8OEJs/j5BjF/3IWVU
OGiPDn4Rwdcbj4Oi6ADue58oMYLZD5dxh1w89QSSBMRA3T877tunyHNlgsXvZE4Co/Z4t9D32ZA8
UHOn3Kh+T28i30BvDtxS6Cy8EU4/8gFHQ67PnAKdT5X+/ek4GnI2cUouZ6ykVSWvCCJ0gGviLWUn
oiR9Wl2Xgmc/2JkP0Q7ufuDWqhwkg+qVbBFCGiExggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBT
TUlNRSBDQSAyMDIzAgxjf/M4aTgLfQ2a61wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkE
MSIEIDGaMwkDWbZ6nzwqpbe55KdHBrQj2Zhewr1Ss/qd+ePBMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDgwNDA1MzExNlowXAYJKoZIhvcNAQkPMU8wTTALBglg
hkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0B
AQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFJB4E4uURUAYOW/eOmh+1vLWR3kIy62
9IvvYQAFQTaLo+TK0CcCDxlIdHz6TZ3meRMKVhVqJuA4mZLOauVdHAHfXCek1nfkwaFy19kq/vKB
AWq4gwogsAHW/XZL1cPP1xVSjBQTMKCxF7RnoMhj2ryyBHrIxMApoDbjxg3v8o2oMClBrc4WZxIN
hYF5o1GXtfraZ6ip41oX5cF8u8rU05IgT4xRqyRdIA3m42VPc2eqcZwAT2rQiP9J7QgnhArGa8GV
peuuLiE1bAzlVwNzZZSpiOQgTMlROrlq2TIWHfthbZKd9IAPCMEZUmOxwex5UJIDXWd+my9/4UIw
/n3tkGI=
--000000000000c339aa065831f68b--
