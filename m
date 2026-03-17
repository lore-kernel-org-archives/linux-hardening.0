Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3212D21B
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707360; cv=none; b=G5Hd6jfg/drtzKpLQ4W5uxkWU3FRMxIE1/2YTF+XNYI3z5SflYzC0jMwj1NNqV9aLwmICZOkBuVq2eW6JMwY9C4euY1eROIvqTjb6sGpU4jK4IGDVehTmdGXWixkGSx1ND20hxfgHzu1KnhuL7Acub8oAkHzPmZZs593p5p6kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707360; c=relaxed/simple;
	bh=Ykl7pRMjv9ddmeTEMSu2XWv5ypxsnnaE2OuTTvdmJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B15V+1QLHonfoWA1G8I/E0Nj7jZpnc2dMPESnleGKm3kW4vz5gMbAP7q2JyDE4TAO58gbr9PqXwGEB5c0n4xG6o6DKacM9sPxcNEWOtQgt+Jw4490Haz4iUwfwv9d9SxH9NIWe5AM8V3bvzUsATGXwkxhYOX1MV0yLoVgHygtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKqgHCMF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKqgHCMF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829865a8471so4905707b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707359; x=1774312159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEaJEC5yeKcESXwFqV6k9VnziI7uI+jjMq7JZGGKBfA=;
        b=JKqgHCMFSBN2PktyvNv9ikODFsFN4db8y1UDUAFV/l3h66ijBTPp/epT4aUYOshxTa
         /zCbg8ydFzlS1rtWzGwKKDfhw6mcsPjciA88tBxolmK90PX1Xd9qoy5UVXlqwkv31vI7
         B9CNqxKFN6v6yFspDcztc1/MGSwLCQSvZxQhInkWi+RazCtKvOwtq+NLIrfb4vVoPKau
         9+Qcrka58jKKJfCn3zMCdAaD+qXWKWfxvLgIGrPojnnR3XrAgOdvYdxzMLmbVexL73/d
         3cg/KRTHRhC3DuS/UC/C/zWRYnDOkV6SIuyvr/vqpN+nnztK90kvC5GTUeJ5McPGAwXP
         klfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707359; x=1774312159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEaJEC5yeKcESXwFqV6k9VnziI7uI+jjMq7JZGGKBfA=;
        b=DCPpEJuaxd6WDTgO4bXnERaPmZx5nSSgtagZZY+DY3fH1gVlCwBoCmCkE43ZWDTUui
         Z8fPlPy4xpWs2zUqZpsb+KBGTJNR7yBoEOZ1CYxkkBTYV401miKyUPVet2PmNgqP/8OQ
         7mkdot2mqlk7h9d/DovdMXPlNQKi0NEbKtdWcNMDY17vfG0CkSdtdpKF5FkPF+SsAKSZ
         +pWwt/jBgX4HXvJM8lmon6yw7AXZez+8pmLEeNBDSCCwuwhssQq9EMH628aIfUBsLW+3
         wt/iJlNcJD7V7tKKZ7BleKnEzbDue/B5CwCSSc50/7zu3+m14OeO5F5fZl3rsPZbbzQD
         tnSg==
X-Forwarded-Encrypted: i=1; AJvYcCWOTAqAIoPKCgVEIaqI95zBmuNR3MoMnk2St0vTe8jtJspnxcykvVsUXbwYtyZBPqvk8Azq+bsorcOqXzE3U6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uxwjSaj8FUxJariso9MYIO7hmourLDztVojuFO6kFL99a2yP
	qNAwKNZ1QZFJuK75WWr2Oz7rU07pp9ppRRNOLpSF/ID9aQh1r3Z7mkut
X-Gm-Gg: ATEYQzwqcPPRg7pL2H3OATDCBuq5voK5aa8WqYUnf8vvK9kxyr9BzFG953Y/9nIPpo+
	mxLLp0ASmr8hQ+A6tzg9ty19NuqSW+fUrIwFR2sqYW9n16DHxKdWdzlTPwES3T+ozNfglZZMLKC
	23J2qGk1Wj+Ow8+aXQav1cLeTjvi4IW65pfWeKdgXUwhjCerPmJWKdfby2FKiQlIw8MoLz/VIZe
	Sf2mIPBRGuxKRIzULd++Y0bWUViwoSR2D2y23f8qdUtXaxpKJ3rKlNPLV5s0FR53H1CWBhJrYef
	kkfCOh6TIP8M8u8/+tMPCjVLy5XNtSyvaTVp2RARwV9+qoOuGEjUb5qL2auohaA2Eidz3xDpAlM
	kIoLw5VwZTBUxWa1j1ecbgHZgwjgIDPlsaPNX2+Yl5BDY5QqHaWszkwfc/3nM460aVGQW6APX2a
	kfYHAM3OuWN5eDOlCXjnxqPr8Q95buspzkrg5hexPoCdAN3EeAZuLtuCI=
X-Received: by 2002:a05:6a00:1594:b0:82a:778:cd73 with SMTP id d2e1a72fcca58-82a1992c45amr10581048b3a.51.1773707358578;
        Mon, 16 Mar 2026 17:29:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072603c0sm14010022b3a.22.2026.03.16.17.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-tegra@vger.kernel.org
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk: tegra: bmp: remove kcalloc
Date: Mon, 16 Mar 2026 17:29:00 -0700
Message-ID: <20260317002900.71452-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to avoid allocating separately.

Use __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/tegra/clk-bpmp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index f6d2b934228b..e2d506cdbae2 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -32,7 +32,7 @@ struct tegra_bpmp_clk {
 	unsigned int id;
 
 	unsigned int num_parents;
-	unsigned int *parents;
+	unsigned int parents[] __counted_by(num_parents);
 };
 
 static inline struct tegra_bpmp_clk *to_tegra_bpmp_clk(struct clk_hw *hw)
@@ -510,20 +510,14 @@ tegra_bpmp_clk_register(struct tegra_bpmp *bpmp,
 	unsigned int i;
 	int err;
 
-	clk = devm_kzalloc(bpmp->dev, sizeof(*clk), GFP_KERNEL);
+	clk = devm_kzalloc(bpmp->dev, struct_size(clk, parents, info->num_parents), GFP_KERNEL);
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
 
+	clk->num_parents = info->num_parents;
 	clk->id = info->id;
 	clk->bpmp = bpmp;
 
-	clk->parents = devm_kcalloc(bpmp->dev, info->num_parents,
-				    sizeof(*clk->parents), GFP_KERNEL);
-	if (!clk->parents)
-		return ERR_PTR(-ENOMEM);
-
-	clk->num_parents = info->num_parents;
-
 	/* hardware clock initialization */
 	memset(&init, 0, sizeof(init));
 	init.name = info->name;
-- 
2.53.0

