Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD87217662
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492492; cv=none; b=KZ4m+zsWZtoKotAXSIO71GqpP5o5/xiF4PPnFU8fdtMzicAddr5guFoD7/GzWbjTezw7gGMpt3k/jFCE2DCz7jOxviyRAWFH+Rxu5pUzSofQzup5M6Nzhe8TGV59XRxUldPQtSEmBQd7bIGsr7BVivv1hzc6Bqt0HIOPwTkcTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492492; c=relaxed/simple;
	bh=TBzzG7hacy5c9qPr3l7NpzqNvZmFVX6fFumUw/1gN6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqqngM6WbTlvAb/9WrCiZ656tnO3JTPlv/THFqaBJXtZFb6MiTYeFvz4tbUoG9Wq7YKSqN/HTPnv3eN2ubSTcc/IRLbVEzFt3vTrj6SioVAaIlK3KwSVb6yJXbrB/tA/ggQBT8diUsL4tlnWBatPuhPDYIhm19eGBFA8Ctd7I3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj4bVc7p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj4bVc7p"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c68339cf0so1094360b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492490; x=1775097290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DClgII7euPARd4Aw2OGYINNJTYi6FW2MEXDTcwKQgeM=;
        b=nj4bVc7psqPja2ngWETFftwZZXez5LVI+dOVOjQMn/ujh5XS70uHICHQB4bXiWqe2+
         fugHUlDpQQKqkTw8g8n1TXzSfCUOMZuYf6A985e/yy6iQecs/9ME7sT3rXK9l64WK0wX
         zxrS+IcWzyrKaIKDTy4eIKYkEcRLRWvr5p3SaQMnyNl0kvkKLqlQ9PA5I4j/1dR1CcIF
         A2MXHbHjnimH5b4+C3/wmBmazCtvsPxeXphlhslBLmUrE1VkWmXfaeuxsa3zeBsPyovY
         MDPyXS57gTdAE6mPT2u3/naQpLvFt6PEHiLHovqRdriNdzpCJOPNBKjw4TS+S5DLV0Kc
         u+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492490; x=1775097290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DClgII7euPARd4Aw2OGYINNJTYi6FW2MEXDTcwKQgeM=;
        b=kFQVBmgGhB3+K4Noj+wljFRgKelMB20XURLzTfm9J0E3ID+G1a6KNKVtpc5Pb2HTW5
         y0NWXHziu8p4G0f17nIbftoE/pIvxb1gj0wKI/6x0/z8E4pg1wkoPD0HadFRs511eeSB
         n4QH7N7wma3wqZQamArYRnj+RFRD5Axo14KoG3AHXk5N4WnkgtXSVLk5Sgh8CnyYLeeb
         x6vFiVf0jbkQoFZkk1VkQEPQtnDzrY8aaofwCGfh/qwJ+8xVWnAp8w1KJ1iwjrSiwm+h
         JMO6PpdHhJPPfb3lDRnf1AKB0FzM7dD2kalgGtGHkiGUUXUBaFMXGfJKPZ1aPaK9lqMA
         vuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlZrufkGZ7u5qik6uWa/5/myt42vGQUzRn2JYhj1W1v0++pXfa0nH/fTc3qIUoDwSX3yGQxX83duE9ZNLYp4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pq/O+izwoRzRhhItGG1GqAvxEFmN9KPlMNVCVTXmu05h5Pi8
	LRNGyGI1jYDX67+EGlFnc5cTyilA+l8STxZIDwx5jDkHj35onWcsjs2F
X-Gm-Gg: ATEYQzzu8PBLsWnuoOfYT7qKkfS9kCR1dkBJMsGfoHUFK8dgVelq/J+VPPZ0bPCbk88
	dnnQNsgni6IMm/ZG+TNdaecHfFBPC6GV4ljRzu2EQhdBgl0M8qA270Oo8NmD44BCseH+7Lnul53
	WeeBgfmwty3peIGURaNB7ImusbH+VOiV663iSc5K/8uOfjIPVFXdUInTWQZjCqjiV8ZKD6di0qH
	DvsEkLOeY5NrfrKIXndqLJbzlS5/Wmh4Tgt72AKYKrCOjbz7sahzsG8YEmih+VI/MU4Zl8yJw56
	kP3UnF5+TvIFJoSCZu+4uaaclksDYR/zu/9E9P5Q+vGv/PmTLDOq0V+28lAXKYSIJpjeskzajaG
	Arpj6OUbCG1wG6Cl1oIO0v/W3TGKBG3p15kyrrYiveqH7FTJjr9oxtl5rKA7GMxiay5nGCIuWcb
	NltCQSEM4up2oFC3kXXHQSg38JfmuIIb9yJBRz69xWJnbi6bEkSeIYxsU=
X-Received: by 2002:a05:6a00:27a0:b0:829:7b30:92f4 with SMTP id d2e1a72fcca58-82c6da3394emr5062994b3a.16.1774492490469;
        Wed, 25 Mar 2026 19:34:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3d5e81sm998465b3a.51.2026.03.25.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:34:50 -0700 (PDT)
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
Subject: [PATCH] ARM: omap2: simplify allocation for omap_device
Date: Wed, 25 Mar 2026 19:34:32 -0700
Message-ID: <20260326023432.54127-1-rosenp@gmail.com>
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
 arch/arm/mach-omap2/omap_device.c | 21 ++++++---------------
 arch/arm/mach-omap2/omap_device.h |  2 +-
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 79db4c49ffc9..55f2a9d5f4df 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -309,17 +309,15 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	int i;
 	struct omap_hwmod **hwmods;
 
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
 
@@ -329,13 +327,6 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
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
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index aa8096ecb23c..9283c15c2403 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
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

