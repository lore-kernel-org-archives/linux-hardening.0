Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F78ECE79D0
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 12:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjITMiL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjITMiG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 08:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E276C2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KRPqkETTBVBC/zv1aXEUiiiXJ1Cft936yka0iGNazc=;
        b=Eg5QpVsAGXnsxPUSYUd83qQDCe+CjuyX/8eN3W5aMh/A0ReWb38QLEdVALoAjcuDNpU78k
        JVE2Oru1pKkOWiM0PZsixYAIxjQCoHlzdliCKZN5KS6Cbf7bhcV8IoocUvjKSXijNRTHMe
        nDV3cgvhMUpAxj0jlmNGri5uFM9nAro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-KkuH6KHsNWiQ4UmGMU9NrQ-1; Wed, 20 Sep 2023 08:37:10 -0400
X-MC-Unique: KkuH6KHsNWiQ4UmGMU9NrQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-404fc59b8acso13443795e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213429; x=1695818229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KRPqkETTBVBC/zv1aXEUiiiXJ1Cft936yka0iGNazc=;
        b=bgZe4vWU1DHozbEHjjm17MVsi1RH/l/GX8IIEiIsDuXKkjtxek2PoSJtdDCUkhCo5W
         IUV6nEavYGYcNJVsb/Z7LK8N7rRUvqHReFos7NsbZngrUL0pgoe6FFXelvm16Pq0HiY5
         nsHJNwP6CmK0Bq1MhZDby/29qVnwwhJDF9D4w7aGucVjvkgl0SSiepeh4HTwzF8Yi2Ko
         mondCnFaCrbyUkuaGobIrS8Arvm/g3TFeD8NXwqZ+WkxP9PmGcx+ONkZn6UURoZyfXv0
         /QY/WRXtEvnkrc1czt0nAJM6+NzOiCwz6xSePngXgh3LRiZmYPb59xhMLp6/4uN08WfB
         1N3g==
X-Gm-Message-State: AOJu0Yx7HI9Ofj43LjY5C9Q/bLAHuYFpVo/s/SbuGr7f9HhYtcSa3eGl
        kz/VOplJYmPkA49sdMqLHl+PpDxlIbKDR856pTR344cQ0ctADl+WIgo4Gl49O93uESEdzUFrZBw
        b4W25vbsOTRniP81oCbsYuwOLprc5
X-Received: by 2002:adf:ec48:0:b0:317:630d:1e8e with SMTP id w8-20020adfec48000000b00317630d1e8emr2031479wrn.2.1695213429376;
        Wed, 20 Sep 2023 05:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorWXFxi2CZ+i0Bq4z7I+sy7K13wS44rMjIuskory3+gtAyjUda2GeiUfH2k5vq773C10/rA==
X-Received: by 2002:adf:ec48:0:b0:317:630d:1e8e with SMTP id w8-20020adfec48000000b00317630d1e8emr2031462wrn.2.1695213429120;
        Wed, 20 Sep 2023 05:37:09 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170906f88d00b009ad88839665sm9297787ejb.70.2023.09.20.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:37:03 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH v3 4/5] drm_lease.c: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:12 +0200
Message-ID: <20230920123612.16914-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 drivers/gpu/drm/drm_lease.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 150fe1555068..94375c6a5425 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -510,8 +510,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	/* Handle leased objects, if any */
 	idr_init(&leases);
 	if (object_count != 0) {
-		object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
-					 array_size(object_count, sizeof(__u32)));
+		object_ids = memdup_array_user(u64_to_user_ptr(cl->object_ids),
+					       object_count, sizeof(__u32));
 		if (IS_ERR(object_ids)) {
 			ret = PTR_ERR(object_ids);
 			idr_destroy(&leases);
-- 
2.41.0

