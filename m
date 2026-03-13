Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6498295DBD
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361302; cv=none; b=aXpTSFF3l9i+4ptmgkv0JoUDOLUq3jyi/bfd34K1UKYGDy0An5Irz1N2dyjdT7xqmuHbXIuEErNSzhdWqeGlceleXfBOhVLOje/QOqOSTK43z+dxUfLLG7j6/ndPJjwSyd1jG2aYq5LVG+Y2Iogf8tgEtLd/sxDqVQfHtKfCKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361302; c=relaxed/simple;
	bh=1YMiY7/Zot15ra9DuC1CUpjFsA44TAxwB5BjF3e8+FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwPpJvxMUDcztj7rfODzN94cNdJEkjTi6jv3npi/TIDgjeKdV53XVzDnd2WplHdWWuupKCL3si2mfGMVlC8CGbqGtmJMK0Z05TE+r4lDztDb0Vkoe7yNJG7OxEVgHAwertsRWHBREGslKEEzB8q5bb4NQB+NMagmnX9H+/y35Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpDjyiOs; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpDjyiOs"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7987531082aso18159597b3.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773361299; x=1773966099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PeETB9eQltddP5mF2mJA8o9tnQJB7YnT8JvFDCE8DGE=;
        b=JpDjyiOsfK/apRe83gzVuB21pDPIfiTt/JP41PuJV1odsJv0jQuPsjZUr7PQa7hdCU
         qJJ1JK+Hsjjt6R54V9zmcb08moedlPSk/8Hbtm58+iGPg8WVxe9IF15b6sowI23hm/Fo
         xx5dbv4vbWP2va5ZTil1s1Jh7bXmgNlmoEn7Qm2QrI6bjHX1rE2c9twg4fDBFLJVGb1R
         WTDphYV8ja1+7M4G+5iv5Ofsb0Q08dRDUepVqT2d5VN6UGHnDpiCVjtdliumfhf48h0z
         aGzwObnN/+jWf6UEbyD8+dFvlqmjax+YK5Tp7P9zG4w1coNt1RcqWhCjUsabLQZgNXIN
         OGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361299; x=1773966099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeETB9eQltddP5mF2mJA8o9tnQJB7YnT8JvFDCE8DGE=;
        b=VEYj4P6TCJH+83b/LQqrK1LoOuyJgeZ4gtkYkCswVPgFnZFY+y0jpmDpPL8WaEWQFk
         8K9IeRrZG09QdJQA4nX7gRXFWi99SpV+yUhHHeymfwSwEA64EAo481TOPu1XBVO2Ommv
         PNk6lwGheWHm6AHhzJ9pWr7pQJ7+08ts4youNVXfndOn5csA5Ipn/zDCoSVrBwL/+9S4
         RNzlJFAFL90i5t3VEVW1WcXvh6BtRuR73EM7oAdlhybiMmfYaD8PyzFXan9fzUJ8TWmW
         EmO9iBswZ3eu4ZlbbsImxfO3QJECUzqN3Yd9ID5yFpnRq6OqQQhvuwuJia6ihGYFlStF
         4m0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXLTFQNYchr5VBcSrk6DK8RHYhQatJBQKC/DEvGpi7xFAETY1PdBFbpcIYf8/52Yo/Xsmo7lv8LkDDasXozW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8Bgb2DidYS60iNXEKDFBKtHwGBDad0Hf3yYw3XPNvVayzXhT
	hh2mxQWCTGMxd8hUfZrZprBUOy/zQg0fYddWxOQN4CRZ1AH+6zUPrKzA
