Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5436B931
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227940; cv=none; b=nuWlPosda/u8w50rb/1ByxDjq0W4Tgx+s6esyOy1WaYyMeGZAQ3+2dSlKNejwxIwmrX2QMcYAw2UrT1NQHQUfRyQVbXjhwcpPO/Sf5DKNlBrvkBIgLpS5G+ANbf+5sIi481YiXBF099/IXzSoDxfriqhf9SodAfFc8YZBk/fGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227940; c=relaxed/simple;
	bh=Qef6evUi2G4yjczQH3lndRw0J5twWf88Bw4M2ky/1xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJdh/CMJll+DKxypxPfT8g2xuz8qjWArIGBrQ9alO7+tFOKvSd6s9oUzdnALA6XMhXqXUQNaCm4t1Hf+sR5OCRHPyg/rJdJmIVujKVHax4O2egyAwwnzk6KPmyR/9QQBCcfUG8fVmEAalzVjAlGNTm4n9uyPO7sv/5MZiUguaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6Nom2Oq; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Nom2Oq"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1023174a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227938; x=1791832738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn5bbgyZyDecjZPI18WaWxFgg4DefMuMpoggO6iLfzw=;
        b=E6Nom2OqKeb0lOx1wzcwdfCeJ1k+ThHWcEvXJe6niQbuR9z9i9jZJKjYefnm1yrXQ/
         xMp4N9ct435Ah0ShYAa8lmHKe43TzIJgikCff97NESmHfuSttM/N8vldSD5tOUdJLLpA
         iclpHd0C1iHseXXAD3OrZV80KS0aMoVRPoNFu7slRU8n5uAsTLeLwgMf3kqYUa6OKiAX
         GyLcwAx6K9ExYTLijk3rfmSjbn49aN8IldvDtb+NJdC4hpF7t6cX+6g9L3DoYF5tDnTZ
         +t+65DPB1fsr1X6Q+ZrX8yFVEkW7C+C7OLxvzHSvtP8cYTcSgvuX96v1SHoDeliyp5dI
         MpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227938; x=1791832738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn5bbgyZyDecjZPI18WaWxFgg4DefMuMpoggO6iLfzw=;
        b=t/pjUvUHRZ4qI3sfAfiyyIOMjLWJMKiDEJEiEY2QgeCxGbtWQGGYcgAYEkpynjLIHd
         3Up9r1gGm+4XsqxbHVtDeDpCdOUzYm2BKCKSMa4mrbeKJtfePgGKOusvrHriD9c1q2yO
         FNcRTVqMYhmJMqnEtOMM2KvNN8qShQbQy11eB1AAtF6UjImR0Z8Cp2/BQP11kBplLO5h
         E5+4Q26LlkE1rL/RBislAQV7XIv8cmFzxgyPS1AbkmVix7jiSGH2WQseTqBdBt2YFrsW
         Pf5mhtnVfS9EE30kNpnQWDYTk4sOT5t4L08EWg4mWlsB7aivmd2R0vrHJwQ4DQFtxmwy
         PBvg==
X-Forwarded-Encrypted: i=1; AKwUvByawe7LMODBGoH12VFoa9qE83b25d0uWo4e3ecI++QQnamwKJljrZKBTCkoAtOaVh5ZQgbYjqd3/eL6fD/K0a0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPLXSgPW25/AvcUA1f01LGDdHvzKwA4UUMRtGEOTW8JXrnp4Do
	Bztm2TDbw5RWat7hJhqafCSvzkwrFy+UMFl9W/TdWdBwUSECXtcMFbcQ
X-Gm-Gg: AYBFou3AbubYulglFfCEoSZriS3mMLHt1GusiLliQew4xVDPtHsZnU9F1s2Nal6jcTN
	hTfMmyxye1vEP5bbBcrZiXFZya2hcN4DXY4akHZ2eRUr20VD1xxxFKo960uOBjbDUH/wxDEwxQb
	WPswBxyDeWWYkTx0fDY4UA0u7YGWE4zhXrQcG/eSNFeZVOOAqRug03Ci1bpBsbe/egRnsPIifhk
	U/re8v0K+1tN22djrjNie4O/s7qC/0QLcEZoD85mVeqKNn5mId4QfrmWX5X1IspZNReIpK4Q7Wt
	wbYEHJm2cMpNCQ1U26JQygGgtvNr/gVQIwctYoB/iiLZJ4r+u+A3aQ8efdrIqqMR/ckjbLUSL1r
	U/GZkO8NfodKl26bZf9tWramVZMUKVjc4NODvxXtOhChJv1w04a84CjA5Vq72MDapVpvQTrqqbd
	vSslnRKRNiWw8GDHJpf5Dx4pbZaYd5L9PIid0ywsXUJ1fvcanrL/oNxuoqDFNsUcb8+hMIEYIoD
	8aNsEws2ilPCi0jO2to0Q9En4m1GHrRMMFzpRapchiTdmFPySn9GrlRaHgTMqB4OG/0c06ChWEE
	B6NfKQ9SgzCSbmuQ5ZLx1yu3sn04OWnmDiS1Cz1KbN6sjFKz
X-Received: by 2002:a17:90b:3843:b0:3a4:fa1a:2b1d with SMTP id 98e67ed59e1d1-3a6ce983720mr9469973a91.62.1791227938253;
        Mon, 05 Oct 2026 12:18:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85436a39dsm806267a91.9.2026.10.05.12.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:18:57 -0700 (PDT)
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
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v2] drm: property: use kzalloc_flex
Date: Mon,  5 Oct 2026 12:18:56 -0700
Message-ID: <20261005191856.90267-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the property values as a flexible array member instead of a
separately allocated array. This removes an allocation and its error
handling.

Add __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

struct drm_property now ends in a flexible array, so move it to the end
of struct drm_damage_mock in the damage helper KUnit test to avoid
-Wflex-array-member-not-at-end.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move test struct member
 drivers/gpu/drm/drm_property.c                 | 14 ++------------
 drivers/gpu/drm/tests/drm_damage_helper_test.c |  2 +-
 include/drm/drm_property.h                     | 16 ++++++++--------
 3 files changed, 11 insertions(+), 21 deletions(-)

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
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 0df2e1a54b0d..c0da8dc591a9 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -17,10 +17,10 @@ struct drm_damage_mock {
 	struct drm_device device;
 	struct drm_object_properties obj_props;
 	struct drm_plane plane;
-	struct drm_property prop;
 	struct drm_framebuffer fb;
 	struct drm_plane_state state;
 	struct drm_plane_state old_state;
+	struct drm_property prop;	/* has a flexible array, must be last */
 };
 
 static int drm_damage_helper_init(struct kunit *test)
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
2.56.0

