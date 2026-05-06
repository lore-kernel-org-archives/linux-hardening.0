Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C593D34BA
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110734; cv=none; b=L1iF6JPhlKOBcbVbB3r+9PHrFyBVKUySZ8x+ltHR9kQdkNnuEuWVfhTftrsq+kuLoCLzxUs4gINODfMZFJLRjTaOId7TxYrMWgO/h5b+7A/kHormx+5PLHcsC+5mPsqKMxjk1BqaZ1SSj38bhvelwtDEiw1D8U7HNLMoZ1vz8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110734; c=relaxed/simple;
	bh=YY+R1qr5oJy3WtrJhQmeK5L9NeY3a4lm2XE9sFQEb6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6Zu27H2L3pzkcEZcBI4G0NaGMfwUD1V5HUrfY/+59HePJiGxEZO8ILMdiR9YR1cdHkXzypnCiNmurs3ElHKyuHnZChELqPIDNWsqm6PaeN7E3plTcseDtGLUqQJLO39WcnUz0dBWpPrt3r8Izt5s+J7EgVCxswDLV8OZHUQ3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qktz3qj4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qktz3qj4"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so68913a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778110732; x=1778715532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyuSYjZx1jLqRtBEtVQBj/M4Q/f4SPIG8RJjNTkgcSM=;
        b=Qktz3qj4FJhhAqld0ILcU9KwStIZav2c18ycDcP5aUNNmxrNDvyCPaHi2iKnfdCg3D
         7Y3b0wzasLHCDcjUpBAb5bfsFnabSeXIyhJE0ptpVJeHU+1NzouPJoDOp4dEajUvh1AO
         yBj5iIsezgcur5JPxPkenMkdnTjJgujPfIz3YL/MYASePdiHwmXKRNVTRX6r/Gj4IO4I
         cn/VCrBsrFYxo0wAXfiv5ieaVAEGotzWjnZu2xdl0Z5LmRbcs9QZs6MYTe+nycNZ1fiA
         f+xZCkfX3d3sOywiI5G6GzxL+jkEAm9yZLw8udl5tkOuBeAZDEOKStpJp13Q9Lv6aQad
         L27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110732; x=1778715532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyuSYjZx1jLqRtBEtVQBj/M4Q/f4SPIG8RJjNTkgcSM=;
        b=cTbUCT0G8hVmrokdC2xMNW/tJmZnT2KOofZJAV3OLmUdNiE6cn+vSx7BhdustI+dpi
         epbfat44eXdeIIGJhay0P3Bm34O8cbLrAtYBdNcIVmYTgIZXpHnYf2qLdJ8MQl89VBLE
         FzKZxeRPt43h5jPJkWFn7lkqIruYjA+/IJKdbrsnhYR7ZYZwxr/o/LYNYJtNFHXiP9Mn
         KCQcoly1idHF2sA/svwBEYpphe6MuXmUoaIdZN1/zyto2tYLjtROUwUgELMsTrxNG37D
         5Ks+Ze7HCVAV0BnFeOq831mq9LYWUw5+vIgJL67yQ1vWBNDFEfiei4k2O43GnK0av6U6
         dG4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DjupKobEGToE9VWMX8G81Zo/VTuurahHabGWH4XKtQ520slDAf/A3g7b3afe1nw1MWmBMcWqOSi5jbuRAq4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YymAvZuowqyOttAkpy0nTHEUFDUuRGhgycU6+Hjt7PcUsFLWJoR
	8lKdz5VLB+3mAPBZ4g1zdQjg+qpBnvEmFG6PZj54Q5flivQ7btmCQ6MT
X-Gm-Gg: AeBDievJOxiFMSobrcN3GBKtTGEp4os+VvB5vAEHx5uQsBdUjAfLFh0HXDAWdZO+CkZ
	qKBbXDAV0juKMLEDe2OYeWNBkbtFVfj9lMbZsycbDmHW02xqugx+Ec9ynnmvuIVH3MZyBqfAr8x
	h+WnwH29UccvSYEJzXDTHhn6zt+qcYFs3X+DOzZdLNu35gCT7CtW4U6baG11tIlJGKrQbvL1O2t
	DqPKZ+xdw3dP0pSVg0qEvV/IkQsgZCOhBKZmKP/1DLElwEnvCv6lFZh+rbOaGhGPaDncRVynLlr
	FH2ksgGfN7ljB1HzLWbhaaHHW1kT1hQbVGy64NYKIYJOxyt02KEQSeaOsWzJmFQEqmezq/ER4l3
	stBCFql/rvH624pc6xHgZgILD8ToU1rxXF6asl0ODSMnvOlwWRfHJNt1aeoCb4lpiiiy/siyMwt
	GNhwsk3BrSKpj42uf4UQmZFJaF3IMhIX3NSprQU4nLXxv44nqiWdlc5X24vNq7TW/noa9Tiygz4
	Ys2YXyvYWfaRD2DZQ8Onf06GIMjV+X2PHxenaLll9hVeA==
X-Received: by 2002:a17:903:2b04:b0:2b4:6080:d4d0 with SMTP id d9443c01a7336-2ba798c2f47mr60722265ad.22.1778110732541;
        Wed, 06 May 2026 16:38:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaaef08bsm3471805ad.28.2026.05.06.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:38:52 -0700 (PDT)
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
Subject: [PATCHv2 1/3] clk: samsung: use kzalloc_flex
Date: Wed,  6 May 2026 16:38:31 -0700
Message-ID: <20260506233833.178357-2-rosenp@gmail.com>
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

Simplify allocation by using kzalloc_flex with a flexible array member
to combine allocations. samsung_clk_alloc_reg_dump is no longer needed
for this struct but is needed elsewhere.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after kzalloc_flex which does the same with GCC 15 and above.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/samsung/clk.c | 11 ++++++-----
 drivers/clk/samsung/clk.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91e5cdbc79d7..2895c77534ae 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -430,21 +430,22 @@ void samsung_clk_extended_sleep_init(void __iomem *reg_base,
 			unsigned long nr_rsuspend)
 {
 	struct samsung_clock_reg_cache *reg_cache;
+	int i;
 
-	reg_cache = kzalloc_obj(struct samsung_clock_reg_cache);
+	reg_cache = kzalloc_flex(*reg_cache, rdump, nr_rdump);
 	if (!reg_cache)
 		panic("could not allocate register reg_cache.\n");
-	reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);
 
-	if (!reg_cache->rdump)
-		panic("could not allocate register dump storage.\n");
+	reg_cache->rd_num = nr_rdump;
+
+	for (i = 0; i < nr_rdump; ++i)
+		reg_cache->rdump[i].offset = rdump[i];
 
 	if (list_empty(&clock_reg_cache_list))
 		register_syscore(&samsung_clk_syscore);
 
 	reg_cache->reg_base = reg_base;
 	reg_cache->sysreg = sysreg;
-	reg_cache->rd_num = nr_rdump;
 	reg_cache->rsuspend = rsuspend;
 	reg_cache->rsuspend_num = nr_rsuspend;
 	list_add_tail(&reg_cache->node, &clock_reg_cache_list);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index b1192ca03db5..098f27a6290d 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -324,10 +324,10 @@ struct samsung_clock_reg_cache {
 	struct list_head node;
 	void __iomem *reg_base;
 	struct regmap *sysreg;
-	struct samsung_clk_reg_dump *rdump;
 	unsigned int rd_num;
 	const struct samsung_clk_reg_dump *rsuspend;
 	unsigned int rsuspend_num;
+	struct samsung_clk_reg_dump rdump[] __counted_by(rd_num);
 };
 
 /**
-- 
2.54.0

