Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4B1B4F1F
	for <linux-hardening@vger.kernel.org>; Sat, 11 Apr 2026 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775880791; cv=none; b=nUYSoN0tI/8vytTxJM4WDmpUrFqxM0yqleZEHzOVXfhRqshAKUkdQm70aC3pE7G17g+CE9OAK1aKBXvCiboWGNLtTOjhB2lMoWs6IWfHJzxNE1tXp2Fab8pGTvMeAlxWmQwqe0YJWAx/Qi8mkuMy0I/gUOCrJd8oVg1BR1LYvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775880791; c=relaxed/simple;
	bh=/9YbK/4p7k0dCS+xImCu5bILIgLPbfTY9eo105YUH80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8oDA4wsfJHQTXTjEgu26FER5EJ8ce2TmJNRS8XwU3WhiecDOLEPBFB/w4lpol647mbQM6rBy+KQjMJ5z+esP9XSIapZGDau6z03Vl8g9XISvcbvRPd0N6BS04ap80/9XxGhamTLUotziL9ZXifCU6FfHn7sEl4SdK5JYdq9hCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GouuZMGH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GouuZMGH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so19306435ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775880790; x=1776485590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rb4KLPpojEy3CtRqR7RKIVuXI1C4jejvtMhj2fQsK0=;
        b=GouuZMGHEnz3Qv+Bo9UmsKdEFPBlQMXmykJ/4uuGLGAr7baUJ1lEhKPwi5190oABFj
         LOWhmz5qONPYYB1y35N/pdOH28CI7uPC3DGPTrtaJsa3NdHRG658JtEpOUlpe5Z7brN0
         CF1fPyOHkEbwi9hK3+4xIyttBTLH6boCf4S9YI3reTDQOHDHHOfgDBoVy3FDlDazCyKT
         b1od7NB/D45BTjfEbDgACwXeQPOa/uJ2BF36YKOtmU/pfDOy/Y11HyL9A+guymhOXOax
         o2uZj70sJsEhcvWo8CjtzPmMiJYwqPX3GZ9hOFzedxkMMrI4Qt+Bkp5DRl6zLp4LzTtP
         FvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775880790; x=1776485590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rb4KLPpojEy3CtRqR7RKIVuXI1C4jejvtMhj2fQsK0=;
        b=ndnHVrsdaWU1G9Jbt9pkn3TpaQ2dHgL68F30NOgZMDuz55DhKoMEVJ+qmuHc1oFr7k
         IoX8FGIVEM+4ubvCKSPotMKRy9AfRPWcl+fjJP+67ui34blI7j8n5ui2co0KhcoXcfls
         m3xHiq9VStV704FBog6Pf0pXypraqAJ/VST1K9J+PDJDjXWjALfbjDVByWAruw4Pj81M
         YTlu8x4VG16xAWXPyvrhDbuwjIU4TdYW5xT0xa5onERK48ubyw3ElaeI6fAKC8stnYNo
         4/UH7+saJKzvtKwCPFCu8FbooN68Ac7BWu0FAkqu9VpwEVD9ncLMpPBB+ChvHkGtBYpM
         loQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpYmuufZu/ZaLgAgPs5UsgwBM/6m+D62KQqyCtijYXQP0MfWXB4BY/hnPBslljKzvRxSBaLLODTAbm9+IGQSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJiDeg0/ygOl+9gOKEdBFwzJZKUSqdx4om68iom2esmppBpv5
	/i3lWadUDaF8ZSD6SOOl95w3DFCUK7kBoBkLoccPl35NwE4vOIev5cMX
X-Gm-Gg: AeBDieue2xn+v7BLirPxA0oHVReoRjmKfhlfppw/SIF1q5uSaM86sMrDKZy3hK/cDPs
	NknHUsekwfElgneElKUQyRs8qXIBxi6Cywr5ovEIf8U5wDc8mXhXbPOMfIDHEDETxt302Z0zvvE
	pCXgcTw8jlhs7WnarLledHxUN/BpKrilW1e15V7WwyMLOjeGeoy5mdOQwDKwY5TTK+HZV0ZPaei
	SzpKcWNVMs31StvLRUxfjP3jlaZ7FCoXq0ovLUp97D56qZw/h0nw9RiK2J7lbH8HmVvkNH78t9L
	uiELpWS53B5JWbQ0sO0RfhXt3AaK+jKdRbRCdl7F63wMrTi+fhPytXfYsG/osKXMpBhHpy0x0bB
	iCn6pYEhEoo7+OqwD1XXjeZUW6LLYZIasEWQqIHVwX4U6nv+6DdnkN+gL9QQ2IurzZVJN08qNzw
	nNPLCHvbA9yLVWM+XovqMATK1jz1nCSVeygMYqesNs1yVA+qAt42kjwgS8lgOc6TucEA==
X-Received: by 2002:a17:902:cf11:b0:2b0:beb4:3bb with SMTP id d9443c01a7336-2b2d593bd65mr61241285ad.10.1775880789965;
        Fri, 10 Apr 2026 21:13:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e036f3sm48523235ad.31.2026.04.10.21.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 21:13:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: bdc: allocate phys with main struct
Date: Fri, 10 Apr 2026 21:12:52 -0700
Message-ID: <20260411041252.166816-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations and simplify code
slightly. No need for a branch deciding whether to allocate or not.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc.h      |  2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 2f4abf6f8f77..cc961161eb46 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -409,7 +409,6 @@ struct bdc {
 	spinlock_t	lock;
 
 	/* generic phy */
-	struct phy      **phys;
 	int num_phys;
 	/* num of endpoints for a particular instantiation of IP */
 	unsigned int num_eps;
@@ -453,6 +452,7 @@ struct bdc {
 	 */
 	struct delayed_work	func_wake_notify;
 	struct clk		*clk;
+	struct phy		*phys[] __counted_by(num_phys);
 };
 
 static inline u32 bdc_readl(void __iomem *base, u32 offset)
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 438201dc96ca..4b16b85da450 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -487,14 +487,20 @@ static int bdc_probe(struct platform_device *pdev)
 	int irq;
 	u32 temp;
 	struct device *dev = &pdev->dev;
+	int num_phys;
 	int phy_num;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
+	num_phys = of_count_phandle_with_args(dev->of_node,
+						"phys", "#phy-cells");
+	bdc = devm_kzalloc(dev, struct_size(bdc, phys, num_phys), GFP_KERNEL);
 	if (!bdc)
 		return -ENOMEM;
 
+	bdc->num_phys = num_phys;
+	dev_info(dev, "Using %d phy(s)\n", bdc->num_phys);
+
 	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdc->regs))
 		return PTR_ERR(bdc->regs);
@@ -508,18 +514,6 @@ static int bdc_probe(struct platform_device *pdev)
 	bdc->dev = dev;
 	dev_dbg(dev, "bdc->regs: %p irq=%d\n", bdc->regs, bdc->irq);
 
-	bdc->num_phys = of_count_phandle_with_args(dev->of_node,
-						"phys", "#phy-cells");
-	if (bdc->num_phys > 0) {
-		bdc->phys = devm_kcalloc(dev, bdc->num_phys,
-					sizeof(struct phy *), GFP_KERNEL);
-		if (!bdc->phys)
-			return -ENOMEM;
-	} else {
-		bdc->num_phys = 0;
-	}
-	dev_info(dev, "Using %d phy(s)\n", bdc->num_phys);
-
 	for (phy_num = 0; phy_num < bdc->num_phys; phy_num++) {
 		bdc->phys[phy_num] = devm_of_phy_get_by_index(
 			dev, dev->of_node, phy_num);
-- 
2.53.0

