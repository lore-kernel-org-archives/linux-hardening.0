Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B29340DB0
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318282; cv=none; b=lrSPbuNzN8JM9a0HcsaDy++0141VHOpWVWZjjZ5nyy3jQAsGrr/iBj0DlEJrXgEpIk9UQ5vvvZZRoamBQ+4UuAYGi4pg+2V2qYzKg4dpyrDIzyZ1xXFWru4V5XGrS+2eKo1lrtSIo52dECaOZcNl4wpJDt0WNH7I6cdvD7EtEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318282; c=relaxed/simple;
	bh=5LCSZy0QNtO4bzoIvyj24RyYrTxJ4vg7ZKTxOvocysw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc0PKWygLS7fqBavamewKH4D6BbCAIPG4mj8NpeJ+gyRo0NzzxPih8ao8GFmaDxGtv/LSv8WBUl8OiYhqwbjCZX8l28RB/VINVuIBq/Uhumnt1mNa7AcFolo9h7KqFYYFmmzXGAl7ozVkngkARQIj4iDA2/Gz9ECMOhKQ2vQwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr79q3pK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr79q3pK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso1646538a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774318281; x=1774923081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg3BeEF/NeYvq9HpPYQyLEWkUbXwDTNUoplMULCqoG4=;
        b=Dr79q3pKlHDZoriUdWMx6Rp0FzjGAH+djAn8d7B40mgLTveQDTs9vJY2ygw8V+/8ma
         Dgq2Hb+09dZYJiOSBS7qX7lpoSF7NowmV+QPwK7Sk2tV658rueIF8+nCcrXuS/u2kvOh
         gujUAVBF6XKckecqAbUGr04HCDa9HfGqDxnz16RGN3BkdhPI7ypFiQdLYYyGCB836JIs
         lgsKHLhWucDa5s1i661bSlPnT3k+JSyqAoYV2dJIXWb+yzjQ4AjohxsbVWWOr595F7mR
         h8EmvYe4DvK2vfOZUr1JbTkVRapjH6rebMAGBEWUP9ggKWoC2DgJzceDLj4B3IZKqSCJ
         1A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774318281; x=1774923081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pg3BeEF/NeYvq9HpPYQyLEWkUbXwDTNUoplMULCqoG4=;
        b=dH+dK3D2WzV3NHsQtVD2LFMFsfmXkU9dOPwjN2Mm+WsVDuUp7ksdqt5fmAeFyBcNT7
         1xmsSnp8cyYlRLQnhelVUeOCjFnHQnz+NmJnbuF0Co4oaaTckWsSbgGEdZ//0qwrQJd+
         0Ib19K9wD8T5p+XSrQfCf9RnOhdDNZ13xTFo2epoo4O3cejtczYznc3+6jMMtmaE9lde
         5RpzHinwhyPC12UgjBt6FVbU8b+ASgZRQidkfy4a+qsvR/7Q9UvDW59IkhGtpp+E2pNK
         DiCS3hlKnui0+vadJbK80+acLOMBSUVH7W0JDlNSRcSpDfLcSLTiiomEbXD8ETlnK8Tz
         BO7A==
X-Forwarded-Encrypted: i=1; AJvYcCVeUNPs/gsjusqX91hfV3n0VwSSA7mEpEjotFlFoDpFzctJXQFlTKwI3C6b4IvTIrCyzh707QVqYjk54qdOADg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr9CHV0ZiqmrFRb2xZbbVRphrw3hZhemEYlHLMZv2q0oTd24Bs
	5xEpu/96FCS2Mhx6nbIP5lN9PtsRkneK7nwv+XSj3nAL7ZVCiNVS50mH
X-Gm-Gg: ATEYQzzc5Q/iYeSfduPYosQaPOYk5u0c4xiTruTDVnBakyp5YEDBPXJDm5oUOjocN3+
	KqN2ZKauj387G1t2lCFvaZ+XVymvddOdNOJVCJFKn09Z5lfhl7pORWM2yfpF/EJd7C+aX2ZyAXw
	Y2QuQRoVVhd2qACne4MZhpryAzHPm9O1wehSSS88SOpWTN89rXwB4Ph+1n+8mYCWJR+wspqnWVV
	ElakQAAtZMTDtwHxHYPeqPEH0LwuYYCy7IRMdDIumUNHC8pMfB/bb50sPoPCFM0hOdnBYzxl460
	g4IXLzLSQ8coU8/XGQRe8U2V/wEmtEDMAizspfVvi/FPkpSirc9JFzIM6yRgy4yKw5pTscSz2Nm
	zB7R8AIbHc7tTURZ4AH3S9TQ4OCv74tWrs7UhyX3aPJlCM/nyA4gaGIOxk/og6oaJGKd5cjqE7E
	F+5mOt9mfQe0aGBk1VvI5KrnocYiovqF31FMGb5G/0aTZJ5k40ZQlL6Xk=
X-Received: by 2002:a17:90b:1e4b:b0:35b:e6a3:41d0 with SMTP id 98e67ed59e1d1-35be6a342admr6003709a91.26.1774318280932;
        Mon, 23 Mar 2026 19:11:20 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03149db2sm457965a91.9.2026.03.23.19.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 19:11:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-renesas-soc@vger.kernel.org (open list:RENESAS CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk: renesas: cpg-mssr: use struct_size
Date: Mon, 23 Mar 2026 19:11:03 -0700
Message-ID: <20260324021103.13651-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct_size is what is normally used when a flexible array member is
present to avoid accidental mistakes. pm_size is still needed for the
memcpy call below.

Added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 64a432fd0e8a..26ea85cfaa02 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -569,7 +569,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 struct cpg_mssr_clk_domain {
 	struct generic_pm_domain genpd;
 	unsigned int num_core_pm_clks;
-	unsigned int core_pm_clks[];
+	unsigned int core_pm_clks[] __counted_by(num_core_pm_clks);
 };
 
 static struct cpg_mssr_clk_domain *cpg_mssr_clk_domain;
@@ -667,7 +667,7 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	size_t pm_size = num_core_pm_clks * sizeof(core_pm_clks[0]);
 	int ret;
 
-	pd = devm_kzalloc(dev, sizeof(*pd) + pm_size, GFP_KERNEL);
+	pd = devm_kzalloc(dev, struct_size(pd, core_pm_clks, num_core_pm_clks), GFP_KERNEL);
 	if (!pd)
 		return -ENOMEM;
 
-- 
2.53.0

