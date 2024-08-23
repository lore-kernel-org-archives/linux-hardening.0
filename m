Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B6189B8F
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430922; cv=none; b=GPe1uU0baiZWjWlRKVF2SOFLQ6RhuZ5AGMuKA5+ZCqETu6YHQVNShdSfGx4irjsiFfLwWhesQs3dKO9MPGWV8gganrK1/RUHxl8SStmLDGQi4c+ORfKIH+zRavVvanfFZRYLv4SSyaqy1bKx3QjQopZhZ0SY56bqgjNUMiplfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430922; c=relaxed/simple;
	bh=8RdcJvVv3gShrKDsP0JLU8Wsg0kuGNpupzjo7uvrHe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oA54PdWDG2AjUc5agVGJ2jyup71kvGJqMhweG0GlBVAtY1G1Vt415JxFLIhdFHga0S+fs1PMUvcslSXRp9qGGpyubb0ZEBEcylSka87qMs5ZA0Iyf20csO8lrRXMlyiKopjZkYXH6Nx7Orb7l+M1U2V0z2sKByPz+GgmKfAGuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lfOoUhxn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lfOoUhxn"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53343652ec0so172038e87.2
        for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724430917; x=1725035717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjrTEbgn235rhvAj96iSdJKR0hzx2vUIB4UjFS1NRO8=;
        b=lfOoUhxnIojgZ6SKsAbGEr0AGMxptBKWzy64KxtZF1u7/bI4w5AVQQe19u95IjRVdd
         tsJvB5KaR+sgUGidRUnnG9CHX5GQcHcl2sZeCUxH2vkg2BphVrspHnYhEI/nZ65WmH4m
         XDy2ujWGuz3XqCgADC/1CrY1DpSjX3yRrbAAW73Hvj1nrBWsefnsfwSRs73b+WUuDttY
         EKI5/7zpjg8sPkDGfAd3v4RvlHjkfMxhTwAgc7prV+lVMc23YfoZ6I+XX344plcGM/ES
         eGivgesTG6YkMfzZ38oeV8v8cvJupRILh13Gv6HMpj1YA2Qi2vw0F9ko5PDNz5hBspE2
         AyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430917; x=1725035717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjrTEbgn235rhvAj96iSdJKR0hzx2vUIB4UjFS1NRO8=;
        b=IxbSptKy4WWND6O8LH7ygUHXrUOkdNuBLORIUGBmV0A2Bx0J2cPxxp2jpJQrFSymfI
         AV+zwv6SE94yhow5GMgzfUI0OSJvV5yOFyCuuCJv1wzaPWyye4g2BMSCYo48Y8skEXCD
         pbaOvWmjBKS3S4RfxtmkEXwV6MzJHSMs0wB8TxbKOoyuQGcwb4rmk823a8K1xCVDTLx/
         trgG+cco/l40TL3FfqAFOXKL5WRx99UJhxMK2Hid9g0lzqIqr1SiWSKHFHWCDfagfDri
         rzo8O9H7Xb08G48nnYf7byADIU09AS4YLi8+Q/2RqoKG7bMuqGuG57RklL/eFixT0b2T
         Wlug==
X-Forwarded-Encrypted: i=1; AJvYcCU3rhJv7D2mx4UteGW9BScbCkwguuAldygTvIgvLd7u65ffV4v7qDq3PUyzaBhT1ovkGB402W1PuOhFMZpcoqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMkeUhkRgHgsIIvooIcYYz3QOcF7nvNwkQ/Gl3RCpkPRnpHbv
	AftDVdq8usvKtS+/eN9NT15VfUTH83HywDi5y/3DfMDuFcC09llmWhBFrldboho=
