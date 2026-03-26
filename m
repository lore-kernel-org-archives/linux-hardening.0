Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF634D4FD
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492607; cv=none; b=FR7miOCrZqzyVbZ4oHw51+Vp2vKvIAxWY8J7vMNPlEE+JsuXWgeHm+J+oj0T79pyOyqKO9uSwMZhUS2EXCFMiVfEIq8aHmP7XJ3tmNWaUMfk9SvFf96GqmqW2DL0zjIvv2uH8P4OT5p/Bmfg0d+9GzZIxW+Nbljh/osal2LzsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492607; c=relaxed/simple;
	bh=x9AzjzvF+Zn/f58SEXBbdYUK8/A08m9vI2LlTEJCV7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jv4o8yIk9BdEMcV4/l4wF9ZHfZNwgmaWdlbtWYVTiIa/FJ/MjL9FsWaRjSvaBmaIJADfBpX/nmPGv9hHVOTcOHtx/BFJ/2KphZQdBY+rGc4IaIwIyQE4rUhawMLVAPRhISG4BOTb3t43VbZibAQlFV5+3XdeIf6PZq/05FliATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+QhDHRt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+QhDHRt"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-823c56765fdso249745b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 19:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492605; x=1775097405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dc94mFyUarnXD7uTGOHIqKLXmGuXftbJg5Kgbu68aTI=;
        b=C+QhDHRtemAh95GLVEXIKzkv7aytG5q8dF+9ChKxMy7ty6zd3mE8rcD0QMPTiVWtjK
         iziO+56iB68d/OxpWjMhTc1g/o/yu5UL2HOPJrpiX+seDk4ParjTIuj1AKmAJIM1i2zI
         Odpg97Ma4jJB9XT4VFxf7vOl/tOd603zow4uQzr5SdR3O+6JV4swleSlTA85dNCVwRms
         UvbrqYSKbOaCVGQj5BS5ej0x6W+ZvVa1Ojo686vKtDvrH+3pIjeiqH8ksxVDJ2WKOt/P
         vfdqW4A4OERRpAdLjZauIZKIvC/yaBBd649hzpBBUYfBOwdJfk4EW8Do/v/I3cs63BJK
         p0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492605; x=1775097405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc94mFyUarnXD7uTGOHIqKLXmGuXftbJg5Kgbu68aTI=;
        b=NggDp7zJOvY4hjh1KamR7cNGVjTNg17DEq8Vd3f6RbG9Th5g8gFb/KCnUxaT7okdwQ
         VBbYzzY7EwAyKkYoEPNPknAbIJbKWSCGZQIx2CMN4f0tUgIfSP+YdZge+BuLPSFwP+MS
         TeXuNCU2V8vBMuGYCkeYJrBNyrnS4Ie/YJJtInbXR0AgRCcV2WQUNXWCKAmy8J6c4WWA
         VRF9DDoVmhHbvopr8p2VsfzmwJ6GPL2HH/oFYRMq8xUn8j7Af6WZywUFZyRbVyVHnhTS
         YLAokaOfdxjHkMa/jAp1wktPtqcnR9DBMH0g+J1YW0tR3NAxeeoLBVdOLK7oU6LUDG6R
         ssOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1UVIRg0yd0/KArjkwrfow7wzxIvcvkJNdNnB53x0c1Y6cNJcv8+egp5Vhv2PFJD4cnR9n5cBLRs38uq1ga8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtsZYk9QMAn/jwonjcFQwFoilFb29yeUN75HZDN9rszOXTPio
	dIo2+IbsxXcATITEpIunmvWJ5BOvgkx+8LTNHI9YOgGWa6T613ly9PeL
