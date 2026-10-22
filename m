Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653020;
	b=jMgVbIVkzNv0b/VTzu9Eu6BK5ZLmPV7Zn1VbKmSlFng6v+veaWsZwR28BJ1YyJRgsdoc
	 wqU7HlmmBrq65390sjFh+hE0rZ5AW0SAbKRK6dhjTHgCPk94kou6d1uC5DIDvJ04aBOVX
	 DegbibyhVyVTaOGnPknwGFDXNCvG0DSnO/AJwjjqkQT0x4XoP2nxMT4nlqb6kzKeb8ZFC
	 8DNPLL+QK7rY50vbMk5wKSENNr+rBuvpSMuzpCV/e3gRleqD1g7iYlyCHf+BIgOfYJa9m
	 gSQZTrR7l8QJP5CdL7PCQQ0CqKZMC7KzqtgmO+wdJYde0Xabuht5S4yB+BAiA2L51tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
	b=mR0LnJKgEN248EkMThbD1Qy3wM91vncg/lnQBKLfFKMwf1zt67r5wOabhajV8RtJxcDn
	 Uwco+uEdM/+ITWd5U9vRHTWr/WVMmvd5lnDK5Qj/bqT25UO/pk0mzHeUIh7uDIVd2l2WO
	 fEPyH9AqwxeWeqFxuYn2O6+wswN8m6yGEQRNWGHjYDhl56TLZvN4Mqy54BHT7UQo619bn
	 wFit4XazAtj8LwrGhgo983LzJR6fI+bDguLI/yxnRIlMujaXjTDPlbQru+BBANy7FxiO8
	 9TS6/o5upjH2dN0Rs16QDX0CIXIACUUDqUZHmIluWRfeaE4FbVZTPMsmAnRSV0ic9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kiOVV5e6;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB20606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kiOVV5e6
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4821449so811456a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653018; x=1793257818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
        b=kiOVV5e6J/GurhcFbB5U4EjybcgG1yzCdcXX6qqqH3B8pLf4zT2exbjzkKeu3AkOYG
         8EQtoM6IijOclz7ZN+NIncP26KuaxJ7N+oPIIOX7hBIcv+ggvbWqc0diJmRQwwrOvOkV
         K1nu/SzFLysQ/vNIBbzqL3nJP6HzHiBXc/QTPIMFjM/XRDVc+9uKy4JrWsGJ/VXcAauC
         avfVAKZ3pJKSIk8FLonvgP9p16ZOpzTUbwSWm1ROEhgcbPkvIjW/Yg/jhy9zhVDLSozb
         udFqaQiSg9Q/PTrYCbTI5X34jL4OHBO9pFrN71nfLTVQwHw5oVidgelNT+DgEBwu91YE
         Y5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653018; x=1793257818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
        b=SgJuKXPjx9LxrQvA4evmHt8Z1ao8EL3E2theS85STrT+9XyYYoliZkhLYW4ysSrQgG
         Yf60UyoSNmOddvdNiHYDCqWkPFSpLoidrvb2dLFlDuuiGVGs4RKdk8rwBsBfuKLhE0OP
         JWmvurPe1qJW9m0Vl06kqB3sXyIltW6Zv1nnVum8y1BSGkHoNBjj0xAiNv931Ic+Hu6e
         dHeswjVStVFdcSbM0CPIgQqcqJo2aKVMXVCoN1sgJyXDNpOa78P2paz4+DNzKmMeyJN4
         sBZpfqryyWCeCTJPNoywHiikwaZBz0zACapQvvIk/tKX97iTk1Py4iDrEX45A5cDzm0P
         8OxA==
X-Forwarded-Encrypted: i=1; AKwUvBwaH6rX0Al92y3G94C/NgXe80Our6JyRjaxewdrphckOer9i0QTHLJRpEE14jNJq/gaDtLDqYdRrp22fr62sio=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWZ5V58ESprg8l1jhskw8A6yQwUHoz/CRKxRghW2ts4IkGNDyb
	EgC1Bjklds2xQ/D+x8u2k9bf38N7h9no0YoGvpB+y3HJkLjep9hgS7yB
