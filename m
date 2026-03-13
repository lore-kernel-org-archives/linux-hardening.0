Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427923B28D
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360400; cv=none; b=ovMrBOp7/ZBqvtrvnV2IOCwTduzx0EtBgmWcmI7fUEkFaxA2KEYQUJRFDXG+Plfk8pu+k5Y8ORo+sfhutlgZfzb6ur23B3apW3PXB3Vx+ImgVMAdpc78v9254tZvbeeTwfJcSfb4HIAU0KarRRWuZS755ImGwVAFHUmhOyS3G4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360400; c=relaxed/simple;
	bh=RNBDhx6SP9Dlnjslw2G6n/SBRm1RMP3mTWySGwZB16E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaDQF9KtooPoexVBiXEXQyKkUcgJTLS0EtQNl0P4NZWpwCfyC4tNoHzp963+VHuK5vGP/MuPajnYs1euHotyOuH4BS5SA6P7bC93ifepqlFJ2BMPgNwuVtMM2210n5UvxuLnXh6b+kvxbOEJc8H0dKArp3wPw5ELgK7jEj5h8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgbjLUm3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgbjLUm3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so983905a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773360398; x=1773965198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuLpHvR1fwObt/8Xvj3rrc9Oc9+CrLWMV9LCtsBGyrI=;
        b=KgbjLUm3nIeMZItgPA/7XBSfz/Ya6u1teNAkKqZhGdLX3XOwyA0cXv/b8CjvPfo9NQ
         DBrsKidCHEbeCpWs4qO5JY4anvQ2AuLb/sAtAEoP/CTDYZVMBbkEV2qXIWop+BGdLRsA
         m971uTr7hzBLZte4GLEA8Vz40/uE8kegf2i3mp5TnChtkstrBguh1LaaD5dRX1+R6QrO
         RxuknpeZPxq/QYkAzQt4m4mHCjQbVqs0WJjB2o45W2ZAMxeBNn3kIzm2Cyxil6FXbrH0
         J9dgyQP4izr3NIiHKLkWvlIeZ2n9dUnFP2slZOk/NSN+w9/lTKtQ/nHaZveiQer0CQeN
         EwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360398; x=1773965198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuLpHvR1fwObt/8Xvj3rrc9Oc9+CrLWMV9LCtsBGyrI=;
        b=CDrwqlvVCB/C3a2f6u8pLuOVbts4VrtTC274eqCi5Osq5R5hpxkYpoJRku0WNF7xER
         uvaCarz17mDjiaXr2vCZ3s38/3THTaJv+9lKnIpO46SmdkJWHapid9CEL08PPgppuBE1
         LOcSv++SFhGxT9HoHwOubqujCheA29FifdcoIxQXvFJGQaS+ElqjxQ7tKpqkA814QVQO
         PdlpWWwx1T4ivQ3s2r4/Ml4mGqYz0ro1OqQKFu13rqMcSs/bk2Gup5n6pQOTTset8e3V
         wAFATW9LvL5pjYQmIAFFQffAe42+ftIRKvXPeqqy2HGZp7rKcwnXdVP9RzuQuI7Xvx9K
         JeRg==
X-Forwarded-Encrypted: i=1; AJvYcCWQvbLjLUA/chs/3hIVZbYRcA6SAC8FfRPj/qv31IaYr72W+m15vYPKIXKY+5TyjL13Kbt2MDIVck4R6V2n4Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhaptyjyUXbubSj20fAbYSi+vEoVQRQJQzM+53IcSpEZwagWr
	7zIJhsPKi088O4M/ylzJGmCC5TjBjRzV6kasgk6UQSSn7C128ElhUgQE
