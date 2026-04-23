Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A836EAB0
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957787; cv=none; b=abhWpaMdZ+OCU89pHQThIVg9cES4VcoWxGN+5CFVmx1OC0Se+Huf2EsJdSA1U8IQYXxB2gtks5hFOl0nHuNd54eh+Xbu5i7Gu1wQZO0yz51HXFvbjDswH2Ps5Kt04PXFEfyMPkjoZPhHL9dGw5vj0+HbgJvETH5DDi2iZ6P9Av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957787; c=relaxed/simple;
	bh=6Fhzjxw+vi8XP19sFgBxNUlkscVh4nTSp5CfK4gr45o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMraNGdqJyNEYKbHgMHusOu1GTAPthuQ7ihIz8zQpTykGCPO7cPIzkGeMQS3M6maff3GPq1xlQERQ3X23Pc/+1+6cbl5t9pIpp9izuK3qeR+vpGe0XmMx8rBXosj5Fn3ZsKeqdjFicr/DV0XZETeHXkofIsKYZY3PvRpNiRRNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZX7+hid; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZX7+hid"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso48861755e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957781; x=1777562581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN4V9UR7DRre5LEE2+ZTpG14TXvnUwqmjv4/QNq2Ugs=;
        b=mZX7+hidc61FA6sH/uyYWJldAoksCQcQsVAhILJPId2UQIio9Ged0bLOmGtAA5UflZ
         AQC+l1Fkvp4MziSQgyZbOX2Fs06xSkOqnziv5hTUiGR2oDD7QCF2H3Ht6NG60mDdwDtt
         H/vE/n98RVt96vVl106DByEk3DNimyuz5WZxVXSrfZ+hQ+wL4yHnZwW5kr+QOy9hvFHB
         40sYhLjK7WGmSXkA9CbK9PlyirO8jAjMUZN49Wk2U1XsLc9Kl8EMs8K3znv8uxrviQUK
         6uLwsd41GoL+fQvOUmS8r5oZ+2eX6KvMIZWOgfiLUnau4OXWjLqSm6kreh5tXBT9fHbl
         PlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957781; x=1777562581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EN4V9UR7DRre5LEE2+ZTpG14TXvnUwqmjv4/QNq2Ugs=;
        b=f6G6zy9d4boKrhA6JDkrFu6H0/PFIub6FMdxizl0vSEUf0EiNnRLEJrplXQ1KHrr5i
         IU7lDeuOcx2OR6p8XWfxPavk/QDxu9hYWnu+W2yoLHxBdMjBdNP4XypJ3XTCEdp/VpSy
         1g/mrsVxl5jmE2TmnM11ZhIQRWRTOjuWUoBmYaF6tctFZ90nXC9kOMswcFeDVIvNeQgo
         uotOLh7vTKcCpyO70WlQtOYfMtzR3Qs/pId1leBM+ls09pxU/b41QwMrg5pjwxObcMfP
         OZyGa2La+tEfU2WOyWgpRdVPhBTFyvYRQg3ThrqesPsjZIVsfpkOwohEQNi6IL0ZTTGN
         WiLw==
X-Forwarded-Encrypted: i=1; AFNElJ8Kki9bs+aNsNun2j4v6ToBW+9dlYlJAD8dOIp2TVbkPeDUn0QTcNMl65niTD3MBvQeZ0QIyGAQdVZ+rIgDoFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwVjoXdHuc0RzJJoZolw85PpCRpqMhLS14gbyLugIEDopEjw1
	S8/DMZmcsVkPSOQ2L3vm14ihctENpNkJlg5yOqz3h14cMIYi35PKgtzRroleil8Fdow=
X-Gm-Gg: AeBDiesb1/Jg0xYgeMQPq7fTN4qR8NTMoAX0MNtwMhLcAAQtk+J627+60kYkGyg9cPw
	yhT14olCd3RjRpXAyG/j1ZIYR9rLRcY9pAK716bQBUhEmloZQv88+nm0WilceOOClBWCZUYHnQN
	+kONPhoU3mqBnbErhr8pBguvlLdHcwkqrkFz3gQtNfcFGUv6kDkuNI0GBwJcr+vQaE5/Uw73bED
	zKRtQxAc2AfzevkCAwWC02Mz/z4B4QPptrUPLC63P3pGhUvxeFmr+Rj8jZZsVd5K01nT5DJVWT3
	bEZv9EVf2FaOsA8yrcVV5mYjaH1mG83m3V+mq/FlKPieGir7+AcxqXmgN/LfAXKHOi8D5px/yin
	yu5Y/Xksfooy5AYUulnuCTwTIm5RH4UOLrCvyIUOL1yHeKxam3xvwQmMHldmGAQUwTQ8oAywAx9
	Us4kyuv7YGA4HRNo7ZQECwpLF3M9vSxmM4n9Qp0TToHPlIlPKLNDx+kPaOqW0bLKEVTYKvWxtUS
	QFWoJjDRsOUktpkHA==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488fb7786e4mr293834645e9.19.1776957781446;
        Thu, 23 Apr 2026 08:23:01 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:01 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:52 +0000
