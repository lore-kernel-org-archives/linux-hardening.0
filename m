Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E92C87A
	for <linux-hardening@vger.kernel.org>; Mon,  9 Sep 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899333; cv=none; b=Vy18A36qg3UG6QeNwWUNTJl6/PV4PE/cbAHMStu2w7xS9AvU48Y0vC3ZJj9XhfyPXxjMGOkq9J4GPa7cd+E8XyHq/j8ZSze7wNYOlGSDoCfHdfkbC3Hvu8f6D0t+gTcj0kImsmbl7O2vMSXXpt0IuiZwpodTnj/XSNeBU7fL9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899333; c=relaxed/simple;
	bh=8RdcJvVv3gShrKDsP0JLU8Wsg0kuGNpupzjo7uvrHe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnjeVcJlXOVCIQcx7w2gveiekuuEzHLrhGCOR6tvmH5S9M26Q637LQItliCpb4zhUl8ivNMBUsjQPQpZ8caWOHtEYeby5ahJUfvHJGSP8BEiE1Q5O29ADYDesKPvB0eTcv0I3mrP4uoj4mrjHofeKXyBcp+C24j/tiNDcVe8ZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=0mCeY7U9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="0mCeY7U9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb0d0311fso3131395e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 09 Sep 2024 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725899329; x=1726504129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjrTEbgn235rhvAj96iSdJKR0hzx2vUIB4UjFS1NRO8=;
        b=0mCeY7U9+v8Yaxk+q7lB5Ts7Hc1XKx75LhJs4qILill8Ly9ZDkqZfrcgSzkXDTB5fz
         dPJErt0l4vGGLZYOnfk+HVbBs15fxIKR/Oc64B96oWiWKT/AGY9dOTWnGm98/M7rMLd5
         7Y2+XoYvpgnf7N5Lbfj+AtlYC8kOmcSm05hJt6IBGfVI5EiKV4PYxhTFV6ijZKZvNoW0
         MJeL+crYTJBSxHGcYgmqTDjp+Kz3L0fWzF/uEjuyT+cqAs/+PKL4xMkjUSfXEwtG3yry
         k7GapwyGu7p47uWwd/6MAUd9TlIxNjhRCL6kH5vBvznE6BmkeNOPq8rjz90XC2nstxrM
         yHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899329; x=1726504129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjrTEbgn235rhvAj96iSdJKR0hzx2vUIB4UjFS1NRO8=;
        b=G6Y6QLOMij8HBctyPForUN0tfUO1xiYIZ9Smx1qB+ct9zd29Zwx2wcwEne1Ay4DRvw
         G2BO2+pZ9IVpLM5ngfTCFEXZpog//HCtdX9Iwz3AGPdoSy+nZmi7Ao1qWRUVK101u42k
         bBU31rIzSut26zVeWL6yQD4aJy7P1lNdTC3+0x5Pe+aq/p/wNOryUuMSD76ZjB1Bdczv
         NITpm+iw1iPHm3bwXGx0DFlvImIBpMeAxUGvA7u6ETIGS+iw6Ce9k/CfGdNbeDidxrXL
         t1Zv4s+NjTQRkcw1r5TL9qJzPvqO7vfO4UlwxPwR4526zjB040XHqaTG3y+Xy861Xhrr
         8+cg==
X-Gm-Message-State: AOJu0YxQHmvCeix9fXHj1Nr05LSG8LG33kc6vJ9khm0YwTo9p4alyVCS
	MVk//cGDtoUvj323ON+rw5oEKbRnTuUfzad9yD5LJVjo7UFTkMTqFLo+uBz9r4g=
X-Google-Smtp-Source: AGHT+IHMA7sheFihP/wz+0UUpBWh26J4I+Iug17IMwFpurdhQTex0X62Km8uClHjOvSiTwLEzsQfGg==
X-Received: by 2002:a05:600c:4707:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-42c9f97bde0mr41860165e9.1.1725899329044;
        Mon, 09 Sep 2024 09:28:49 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-120.dynamic.mnet-online.de. [62.216.208.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8182dsm82078765e9.36.2024.09.09.09.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:28:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org,
	gustavoars@kernel.org,
	andriy.shevchenko@linux.intel.com,
	mcgrof@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
Date: Mon,  9 Sep 2024 18:27:26 +0200
Message-ID: <20240909162725.1805-2-thorsten.blum@toblux.com>
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

