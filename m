Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585923;
	b=JY557eF6m9w1UQWKOPxfuBnkO6VSXU0KOSRQpoqxjDF4xJ4M6uWcQTtgK7/qcuBq89PZ
	 1AkRMlRdMYkN1bOvWKVKDpOCg7o4GUDzoyiMhdsHzwlf3XAiqc25Ip+/U1rAIQJebwbFW
	 xJvz3+nHrE2KYBD2RwOBhVVUOzvJxwwlyPV2cr1F9tkyHjbzkFOB0REXSYN93r28gRhkx
	 AgXCFbomD6zbNERE1EQnHgtYot6Vyuz3sYaxeRMtaQZ/WnxJDuOMMACZml/y39Ng0ecCE
	 eTRABUOYv6OMTk4Rb5El2wGw5X6kTCvOqj3IhCqbyKDPUDzdk5cmyT6J+Rj8K+fsnng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
	b=Wb+Io5QcOecu7GwXCmIYD/aCWUidrRNILUuwj9pcjvqjxkBDKITJ7IZ7SnmfH4i6ONfT
	 9szoffcUSH2e40NE0+hSKWpu1tRzEgZhokzkBBDRC1nKvIWGbOjejHO4vDHjnU7/tBMCZ
	 YPdto15X6CpUwKdll74IeK9GSomJFoHqSSK6eX2noob1yAK9B7MRF6B1+Z05bY5qE5nJM
	 /vWIco6p3bvy0wHoI4hQnmjOJY028Ppt+FyqsEWW/FhEve+RYw94KwwPl+wpsyUXh2aa+
	 czOOxktO5eqGfRfrA6xpJdGQdd7sjCcPJxBKC8UxtvJPwzY4T+uEEACWfPcP0F9oY8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pyKK+ubN;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013960A2613
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9013960A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pyKK+ubN
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3ad6011ecebso177794a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585922; x=1793190722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
        b=pyKK+ubNg2ugvEiozcnh0bkIjd7S64/hpGWpkYQm1AAeaOxNzuSx/aQ3gWBSrfKJ7T
         EWkXp/iFEiDA//sZrdJBHS9mssG66AQbKTkDlJnXepPEbSGHX7hm8gJMbnJdAhflq7Bt
         lMcqeE4aA3lvQf5W49uv8lNZ5SrH+lE+GWjr1jLwih+H6J3MSLWmh0eIsYnpbOHtGjpF
         3un1ctZsA0M9chdX6rO3o/dC/1Pmj0E2TVBFHvhH237+1JNCZj8Quj3lcZ/m+r+Fe9lw
         FKJTAWR0j+NIw/ztyfwqpfQA1OdPRtE5W17l6PSn7Wj/EJVpp36ybi9r8s8hQVxXjf6w
         ZypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585922; x=1793190722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPba+bVamvzTWQLnLCNMaFu8OZtPQlAUYLXZMzIXg3E=;
        b=l8fqqYIxnWD/FQ9SMib5Tw8e3PRDtJ/a6GZ4ACHHRhl/8aD7/AEbacHt+un4/iZWjC
         y6IejvIQZfsuARXkoZUu12EHOJRYjp3UF41Eq/RkxKJpyl0ZURBi5gluC621hgB6Z62+
         9kAyEPEDRjttBjGIfhOH4wx+GHsjGJrKUHnOGmFE++wS70DSLmFWX5a9ki+zXeT2umuF
         vDempIDlfAWLbDxYYlrTX72l3iJNucgqEMxH6bTDiPrRq0kPWFCBGZmyFzDR96T1VZJY
         6D2QA66MObaxL85KWxIFrxvjXti26LptOHYzwrQacP6LOD507M7TxeCDfz4jWS5MJKUz
         zQ/g==
X-Forwarded-Encrypted: i=1; AKwUvBxoj3F/deEl0CK9TH3F6zRArJUsm9+NU9+3mMZ0uOhp4Rth/ZpOONxbGSrYokwA5ZxRiKsHtDsEhvyKcIcMtEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUtqcLNYqwg0nMqVJ0I2vHwUtdwFdY/SVrMSPRV/OiwMGes0ox
	h46Ma+gaiKiy2FHi8U/Zu85f/UuGX25NgDYGm9NlyPZAsOjZRPS8KZQr
X-Gm-Gg: AYBFou1Xowx1ieIVgy+8GVNvmjjIKFw2E8QmmBsDqGXO116XhHQndyvcKsKZNN4cb/L
	7mC3GGUXbdWzxEFcxRaYgW7NtGdS3/qgHS/3ZFnkskjkQDXhEuQnXwso3jn18HtybE4D0FInF/W
	4nwvyz5HAIJJ+/eKfY9Fl7vvzw1N7HDmXPurP06p+U1ZPXj7r0hmsRA7tfLApN6Q0n9iux1uew8
	X2Kqn0zJL+pOpzwIRHPOkjNE15XnU8JRkBMURxa4GwLA+/TaSPkQ1E8FEdOTt673IcGTwNvq7CI
	1kpa12VRtX9yV7IBK1CdIa/SnDjhkjVpxcJXkCYTKbIeoYrSG9odWDcUV3p9fWpG59vjgSWPcRQ
	+Qh6zppfav3arAxCeQFTYuiPPnijw1K+fRTf2cOsoBQLuhQMYCJavWRFbBCvRGiyt46SXIUT7ae
	QVb3rJJOBldwxMPTi7tiVNzZyO4M6fmNT4tkZWJPAm++tn0ovi1YI+dAzzviKOjbOkMm6DmeR0p
	ZBG0mXuwYQm46rZNS1031VIcYueS99yKvVNEyehjQZQdciU3+sQdUg4CuwcZ4IUM4cgGYKBSg==
X-Received: by 2002:a17:90b:5547:b0:3ac:80dc:f40b with SMTP id 98e67ed59e1d1-3ad86ed848fmr1597600a91.33.1792585921869;
        Wed, 21 Oct 2026 05:32:01 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:01 -0700 (PDT)
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
Subject: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:42 +0800
Message-ID: <20261021123146.17202-3-shlomojune6@gmail.com>
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

The pxrc and xpad drivers build their input device physical paths
by appending "/input0" with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API [1],
replace each pair of calls with usb_make_subpath(). The helper
formats the USB path and the "input0" subpath in one call,
avoiding a separate buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/joystick/pxrc.c | 3 +--
 drivers/input/joystick/xpad.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 52d9eab667b7a..1a11e73d7cd04 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -169,8 +169,7 @@ static int pxrc_probe(struct usb_interface *intf,
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 
-	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
-	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
 	pxrc->input->phys = pxrc->phys;
 
 	usb_to_input_id(udev, &pxrc->input->id);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834e..0f7ca5adaeee7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -2059,8 +2059,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	if (!xpad)
 		return -ENOMEM;
 
-	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
-	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
+	usb_make_subpath(udev, xpad->phys, sizeof(xpad->phys), "input0");
 
 	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->idata_dma);
-- 
2.43.0

