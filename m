Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96239C83F01
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbjH3S4g (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbjH3Nr7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93E1BF
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=P8qE/f2vYW1lb4HizM9j2XDFEQhHMfh1bUAhZtX/FCeny04h26NSrWWJJUiUMFeYX5OKKB
        zl4Tya8w0P62TRpiaxhJRrwCC9Z6WkJTH5IzzT5eJCmtOpWs4JapFSid9p9rZjxqejFQKn
        2Wnu0Tx8baGjYRcLKLO4zxqQueGglcA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-csP4xd6FMIKdJykTjt4RcA-1; Wed, 30 Aug 2023 09:46:38 -0400
X-MC-Unique: csP4xd6FMIKdJykTjt4RcA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9cca3c395so19428601fa.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403196; x=1694007996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=QpND67xlXdt81r95rL9Zi5YwrG5ZJw5mdBaLbCQCNygqH3gANFXL0SKyRzMYfbxxS/
         25AS4SE3ApL9FP/vyhKIRXHrA02x13Iqrk1SCBn+STDCl+PYmgVrR+GPDeYRIKEjWhHs
         Vr1wQOZSmMgD1WWd7S2zaRFlRbcoKR8hlcNwLlpzYT1pjgDkXWdDM6ty1lNBQMbtzbIQ
         MHweXRtKxz8XObd+ZizklarF1JIWf+l/JFrPsVs+iNy0mkqX3u8Qpm+1e6xm/lR6faZ9
         iu9Z1cmVKe3g8V/rrw2w3A02sDaklk8D8cF8ITDqx4u+mKnJ69jd0p0jxE4T36X7Zcww
         oLMQ==
X-Gm-Message-State: AOJu0Yw+sxDDcRunLFk5J6nSWGsmdpESF1zl52fc6psu/T1U+BHaYyv2
        ycLusJm7Iq8L3fER+QNcpGM9HIQW+0f4nhHB9uIRd/F6oZjgswixDe7lo8RLHco+B8Q59Y94kI8
        O10Eu1dhi3fjL1BjLglCARM6iRRbJ
X-Received: by 2002:a05:651c:1182:b0:2bc:fc2e:766c with SMTP id w2-20020a05651c118200b002bcfc2e766cmr1857347ljo.3.1693403196830;
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNBSsy/iFndvURQgQS9ZCnlQ9lW+9HBjOb1QIZNMn1l3Gt7cB24Ma8x0ITyx+CEVBlGHtj+A==
X-Received: by 2002:a05:651c:1182:b0:2bc:fc2e:766c with SMTP id w2-20020a05651c118200b002bcfc2e766cmr1857319ljo.3.1693403196642;
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id li22-20020a170906f99600b009a198078c53sm7167678ejb.214.2023.08.30.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
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
Subject: [PATCH 4/5] drm_lease.c: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:55 +0200
Message-ID: <34e14523c9cea13e2f63afabf2938c89d2e84776.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
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

