Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528A3D4129
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110738; cv=none; b=ng/NGzykGLQamnnGp2Gsozud42NglmrOIfzPU3ZUV0owxBoSO88kiKGg6Rd4F7Ofc5hfZIjpet9aDN4GtsDYSN6Cve9VXHf9FZ4xEmN+3FG0e5HxCyYptOU6K1T0+DBUoYu4xOh5DfmBFWthhqWt/h6ieJlVdumo5dTvZmaTWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110738; c=relaxed/simple;
	bh=2OtwiR0aUl1XQdXsTMhDBXZj/AxoFLijZjRd9Wnd81k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWy+5XUaHUFsksupIaNMpV1PbzXdKi2T8D6EunUgAN7q6QDPG7IB1cmR2FmS04+Ft+Q+BuhOiqv/GZft+SqMUjC8D4O8lgpR7Ai401t6Y+1XdONhGyyN8BVPxCxZQ3GAMDNu+BFqQOdkWhkZqEhu3o+qlGIYASp5rT2Hx7VUWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oc9SftNn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc9SftNn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b458ca2296so1490435ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778110736; x=1778715536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okd3JtsJS3ksT2GaRH8nnVfDydk7G//ESOzr5O9Y1xA=;
        b=oc9SftNnNlefwgQh1Rx3kyrFn1tBuKmMYpHwyqbKxCim7y29yMjS1D5hxpYFP9r4kE
         whwf0d0hwiba5MSJUpzj7ZcHTHR/SfyKFYuc81JVGZF6eAAGt7Yf8ycLblnU9sfyfH/U
         pwjPOegkbYlUfI//G9oq/rUzIcXwFSUknzszSxpTMNLgD+X2fmDA+QfHXXr2htqESTlD
         lHxb61ku4rTQFH1BQ1JW/Q1/9rUZCoTwrbmzJjaBxkUYZkdLAv+6y9crka8H//22Zlcd
         ENYASk5pjZASVOgbte/76R7SNFd3Xf2P6xExw6BKJnNRgWJ8+5ipwA8PiyCMsLq+fuPA
         X2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110736; x=1778715536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okd3JtsJS3ksT2GaRH8nnVfDydk7G//ESOzr5O9Y1xA=;
        b=qfHQm98wFmL0d6LimyZxC5Yp2NRCmAfc0OYz5DO6mIEG3HNHcJ0LYd3tfPqrLALAqg
         8SQM1Q+9TAW0FjYJMqP02czEN8avat4n1c1xnwjTClHtgMmGO2TMNhK4EE9qGpfqb+0C
         YaUn6Lyg7FbBGsWVODrrMTZlN4KtHoIkxzRW3JjcvT8nrdFTaFM/c0wbTWRn+UHFf9aK
         qJySj/YvmfWZpa8/PiLtf/epaPrujTT26IHEaRY81/n54JoE7zUojRHaHIOI2uD9T/Un
         rY6XN9N6/xZo76SMlRhaaabkRfP20AHmyJ9wjWgEPM7FLIKFiIdIQqJwSL3oL+jAWe9Z
         WdWg==
X-Forwarded-Encrypted: i=1; AFNElJ/Qn0u5Ij5kKaopKB/3ALZZYo4Q7shKS9szEYohREF3iQYiqozmxPI3Zb8PfsOAGXnkaXsG2VAsF0xsuaPPqoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJOHPGRzuUWIFKCZE3vWPXMsAMKsZPexuNIRMAhMqAtF7dmap
	miiRejJFGX3zoCqRnqUkZPRk3BMzXG6krb53c8V5Bm63r2cQ2GlaQnsp
X-Gm-Gg: AeBDievaqK1zChkkGYfzjKGoYe35lH32O24kSCkV/8jOOCw0PSbPomPD3hP7lHdg4Ye
	DvHGMpUs8FfTDvtBXQRycF9EDN9cV8o0p69LWrkcoSVuAbHbF3u2ni+R6T76Z+oX066KUm15aWE
	8QBpOy1+4+8XiXV61Mc+p5Xlvi1XjPlPB3ytXGJxKBfgpZt0kL0FuTLIJ46cRlFEnxRX5MZpDID
	4MszLA32gEcIXRgmFkz+JjWYVNQBfxYxJtjj9FQnBLU8XVV21swUjBtkLjZIJWpO+GNiPO1B8xq
	p795zTnUYeSGx2sFdq8W8fK3EYecq3260WKhMT2O3nRhyNe54Bn/u6oVbtkMkFyE4zB/cETzMcW
	ipZM6RWE/HFC1iuC88HkMI4l47v01CFZ41Yc8uB7zt7oZw3PqdQM1SaGSjZtJRsiFkJojJFSTRl
	bumU18DnK/TxkOdb2cjovQtC1ILRGYOmUl4B89gNwN09WRdEYcPwGrT3R1jQLNEUiix+EenXWN6
	55chcICji18a/fMtM5S1yQoDgt5aaGnDQXyd9AcUZxDgA==
X-Received: by 2002:a17:903:178b:b0:2ba:881f:6192 with SMTP id d9443c01a7336-2ba881f63c2mr46188485ad.22.1778110735541;
        Wed, 06 May 2026 16:38:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaaef08bsm3471805ad.28.2026.05.06.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:38:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SOC CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 3/3] clk: samsung: pll: use kzalloc_flex
Date: Wed,  6 May 2026 16:38:33 -0700
Message-ID: <20260506233833.178357-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506233833.178357-1-rosenp@gmail.com>
References: <20260506233833.178357-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member to combine
allocations and remove a kfree.

