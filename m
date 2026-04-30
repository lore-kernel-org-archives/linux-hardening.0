Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FD336897
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585955; cv=none; b=B8Uap1pQb8QALRTqaF1uMVazehogKdwZOmM0EXHLItBVDiEO2z+4sJVbh5ws3Vnk2eF5EvMzJMGJHQvdIMO6Z4q6x52zugWlTWM+hEHZFx3PCNp1HRf3hLFDRsnoPq9GbGzhFMdeLqtVXtfjxfIYddUGFlbCnWZGv4+lCpVaDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585955; c=relaxed/simple;
	bh=D4oNtYz2t0TWPUHQ3j4VxlVibUbLuw6I9Vgy0rU4DVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCpR0D9lLZ2BiEoEQdO0PhkyJoR7YZ+LjN6qXXXy8PJe0gkyDWBMVQ0ggjpDOoCa8IMFFeE25ncWwuo2B4Jo4uiWOzPk1OQFf2SDE1WQWpG/yt/SVJ65WRf0Hm+nrnoKj6Pmy0Bb2VLQ96/oLRZQ9YaTUnG66WkIVmJlyyuDXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp1b9lwA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp1b9lwA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-362e50b4641so869275a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777585954; x=1778190754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAYkKhsjHuqfxlTreMjHoYYadz6X7z73kaUVyiEIU04=;
        b=Hp1b9lwAnNIFSze7sGC+dNpZfqYg3cvkmVT7CYR+Lt4zicT4QOfQpvc3edtt+500Bm
         uokRhFLlaW09S1rTmWFpIVsj04WBMHJAGAplCfBlPUa4qQqajUvNFPp8GscrqevFS4dD
         SP5c5Lk2ZAHH6SbWdQCCzr4iMBxjXjGmDeTtzqdSgz3dasYWHD5E+9jZFXRBDLIbHUZE
         Ht7sEAr37bdF4VFECpi/HPsUMOtDjZZJBmXrVKKsW464FzYE7AgTAO9PLLT+j2M6h/Gr
         xh/lm1zQ12G8NC56X/WsvF4ek5d++8S6qprjj7Of7yfzgXwhNFiAmUIVBq0zbpnvf6W6
         NGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585954; x=1778190754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAYkKhsjHuqfxlTreMjHoYYadz6X7z73kaUVyiEIU04=;
        b=LZqy/uMPmxRv4c1JdKpYRL3JXCTodfjhyWC49kNK/WIl0L3AAr4kblQ559+kSt+hY8
         F9rCdE04yAWw89GBzSoBfCxTAZW+4aFc3w6bYxSTDg9omSsV2yEtGKcfg4HNCNZqTe9E
         mQZKOI4oOJno49aqTO8ExBDlUBkjkZNG6Kfqr52d8olct9ncj49vRyCt1ZtV7uY/2pwo
         l0Vo64gKrvKU0y0wiZiECPxPU+zRVLkSpHXjYDiWfjIJIf0BJ4T7GjM+SVLdazrP4mg7
         bJW+6fwSKfWc1qmM8rSwAT6D5jQtDgPg8Ig8xHRd44d2COFoqUlJXWqPEVsXZ5DDB16/
         gMJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FnBILx+Ulz9Veno7LcfkK83SqOS5FsmjnDFrLHjIJzMN1UGiHwQcigmJYSYqKZWWA/VVh+x0v9MRI6wEvXZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGWsFFuTCgBok7zeF1O1q4cbdIu7LkeKkKc+60snV/Yweh2v2
	bBZKa9c8+4DllBmhZ3Jp/TZ894af1HNvRZ9sX9NWZIa2pab7tzG2Apmd
X-Gm-Gg: AeBDietpQrmKUTleVtuY9tnEd83fukYlFh7s3EdU6vpcIGf8mJYWfmFjiyRWemJBBWz
	AgFwWX3f9cYO50C3gYHdwpx9CxPNzJujLmL/AUYV5R1WG/AP4Hrfo9YBfJHTWaF83ds49YjrB80
	F16Fka7dc0JVMG9vExS2X8nhc3f8EkAgRlJPnQ+PNcq8vhSvNEZ7dOJBdWbuEIVQ/IW0tad3fqE
	XLQYN/p133figOTegxOohjvzA8HRprKSkDMFBwh31lx4uKvatzGLgJ76I7L+2EgRyBhAMWDQ7N5
	tSQCOTY/9ZpNbXPNZVAhltRuaDmtfl1t2WYeD05BrqRxiBq8nT7V3/mmSCUz+qeU0NYpk7kYJVz
	89XXZ4SWKW8r448v9FKkQgBnxovicHGob708FpiwqU3v/45dzBkPjXxYysXn/yxUA0Ae+tjExhi
	QvoZb+xdpe445a+hgwoepY/IxTk28IAsejn76Gq4G0tQdqYYoUJtWEQcKz/KRN4A3oESlxAc1Tz
	cUHyUFga2reoIXH9/jsqzIl3iOrNMSD6LMllkOzPzQZCQ==
X-Received: by 2002:a17:90b:1a8d:b0:362:e7e5:a20a with SMTP id 98e67ed59e1d1-364ef34a965mr272407a91.4.1777585953731;
        Thu, 30 Apr 2026 14:52:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be00b168sm3697703a91.12.2026.04.30.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:52:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] EDAC/ecs: simplify allocation for context
Date: Thu, 30 Apr 2026 14:52:16 -0700
Message-ID: <20260430215216.65803-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/ecs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
index 51c451c7f0f0..f0833080c5cc 100644
--- a/drivers/edac/ecs.c
+++ b/drivers/edac/ecs.c
@@ -33,7 +33,7 @@ struct edac_ecs_fru_context {
 
 struct edac_ecs_context {
 	u16 num_media_frus;
-	struct edac_ecs_fru_context *fru_ctxs;
+	struct edac_ecs_fru_context fru_ctxs[] __counted_by(num_media_frus);
 };
 
 #define TO_ECS_DEV_ATTR(_dev_attr)	\
@@ -149,17 +149,11 @@ static int ecs_create_desc(struct device *ecs_dev, const struct attribute_group
 	struct edac_ecs_context *ecs_ctx;
 	u32 fru;
 
-	ecs_ctx = devm_kzalloc(ecs_dev, sizeof(*ecs_ctx), GFP_KERNEL);
+	ecs_ctx = devm_kzalloc(ecs_dev, struct_size(ecs_ctx, fru_ctxs, num_media_frus), GFP_KERNEL);
 	if (!ecs_ctx)
 		return -ENOMEM;
 
 	ecs_ctx->num_media_frus = num_media_frus;
-	ecs_ctx->fru_ctxs = devm_kcalloc(ecs_dev, num_media_frus,
-					 sizeof(*ecs_ctx->fru_ctxs),
-					 GFP_KERNEL);
-	if (!ecs_ctx->fru_ctxs)
-		return -ENOMEM;
-
 	for (fru = 0; fru < num_media_frus; fru++) {
 		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
 		struct attribute_group *group = &fru_ctx->group;
-- 
2.54.0