Subject: [PATCH v4 04/11] firmware: samsung: acpm: Drop redundant _ops
 suffix in acpm_ops members
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-4-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=4435;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=6Fhzjxw+vi8XP19sFgBxNUlkscVh4nTSp5CfK4gr45o=;
 b=m4fvvg7wwQHeVb0yPnYIqHEWlawnheJct73ayBmrt0vkfwIxMaAcSV6BGF7raasQPHx7k6W2Y
 gg/2Y1LaGpgDZ1YNuIQjhH8k3GmTU4AO/Uu4HrbMnBnxExDYFknXje1
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Rename the `dvfs_ops` and `pmic_ops` members of `struct acpm_ops` to
`dvfs` and `pmic` respectively.

Since these members are housed within the `acpm_ops` structure and
utilize the `acpm_*_ops` types, the `_ops` suffix on the variable names
creates unnecessary redundancy (e.g., `handle.ops.dvfs_ops`).

This cleanup removes the stuttering, leading to cleaner consumer code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk-acpm.c                        | 8 ++++----
 drivers/firmware/samsung/exynos-acpm.c                | 4 ++--
 drivers/mfd/sec-acpm.c                                | 6 +++---
 include/linux/firmware/samsung/exynos-acpm-protocol.h | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
index d8944160793a..93667777094c 100644
--- a/drivers/clk/samsung/clk-acpm.c
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -68,8 +68,8 @@ static unsigned long acpm_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct acpm_clk *clk = to_acpm_clk(hw);
 
-	return clk->handle->ops.dvfs_ops.get_rate(clk->handle,
-					clk->mbox_chan_id, clk->id);
+	return clk->handle->ops.dvfs.get_rate(clk->handle, clk->mbox_chan_id,
+					      clk->id);
 }
 
 static int acpm_clk_determine_rate(struct clk_hw *hw,
@@ -89,8 +89,8 @@ static int acpm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct acpm_clk *clk = to_acpm_clk(hw);
 
-	return clk->handle->ops.dvfs_ops.set_rate(clk->handle,
-					clk->mbox_chan_id, clk->id, rate);
+	return clk->handle->ops.dvfs.set_rate(clk->handle, clk->mbox_chan_id,
+					      clk->id, rate);
 }
 
 static const struct clk_ops acpm_clk_ops = {
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e5c85d769d0a..a2cd54ee4589 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -627,8 +627,8 @@ static int acpm_channels_init(struct acpm_info *acpm)
  */
 static void acpm_setup_ops(struct acpm_info *acpm)
 {
-	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs_ops;
-	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic_ops;
+	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs;
+	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic;
 
 	dvfs_ops->set_rate = acpm_dvfs_set_rate;
 	dvfs_ops->get_rate = acpm_dvfs_get_rate;
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index 0e23b9d9f7ee..9e15b260b8df 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -391,7 +391,7 @@ static int sec_pmic_acpm_bus_write(void *context, const void *data,
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
 	size_t val_count = count - BITS_TO_BYTES(ACPM_ADDR_BITS);
 	const u8 *d = data;
 	const u8 *vals = &d[BITS_TO_BYTES(ACPM_ADDR_BITS)];
@@ -411,7 +411,7 @@ static int sec_pmic_acpm_bus_read(void *context, const void *reg_buf, size_t reg
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
 	const u8 *r = reg_buf;
 	u8 reg;
 
@@ -430,7 +430,7 @@ static int sec_pmic_acpm_bus_reg_update_bits(void *context, unsigned int reg, un
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
 	struct acpm_handle *acpm = ctx->shared->acpm;
-	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
+	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic;
 
 	return pmic_ops->update_reg(acpm, ctx->shared->acpm_chan_id, ctx->type, reg & 0xff,
 				    ctx->shared->speedy_channel, val, mask);
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index d4db2796a6fb..b206efa62be6 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -36,8 +36,8 @@ struct acpm_pmic_ops {
 };
 
 struct acpm_ops {
-	struct acpm_dvfs_ops dvfs_ops;
-	struct acpm_pmic_ops pmic_ops;
+	struct acpm_dvfs_ops dvfs;
+	struct acpm_pmic_ops pmic;
 };
 
 /**

-- 
2.54.0.545.g6539524ca2-goog

