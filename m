Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2D2C0299
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777587102; cv=none; b=JlAVGUjtKrAP1T8wTi8NolghErllHSa4m3uHRFiRssv6N9BU2kxNEEjepJ3vmMy3NAON6YUnH4S+vQ9eywlKyYLRaaJ/YfmB2oE4X30oO4ynSn4KMrd1nXA6W6FbUYhENh5QO/Ad/vMAC5STdNpi+nzwZbnGhMLA0AG+3xq03B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777587102; c=relaxed/simple;
	bh=vFGv55dfkj0ETD0g0nqltAGLsOx/oLvtbrwX44RQX6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oigBZ9oJ7ffg+W0FPV6LddVVAKasBfowQKIPxsgNnYxkKCEeNZ3AKE3PkjSS9l/b4z8brlXIab11gr/jdO2CyJ09uQ+rjSSKN9SsBexP7c54AWqH01nM+lVETA+x3heOD9FrRTZMwQjqlnaOeIDZTNVbhEj74/FlmqdwpPlg/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7Qe6JAS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Qe6JAS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso881358b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777587101; x=1778191901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CyYpr5DG2wVXaggugKyiSvcVLQEXsc/QvDPZHxp5lw=;
        b=R7Qe6JASjtDSiB8xbVqqBe19ZACFgfEjFFile8iFLJ8mzXfBuBzuNDY69MxCnyQkjn
         266HYjIwHgRQk7sMgBLcWD+d4U/6POwmZfIPWfUL/qzrfNiJoFUr9Yl89Yi2DMIxWezf
         F1MVW9ndvmjYxhohJ57oteOvgQJnvP5I6Nv0drwbpP6CYcyixR4ah/L7z0OSROvukNLa
         6TJc3RabQmk6e4CVmyu29PxjL8GfVMwGx3QQU3af9Va3iAxq8nwpFbH3i2xJm5e7ukRF
         ER2MCgyQ4VUkldb5JuRtdq0l9OCCAy+xFBDsABs0eCi9HSD2tKB5eGWCwrNGVKLx5zsX
         Sw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777587101; x=1778191901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CyYpr5DG2wVXaggugKyiSvcVLQEXsc/QvDPZHxp5lw=;
        b=nK9TmTpBmYlLeSbOj2xeG9gMK5q+uYR2zA9xYBHYZKWxrmCSXlmJKzUNP6CTKRUFbl
         0Q58mL6cUKP4/gGYPm4qVixHt3mijaCWmaZxw/qDX9OpjfkFhx7UL0AOxKS5H4VuV/2o
         Qjrg54UP71QbFJKf5U7SSIb8mDD6A/iv0nYob7recsRCwmxPVTzk+6aEptBONDukcH5r
         wLat/Bny2iUFqIkLESeDzP4oAlytr1yzZRnqMRkG/nDqawOm9A3AIg9TW2jd4ATMzr16
         BUU3+TwvLEXg/cHqhq/HPYVpih+I5w4TmyeL+qRLseiPYHvBIAdVhHW6ByMXVIwm8H2G
         UFJA==
X-Forwarded-Encrypted: i=1; AFNElJ/NfZqfUYMuqmWthL5yLpuzav+RsuEvqxCdu+vNYdzOqZ+xdwWU05eqq3aXhXqblmjoI6SocthnZ4DAXqzEJRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GrqttZOLJgex8Pwv4/6CN6gm2rwSpZFqmIDnQZ06t8GZi+6F
	y9Rezk1Atz5H4R+i1SDRns/FLTIz9TF4D12O/u4pT1369XmlqMcSqNU8
X-Gm-Gg: AeBDiesOq34BtoehGV+fX1CxA9xLuuzfR5TfyEdpZ1Ho/TFC7Go1u0xY0d4hCwn6VM6
	OUUGkAP2T7I9VNTLtHXrYcB2lWuA1SHe08CpiZpyFj8HjhIhjvaF9eUJ7L952YzhHWSXqDhvwv7
	1vW77fJKlR7t5VvrkP9/7SYmy9xkGjcIgf0CMwV0CPn7aRP3MsEwUz+/drunxcQ8KjUt23gDxmb
	x+8vAhre7qAeh5Mt3EqhM+DvRFLS3nlt6F8NvWYLpA/TIVi81LIq2mPMRm6EzB3wswyk/8EYXsm
	XYUiehZi+yAAyEfXLg7vbFOZd3+/57H/24qd2sTUG4zMVO5DtHHnJXPOWPeoTtm10HL0gFTfId5
	OmAes6hBU6p/914hpDwoTMkWwLjUi+6s6pRIgUmcP30u0zxdMaF/V5hHaFvg9pfPO78J/1RT+do
	7LUfqsgAbh8OeNbwNmib74siikf094sMIVJdu55JLC6ECZsYswvzFHS5AMoOGv8snYFz3wgA7De
	N771h5GJR+ajog8Mi6O+m/fEarDemPulUgr+fMohQgg6qa8TDq3bGt4
X-Received: by 2002:a05:6a00:299b:b0:82c:1cd0:2f7e with SMTP id d2e1a72fcca58-8350017cb7amr4240028b3a.20.1777587101053;
        Thu, 30 Apr 2026 15:11:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515838b34sm626013b3a.4.2026.04.30.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:11:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TI...),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] firmware: ti_sci: simplify resource allocation
Date: Thu, 30 Apr 2026 15:11:23 -0700
Message-ID: <20260430221123.79947-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/firmware/ti_sci.c              | 7 +------
 include/linux/soc/ti/ti_sci_protocol.h | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index e027a2bd8f26..04d99c1fafa1 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3574,16 +3574,11 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 	bool valid_set = false;
 	int i, ret, res_count;
 
-	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	res = devm_kzalloc(dev, struct_size(res, desc, sets), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
 	res->sets = sets;
-	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
-				 GFP_KERNEL);
-	if (!res->desc)
-		return ERR_PTR(-ENOMEM);
-
 	for (i = 0; i < res->sets; i++) {
 		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
 							sub_types[i],
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index fd104b666836..7632bb11c862 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -599,7 +599,7 @@ struct ti_sci_handle {
 struct ti_sci_resource {
 	u16 sets;
 	raw_spinlock_t lock;
-	struct ti_sci_resource_desc *desc;
+	struct ti_sci_resource_desc desc[] __counted_by(sets);
 };
 
 #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
-- 
2.54.0

