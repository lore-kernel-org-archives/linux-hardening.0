Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE56EEB56B
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 20:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344482AbjIHUEW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344510AbjIHUEV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B3CCF2
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=c3h7XPFbBHsHy20pb8A3s365xSIrpDGHGQciJWa3bskMFGRnfvKGufr+/ulkkc+tay8S2q
        eVxu1st2JmHOf7wMMzLfeoUdKIdHVFJfc9HPiuEm2EQxj9D7b0SN/5jnTgt46BGETjkl3a
        kIRcVzIeyNNw+cvbbzkXwmSF1Wberu8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-oL7M8f36Pa2h0gd9_D5O1Q-1; Fri, 08 Sep 2023 16:03:29 -0400
X-MC-Unique: oL7M8f36Pa2h0gd9_D5O1Q-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5711c85f02bso414322eaf.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 13:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203408; x=1694808208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=lzAxyGlwxD9eFuRelHv3VIfecM6HKCrmAfAHQxSffOBFvdPD6s+hVPTG8cs9718ALB
         ydys3n055UxOzns2VpaEE1+jMuQdEwD9ZgzncdtYjBodK2QFaV5ialVYDyNV6jUzEt/t
         t7MdB8w5iOdU6I8+U6HOyUaxPrZKmQoL+5aEwMNoX1QzQQXtkeqGD+FwRTkDdJL9O5Bb
         WBgM7N44Y6x4EOF3zqJ8sCFpCefDTyR1ESL1cHvw+CVLMhD3pwJVfTtu0DHhJ6ExwjVO
         5zuZ2EFNu9jCQ24//wfNrykyLy+vOVyaYaAQ+UjhP0atSvcIZJzrdamYkhyEG+yhSPn0
         DIcQ==
X-Gm-Message-State: AOJu0YxJQYG+uEqbhSYwM9Vg+X1CZC/W81xCO7Y/A1mnVmh+7EcIuNGg
        WP/xjMD3DE8PXrGKKIo4yx9DdtSNURTpQWymEIWqZHGG5AeIIR+muQMPoXbLT820dUzXShGyz1m
        AJVqYG/mQinhL7pI9wpQutrlQZkk/
X-Received: by 2002:a05:6358:e9c:b0:134:c407:681f with SMTP id 28-20020a0563580e9c00b00134c407681fmr2557578rwg.1.1694203408125;
        Fri, 08 Sep 2023 13:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gCAzKUix7oIOcBNdjPHJEb7aCyOwwUAu2PzcC43CT3hwK4BjknICUG8MLI4Ii5zItWgaJg==
X-Received: by 2002:a05:6358:e9c:b0:134:c407:681f with SMTP id 28-20020a0563580e9c00b00134c407681fmr2557556rwg.1.1694203407699;
        Fri, 08 Sep 2023 13:03:27 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id x29-20020a0cb21d000000b0064f53943626sm971150qvd.89.2023.09.08.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:27 -0700 (PDT)
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
Subject: [PATCH v2 5/5] drm: vmgfx_surface.c: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:44 +0200
Message-ID: <3d2b36a2cf7bbff1b036f474eb805e19be3c57f5.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..9be185b094cb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -777,9 +777,9 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	       sizeof(metadata->mip_levels));
 	metadata->num_sizes = num_sizes;
 	metadata->sizes =
-		memdup_user((struct drm_vmw_size __user *)(unsigned long)
+		memdup_array_user((struct drm_vmw_size __user *)(unsigned long)
 			    req->size_addr,
-			    sizeof(*metadata->sizes) * metadata->num_sizes);
+			    metadata->num_sizes, sizeof(*metadata->sizes));
 	if (IS_ERR(metadata->sizes)) {
 		ret = PTR_ERR(metadata->sizes);
 		goto out_no_sizes;
-- 
2.41.0