X-Gm-Gg: ATEYQzyh3bP8zNUv+SYM1ZG/Jn9+hNWqqY+BannBQ3n/Mg2OyMws0Fsyt+PUvrfdeeZ
	1/MWVKDfO+1XBwUARxr0i9Nj0B2aDBxc4wsNMHTc/bLIIr0LJ84JaZj5tqkuPmiqZWmqajSrhbN
	AlkcnvMn5A6DEQX5hWf07hO9+RZZJ0OhPoBYh55QB505Ylp2uUbhY7J2+VrnnzTaraYMTxtFVKP
	rIaGiV/7DcDfAjI/sjhUEX+9PF2R1MdStfixv8tBIBzCHsVqGAa9OD5LPGTVT4MGf3ED1qRAQ98
	HzG8P9xLFDyrLfgXmIh81yCd7SAISE277jB4xhyK6yV+BFMI+3MNICQMhansirxCUVgI3M3BbWR
	K4ueR3ucd4FmALRLPPKgOTYZ4O98ou9eMHKlw8sgHRjmHRuYn1iXXXmoUeXUnjx3TFsk8kV9jTm
	2krp7kBTo+ZOucATh44R3x2d5okNLdncx0TEeUqrO44Kn/BVF8eFlWFrkE7+5WiMGYSg==
X-Received: by 2002:a05:6a00:f05:b0:82a:6de8:fa4e with SMTP id d2e1a72fcca58-82c6de9f009mr6630975b3a.17.1774492604974;
        Wed, 25 Mar 2026 19:36:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d385601sm990176b3a.33.2026.03.25.19.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:36:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] pinctrl: intel: use FAM for communities
Date: Wed, 25 Mar 2026 19:36:27 -0700
Message-ID: <20260326023627.54349-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations into one.

Add __counted_by for extra runtime analysis. Move counting variable
assignments to after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c   | 43 +++++++---------------
 drivers/pinctrl/intel/pinctrl-cherryview.c | 11 ++----
 drivers/pinctrl/intel/pinctrl-intel.c      | 15 ++------
 drivers/pinctrl/intel/pinctrl-intel.h      |  2 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c  |  9 +----
 5 files changed, 25 insertions(+), 55 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index b733ec31ad9d..e73419498857 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1558,31 +1558,6 @@ static int byt_gpio_probe(struct intel_pinctrl *vg)
 	return 0;
 }
 
-static int byt_set_soc_data(struct intel_pinctrl *vg,
-			    const struct intel_pinctrl_soc_data *soc)
-{
-	struct platform_device *pdev = to_platform_device(vg->dev);
-	int i;
-
-	vg->soc = soc;
-
-	vg->ncommunities = vg->soc->ncommunities;
-	vg->communities = devm_kmemdup_array(vg->dev, vg->soc->communities, vg->ncommunities,
-					     sizeof(*vg->soc->communities), GFP_KERNEL);
-	if (!vg->communities)
-		return -ENOMEM;
-
-	for (i = 0; i < vg->soc->ncommunities; i++) {
-		struct intel_community *comm = vg->communities + i;
-
-		comm->pad_regs = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(comm->pad_regs))
-			return PTR_ERR(comm->pad_regs);
-	}
-
-	return 0;
-}
-
 static const struct acpi_device_id byt_gpio_acpi_match[] = {
 	{ "INT33B2", (kernel_ulong_t)byt_soc_data },
 	{ "INT33FC", (kernel_ulong_t)byt_soc_data },
@@ -1595,19 +1570,29 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct intel_pinctrl *vg;
 	int ret;
+	int i;
 
 	soc_data = intel_pinctrl_get_soc_data(pdev);
 	if (IS_ERR(soc_data))
 		return PTR_ERR(soc_data);
 
-	vg = devm_kzalloc(dev, sizeof(*vg), GFP_KERNEL);
+	vg = devm_kzalloc(dev, struct_size(vg, communities, soc_data->ncommunities), GFP_KERNEL);
 	if (!vg)
 		return -ENOMEM;
 
+	vg->ncommunities = soc_data->ncommunities;
+	memcpy(vg->communities, soc_data->communities, soc_data->ncommunities * sizeof(*vg->communities));
+
 	vg->dev = dev;
-	ret = byt_set_soc_data(vg, soc_data);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to set soc data\n");
+	vg->soc = soc_data;
+
+	for (i = 0; i < vg->soc->ncommunities; i++) {
+		struct intel_community *comm = vg->communities + i;
+
+		comm->pad_regs = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(comm->pad_regs))
+			return PTR_ERR(comm->pad_regs);
+	}
 
 	vg->pctldesc		= byt_pinctrl_desc;
 	vg->pctldesc.name	= dev_name(dev);
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index a33eca5eafc4..e9b062b44fea 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1595,19 +1595,16 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_data))
 		return PTR_ERR(soc_data);
 