X-Gm-Gg: ATEYQzywWLlH1PFLZz7EaP/L0mQIhu+G+9eS7u2TDpukBxE6PM2kDjbVhUrpLosMkgi
	jWrc1lg5Ko7xU6ButHH7mfjNITq36HvDlR1Mdp61joAdP1zJnTfkm8S5DbmLjlsefkGAWx/mDiu
	LK+meMnwA+PBIuE6zQZSRmenqQBmZc9fK2qwT7yYxzrimaOs4l2brdHemOz9RsVz+/EBOzYeSS5
	wiRo7iPZttCxqss04i9oDquLKpR6JQvz+RMxzuILEqm3rCUDUPlEGtHYvKoGShWDxqjzVrw3XXS
	g7O4n3YmvZsknfuNOzkMSoW4x/pu9i/D7Vnh2Nnw6Jee7NH3w9kv4qvrVoilmhQrnl01dM2IElh
	nTSkaDKfnd0/jzA9UL7uLCvUCeyMYHc/BkTGxpZ1Un3/uYQx+JKzbJjtouBWcvm/YALS14mezWg
	dF3VPI5K/6/cbHJp7RqyA9TKeZmj5aYokEpscGfyrC0r5eAFqlGkTxpg==
X-Received: by 2002:a17:90b:3848:b0:359:f2e1:58fc with SMTP id 98e67ed59e1d1-35a220cf0ddmr1186924a91.30.1773360398558;
        Thu, 12 Mar 2026 17:06:38 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a07f0a365sm6192261a91.13.2026.03.12.17.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:06:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] drm: property: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:06:20 -0700
Message-ID: <20260313000620.117065-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't allocate values separately to simplify allocation.

Add __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/drm_property.c | 14 ++------------
 include/drm/drm_property.h     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index f38f2c5437e6..a6008e5c2b58 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -107,25 +107,18 @@ struct drm_property *drm_property_create(struct drm_device *dev,
 	if (WARN_ON(strlen(name) >= DRM_PROP_NAME_LEN))
 		return NULL;
 
-	property = kzalloc_obj(struct drm_property);
+	property = kzalloc_flex(*property, values, num_values);
 	if (!property)
 		return NULL;
 
+	property->num_values = num_values;
 	property->dev = dev;
 
-	if (num_values) {
-		property->values = kcalloc(num_values, sizeof(uint64_t),
-					   GFP_KERNEL);
-		if (!property->values)
-			goto fail;
-	}
-
 	ret = drm_mode_object_add(dev, &property->base, DRM_MODE_OBJECT_PROPERTY);
 	if (ret)
 		goto fail;
 
 	property->flags = flags;
-	property->num_values = num_values;
 	INIT_LIST_HEAD(&property->enum_list);
 
 	strscpy_pad(property->name, name, DRM_PROP_NAME_LEN);
@@ -134,7 +127,6 @@ struct drm_property *drm_property_create(struct drm_device *dev,
 
 	return property;
 fail:
-	kfree(property->values);
 	kfree(property);
 	return NULL;
 }
@@ -447,8 +439,6 @@ void drm_property_destroy(struct drm_device *dev, struct drm_property *property)
 		kfree(prop_enum);
 	}
 
-	if (property->num_values)
-		kfree(property->values);
 	drm_mode_object_unregister(dev, &property->base);
 	list_del(&property->head);
 	kfree(property);
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index aa49b5a42bb5..8c7cef4418c4 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -175,14 +175,6 @@ struct drm_property {
 	 */
 	uint32_t num_values;
 
-	/**
-	 * @values:
-	 *
-	 * Array with limits and values for the property. The
-	 * interpretation of these limits is dependent upon the type per @flags.
-	 */
-	uint64_t *values;
-
 	/**
 	 * @dev: DRM device
 	 */
@@ -195,6 +187,14 @@ struct drm_property {
 	 * enum and bitmask values.
 	 */
 	struct list_head enum_list;
+
+	/**
+	 * @values:
+	 *
+	 * Array with limits and values for the property. The
+	 * interpretation of these limits is dependent upon the type per @flags.
+	 */
+	uint64_t values[] __counted_by(num_values);
 };
 
 /**
-- 
2.53.0

