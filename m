Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455472248A3
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774638684; cv=none; b=iyHcXmrgz2O+fONrApsOyQV7vByI9MhW3HHjA9R6jFnDDkDL8+4d5hQleO8Wvd3DsT+AcRHjff3voTF+prfmYStqMzyIk1uJKwOjVn1QGtcd7G72Mm5EDL7nmHLHwv3MEZXF518fGJiXQCfyeDwO/xa5Acu5FtCcIwwbYZEtzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774638684; c=relaxed/simple;
	bh=MY7cvhxbG7/wiNuf5e5sQpLEVRQoOMUVb6G8zWyUBs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drOKNJyGVwWp7K1h2aeRZVHP88CJJiHFOJ05YQ8owirvhHgnUfyEdIrmsLFF4GYblwyePZtQBcA0WxWd7CE2Ifea5MlDrOBhsfucDFRJHV+Zj2IDRBfsPhQywSiKMIfoBxWgSr+4HP33eZ5SGpXwPDhUe1wN5vhGlk4K2pARW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHqLCdt3; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHqLCdt3"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128e4d0cc48so3138190c88.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774638682; x=1775243482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCbLjBWf2b55Ge/3z8jm9aEiQT0X4UuXkcvJNvdHJnc=;
        b=HHqLCdt3HSwMxY8SYohSVOvhhyob2P4NRsXJ/z/ifCwWrpXxpXmxXLMA7STK1BD+Fd
         MYprgzZ/mS58Cbes6VYME0bfqbboBhlQQCXF1u+wlJ27nbBAO6D5GNzzPD3D4tUZDgdH
         Pu5ZsD+WYdx5gkmE9VhbQPIyezQSzlNd61mGUQMUtzH9NXgZVsKTorgzvBhU6Hr7nYMr
         X7ngEDqpKy3/hO3VV/32VkNLNpTMixvlPCBk5H5NC1y6Pim6rDVA0rOss4/Mx/84kOFr
         EwP/axiCkpc+085PcYoIWOs6pHO0sWRblbttDK63eye7Cij6ywhhnWzC0Jx7OAgbGjOF
         Pf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774638682; x=1775243482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCbLjBWf2b55Ge/3z8jm9aEiQT0X4UuXkcvJNvdHJnc=;
        b=lyZ05E8lbSK/HC1SCcIK7HlAYJ8dZXrUbr2UAyKi4Iw0cW+0QYtDP8lImlLgi/hQBb
         HY9SnsEaJrHUFhg0enDoxFQa098B0Ob/avi971icMnJlVmxa8oZkhlpOl57C7KtHPO97
         4Qybr6GdgfzjGUIN3uUDhWFlwpQIAiubv29O2og4kAznpShvTU3bl/N9kDhrvqYmkfjK
         C+OxTG00hYM7ONRvt41TF/CZ2Z/WymzrYRZiyqrea02HVp927ZY8ljXI/ZiqAyPElHfY
         a8f2N5kHYIYSmaeTnREKLHu4I62EtSvmmOLaoKEyuFksa+Nlh5ymhrooPjrm7tSm6g+7
         BRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaqaetxtJmWIGq0ZbnRch/ZUmx96Slf23lNigBTs6M/Zn+SnrifT44enS7UTHthjhXVuccFXwKhvLjkeuc0Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFk+DpQFYUbrybMm/A46RWZZWV79se0yAhzeeShENw6GROqak
	CXANokW0NwmnY2FrUISOx8+8k02w11w83XKKv/DjNskq1i7/YNou3/Dc
