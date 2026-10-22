Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653026;
	b=kaN6z57akIreQ8D5BgE62fDDOUn+AnXvU4vVaQnh0RZzMDTdNzgJNv6fwv5GnFszDtX5
	 0MQDxBCEVto//MWMIxC6ppempXh/9PAhzFkJIuwjd0c+oNuC/vLhAMVH8V00XPA08YfAM
	 F48F/2WhQayU5bhNlyVsBJdaN2djbqlmE6boK+ljUjnjsbd3fNaJEv+v8TRR6xgd0/FUZ
	 CEbbWULC4d7oJNwC8IS7phEdUNbvP2upnY/1t+DJJZmBUzZ+7fyiy6PLkkMLWEueJxy0d
	 6mnHUYWdbEppEaE7A61FizHCzCy87Eh1wWPEhrF5Wjh4/VEDyu0iSC/i9a1/fEzU4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
	b=g1WRKGTYkJEdW6GgrrCya9BcmehhBkc0kc2Fv5nYvmyAksXW03+08qy9iRbna7B41YQ0
	 BlINnXuJvi3Rv/NlF/Wb2fQGwPtGXPrSwdzKKXkIePejxcjC5n+94uSDYhLf3PHoNYvey
	 th1nbweVmSs1ZkYLwNncXS9FFNlZ9ii4hB+e/4rOJuzKMQnyFiFXv+l4rP5JEfqd7yqbP
	 qlGgdiNETfwRJ+76UyFzVsmOnD+ybF5I8ZknFKKG5LGMITXLh/Kg2KGIA0UJcJzQtXTXJ
	 jHYJOfptmKj6eXVGNpoe/fuajA/ZXkNyfZf3cel7YIfH1MI37cqnvL6VoOp9s60o9Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFUMBxMa;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CB606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFUMBxMa
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso5604385ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653025; x=1793257825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=qFUMBxMaK6CdgDBTyOpMWCNdcpfDDqGdiQLb/pR1oPQYi6CKaowEzQBpBV0iOSwnVU
         n1Ka8uwLGD93La8MP63IB9EKMndadwJWLM7vk+135dSsI6liSrGFTLi4UEh/YQQ7xHUz
         3L2MDkQdbK//LlcZEuy8jJr3RDvrbPp5fMWbVh6w3HBe5W4Pbq6v2FYBAt4FVakfLI7S
         amDIaOHHbjSRjkCVAnCyms2ivFmTinl7uvmRVWJvej8mlaWm9ZJHDdP+vwW66PKEJpKf
         YE2ngiPpfMh5FrXMlWKX2s23wVNEs1a1hMVnfPih+WL79F4ZIlp4iekknikNaemb6weY
         nLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653025; x=1793257825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=ocz2irnWc+BiIVrbxl55Ub6yWbcTpKmYPFsci8fFM1S/aBbvVA3ywfzfFMbrvaggo3
         d3zDUjQalMsaT5MY5YWXBFGnq8uaFe1ZkcWu/XBE05HJGeS/pu23bd2gFGqSH5naCPnz
         wz7aqBJT5C6ZJsjiuPCeIPDRQTyX2NqLdZ695hd5vNsVkJd0IUZNWhBvdFoy8ErpgJul
         ftOMSJnnmMzoh7dj1CKuhbjv+MHgWWECTV5+LDJ5bKLGhlgTDGs/rXfgBec75ySUjQ4Q
         6HWRN/NeX1vvwEyzHPsjPpnVBLrGjAJMXGINA8KAMXZUfhTX8d9YWOocf3eU/i2nmGHv
         3A9g==
X-Forwarded-Encrypted: i=1; AKwUvByRA2xootgldwzhw3h004aqn10k7KRszT0MnMobMJYvR2jYR7FTKb750GuM2N7WduJ9TZBIiNpTniJbhT1O7uk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8FX+oMxYXiu+nxE4/asXbetscqCYl3EpFWgt6xZrNpkvcz76v
	y+BCgxUflhbZcA455e/O+7cdpH4yfZjsx3hBxRe2scC3/LIY/PkcH/Kc
X-Gm-Gg: AYBFou0zGu/GIh5vEsK0cv8oehyT5KglLBbAmNnytMpFbW30gaTEWB46KU1+ViLGic9
	1k2bnajtYNlENOouYDSaDUhpZWjXRicN5bIzI2f5GcK1I/6nxOPN4Wxj1R1+iz52UkNeYX7KQQA
	meHq/XQnFyr5kijpho9VGP3XwSeIKM1W533+Sd+fD53eADa/lKhu9u7fl5ndsJS86un9k9R/F9g
	xvBuHrg/YQAoPs1Jpxg9HGQSSyq39AjKgHjkTJm3v21Y5ASweCLdgNzItVkTIXc08WLC2Bskz8G
	5HWYeEs2kf+i9E0c2WF7hZGvRtUMZ41slFTWC59xBNdOObtF6qGapn2JnEGAHC3datGuGe8UdpP
	IyldVPSfPsVykYprzwD6ESNa9ai1pud+f640DIZo+lnCvosii75wgfQeGeyK+1NjLGJ9/22XyjP
	RItXEcFLrDRTMrxbcBvBH34bGFYgPN0iV1k2pmJcd2JYMUHp8RhcTrk6oKG0A1RVCXcFWT6A6ru
	KoH/pD51oBpiyZsylPdc0DK3eCyJkHKJjNMjSu7cG+HsLgSZitkAtEbOZ9+u702oEiOZL57cQ==
X-Received: by 2002:a05:6a00:2e17:b0:89f:4cd9:241a with SMTP id d2e1a72fcca58-8a089d45677mr3426736b3a.41.1792653024539;
        Thu, 22 Oct 2026 00:10:24 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:22 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 6/6] Input: touchscreen - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:29 +0800
Message-ID: <20261022070929.20820-7-shlomojune6@gmail.com>
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

The sur40 and usbtouchscreen drivers build their input device physical
paths by appending "/input0" with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API [1], replace
each pair of calls with usb_make_subpath(). The helper formats the
USB path and the "input0" subpath in one call, avoiding a separate
buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/touchscreen/sur40.c          | 3 +--
 drivers/input/touchscreen/usbtouchscreen.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 77ec2c94b91fd..7702eead123e2 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -690,8 +690,7 @@ static int sur40_probe(struct usb_interface *interface,
 	/* Set up regular input device structure */
 	input->name = DRIVER_LONG;
 	usb_to_input_id(usbdev, &input->id);
-	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
-	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	usb_make_subpath(usbdev, sur40->phys, sizeof(sur40->phys), "input0");
 	input->phys = sur40->phys;
 	input->dev.parent = &interface->dev;
 
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb517c286..fd2b896675dee 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1512,8 +1512,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 			 le16_to_cpu(udev->descriptor.idVendor),
 			 le16_to_cpu(udev->descriptor.idProduct));
 
-	usb_make_path(udev, usbtouch->phys, sizeof(usbtouch->phys));
-	strlcat(usbtouch->phys, "/input0", sizeof(usbtouch->phys));
+	usb_make_subpath(udev, usbtouch->phys, sizeof(usbtouch->phys), "input0");
 
 	input_dev->name = usbtouch->name;
 	input_dev->phys = usbtouch->phys;
-- 
2.43.0

