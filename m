Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFED54281B
	for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170296; cv=none; b=mQ5GJYDL0QZqHNdd+xts7L2JZY9LGp0wFB1fgEluUFylIweP/cb3BUSlWjt9Zt3SPqAZPaMsctNwQcr6ipy71lWwPHSObLd3d1nTubBAJ2tzXhlmT2YTOYm5Asp6Ec92MYSA3IlgcIYZD6dnxGV1jzfXVTJG44rKY9ZvBf0hH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170296; c=relaxed/simple;
	bh=P0Sg+F0KKBPtMKdv7lWgT3UyF3Ll76cOvOMLZIK6NBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/yWcAdfnr4CAImTWBysLXRZIwMQXCY5CemH24K4kG8Fth3RKEXRmY6FfSJnTaGyucv1mHYvIP2onlcwoTccJARv5tdsJvoJ70hKl3DMbBXovKGt3HsIPk32OkyZX64tN1PBqzBpTw790VxPM99eObCNCTjiSg8rNdr736wMMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+/DsjxN; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+/DsjxN"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3ac96ba6a4eso26366a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170294; x=1792775094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTK7t+qRWhyCyqZmU5cFtXciAINVp6GCAy+u+kWv2kg=;
        b=j+/DsjxNRn4pSCNitIQqwqo6wCfmoBXav8ejxpJuFxM2XRETwZuuFL86CX/AI+ojyA
         IwBl23VCelSDOOuhGAm528+D/yjCHpKezRyv/oMASUHCiu18+NvZihJd27CsO8MkdK8M
         zq23nS1PdWUljzxjoH4KKbbtOMiQcIH7tgrsO7DTgDaNBHuCOpn/C6Nd90k6eUotAYsJ
         ubJUY44LMaxXs2ZWDR4Ne84VNbSkgadDGghgYhOtntD9jiPioej3pDvZBofA2+QLVdXk
         ChyMdtl7/RdiWIqomOw7qeHZDvWyEVvbjPY/GiObHZfr+eVtm6y8PSzByDyyR4G8WELp
         iZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170294; x=1792775094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTK7t+qRWhyCyqZmU5cFtXciAINVp6GCAy+u+kWv2kg=;
        b=ntm7DOS7NmlKAzsFT79q21qmlWDq8sUA9sgjtF+C0KSovTQQweSZYpoyr9Hc/q9WMm
         w46Fz4iGJg9l4kFw7AlHjiI5gFF0MK8m7G9Mibid9NWXodNc1qMMFTbgnEK2Vbso4SYg
         iZcWtBqrtxNopzp8kEJi9fdsdQjAUTukWHOT5l40uq28HIFJiVI5PqJUwGU9EOan+7rR
         MhEoev36fE/L93/jrNqo8j0jqINJrOUabM3wMd+6fJ+8WQxZP3lPMAtgm9MkeXhgEJPL
         4hcTEjh/Ad4B0P/J6KzB5CSAs0z+KExZbCs1MdARx9H5YYLJyZxyLco12G7G+5zRwUo8
         svtQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7Q/dWrwAdMSHvUdsn72Owf7cQeSMYpuJo5QjB+4nbf9cYdnKvKATDN+D+QOND8VOcNVf1I494wF3FsibuqXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3V5+rXiuH6qm4l6g+oriup+nnI1FHB1XdyFwXqdLnK9Zqtw73
	NWgKZKwS8Z5a5H93ItaL/CSA68rHgzheVKkwpu8FmY2aUis2+KhZ15KW
X-Gm-Gg: AYBFou0jegBvqpZCwDO0yr9V68TwGBNDZAUgpRtmQxDpdSvm2HX+3gq/Yw1lPm9TFRO
	tlFBrwFQA4EBzSpPn7WW6b3MsXNhM0Bq/ZPqfQKADpCxk99HS2GamluT95ClhIGByP12GZrtN6q
	uowcB2oP+M6Q1pM894Y2itg6ilQxcbVXqgFFt+k07K52bj/Wlkonv32Hi4Ooc9D2YMoV0q4Ia23
	UVGjetuaksQAeMR3pS2+UqBdtSuiabQr7fxi7rofsfAVOKdH7OqFUchCV9b0otzG6tVUEwLfWCx
	JQTDh1zp5Oigeh3xxunyCIlxFy5qZtoOX8xfPSfWkMrSUXg3iHwpCpXJxHmLfkROZFV9FOUyNT1
	bxCwtuCv9f0Vl/+ley37OlB4diTaUu+nQwhXH79OjJJKcvxIVdtMirMtC2+MXGox9CzcR2f1AH6
	eyzitmsC+o9kBUX/nkllaC/yRFNkW8yo5+CIvvW8IWUHLNXbAfbJaD6RZu3QArnSwF2xQY8q/92
	24L+XsDfKLh+UQ=
X-Received: by 2002:a17:90b:48c5:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3acef4e131cmr275516a91.30.1792170294449;
        Fri, 16 Oct 2026 10:04:54 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:53 -0700 (PDT)
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
Subject: [PATCH 5/5] Input: touchscreen - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:11 +0800
Message-ID: <20261016170411.51025-6-shlomojune6@gmail.com>
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

The sur40 and usbtouchscreen drivers build the physical path by
appending a constant "/input0" suffix with strlcat() after
usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/touchscreen/sur40.c          | 4 +++-
 drivers/input/touchscreen/usbtouchscreen.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 77ec2c94b91fd..72ec3882e3d40 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -657,6 +657,7 @@ static int sur40_probe(struct usb_interface *interface,
 	struct usb_endpoint_descriptor *endpoint;
 	struct input_dev *input;
 	int error;
+	size_t len;
 
 	/* Check if we really have the right interface. */
 	iface_desc = interface->cur_altsetting;
@@ -691,7 +692,8 @@ static int sur40_probe(struct usb_interface *interface,
 	input->name = DRIVER_LONG;
 	usb_to_input_id(usbdev, &input->id);
 	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
-	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	len = strnlen(sur40->phys, sizeof(sur40->phys));
+	strscpy(sur40->phys + len, "/input0", sizeof(sur40->phys) - len);
 	input->phys = sur40->phys;
 	input->dev.parent = &interface->dev;
 
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb517c286..e6f88bd9a3408 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1438,6 +1438,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	const struct usbtouch_device_info *type;
 	int err;
+	size_t len;
 
 	/* some devices are ignored */
 	type = (const struct usbtouch_device_info *)id->driver_info;
@@ -1513,7 +1514,8 @@ static int usbtouch_probe(struct usb_interface *intf,
 			 le16_to_cpu(udev->descriptor.idProduct));
 
 	usb_make_path(udev, usbtouch->phys, sizeof(usbtouch->phys));
-	strlcat(usbtouch->phys, "/input0", sizeof(usbtouch->phys));
+	len = strnlen(usbtouch->phys, sizeof(usbtouch->phys));
+	strscpy(usbtouch->phys + len, "/input0", sizeof(usbtouch->phys) - len);
 
 	input_dev->name = usbtouch->name;
 	input_dev->phys = usbtouch->phys;
-- 
2.43.0