X-Gm-Gg: AYBFou0mqcIyTgMNEX7BumURYiYir3+h7EKKlo+PVSpRpJ57mLsmacDddXshb66TMJK
	nIHPEjLABEn7ErN18d5D8oRgAhYQULXSSBJlbzwAVwyRv+ms3s6qyhvBB1rHsMITXmL+Qg0ZUoS
	F42WhcGxrKtAxkvDzyoz8t9TdSgupQTLmFl5RzdVMacgj7PPuJ8u/K0wY5/GZ7ZPnvlW42oKtpt
	SRfzIUjh5jiplGKQF1eb2xDk1JeqgiVY3JCnpypVKjGux2rHGdj+2gWMC1vFoINOqJybLCBK3N1
	ZrnUz3WoAajz6QPMwzx1ynIlzUNIdHH78BWHSx8mNs3i4s5RAsnBL9PfDaa+3yHCNXPW/ZGEqIQ
	/RqRLUbmi/Uifcn0p0OxJxxx1SnxU6zDv7rFGuCuX0ErUOcyd/Zmluxlfj3ZjBpGtqAHzeV6Jmf
	FWDnc/szB0HtDoEpaQN9KQWsncQlxpAuacr4UFA2WLc9rZ+Y0V4e6Pk+7ld/qqZfh6ClmvYvBIP
	6Hu6VYszwMP8NX3Ddd3CQelKkTRhrPJOF5mfEqn3Bh46K/fxFRdUAVP2D/gy+rcSXpX8nwVUw==
X-Received: by 2002:a05:6a21:4ead:b0:3e0:df21:9de5 with SMTP id adf61e73a8af0-3e287dbdaa0mr3277689637.35.1792653018511;
        Thu, 22 Oct 2026 00:10:18 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:17 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 5/6] Input: tablet - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:28 +0800
Message-ID: <20261022070929.20820-6-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022070929.20820-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acecad, aiptek, hanwang, kbtab and pegasus_notetaker drivers build
their input device physical paths by appending "/input0" with strlcat()
after usb_make_path().

In preparation for removing the deprecated strlcat() API [1], replace
each pair of calls with usb_make_subpath(). The helper formats the USB
path and the "input0" subpath in one call, avoiding a separate buffer
scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/tablet/acecad.c            | 3 +--
 drivers/input/tablet/aiptek.c            | 6 ++----
 drivers/input/tablet/hanwang.c           | 3 +--
 drivers/input/tablet/kbtab.c             | 3 +--
 drivers/input/tablet/pegasus_notetaker.c | 3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index ba79dff21aac8..c12b0a0181837 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -160,8 +160,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 		strlcat(acecad->name, dev->product, sizeof(acecad->name));
 	}
 
-	usb_make_path(dev, acecad->phys, sizeof(acecad->phys));
-	strlcat(acecad->phys, "/input0", sizeof(acecad->phys));
+	usb_make_subpath(dev, acecad->phys, sizeof(acecad->phys), "input0");
 
 	input_dev->name = acecad->name;
 	input_dev->phys = acecad->phys;
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 0c1acb9e6b437..cc68ee82c12c3 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1705,10 +1705,8 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 * & a tablet, and the inputX number actually will tell
 	 * us something...
 	 */
-	usb_make_path(usbdev, aiptek->features.usbPath,
-			sizeof(aiptek->features.usbPath));
-	strlcat(aiptek->features.usbPath, "/input0",
-		sizeof(aiptek->features.usbPath));
+	usb_make_subpath(usbdev, aiptek->features.usbPath,
+			sizeof(aiptek->features.usbPath), "input0");
 
 	/* Set up client data, pointers to open and close routines
 	 * for the input device.
diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index fd5a7e761dcc4..a9521bbc89646 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -350,8 +350,7 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
 	hanwang->usbdev = dev;
 	hanwang->dev = input_dev;
 
-	usb_make_path(dev, hanwang->phys, sizeof(hanwang->phys));
-	strlcat(hanwang->phys, "/input0", sizeof(hanwang->phys));
+	usb_make_subpath(dev, hanwang->phys, sizeof(hanwang->phys), "input0");
 
 	strscpy(hanwang->name, hanwang->features->name, sizeof(hanwang->name));
 	input_dev->name = hanwang->name;
diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index 6ce70c8e2d7cc..f777118ed7c8f 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -137,8 +137,7 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 	kbtab->intf = intf;
 	kbtab->dev = input_dev;
 
-	usb_make_path(dev, kbtab->phys, sizeof(kbtab->phys));
-	strlcat(kbtab->phys, "/input0", sizeof(kbtab->phys));
+	usb_make_subpath(dev, kbtab->phys, sizeof(kbtab->phys), "input0");
 
 	input_dev->name = "KB Gear Tablet";
 	input_dev->phys = kbtab->phys;
diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 85390ae423076..28fbae98f7399 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -354,8 +354,7 @@ static int pegasus_probe(struct usb_interface *intf,
 			 le16_to_cpu(dev->descriptor.idVendor),
 			 le16_to_cpu(dev->descriptor.idProduct));
 
-	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
-	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
+	usb_make_subpath(dev, pegasus->phys, sizeof(pegasus->phys), "input0");
 
 	INIT_WORK(&pegasus->init, pegasus_init);
 
-- 
2.43.0

