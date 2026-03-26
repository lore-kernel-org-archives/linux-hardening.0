Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062732B989
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774499018; cv=none; b=ZHlpXTYOjoN2OCPXIYF7hF4xQZqJxAD7pe0K9YzQnZo6zlrCmeSSmRKNRZBcpjofJPAiC1mX0S1A3ztdwd72rL8A+Jvk+C8vm76BqhPEnEs9tmHPCsTCTyJLYFxqynGhlA/hpsKmxDxNCaRQbs5X+aUAmckgLRikii5za1taA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774499018; c=relaxed/simple;
	bh=9aXpIYHxEZve/zODLL3ErK9l7SJiyftQgW265r3QNo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCexUu2XgsbXj+RYOkvGcZ38J0WiTlU7GEHJvEH/lhM2LoqZVX3Y9h02BEd0D61RPXuglZhdQ4FyVwYpnD/hKu4+OKz0n95pOkKIKHlqO+1oYa6ccTmd/JX82f4rLPOTSzitwAXDlf/hMGekJz4ZERHsQIR8JzA7EK8aBODdG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK4jyelZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK4jyelZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b04e6a989eso3055545ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774499015; x=1775103815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uePC4t9zYdAqfWmLVP6FLg/cJ2NqG/wiW8h1ArBlvSo=;
        b=UK4jyelZdP0Eb6vUdPuGFatpW/rxaJ8Ao76PGrQE8yY7h2qxQJriM3JZ02O7CemOCl
         5QF5pCCy9jPUaM0JNt4Vj1+F74SSu/vYJDmFUXaIszEbmdlWQgWm6A/mJexUqXtBwbGA
         kHZPTgsp+8jqnLQ+sqJDU3L3lsnqsgbgN24SHzRnl+5ySGbO789qdSZyYKM9e0Z9LJqn
         QhNyu90hsKcTjzeqxmPnZUNq2gI4I9TIuqqPHQjiIrky7LWPH5912B9WhOeUrxA6S9Dd
         2BeT5ehUICDfpbTLqpB0R9oKvWfafJ6O2QzOQ6zGUycAi+52AyGmrEndG+N6Ys3ls0bc
         ZvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774499015; x=1775103815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uePC4t9zYdAqfWmLVP6FLg/cJ2NqG/wiW8h1ArBlvSo=;
        b=R6im0wWhS9o0tL4taPg5MML6T3nD0pQWcYp0y6poJRIe9NgxPi+EA3ZJ8Pdz0t5ZQr
         tZYDmT2oIBk5Hnm9KDMit9KpiZgy7jO/XuU8pkpZE5XhkzDOu5CiCTWQt0Pez7rCS3vZ
         bC9I4Xi8FTB4W5w9V/A7aNwfSBqWvKQFkvy74YdC8US4h6MK9E2+24hMCidh+BKGPovz
         q95lD5BdDSX9n00YYhF2rEL21qr8FrakoAkJ65eXZAiWgvpDtvvfeEQPaHBRbuY8Mi+3
         vnmRw+h/xCEgn2v8d9DOcM2WzAl79o+KWCHVOZS28d7Xce/hRDUg5DW+5I24kuLz9B+g
         X+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWje3A4avxdbQJajImj66w4ghRTHP5OTFVjdCA2fA4PIyIIAKvTV4n+KgKvxOvxWezAya+mk7PknSWReckoFQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuLIvkZoyjtnzWkI9zMzxolSBCh6+kFiKmcbXaXJh0A/+FQ0i
	d5cV8NzjE8lHqV7oFY7vbP0isOK95POPhBU1js446/NLikJ0WMkeB7q0
X-Gm-Gg: ATEYQzzHivJcs4KehVpiA66gDa2N4tXbboBefdvDol2LexYh4ZmV3dFSQKYe2XC/o4K
	e/lgkWBMOnOM35BvckpuGin+A6l1gAwJZY/LR+smX0/6hXejk9FbAyuonECrH1Vb9Z7nCsF0LII
	Oa/n64JOEZN3gLf/gqbtoOB5IU6H3AGyVQtNsd4hue7NyrpjVm7I5s2/8igObxB1MN/R9SJ6KKS
	sDA/KOpbSWlXZcWyCRC0x00XNOoMP7b5oy9KMnqAEvO3yZfNI+zeLNoFoG2XDNpb6aFaDCRDjGg
	p7HvpKqROqcp9A6jzKSJN22n53genASwKdJlR6I7e7SpOOS6RCluTndy3YK2yvGEXDWBWNJXWzh
	ZVjC+qHfM0t9f9mPCEpEVGz1KyLvT+LEwiD7XwxQVhD4eYxB8WNWbpwHIqshAPvJUIwNDx9/pO4
	BaG0BuuXyWyD+y6OlZRuK+Kf0sY37upcEUF+/XYv91sNa8qhJgX3oZR3Q=
X-Received: by 2002:a17:903:3b84:b0:2ad:da28:98d with SMTP id d9443c01a7336-2b0b0aa685fmr63377505ad.37.1774499015189;
        Wed, 25 Mar 2026 21:23:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc883c0asm15566685ad.45.2026.03.25.21.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:23:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TOSHIBA VISCONTI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk: visconti: pll: use kzalloc_flex
Date: Wed, 25 Mar 2026 21:23:17 -0700
Message-ID: <20260326042317.122536-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member and kzalloc_flex.

Add __counted_by for extra runtime analysis. Assign after allocation as
required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/visconti/pll.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 6fd02c4b641e..ca29d12f9316 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -21,9 +21,9 @@ struct visconti_pll {
 	void __iomem	*pll_base;
 	spinlock_t	*lock;
 	unsigned long flags;
-	const struct visconti_pll_rate_table *rate_table;
 	size_t rate_count;
 	struct visconti_pll_provider *ctx;
+	struct visconti_pll_rate_table rate_table[] __counted_by(rate_count);
 };

 #define PLL_CONF_REG		0x0000
@@ -255,10 +255,6 @@ static struct clk_hw *visconti_register_pll(struct visconti_pll_provider *ctx,
 	size_t len;
 	int ret;

-	pll = kzalloc_obj(*pll);
-	if (!pll)
-		return ERR_PTR(-ENOMEM);
-
 	init.name = name;
 	init.flags = CLK_IGNORE_UNUSED;
 	init.parent_names = &parent_name;
@@ -266,11 +262,13 @@ static struct clk_hw *visconti_register_pll(struct visconti_pll_provider *ctx,

 	for (len = 0; rate_table[len].rate != 0; )
 		len++;
+
+	pll = kzalloc_flex(*pll, rate_table, len);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
 	pll->rate_count = len;
-	pll->rate_table = kmemdup_array(rate_table,
-					pll->rate_count, sizeof(*pll->rate_table),
-					GFP_KERNEL);
-	WARN(!pll->rate_table, "%s: could not allocate rate table for %s\n", __func__, name);
+	memcpy(pll->rate_table, rate_table, len * sizeof(*pll->rate_table));

 	init.ops = &visconti_pll_ops;
 	pll->hw.init = &init;
@@ -282,7 +280,6 @@ static struct clk_hw *visconti_register_pll(struct visconti_pll_provider *ctx,
 	ret = clk_hw_register(NULL, &pll->hw);
 	if (ret) {
 		pr_err("failed to register pll clock %s : %d\n", name, ret);
-		kfree(pll->rate_table);
 		kfree(pll);
 		pll_hw_clk = ERR_PTR(ret);
 	}
--
2.53.0

