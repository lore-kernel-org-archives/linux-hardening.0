Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282054146F
	for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170294; cv=none; b=If3/WBP1G/Lkvk8Z85UvgOVlJsOZXOwhtT1j1QoSSCQPDl3ymFUIcaiTkUDh9offjhBQ1ysuZDqIfGVjxGha68HvVqe25RgPlxkeckIDyPWFej4w9mG0vIB55KxKDZEzvKyMMOKAbpql7jdmo+8AU///NIrHxNSA9mS+IR0Wxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170294; c=relaxed/simple;
	bh=IhskYAx5XZAsBuHLBdeBeP1Z1C394yBsocGQ00UuckM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSwH3/xzv5g9u8lI2tJ3qYwCd0OgL31JnX4Bp5gHKRvLpwGGpPrdD5qJ+PlnqtaikBm2rf4ZOCZEUf4tMFndR8DrezDC34KyfUqe7N8Rfp9gOntLJJGCjat+TyNV0IYUECMV1a/L15Ds4UHTe7iYRaggBS4pSK3fNwhAp30hydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbCm7ifg; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbCm7ifg"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso61209a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170289; x=1792775089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqBuBqF5w5nYW+qU6oWNYgmkbXGdZx8t9CJGJi5QLPA=;
        b=sbCm7ifg/PWE/WDXq9jsRYxMVjXNQltyY3etTdvmjyqfQHtvvGLN6gtcGEwa8uD971
         nKexsILFyEfl7ijuUwUqxh9SJOqKs0+lUAWMYQSSoqMR/R7Z72K8b5SXgz4VPRnOIMKi
         4xsLzAGrW/wAAlNFbJGowGOi73Lvyn8ans4wr4cII886J4eaRsTTXVmAe1iaMHLnUCxc
         HfZOHIsmgDVKbKUA6bEZvMBGgZSpWDif95Z1X/kAyLOQKiyhpMxIcfKpFT1sPHNghfOo
         VUPsfi4H8TtrYQiv4/my3bW60iU5gdlsDmR8WKXBYM6Scl609UpfFmDU3fTWBid4q5Ms
         IbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170289; x=1792775089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mqBuBqF5w5nYW+qU6oWNYgmkbXGdZx8t9CJGJi5QLPA=;
        b=Vw0xn1TKFrxxybP5gles7MiZkwE3Yc3zRKVdxjaZ7Xj5nseA7uKhqq6HGBGgeHo9bR
         em0AxP8m/yBAAYKfS7hWnu5bOLsPx3Si09IRnqK05YPkDfzTiCdCI+f93HBdk6CB5/M3
         3bbrFcor4/FyRVFLSw4dUbRpB3wrBgkGb1wZY23y0uBWeH5NYEzW2sloCJmAfKPbb6nw
         pAZjvktS8L84qiwxgQzKv23W8YrP45KEwTSLpQ9Ww1xWQoeHX3e34M3G+yXV9/ESUuih
         azsRxi4bGYYHfOa147D/z3FZez1LwFjATeWynixBljyeEPH+0QtugXaYHAAFQVODIyyE
         cmBA==
X-Forwarded-Encrypted: i=1; AKwUvBz+CD7L3ELiyW3wPQtOVNGKiwYJxd4dJLavBnPt1g8dnnRmVOwuAtjx+YnZIvqR8y5eWi97vsVRolqSR+3qp50=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTMzonY8zLjmVzdgl2RzelRqpw/sEyAta0YvN4gT4QL3jKJem5
	1kXp7iZFlEZD9t5v9pSmY791EfFSSr5O34CmSXSdVJk/bkbvxwM/vUdz
X-Gm-Gg: AYBFou1En5xeIX0YJMmkM8SMeCQMCfF7EzpmiVxAAl58y/ZDbwi7d7X/c/WGzZB7nxw
	SXu08uN5iGVHfcHxY00vC5hbrVorAefmtjkbt1qe+a3oMUXi5qbrU628KqBuCD+H4zFzQgGNcnQ
	Q+i9GAfEoLVN2Oow/stRRBuLEum+ElYNclbxNOdd9fLEFpzKCmxtKgVSLafDXDNC2SWOJslqEQT
	B419mjfJPodAPQ5E5SIC4zcuG491xNREJ7vY309zr4NYn86Iz+oAZB0wPgF/2HSqTBkhsTiKP/R
	GviBgBshat7Tdcbf08jd8s9L7gbXqTqua+mW2H+FNR7ZhyyL2fAg7dGrVDLTwv6dwUfIMK8pim4
	u8cd2tvk0VXBhcvitb1jVllDeZ71UCH2eog/KcXmjxFU5RZ9GSGKuzYVmFylYvmD1lmpPGbxU+U
	54zl2KsvRYx3bap6UgGtiB5ohcuIipleGGT1EFNiSAUYsgtSo5pGyDXlU53Oc0WPkMWFnmwlqqT
	mqWfcXzx63xe10=
