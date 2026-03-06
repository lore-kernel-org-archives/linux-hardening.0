Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0BA36997B
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767560; cv=none; b=CfXJ1Yx/jKtYMT+H7AUIvxYEv1xePyN5vtF3lSQh7sVWlKP8VoKgyMYO+rr1tzfg0r/H3pAiz0GKzsfHJ6CfAOQFUGUbuBUwtLgr3RZhFw8O2aQF/6ccf2QmGNXBimO1pQNOU/xECkZlwkRmXPGjF7p13eXxENWKALxsIC13kYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767560; c=relaxed/simple;
	bh=QpBAD8aFcmAHNuzz618F5XcjlFcS2PJ0+mVIGBpyjtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNBq1EupVRFjhIimaZ4GrCO/T4tYZ3kMXhDDc5pwtQFxeLuCSnAQcymkLZIHr76hJC2MbygZ7sPojcj/FF4lsae4SSfvPOKmNzUPUTnqh52C1B/v92S/Yp9N73cLQaRn5cA7eVk60oE2i687IVa2GSNIDUtzAzqZHXA2arj388M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2/JVaI+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2/JVaI+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7377119453so1180856a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 19:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772767558; x=1773372358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6bAE765oO9RMv6HiG4ahAua9/sTwWO++ewXCfT3Hxk=;
        b=Q2/JVaI+mupxmqIZqkFiYcLfEP1ejwGuOg5vL/AQNRTSo7f2AcCf2bEg12zlxm2UGG
         UeozslG0BgUAuoNoS9y56qGkgB7kP/yZG1UcVcyXJNO2u3tdTuGg6wWmFeEHnZfMqEnQ
         6EhJDzt5+tiXA4Vb7F1NcE51LWWw5Qx2utrtbaOcuHncYjyBGmgxDAuy1msQmG6P/FM2
         XDL5BghpgJsRQPe0kMMRtyeqptzZqGTdcAOewu/CJKvY6LIyzREnZMsUq3rfAkVkmS6J
         Vgfwbrel5hI2tB354hOXuz+CJD2zt8Z44A+TdaumQ0ofagU9gM7aMZ8o14C1YLm/yEKP
         s54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772767558; x=1773372358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6bAE765oO9RMv6HiG4ahAua9/sTwWO++ewXCfT3Hxk=;
        b=sFReQEFtXTrOn451Ex7K8JitGQArdLEX185RpZuLsMBwJ3efnd3M1uYGGZJChsB4wS
         hlzARzjmKb+/lxWKxqZ92WJArxOfocN2UdlkPB94nJ7xHMZ4tX7oi7IlImMZ5+ta3x+5
         fm7pyWa1VAxRDdcqDi0bj6v73NMHLz5B+/tTJoeQnJSwf7mKNgmAWjqrQjKL9/FByBSt
         z0OqiV43CzF7xg6uBYy5sq2GbNst2CopF4PCej+9tX+KnF0eGRJmxqc5J5qd8L5dg5wy
         un66fneJShdpCohZ6M/pSeHOC/GUp2THrQ9BuU7pyQ46Yey2lhYVhvgP1uttwl1eanjg
         wzaA==
X-Forwarded-Encrypted: i=1; AJvYcCVT/Oj0gu7GW+aadw3vGgkDinve8rNFCQvAEth5rPp7/9hJIxmFbY2EphTbli9XCcpKR5DN5RiXZb4pxjqKSOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycp1MarFbiBeIblMwxTKlE9IE08zwXxkCBT4cV7G+UY7yt00S/
	FCD4luHQLDCX7RaRihtu/sKu1oBTzMnAGw0ubknpHxuVRV5S2ubtnxDM
X-Gm-Gg: ATEYQzy7qSB3xYuPy6s65XT0blBp69e9bBCThk+WsSFxYvFgolUqSCz6d00Mw9KBDsV
	Ku/4MkCSF3qqF67Grq2wECr1jITvj7v7K3YQgEnXa4E9JbGYGiL/nbPvS1/xLOBINn9/Q7whipj
	AyFAZ9mvzVN6xeqmgB/lshIZFikIt/8GBpI4Vy/NrpNEkfcRi/OrLWrytK73Bhhfw28syrAb5tE
	PIzeka8Tl6WXsquaA8lDUj8jptaDoJosczK/coFFsG/VQ7Okl3gmYrMDz2GLejF59aO/T2avxXR
	T1RST1jICfZ1T3R+RpQOek+PdNrdCAdC+kS/pKFBU8bhsQ+2SQwG4vqsx/WTZe8lGfZR1Qt285R
	DVDRpAoLxcZI/lZM1OPalrgcI28BNrcXeBWv+n++xKJ25j1YosvuHtRj2A55c9HUmAyWcz67fES
	gjEzs4wXeEwR+9/18INZxYpz9RuxYfwdfoTMew7ZQX6Y2Np3oO8/0cZmE/3aCOodmrtw==
X-Received: by 2002:a05:6a20:6a15:b0:366:14b0:4b09 with SMTP id adf61e73a8af0-398590d61b6mr872614637.69.1772767558244;
        Thu, 05 Mar 2026 19:25:58 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0a70f9sm148424a12.6.2026.03.05.19.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:25:57 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC18XX ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk-lpc18xx-ccu: kzalloc + kcalloc to kzalloc_flex
Date: Thu,  5 Mar 2026 19:25:40 -0800
Message-ID: <20260306032540.47815-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation by using a flexible array member.

Also allows using __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/nxp/clk-lpc18xx-ccu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
index dcb6d0c0b41a..3793e701835f 100644
--- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
@@ -27,8 +27,8 @@
 #define CCU_BRANCH_HAVE_DIV2	BIT(1)
 
 struct lpc18xx_branch_clk_data {
-	const char **name;
 	int num;
+	const char *name[] __counted_by(num);
 };
 
 struct lpc18xx_clk_branch {
@@ -266,6 +266,7 @@ static void __init lpc18xx_ccu_init(struct device_node *np)
 {
 	struct lpc18xx_branch_clk_data *clk_data;
 	void __iomem *reg_base;
+	size_t size;
 	int i, ret;
 
 	reg_base = of_iomap(np, 0);
@@ -274,19 +275,14 @@ static void __init lpc18xx_ccu_init(struct device_node *np)
 		return;
 	}
 
-	clk_data = kzalloc_obj(*clk_data);
+	size = of_property_count_strings(np, "clock-names");
+	clk_data = kzalloc_flex(*clk_data, name, size);
 	if (!clk_data) {
 		iounmap(reg_base);
 		return;
 	}
 
-	clk_data->num = of_property_count_strings(np, "clock-names");
-	clk_data->name = kcalloc(clk_data->num, sizeof(char *), GFP_KERNEL);
-	if (!clk_data->name) {
-		iounmap(reg_base);
-		kfree(clk_data);
-		return;
-	}
+	clk_data->num = size;
 
 	for (i = 0; i < clk_data->num; i++) {
 		ret = of_property_read_string_index(np, "clock-names", i,
-- 
2.53.0

