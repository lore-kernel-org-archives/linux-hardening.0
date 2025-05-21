Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0E27054E
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836620; cv=none; b=QgQHqReW3S8liGhYrK9mMnFFPRyw4av96ghRdA/I+0RdNYJdVZv81YFBqvpTs4b2JLI4m8wxr44JUWR7G5Ue/RZWUvq1IDtfwtRU1RcWbAnKuAOsj4XtyjRBSg/VGCzb2WMnsnDbfFkjDyS++QISoMuRheOb6+LBSfrEP9ExOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836620; c=relaxed/simple;
	bh=EGFE9fF8CoyqCcQrGQ5RtJ1O3HstgRvlsNO0EcsOKKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kL+cf9PiuQZXQckPrqsRJUtfWZ1M3ThR4b4rn+Fb05l5DHOmppRDslph713W4ndf34hUYDkpc0IaHrpg/8oO0j1iWbAqxGRLHcVWRKR9AVWrmPNnRyvBsyc4/Ohv5X2Atj4SXFADQkTyEY4ds6ErsSquhDDNCPWABM5ddF5U/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=h1gOxFXk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="h1gOxFXk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60236e3d093so1377236a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747836617; x=1748441417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1CHusJ4ei6D6vHackJEhVkMXrFixKZ73PuOqrjq43c=;
        b=h1gOxFXkymt5ugbEYFFKHOVB7tTtFkFGsrSQC2FaVTZ5TarZVdDS9mYA7uwRe6q0ml
         VOrIW0FdUF3bFL/A+aX9B+roh1XYO6Xqzkjn5lHZxIg+lq8jPBi9eYnCH3ScPoSVOcsj
         5GV/hO/TKIIP8sgBbDVVpRTA7geFA2TlUK3KY3k1UAN9PVaffh24Kjrl5VzDm+5e6J9k
         w7GByWFqCCRym8WJeH//sb0Vd/UhNI6ZZr4nrfOz17+lNoeX4Xcp3YijT+IevLxr2Vzu
         71rbrRIhsEHBCiv4QAHvBh/NDtiSF5arkzWHgsb20isQ6qohrJTJqYNSZvA8qMjtbZbK
         iVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836617; x=1748441417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1CHusJ4ei6D6vHackJEhVkMXrFixKZ73PuOqrjq43c=;
        b=gSalsmk17rcvtvxwDw80t/AZXM0EjpCBBEjxSWhb3JlE25R11FmatLh83Vw4tKJi1P
         UeNa/tgusV2itWFSRmnbvXPSgUfUOQgDmNAcr+w//I4XC/nhuuI6urA4tk/2MjivXWJu
         bQ3F0y2siTCnrRC6iY+YSn1NDvcqQhtVyKY9t8L8nlr5FlDrJM3IE2by/xHHON3XLYwo
         CaM23zEszgMd4qr2uWP5W9dD7U+gEfCgRQorxPep00pPRGBnVBEHTRb+cDU7d1GQveln
         a0NQ19lp3iY/9xY/79/aEE9CyYz+HrXk5cp2CP38T3/9aUSm/cq2fRDj2pa9G+AkkTXw
         Vqeg==
X-Forwarded-Encrypted: i=1; AJvYcCU4sWrRFCWvHcsLuzzHR5d8rg9sqFgaHqY7ztPs+tux4HfQS3gG9w1yv5IouFx5PNsVnCeMKmjJ+TTm7X3Vn8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZzzTXzULrBhnW7aIzaEdM+oinyGSgDBN1ztNi7T9ULiSHCXE
	7NdMWbd0Ag7JMbtKVe3uLuMStLBnLu+GvmGU8BicNjUNfbcWSjieWggWNBgxMakKqUY=
X-Gm-Gg: ASbGncuMyjjZfy4aSCI8/zCi9ZqBwOshIaEX+fpMYl6xKwQM8x5FpJus5uJwN41DzLk
	MmXbRwzZjHgi7vFvwX9XXBM3aRsjFlgEwCva/hGLYtTOW3mRYIxz8ZioG3xti9PXGiqKW/dLSn+
	Exa28kfisof1THY98XJSX0Cl+bVVc4Ld5V+IKPlq+EZJBxfmbx7SyCnPWBSZ8rkZPjtXae8eabO
	DYprNcalr/WOVaGZiA6+GHqLDaqWSfBgo7Pjd3MxFdmB452hkZ+KBcF3iBaF1/CKMt9dp6G0gAq
	8SVsdGCtb/JZ80boJxUBvduwRCLDWYS/lnXGxpnXPH4PLbc3E1bsno76yg8x1WOzSh/okMTQO/S
	xAdew
X-Google-Smtp-Source: AGHT+IGvqJR7e/kOZrWWHQJQW+m9p5RsEiN0pjfvxiINSPfnR4snDax5MoMW4mDXwqItr/FNVvG8UQ==
X-Received: by 2002:a17:907:7d89:b0:ad2:5408:bf1a with SMTP id a640c23a62f3a-ad52d64216fmr1934817166b.61.1747836616979;
        Wed, 21 May 2025 07:10:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm914552866b.69.2025.05.21.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:10:16 -0700 (PDT)
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 06/12] phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()
Date: Wed, 21 May 2025 17:09:37 +0300
Message-ID: <20250521140943.3830195-7-claudiu.beznea.uj@bp.renesas.com>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If an error occurs after the reset_control_deassert(),
reset_control_assert() must be called, as already done in the remove
function.

Use devm_add_action_or_reset() to add the missing call and simplify the
.remove() function accordingly.

Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to initialize the bus")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: removed "struct reset_control *rstc = data;" from
 rcar_gen3_reset_assert()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- none; this patch is new; re-spinned the Christophe's work at
  https://lore.kernel.org/all/TYCPR01MB113329930BA5E2149C9BE2A1986672@TYCPR01MB11332.jpnprd01.prod.outlook.com/


 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 47beb94cd424..d61c171d454f 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -699,6 +699,11 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
 	return candidate;
 }
 
+static void rcar_gen3_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev = channel->dev;
@@ -717,6 +722,11 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 	if (ret)
 		goto rpm_put;
 
+	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert,
+				       channel->rstc);
+	if (ret)
+		goto rpm_put;
+
 	val = readl(channel->base + USB2_AHB_BUS_CTR);
 	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
 	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
@@ -860,7 +870,6 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
-	reset_control_assert(channel->rstc);
 	pm_runtime_disable(&pdev->dev);
 };
 
-- 
2.43.0