X-Gm-Gg: ATEYQzwrnr0J5JNQlVJ6aaG9GZcpiArUdsVxw0zDrZmvhNwNONN7qBecKt5fXD/ccw1
	IcZ86aPG+CQc1XTX1H2zBvetdfNVnOkoPA4V09mhrIb6UdbNaBi5E+Qk5xeOBxY3OZ03kxPzqQp
	W64qXk6Vytuf3Ou/xSMJ6OCs5M2+7sdVLBOC1x9jOLl3sKt+DomxtiAU/0xxDsQfvgAMN+71S8L
	1zbK8tdNgH2gDNfiAImLf14XVVOEGoNtnS9O8IHejMrJ+rhKkW5CRhnB1OvKmCMY57JeOdQDkKa
	KB4VlVgD1N7DpVwDVIcBv1X8wayYXAMLJfk7dyMwcRuahGiEnas+CTSOuGFP88iLY6zYDe8/IAD
	qkTRSd1jE0Ov0qFRDJreLz8TYl0Dl8/vnCQU5l83zbQADnO8L+Io9Hydxvk/S3UHqwUanJl7iCx
	5LxdlIyX7CXHNOzOyNi7zk685W3d7buAJi5g6/dJh9FTI2CKs4/5Zw51I=
X-Received: by 2002:a05:7022:6191:b0:127:3b1e:7e0e with SMTP id a92af1059eb24-12ab28cb779mr2194710c88.20.1774638682181;
        Fri, 27 Mar 2026 12:11:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c46a0a84sm216527eec.9.2026.03.27.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:11:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] ARM: omap2: simplify allocation for omap_device
Date: Fri, 27 Mar 2026 12:11:04 -0700
Message-ID: <20260327191104.206512-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Remove goto paths as they are not really needed anymore.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove kfree and fix compilation.
 arch/arm/mach-omap2/omap_device.c | 29 ++++++++++-------------------
 arch/arm/mach-omap2/omap_device.h |  4 ++--
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 79db4c49ffc9..77a75b0b9ae6 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -307,35 +307,27 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	int ret = -ENOMEM;
 	struct omap_device *od;
 	int i;
-	struct omap_hwmod **hwmods;
+	struct omap_hwmod *hwmod;

-	od = kzalloc_obj(struct omap_device);
-	if (!od)
-		goto oda_exit1;
+	od = kzalloc_flex(*od, hwmods, oh_cnt);
+	if (!od) {
+		dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
+		return ERR_PTR(ret);
+	}

 	od->hwmods_cnt = oh_cnt;
+	memcpy(od->hwmods, ohs, oh_cnt * sizeof(*od->hwmods));

-	hwmods = kmemdup_array(ohs, oh_cnt, sizeof(*hwmods), GFP_KERNEL);
-	if (!hwmods)
-		goto oda_exit2;
-
-	od->hwmods = hwmods;
 	od->pdev = pdev;
 	pdev->archdata.od = od;

 	for (i = 0; i < oh_cnt; i++) {
-		hwmods[i]->od = od;
-		_add_hwmod_clocks_clkdev(od, hwmods[i]);
+		hwmod = od->hwmods[i];
+		hwmod->od = od;
+		_add_hwmod_clocks_clkdev(od, hwmod);
 	}

 	return od;
-
-oda_exit2:
-	kfree(od);
-oda_exit1:
-	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
-
-	return ERR_PTR(ret);
 }

 static void omap_device_delete(struct omap_device *od)
@@ -344,7 +336,6 @@ static void omap_device_delete(struct omap_device *od)
 		return;

 	od->pdev->archdata.od = NULL;
-	kfree(od->hwmods);
 	kfree(od);
 }

diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index aa8096ecb23c..fae09cfce137 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -37,11 +37,11 @@
 /**
  * struct omap_device - omap_device wrapper for platform_devices
  * @pdev: platform_device
- * @hwmods: (one .. many per omap_device)
  * @hwmods_cnt: ARRAY_SIZE() of @hwmods
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
  * @flags: device flags
  * @_driver_status: one of BUS_NOTIFY_*_DRIVER from <linux/device.h>
+ * @hwmods: (one .. many per omap_device)
  *
  * Integrates omap_hwmod data into Linux platform_device.
  *
@@ -51,11 +51,11 @@
  */
 struct omap_device {
 	struct platform_device		*pdev;
-	struct omap_hwmod		**hwmods;
 	unsigned long			_driver_status;
 	u8				hwmods_cnt;
 	u8				_state;
 	u8                              flags;
+	struct omap_hwmod		*hwmods[] __counted_by(hwmods_cnt);
 };

 /* Device driver interface (call via platform_data fn ptrs) */
--
2.53.0