Use __counted_by for extra runtime analysis.

Since rate_table is now a flexible array member, NULL checks don't work.
So use the counting variable to check allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/samsung/clk-pll.c | 56 ++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index fdb84bcec912..e74552846ba3 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -28,7 +28,7 @@ struct samsung_clk_pll {
 	unsigned short		lock_offs;
 	enum samsung_pll_type	type;
 	unsigned int		rate_count;
-	const struct samsung_pll_rate_table *rate_table;
+	struct samsung_pll_rate_table rate_table[] __counted_by(rate_count);
 };
 
 #define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
@@ -1593,35 +1593,32 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 {
 	struct samsung_clk_pll *pll;
 	struct clk_init_data init;
-	int ret, len;
+	unsigned int len = 0;
+	int ret;
 
-	pll = kzalloc_obj(*pll);
+	if (pll_clk->rate_table) {
+		/* find count of rates in rate_table */
+		while (pll_clk->rate_table[len].rate != 0)
+			len++;
+	}
+
+	pll = kzalloc_flex(*pll, rate_table, len);
 	if (!pll) {
 		pr_err("%s: could not allocate pll clk %s\n",
 			__func__, pll_clk->name);
 		return;
 	}
 
+	pll->rate_count = len;
+	if (len)
+		memcpy(pll->rate_table, pll_clk->rate_table,
+		       len * sizeof(*pll->rate_table));
+
 	init.name = pll_clk->name;
 	init.flags = pll_clk->flags;
 	init.parent_names = &pll_clk->parent_name;
 	init.num_parents = 1;
 
-	if (pll_clk->rate_table) {
-		/* find count of rates in rate_table */
-		for (len = 0; pll_clk->rate_table[len].rate != 0; )
-			len++;
-
-		pll->rate_count = len;
-		pll->rate_table = kmemdup_array(pll_clk->rate_table,
-						pll->rate_count,
-						sizeof(*pll->rate_table),
-						GFP_KERNEL);
-		WARN(!pll->rate_table,
-			"%s: could not allocate rate table for %s\n",
-			__func__, pll_clk->name);
-	}
-
 	switch (pll_clk->type) {
 	case pll_2126:
 		init.ops = &samsung_pll2126_clk_ops;
@@ -1640,7 +1637,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_a9fracm:
 		pll->enable_offs = PLL35XX_ENABLE_SHIFT;
 		pll->lock_offs = PLL35XX_LOCK_STAT_SHIFT;
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll35xx_clk_min_ops;
 		else
 			init.ops = &samsung_pll35xx_clk_ops;
@@ -1659,7 +1656,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_0732x:
 		pll->enable_offs = PLL0822X_ENABLE_SHIFT;
 		pll->lock_offs = PLL0822X_LOCK_STAT_SHIFT;
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll0822x_clk_min_ops;
 		else
 			init.ops = &samsung_pll0822x_clk_ops;
@@ -1669,7 +1666,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		break;
 	case pll_4502:
 	case pll_4508:
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll45xx_clk_min_ops;
 		else
 			init.ops = &samsung_pll45xx_clk_ops;
@@ -1679,7 +1676,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_2650:
 		pll->enable_offs = PLL36XX_ENABLE_SHIFT;
 		pll->lock_offs = PLL36XX_LOCK_STAT_SHIFT;
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll36xx_clk_min_ops;
 		else
 			init.ops = &samsung_pll36xx_clk_ops;
@@ -1687,7 +1684,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_0831x:
 		pll->enable_offs = PLL0831X_ENABLE_SHIFT;
 		pll->lock_offs = PLL0831X_LOCK_STAT_SHIFT;
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll0831x_clk_min_ops;
 		else
 			init.ops = &samsung_pll0831x_clk_ops;
@@ -1703,7 +1700,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_4650:
 	case pll_4650c:
 	case pll_1460x:
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll46xx_clk_min_ops;
 		else
 			init.ops = &samsung_pll46xx_clk_ops;
@@ -1712,19 +1709,19 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		init.ops = &samsung_pll2550x_clk_ops;
 		break;
 	case pll_2550xx:
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll2550xx_clk_min_ops;
 		else
 			init.ops = &samsung_pll2550xx_clk_ops;
 		break;
 	case pll_2650x:
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll2650x_clk_min_ops;
 		else
 			init.ops = &samsung_pll2650x_clk_ops;
 		break;
 	case pll_2650xx:
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll2650xx_clk_min_ops;
 		else
 			init.ops = &samsung_pll2650xx_clk_ops;
@@ -1734,7 +1731,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		init.ops = &samsung_pll531x_clk_ops;
 		break;
 	case pll_1031x:
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_pll1031x_clk_min_ops;
 		else
 			init.ops = &samsung_pll1031x_clk_ops;
@@ -1742,7 +1739,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_a9fraco:
 		pll->enable_offs = PLLA9FRACO_ENABLE_SHIFT;
 		pll->lock_offs = PLLA9FRACO_LOCK_STAT_SHIFT;
-		if (!pll->rate_table)
+		if (!pll->rate_count)
 			init.ops = &samsung_a9fraco_clk_min_ops;
 		else
 			init.ops = &samsung_a9fraco_clk_ops;
@@ -1761,7 +1758,6 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	if (ret) {
 		pr_err("%s: failed to register pll clock %s : %d\n",
 			__func__, pll_clk->name, ret);
-		kfree(pll->rate_table);
 		kfree(pll);
 		return;
 	}
-- 
2.54.0