X-Received: by 2002:a17:90b:1d4d:b0:3ac:a7ee:6760 with SMTP id 98e67ed59e1d1-3aceefc2b04mr378835a91.23.1792170289006;
        Fri, 16 Oct 2026 10:04:49 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:47 -0700 (PDT)
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
Subject: [PATCH 4/5] Input: tablet - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:10 +0800
Message-ID: <20261016170411.51025-5-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016170411.51025-1-shlomojune6@gmail.com>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acecad, aiptek, hanwang, kbtab and pegasus_notetaker drivers
build the physical path by appending a constant "/input0" suffix
with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/tablet/acecad.c            | 4 +++-
 drivers/input/tablet/aiptek.c            | 7 +++++--
 drivers/input/tablet/hanwang.c           | 4 +++-
 drivers/input/tablet/kbtab.c             | 4 +++-
 drivers/input/tablet/pegasus_notetaker.c | 4 +++-
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index ba79dff21aac8..8fec79c46d4b0 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -117,6 +117,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 	struct input_dev *input_dev;
 	int pipe, maxp;
 	int err;
+	size_t len;
 
 	if (interface->desc.bNumEndpoints != 1)
 		return -ENODEV;
@@ -161,7 +162,8 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 	}
 
 	usb_make_path(dev, acecad->phys, sizeof(acecad->phys));
-	strlcat(acecad->phys, "/input0", sizeof(acecad->phys));
+	len = strnlen(acecad->phys, sizeof(acecad->phys));
+	strscpy(acecad->phys + len, "/input0", sizeof(acecad->phys) - len);
 
 	input_dev->name = acecad->name;
 	input_dev->phys = acecad->phys;
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 0c1acb9e6b437..e868d0bac771d 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1637,6 +1637,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		AIPTEK_PROGRAMMABLE_DELAY_300
 	};
 	int err = -ENOMEM;
+	size_t len;
 
 	/* programmableDelay is where the command-line specified
 	 * delay is kept. We make it the first element of speeds[],
@@ -1707,8 +1708,10 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 */
 	usb_make_path(usbdev, aiptek->features.usbPath,
 			sizeof(aiptek->features.usbPath));
-	strlcat(aiptek->features.usbPath, "/input0",
-		sizeof(aiptek->features.usbPath));
+	len = strnlen(aiptek->features.usbPath,
+		      sizeof(aiptek->features.usbPath));
+	strscpy(aiptek->features.usbPath + len, "/input0",
+		sizeof(aiptek->features.usbPath) - len);
 
 	/* Set up client data, pointers to open and close routines
 	 * for the input device.
diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index fd5a7e761dcc4..a75d10dd2fc7d 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -318,6 +318,7 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
 	struct input_dev *input_dev;
 	int error;
 	int i;
+	size_t len;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
 		return -ENODEV;
@@ -351,7 +352,8 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
 	hanwang->dev = input_dev;
 
 	usb_make_path(dev, hanwang->phys, sizeof(hanwang->phys));
-	strlcat(hanwang->phys, "/input0", sizeof(hanwang->phys));
+	len = strnlen(hanwang->phys, sizeof(hanwang->phys));
+	strscpy(hanwang->phys + len, "/input0", sizeof(hanwang->phys) - len);
 
 	strscpy(hanwang->name, hanwang->features->name, sizeof(hanwang->name));
 	input_dev->name = hanwang->name;
diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index 6ce70c8e2d7cc..79a5e217654b6 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -113,6 +113,7 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 	struct kbtab *kbtab;
 	struct input_dev *input_dev;
 	int error = -ENOMEM;
+	size_t len;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
 		return -ENODEV;
@@ -138,7 +139,8 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 	kbtab->dev = input_dev;
 
 	usb_make_path(dev, kbtab->phys, sizeof(kbtab->phys));
-	strlcat(kbtab->phys, "/input0", sizeof(kbtab->phys));
+	len = strnlen(kbtab->phys, sizeof(kbtab->phys));
+	strscpy(kbtab->phys + len, "/input0", sizeof(kbtab->phys) - len);
 
 	input_dev->name = "KB Gear Tablet";
 	input_dev->phys = kbtab->phys;
diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 85390ae423076..679600bd214e4 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -277,6 +277,7 @@ static int pegasus_probe(struct usb_interface *intf,
 	struct input_dev *input_dev;
 	int error;
 	int pipe;
+	size_t len;
 
 	/* We control interface 0 */
 	if (intf->cur_altsetting->desc.bInterfaceNumber >= 1)
@@ -355,7 +356,8 @@ static int pegasus_probe(struct usb_interface *intf,
 			 le16_to_cpu(dev->descriptor.idProduct));
 
 	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
-	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
+	len = strnlen(pegasus->phys, sizeof(pegasus->phys));
+	strscpy(pegasus->phys + len, "/input0", sizeof(pegasus->phys) - len);
 
 	INIT_WORK(&pegasus->init, pegasus_init);
 
-- 
2.43.0