X-Google-Smtp-Source: AGHT+IEG+5HzmoKtxYv7K5mHJzlZfGPcBhD6/5HldN1KYcznaq5LdMfnwge5FilF0SAzHPozeP4Adw==
X-Received: by 2002:a05:6512:3ba7:b0:52e:9b87:2340 with SMTP id 2adb3069b0e04-534387be0d3mr1104239e87.6.1724430917206;
        Fri, 23 Aug 2024 09:35:17 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5dcsm282423166b.172.2024.08.23.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:35:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org,
	gustavoars@kernel.org,
	andriy.shevchenko@linux.intel.com,
	mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
Date: Fri, 23 Aug 2024 16:59:33 +0200
Message-ID: <20240823145931.107964-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment num before adding a new param_attribute to the attrs array and
adjust the array index accordingly. Increment num immediately after the
first reallocation such that the reallocation for the NULL terminator
only needs to add 1 (instead of 2) to mk->mp->num.

Use struct_size() instead of manually calculating the size for the
reallocation.

Use krealloc_array() for the additional NULL terminator.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use krealloc_array() as suggested by Andy Shevchenko
- Link to v1: https://lore.kernel.org/linux-kernel/20240823123300.37574-1-thorsten.blum@toblux.com/
---
 kernel/params.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2e447f8ae183..5f6643676697 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -551,7 +551,7 @@ struct module_param_attrs
 {
 	unsigned int num;
 	struct attribute_group grp;
-	struct param_attribute attrs[];
+	struct param_attribute attrs[] __counted_by(num);
 };
 
 #ifdef CONFIG_SYSFS
@@ -651,35 +651,32 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
 	}
 
 	/* Enlarge allocations. */
-	new_mp = krealloc(mk->mp,
-			  sizeof(*mk->mp) +
-			  sizeof(mk->mp->attrs[0]) * (mk->mp->num + 1),
+	new_mp = krealloc(mk->mp, struct_size(mk->mp, attrs, mk->mp->num + 1),
 			  GFP_KERNEL);
 	if (!new_mp)
 		return -ENOMEM;
 	mk->mp = new_mp;
+	mk->mp->num++;
 
 	/* Extra pointer for NULL terminator */
-	new_attrs = krealloc(mk->mp->grp.attrs,
-			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
-			     GFP_KERNEL);
+	new_attrs = krealloc_array(mk->mp->grp.attrs, mk->mp->num + 1,
+				   sizeof(mk->mp->grp.attrs[0]), GFP_KERNEL);
 	if (!new_attrs)
 		return -ENOMEM;
 	mk->mp->grp.attrs = new_attrs;
 
 	/* Tack new one on the end. */
-	memset(&mk->mp->attrs[mk->mp->num], 0, sizeof(mk->mp->attrs[0]));
-	sysfs_attr_init(&mk->mp->attrs[mk->mp->num].mattr.attr);
-	mk->mp->attrs[mk->mp->num].param = kp;
-	mk->mp->attrs[mk->mp->num].mattr.show = param_attr_show;
+	memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
+	sysfs_attr_init(&mk->mp->attrs[mk->mp->num - 1].mattr.attr);
+	mk->mp->attrs[mk->mp->num - 1].param = kp;
+	mk->mp->attrs[mk->mp->num - 1].mattr.show = param_attr_show;
 	/* Do not allow runtime DAC changes to make param writable. */
 	if ((kp->perm & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
-		mk->mp->attrs[mk->mp->num].mattr.store = param_attr_store;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = param_attr_store;
 	else
-		mk->mp->attrs[mk->mp->num].mattr.store = NULL;
-	mk->mp->attrs[mk->mp->num].mattr.attr.name = (char *)name;
-	mk->mp->attrs[mk->mp->num].mattr.attr.mode = kp->perm;
-	mk->mp->num++;
+		mk->mp->attrs[mk->mp->num - 1].mattr.store = NULL;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.name = (char *)name;
+	mk->mp->attrs[mk->mp->num - 1].mattr.attr.mode = kp->perm;
 
 	/* Fix up all the pointers, since krealloc can move us */
 	for (i = 0; i < mk->mp->num; i++)
-- 
2.46.0