-	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
+	pctrl = devm_kzalloc(dev, struct_size(pctrl, communities, soc_data->ncommunities), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
 
+	pctrl->ncommunities = soc_data->ncommunities;
+	memcpy(pctrl->communities, soc_data->communities, soc_data->ncommunities * sizeof(*pctrl->communities));
+
 	pctrl->dev = dev;
 	pctrl->soc = soc_data;
 
-	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
-						sizeof(*pctrl->soc->communities), GFP_KERNEL);
-	if (!pctrl->communities)
-		return -ENOMEM;
-
 	community = &pctrl->communities[0];
 	community->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(community->regs))
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 97bf5ec78db4..635e4e5ab10c 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1581,24 +1581,17 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 	struct intel_pinctrl *pctrl;
 	int i, ret, irq;
 
-	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
+	pctrl = devm_kzalloc(dev, struct_size(pctrl, communities, soc_data->ncommunities), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
 
+	pctrl->ncommunities = soc_data->ncommunities;
+	memcpy(pctrl->communities, soc_data->communities, soc_data->ncommunities * sizeof(*pctrl->communities));
+
 	pctrl->dev = dev;
 	pctrl->soc = soc_data;
 	raw_spin_lock_init(&pctrl->lock);
 
-	/*
-	 * Make a copy of the communities which we can use to hold pointers
-	 * to the registers.
-	 */
-	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
-						sizeof(*pctrl->soc->communities), GFP_KERNEL);
-	if (!pctrl->communities)
-		return -ENOMEM;
-
 	for (i = 0; i < pctrl->ncommunities; i++) {
 		struct intel_community *community = &pctrl->communities[i];
 		unsigned short capability_offset[6];
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index b5476b9de0db..c382fe8f08c2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -260,10 +260,10 @@ struct intel_pinctrl {
 	struct pinctrl_dev *pctldev;
 	struct gpio_chip chip;
 	const struct intel_pinctrl_soc_data *soc;
-	struct intel_community *communities;
 	size_t ncommunities;
 	struct intel_pinctrl_context context;
 	int irq;
+	struct intel_community communities[] __counted_by(ncommunities);
 };
 
 int intel_pinctrl_probe(struct platform_device *pdev,
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 299ee4f22bdc..b3cde7afded9 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -715,19 +715,14 @@ static int lp_gpio_probe(struct platform_device *pdev)
 	if (!soc)
 		return -ENODEV;
 
-	lg = devm_kzalloc(dev, sizeof(*lg), GFP_KERNEL);
+	lg = devm_kzalloc(dev, struct_size(lg, communities, soc->ncommunities), GFP_KERNEL);
 	if (!lg)
 		return -ENOMEM;
 
+	lg->ncommunities = soc->ncommunities;
 	lg->dev = dev;
 	lg->soc = soc;
 
-	lg->ncommunities = lg->soc->ncommunities;
-	lg->communities = devm_kcalloc(dev, lg->ncommunities,
-				       sizeof(*lg->communities), GFP_KERNEL);
-	if (!lg->communities)
-		return -ENOMEM;
-
 	lg->pctldesc           = lptlp_pinctrl_desc;
 	lg->pctldesc.name      = dev_name(dev);
 	lg->pctldesc.pins      = lg->soc->pins;
-- 
2.53.0

