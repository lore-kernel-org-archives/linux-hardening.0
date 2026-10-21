Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585936;
	b=zNNQJzpZdG9aj8mfMJ8IagSappEjuhlwbWnim1NFFJd12XyUadihU38OMGZesy4tZQOx
	 P3XoXkgsKzI/85UTqgxoFVwLwYAAKiZTdnlSvJKzzsx19DQgTrZKWqFyilfqNesRHhM8w
	 2cXy+Ow+dUMNDlgsEK6QOVM04RgYb2K7A25qBEBFQFe3QMMoVQqOWs8exLEunFuxW7/JA
	 evCQg6alkkRG4AaiZa5DNJ+uPy5MiCmv8yjEbhe7vyRjw+GRnHTtCP2wmTx6KJPRveRRo
	 h+DFkyax9x1yDybMA8o8IHUNSLtaFkM9sttCcOOY5+cwayqOwvQCahHWmOTF+xGYxWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
	b=U1pqwDH43EAojVKY1VeDrnYnBvRhnQOzSZa8VaVtW+DiI8KO2Ft5OGKFgC8ShNpfZXlR
	 OSymZX2mqg+uDxCacYFUvEd+C/0uEsNTgIRUX3VeGRoAbrEtBcg0LgF/4nWTUh6emkFEo
	 KI3uS+IwUYn2SJ8xZbkMPQnzDzqb1Q00gCnWu+6fQITMrSZZ0emZUC/KzKVAU8TuZtFIo
	 oo3jV5eZv1Rux1w30SwrFHyyqFV+ZKT4Hwgc6VZ+mYspfiD4snAgxJvPN5WVjpXMzHDmr
	 ewbAJFRdSlZZlMskJceeeT2sJbuQTlVnndbFLa15SgaGolUjkQFl6zjPtJae7JXAdzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EF9HLruD;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4260A382F
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E4260A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EF9HLruD
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac6fe4aff0so392283a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585935; x=1793190735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
        b=EF9HLruDnCdBFiWI52nFz0wGrnjT/Lfj5ghs0xy/UlBDEoPN04FyAPV9ZTATR0H4wc
         Io5MeRGt/au463dBe42mkIM8PuqYGnYAZ7Hr+r48V5mTbJb/5YCeAV5p52cW18Leznc3
         0Bknn70Ffim2Ex9Cp947zlJJWG5BcaDCUFg0J3gKbBGsHXfmmHsycVLNNfN8IvwXhfPU
         2U6F6RwXCDR67/ekV26JJSqBOQP2/VE4XWGm+SKr3xlSWZTDucu8fmXeO63bwuORaxT2
         VXghlIu8SizpUNJTMEwZCBGdWJ2fwo8BCIMXVgHMvLtXwljDr2eGDAM9G+GG8ofh4f0c
         YSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585935; x=1793190735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D0jGTVLtzaIFDc7gI7x4v6SVaJxQo+nXgqAY9AHPQIU=;
        b=zjOLJ4Zki8q6sJLyEzEScwm7gvzk6KWzlp6Vjm8VX89tD5s0gGWy8NF2CMZJeTLZCJ
         4EnjvY48lYlVw65N8Xw/jicifdzqs8Lgn7TD31ehyXUs4b/vsUHUXh+ibSJCIXEUlVo6
         Q8RSf/ZtshyYS2sKXkBKPAZ45G/khN5/x8FMczBTH5PKkjGKCW3MAbe1C2PhrJ6A7tqT
         XeMuFropCTnn+O7vgTtildyIq1jCYnEOm/gxJ9YEgltpvt+E1V8iBoJnnNfLr7koElMh
         jTZC4XiYwOW4Z6KQ3WYi+OSuBlAA0shWftFykHpntHkSEUG/B6ecDkK4SWGkUAvPZW0V
         UYCQ==
X-Forwarded-Encrypted: i=1; AKwUvByyU3g9qf5GaNPsNYP1t1k4FtXA/kFmAn6hGU97xNSnWjT3rmrvMuj8lx3++1hpLbPyx9R21uFDlfzwxNw7eQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLerK0vKXsplv5jHgc4Dx13FaV9W30cjXgvXute5DvtnDa7fbJ0
	fe4NHswRCX6tXCbv/GqtEZLdSEn+lpyKeSp6QZbnMOV96r4rM3LCDXT1
X-Gm-Gg: AYBFou3yWZPL+V9RhuXrWa3aSki6XyddK26ttaqIoaDG16Z3l2yFPLlwO8y+SAJ4DOB
	FW7Bdof2fQOVhPEVggHI6ZeK+hj9Lei/vPCgxj7ACrDdpPXTXLUL/ZaTCCOH7RdTD3sH+nufGB9
	zi226USGAP3LAjQb/rl52Y4XJwfrGL1o+g9b1+45nH8L7xWAp7b1eO/S6/tU1V2wdlrW0UjWCn+
	iIasj+r6BpyiRLqmLdbhNXIoOGgWp2EanMLCqx3Qz21F7DS+c7p58MChnjTapDJhgPp1NzZ9Yfo
	Sf3YpppUe51cyOVz3OF3plIL74q7jG+cTUF6GKa5oXlrnPq1rMB1sTv/ElSCKmbTD/WJ2/yM/oT
	WHuyHRfm8HmBifwqinAuxvD8Xfpfo3o7TMFmmWU0J4TGJPp0oH0tKSwBVvGENB9x7U6Nq6Vhy39
	U/3+zcMQbZcT7xuAjv81pV9NOEVhbgWTKd/EZhjL1rGyhT42TGQnNq7H1KvIWziPnRyjFxuBnE8
	Ws4uQHXMxP42cf14Mc6owOTK2aycxUvvO2Db2T30eI9zSt26BHfdn2M0aPQUuH6laAkvFUcNIqo
	NvXNdxUUjA3aAfe432M=
X-Received: by 2002:a17:90b:570f:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ad870711e1mr1875316a91.37.1792585935271;
        Wed, 21 Oct 2026 05:32:15 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:14 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 5/6] Input: tablet - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:45 +0800
Message-ID: <20261021123146.17202-6-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
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

