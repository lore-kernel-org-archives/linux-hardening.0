Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5211C83F01
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbjH3S4R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbjH3Nr7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C7CC9
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=OE5ECJrGM24DknbMl8BDqzUVlOCcJaJBNR/KILwZGxOcYr01HdpI6VJdrifdL6V86Y5v18
        Mp4Glq8+2pTE0ZpPoaFo5OQMLEuISOr7yTwc1oZxuMTuFrosIR1lkcHq6zE/nI64MertCD
        GNl8vZ3RMPx3aotlnrVz95m5v2yKuWw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-wbcwD7G-MOWfGeDCaFk8jA-1; Wed, 30 Aug 2023 09:46:41 -0400
X-MC-Unique: wbcwD7G-MOWfGeDCaFk8jA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a1aaaf6460so87012266b.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403200; x=1694008000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=UDauObjjtOLS/yevK4qTt3M6NwdpZqNa+XcKj5CQ2UApWCwhBL+3LmlSP9YUjOqb+1
         q9lYV6fnSCe7wNQr6JBG1SOeX6feNDn/gCcTgDRCNGmByp8sSYcYjL/eNBVd3Sm23oEr
         aYfJW07AghPkj+7yYhNPiw6jfgWKKRWqPZ+nJ1wqynSh7Bm6uyJH8oBQA0HvVdgVZG70
         9nzGJ7Vlin7rm2Yz0bPsm/L+oE3Jh75bfZSv7c2OJSM7sepG2j2l536zdQhnPaxyIJR0
         SfVZhcijgutxio/ZGtmuO+lLaapIplVqptRDI3q3NkUYAqD0ivMfOc4/dqz3DCraP4dF
         OpbA==
X-Gm-Message-State: AOJu0YzHHhSO8Mh9TJLviRwd1QcZebxg5AlsdxzrYnzjxL3V4PHFltJF
        +p3BmVi8E4WnDQqxbV/9Tem3eDN3EmBxWgW+vTn3CvYdM2bxirs7Qt/Fzxsv+W6KBxwj76Ux//e
        2ykTOnyZSrHq+FJeEhYrE96xuw3Y2
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr1574506ejm.1.1693403200684;
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFovveJ1gRkNa/hbpuOdO660EpmuFNfSfZvj7MduSJ07LTCEG5M6k7oeDfsA0MPBedrGa9vw==
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr1574480ejm.1.1693403200487;
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id gy25-20020a170906f25900b0098951bb4dc3sm7218566ejb.184.2023.08.30.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
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
Subject: [PATCH 5/5] drm: vmgfx_surface.c: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:56 +0200
Message-ID: <6f9397d6af919b7e8325c2945385c13aaa3dc5f1.1693386602.git.pstanner@redhat.com>
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