X-Gm-Gg: ATEYQzy9xX5AKSCvkyxoa3tU9CpU1eq93L00hAD5aQ0azD7QUyNOSoCWWuz9IuQ3jmR
	f9q8LicHCcnR3/J09734JmhhMCwAc/vBrn85NgMnVJnEGyDVoO6KXlmyNwdZaegw+dHz/mYEMa4
	UUOBgsOECWQa3KTvqCGUMZBLI3FHLrOY1brK+OsfAmJzHv5oDIN2WpbI+a+mMFJ97EAC4TSWdvp
	+GdSCk4JR8xHhVf7CNFfFZvdFKRuLzLVn37KIy/9sxFPkpur0UmT0dybCbHQvWW8RZAadrXyMmG
	VzEZiRsziFbFfScOzFgYhPF5Ht3VXwAYXlFZ9io9mmPNNi+7Wlt295QctHCVxxD5yPXYXMRSHhJ
	zGCJ8vRHZM5yfiwkhSK0e+fMhs/wCeD04r16i8gr7JLtJUadwPsqkCxhkMAo48V+jB3yUqCbaas
	kpNyModyBwoPDaxvK5O7DgKAqotzg6/4Su+xKB1Ap2IIoiIYM+tD5aSoHAwBrU9rGi
X-Received: by 2002:a05:690c:c155:b0:799:182:17bd with SMTP id 00721157ae682-79a1c0e1676mr14239947b3.24.1773361298678;
        Thu, 12 Mar 2026 17:21:38 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm39089407b3.45.2026.03.12.17.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:21:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk: at91: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:21:19 -0700
Message-ID: <20260313002119.118962-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/at91/dt-compat.c | 15 ++++-----------
 drivers/clk/at91/pmc.h       |  2 +-
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 5d543e807843..5c88cfafa31f 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -548,7 +548,6 @@ of_at91_clk_pll_get_characteristics(struct device_node *np)
 	int num_output;
 	u32 num_cells;
 	struct clk_range input;
-	struct clk_range *output;
 	u8 *out = NULL;
 	u16 *icpll = NULL;
 	struct clk_pll_characteristics *characteristics;
@@ -568,13 +567,11 @@ of_at91_clk_pll_get_characteristics(struct device_node *np)
 		return NULL;
 	num_output /= num_cells;
 
-	characteristics = kzalloc_obj(*characteristics);
+	characteristics = kzalloc_flex(*characteristics, output, num_output);
 	if (!characteristics)
 		return NULL;
 
-	output = kzalloc_objs(*output, num_output);
-	if (!output)
-		goto out_free_characteristics;
+	characteristics->num_output = num_output;
 
 	if (num_cells > 2) {
 		out = kcalloc(num_output, sizeof(*out), GFP_KERNEL);
@@ -594,12 +591,12 @@ of_at91_clk_pll_get_characteristics(struct device_node *np)
 					       "atmel,pll-clk-output-ranges",
 					       offset, &tmp))
 			goto out_free_output;
-		output[i].min = tmp;
+		charecteristics->output[i].min = tmp;
 		if (of_property_read_u32_index(np,
 					       "atmel,pll-clk-output-ranges",
 					       offset + 1, &tmp))
 			goto out_free_output;
-		output[i].max = tmp;
+		charecteristics->output[i].max = tmp;
 
 		if (num_cells == 2)
 			continue;
@@ -621,8 +618,6 @@ of_at91_clk_pll_get_characteristics(struct device_node *np)
 	}
 
 	characteristics->input = input;
-	characteristics->num_output = num_output;
-	characteristics->output = output;
 	characteristics->out = out;
 	characteristics->icpll = icpll;
 	return characteristics;
@@ -630,8 +625,6 @@ of_at91_clk_pll_get_characteristics(struct device_node *np)
 out_free_output:
 	kfree(icpll);
 	kfree(out);
-	kfree(output);
-out_free_characteristics:
 	kfree(characteristics);
 	return NULL;
 }
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 543d7aee8d24..123050b4356d 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -75,12 +75,12 @@ extern const struct clk_pll_layout sama5d3_pll_layout;
 struct clk_pll_characteristics {
 	struct clk_range input;
 	int num_output;
-	const struct clk_range *output;
 	const struct clk_range *core_output;
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
 	u32 acr;
+	struct clk_range output[] __counted_by(num_output);
 };
 
 struct clk_programmable_layout {
-- 
2.53.0

