Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1F1A239A
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836603; cv=none; b=cfA5bnebvPCFwbVSwieEqia7/SBN/4j6eL2w0kKRVplcU1se8CfNIIfH7f2mJ2YsZLrtAyxOId+dRHxWjll1t/ZbKNAVptgH9eFKStJzUT44EqCIGfQmRbgAbFRCi9IqypoXVEDsBatC6R4odr/ljW6vAF3bmkE7YJG2RglRgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836603; c=relaxed/simple;
	bh=GNUv3gFnSwoRSjP9gzZWVkQwJU58x8lWUNsagYfsIUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sem+McGpd4fPeKryqQCtZemuMFyHVqc4yU6YWEpSixZfIqA0BIWMoy2CLTwtb4C5Fyuo85tv/8FDhl113aemUXSN1wrZskSuQOERzvgNqy9Re2++AuoPZL+07yKcN1w4/1ZTOeZa3GBr/ggh8CZHlnvXVOrWIlxa30jabnRBhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qc4NKb15; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qc4NKb15"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad563b69908so578285066b.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747836599; x=1748441399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZb8t0p/60BOZFK+73UBXY9hEJgsc04mR3HhJl60lrY=;
        b=Qc4NKb15LjCfrbExGVMMH7aWJVb7j/Z/+lfOKmHOYmP0GDF29KdkN+kuQ4eGOpUpYp
         YlHLgUR6HKWoIuChDki2kkmWijns5dj/P/EFdmH0WnzZZzrwmkcqx+20dMPkOvnBHDMO
         PqPAGzxHRn+39Xcr5ld4iVYaPWETMlQtyslHaMsQWXQ5L8dHgfSWxTc7b6Kn5yw/ufd6
         z2qOzahpSySnxfKB4b8Ds9cvun4+KYIxdX3S8+IOBrH7rU7g2dfg7niTBF+XDbCZpBSp
         1xvSaxB2Mfi2hy3P/rz6cRvBiSv+XTnnpn1u9lhX3SfJafVnYY9cz8j4Bzo0FIgs2IuG
         zSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836599; x=1748441399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZb8t0p/60BOZFK+73UBXY9hEJgsc04mR3HhJl60lrY=;
        b=hIJCkSWp8R5/ThTkVedEbuHyIr8p4d2wBW3ETDssuwnNCs4waw2wng1KaHOiJBrr5Y
         +r7Ar6JmMhEN/m5DLb2XQ5powkRxi8yR91Ab6Uy0YCNzQj24A7G7Rsg4vb/2CplaJ8zZ
         9X9NFjVEMYlW0BaYTyh5pIPG64+5ciuhxQ1Ch1RKWVL1mtz3RndSwZn3ZVS9GDLl/MBU
         44/yn1a4Tz2Sv8oaUtH+qgZYQ7OW2xwbg8APldcuhG3XfYIkv9uMUaA4kyCYEb6wPLS7
         Ix8YdP6gTE4Fz/9c4r4Ke29QbXnin0Z1cBbnXcKpOO5zusrTKm5nOAvaw09T73wXvJuF
         X6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh5dic6jyTYH5BR4ySYTEgdItN46I7YGMVpMKc/oFc+hexy+q1ojXD0MBLLFpCx/0SAk4vPQILMfqb6saKI5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZylgFG1I9vG0r+sN4eFCo/3uHyhnPTA9/47al0ohPEvYJ9cU+
	JoD9vSekzACVfSrElfYb6Lyc4a55P7oEbRIT3+ebhZ1ksUH4tscqzcyovt/+qb7lKBQ=
X-Gm-Gg: ASbGnctEnqqfpHDn3O580RFu59F5h1yzNGQBBHYM/grlmKMzo6mDY+fY/ItvG3dmPMg
	o4C0q8+230B967BGjN67xAs4sItU1ukz1/nsjzHm+x64yX201gcEAbpZC/YzXrlP9WTFK3luZVu
	OGeD3pK48GYbpOPK5vWiapKSv+8WC4kPAcvQMPTwDO3BqGvV6vQq9DiaHZfSr2irbc2XzVrJWEl
	Q+VG/UliX5y4yJCfMEl+696UMJPGQb85gAODYJzE3yBTva3mlD23X+cYxqckdWjdR5C3+MWD761
	33Z/Z17ua0iwQ1UtJN5OsdVVPVKPq83C/BtF+FwToSnmghTitX+2uPY9dZH85qWcIMqkaGwNIfe
	Suh5a
X-Google-Smtp-Source: AGHT+IEV9P83fNsYEF0MlXW3EZBsJyq8zW/+sCayFAQ2aHH/AfpUFdSzKl7+4r2gtOdoYzJbBhZX+g==
X-Received: by 2002:a17:907:7da2:b0:ad5:2656:ee58 with SMTP id a640c23a62f3a-ad536dcd6e9mr1744917766b.43.1747836599396;
        Wed, 21 May 2025 07:09:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm914552866b.69.2025.05.21.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:09:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 03/12] soc: renesas: r9a08g045-sysc: Add USB PWRRDY signal
Date: Wed, 21 May 2025 17:09:34 +0300
Message-ID: <20250521140943.3830195-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The USB PWRRDY is a SYSC signal that need to be controlled, in case of
RZ/G3S SoC, before/after the power to the USB PHYs is turned on/off. Add
the USB PWRRDY signal.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new and obtained from [1]

[1] https://lore.kernel.org/all/20241126092050.1825607-3-claudiu.beznea.uj@bp.renesas.com/

 drivers/soc/renesas/r9a08g045-sysc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/renesas/r9a08g045-sysc.c b/drivers/soc/renesas/r9a08g045-sysc.c
index d2c9e3b77f41..7e6b5edf9666 100644
--- a/drivers/soc/renesas/r9a08g045-sysc.c
+++ b/drivers/soc/renesas/r9a08g045-sysc.c
@@ -5,11 +5,21 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/init.h>
 
 #include "rz-sysc.h"
 
+static const struct rz_sysc_signal_init_data rzg3s_sysc_signals_init_data[] __initconst = {
+	{
+		.name = "usb-pwrrdy",
+		.offset = 0xd70,
+		.mask = BIT(0),
+		.refcnt_incr_val = 0
+	}
+};
+
 static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initconst = {
 	.family = "RZ/G3S",
 	.id = 0x85e0447,
@@ -33,4 +43,6 @@ static const struct regmap_config rzg3s_sysc_regmap __initconst = {
 const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
 	.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
 	.regmap_cfg = &rzg3s_sysc_regmap,
+	.signals_init_data = rzg3s_sysc_signals_init_data,
+	.num_signals = ARRAY_SIZE(rzg3s_sysc_signals_init_data),
 };
-- 
2.43.0

