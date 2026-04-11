Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6F42A96
	for <linux-hardening@vger.kernel.org>; Sat, 11 Apr 2026 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775879258; cv=none; b=jpDrdxT2gw5tceV54NSJ6TvH9s4SVOystauJ49eEH6BlfQkKZSgCtUKqbu01CbjFKZmGsYvP06zmcqryN31P69ZCw9LwuAgzuQUK9joBz9L/eo9XCSsNWEAouJuXWOAI/HtZ2Nz+xoWlgxJ51yAf0DDEz3u+BORoefxqy68IBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775879258; c=relaxed/simple;
	bh=tR1X5bTvGMCjFYa5yAHh3yNIfn6edk4tK53EiK4iKFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhQcbgdwxhJNfi2PcwNHGJ4jMeGAkNEdbrqp/XbkvA4lW+HDLSogENn9Bymnrxbq4v7oOF6oPxL/E8kPifYPus+eyRlPIrMkVpd9sBf6/WBp34HDDpMf9MGAYBCR5Axy+JPQmzOiAPNCwHI+MeO0vEBSBDnjLXI9dk3n9Uy5W6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAuQ4R+h; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAuQ4R+h"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a151012558so32304906d6.3
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 20:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775879256; x=1776484056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTrg3tEJ6M09HWK3Sh9RrgU4ykgP07OdBKz3FVnDC70=;
        b=rAuQ4R+hBVXNUYXwLV3egXNAwgQgy5f5tFh89hh2Gc/mb4TPA+2ntCDx9IXSt/axIk
         gU07B1uiRF5/MGeFHZ7pyl7V9Uc8ArBil7T5EW2dGfPiCCqL6BrR1deX8Lj1iCiIwmDT
         Ipv8kyPcbrKxT2jO6v3oLDGugw9YMWPlMwawvBEeKmb7wvHd1Jp/QTqKzs1HQSAnKRdu
         D0jA3Nsic9wsUjgYWTMgBl0yU/yk3P3c8b1EfTmSS0xIDRpdINHZJC98W4SFxDmOphvI
         xud+fiOE0KWi2spx3AM7ca9xzzRKTlKfj7Nyk6OYBz5dydto2ZMEQ7wtuBTT2ssDSfql
         J1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775879256; x=1776484056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTrg3tEJ6M09HWK3Sh9RrgU4ykgP07OdBKz3FVnDC70=;
        b=QVdpqqPK3fHXD4O3ZOyjI6qIpBP08KpGhH2E4hyWUa/WqnUG933/pkOLAai6JyO3Uv
         Z2JigZvuPykVd+MOWj0D68d3KKPBZtYDnqOTtC7x3xEsWKBr75qwOOPs9krGCy0fef0D
         VG5JtVG/S/vGG/Vi764gTEu2R48ZKf4iD77NPtkH9JhmlPMUwjhRqfSt9CJw7HWZSOnF
         ntzyLnWrO97qUUtUvCjfLKzgbnOCTeVHUUD/UnRUbk1HlDW+tdyahFJcsG3uuEO+chxU
         I/4Qgsfx7rdkYOptN1TTFjs9of0EKYeff/JRKlwKiPFDlNyW5XY+GYmnrW8+Jb7WdZ7d
         97lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh0nXp2CyT+5vORcSuEIYVwIG+/SWxhUlStmDjDiRrKbk+QaknsAT9f/Nn8JJD8iZVfs+EB4eBc3KDA9UjjPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMALg6AaAmxve283Qek7VvJJ4PxK3tqe0mZLVHqf5JfWg7CfF
	cIRkIbPCIskdXNyW1JCcmyP5MIQjS1nQxFC3OFCcXeM0V1aUgSz85dVK
X-Gm-Gg: AeBDieuFPNjaMbtSehA+wssn2NFm04rRY/B8LfeUojZl0t5uiAXqT228d6VkjYPhbdY
	Sqbs6H5tlSuDgDJbOIXYcW63QLg2fFrPYiS0cUoM76nwLd6fwZqqkkXRhtWYN+N6avAqkYjYg9u
	EGAW7vFUB0ajmKJsIC/H34YdyxXrpLaIkIourlgN9jDVkwgqTufX8SVVaT43hG3ATV5y6W7/fxE
	YogfzuGBAMMiVNKIdv64zZxQW1gVcpIZ7XPwyla9EYroivQovQeT119UMxj51Nspb1bElPjMcrA
	fsFx6ECP9RN8mxjXzUB5SXknyR0E0scFZWUNSyL4GgjD1toG5Muz9KI4jftn0nSOkUAUX4s7vev
	gswEsY7ROKPk3a2D2GTVUqI1TBfVPduiIau/2dvx2jRR++WYjHs221cOy/ujXGPQoegeYuMs1LM
	mXSQ2n4ckTL0c7uTsQ78jFr2R1So8kk5fRM/8b94Z5fpO5fGeyDvwq+Io=
X-Received: by 2002:a05:6214:590a:b0:8a0:f8b7:3921 with SMTP id 6a1803df08f44-8ac862b616fmr101986536d6.41.1775879255892;
        Fri, 10 Apr 2026 20:47:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a10e7esm39355356d6.16.2026.04.10.20.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 20:47:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: dwc3: qcom: allocate clks with main struct
Date: Fri, 10 Apr 2026 20:47:19 -0700
Message-ID: <20260411034719.161736-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Change dwc3_qcom_clk_init to a single parameter. No need to pass count
separately now.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/dwc3/dwc3-qcom-legacy.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom-legacy.c b/drivers/usb/dwc3/dwc3-qcom-legacy.c
index d3fad0fcfdac..565d03eb01b8 100644
--- a/drivers/usb/dwc3/dwc3-qcom-legacy.c
+++ b/drivers/usb/dwc3/dwc3-qcom-legacy.c
@@ -74,7 +74,6 @@ struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
 	struct platform_device	*dwc3;
-	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
 	struct dwc3_qcom_port	ports[DWC3_QCOM_MAX_PORTS];
@@ -90,6 +89,7 @@ struct dwc3_qcom {
 	bool			pm_suspended;
 	struct icc_path		*icc_path_ddr;
 	struct icc_path		*icc_path_apps;
+	struct clk		*clks[] __counted_by(num_clocks);
 };
 
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
@@ -653,10 +653,11 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	return 0;
 }
 
-static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
+static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom)
 {
 	struct device		*dev = qcom->dev;
 	struct device_node	*np = dev->of_node;
+	int			count = qcom->num_clocks;
 	int			i;
 
 	if (!np || !count)
@@ -665,13 +666,6 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
 	if (count < 0)
 		return count;
 
-	qcom->num_clocks = count;
-
-	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
-				  sizeof(struct clk *), GFP_KERNEL);
-	if (!qcom->clks)
-		return -ENOMEM;
-
 	for (i = 0; i < qcom->num_clocks; i++) {
 		struct clk	*clk;
 		int		ret;
@@ -736,13 +730,18 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	int			ret, i;
+	int			num_clocks;
 	bool			ignore_pipe_clk;
 	bool			wakeup_source;
 
-	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
+	num_clocks = of_clk_get_parent_count(np);
+	qcom = devm_kzalloc(&pdev->dev, struct_size(qcom, clks, num_clocks),
+			GFP_KERNEL);
 	if (!qcom)
 		return -ENOMEM;
 
+	qcom->num_clocks = num_clocks;
+
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
@@ -766,7 +765,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		goto reset_assert;
 	}
 
-	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
+	ret = dwc3_qcom_clk_init(qcom);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to get clocks\n");
 		goto reset_assert;
-- 
2.53.0

