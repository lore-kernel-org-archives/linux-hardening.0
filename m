Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C514F9D4
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416394; cv=none; b=D51IJynQ+QYly8dYBLDDQDnCalYMyf7UjrdYmUGtTRHgXcBrY8HUBYu+EehBXDZE9zc2eOPYO+hoOd7N77iY8rFd1Qn8CGqQkyfYXadZMWzVHrz1xAzYLJFCYTUn5Haim5KA4OdFkfQF5a5rorSKh5PkVngxFOkKgTTqWPFxFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416394; c=relaxed/simple;
	bh=KaWzfTx7aivUj5r4qnX69PVpWi6RJY06+4V84ASbd40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESJNEuRpouV3sLWbb7aEti3U0uCPkOpquxMkWsEQZkg5dTfNMdbnjGVxqIgzotHW0N/63+rNUyBLNakCgGFxUGL9xNNK/WHdnnUBUs+M/Teya1LyBWByQFx/lUa4fMjEM2GKPayaK865Dwxv1QkTz9uvlqG01MDSVuR6aM60DDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JDzLukDl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JDzLukDl"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5befecad20eso277535a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724416390; x=1725021190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze74uMNv/Wj8RDboLKvxC9QND1isMlgj04bWbL5LCXI=;
        b=JDzLukDlW9RM9kTleyicm5EbXzEmeIKaJUCbmqWtfAWh52qDNjDtmIZqDZr4ufdIIj
         /LxX/7Y0eVgzwXrcKJfgLLOM9KN3EwecZICaU4yUwTLlgbIkbGHW4tuXZUMpLJUPAL4/
         tUzo2L5yWYQY3F1L2K3QRAEGngv4Fkuxo9MKEbX0fZq2caNiR46j6ZoIPzxc3sHKs8Li
         p7IQRCioQHUd7EcImJaM63GDGZgphYFabZCsw5R2w8+3y6Dq3AHtqlH7RcC85od5gEXt
         tRbPVOHhkrP5pK8VUM8cMWeX+0Ro9IECuzk/wILfhoWOtP6Gq/QuZnl7y09uxwpT1LDD
         U+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724416390; x=1725021190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ze74uMNv/Wj8RDboLKvxC9QND1isMlgj04bWbL5LCXI=;
        b=eNzM66w/Gmkw2WNCszfcP8CH8PSP3mhyD7Tim4FlYFIYaINy8m70dBSK0Yt1H6HNEu
         Z0cpWOLa6/jynx+I3unjc7YtTM+TDJqyz+desV5CuC2V3g0MSFZyTkjMOopgVJW53kXp
         KbAE+urX6K/4tf5wABjHtqs9d1GV6AUDqwl65URpmzXTvGPfd2i7IY+EGvSvEQXBVOGL
         9GCSO+rKYxnwnpLsV8PJRUcp5CZjDB3ZXpUOLHqHZnY9S0tTRbtJxn+rWvqJmDB7lJoS
         /23zipgbVdhXZJiqZLMAYv+2EdVWDolvBO7esX5P5Xy1FzsAiFjVUg+E9rzFCDe4hVKh
         HYmA==
X-Forwarded-Encrypted: i=1; AJvYcCWah3tpdJUXZa+rMwWzfyoPABxRuqhua8/xijVbWjqJMy00/gVnxzTLDpHfLRP26rZt+HSe3hP1w1UH8jb38v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/O7jiyIzXel+mKUv2yi07mf4Q/wQTKPRt+d59790/T6XGOmsn
	I8iAZjHVv+nZ/Rahndj8nABZLHuiuAfYWvSyhb1jCBs9UiN1hwwyRPi2o5OeUHI=
X-Google-Smtp-Source: AGHT+IFi8C2ckvVTPaFMb3zoPvCuBmWultnoZJdb41ih83dnKe7kJzFBdBe3Ht+YJJpk2SuhYxJOug==
X-Received: by 2002:a17:906:c105:b0:a86:a4cf:a197 with SMTP id a640c23a62f3a-a86a54a8e30mr87749766b.5.1724416390033;
        Fri, 23 Aug 2024 05:33:10 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f437bsm252713466b.197.2024.08.23.05.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:33:09 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org,
	gustavoars@kernel.org,
	andriy.shevchenko@linux.intel.com,
	mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] params: Annotate struct module_param_attrs with __counted_by()
Date: Fri, 23 Aug 2024 14:33:00 +0200
Message-ID: <20240823123300.37574-1-thorsten.blum@toblux.com>
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
first reallocation such that krealloc() for the NULL terminator only
needs to add 1 (instead of 2) to mk->mp->num.

Use struct_size() instead of manually calculating the size for the
reallocation.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/params.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2e447f8ae183..160b66dbc0b0 100644
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
@@ -651,35 +651,33 @@ static __modinit int add_sysfs_param(struct module_kobject *mk,
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
 	new_attrs = krealloc(mk->mp->grp.attrs,
-			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 2),
+			     sizeof(mk->mp->grp.attrs[0]) * (mk->mp->num + 1),
 			     GFP_KERNEL);
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

