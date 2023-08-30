Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67B7C6FA8F
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjH3S4q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244716AbjH3Nr7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7A31B1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=VBafd5+o1BPasgg3fepmn+pHFg9tfaRqiRoKKiE9l9T2E7RMw1qv4xHyTPt0ekn0jCi9/N
        7XWEFXW7pjfnYufLxmnG7EKyeEZC9KJy7i36g9LajCQJMNCMuW0EPiDU1AXC9uaLhL6vd7
        97T94ul4akjY5DV4rSGaDoc7zb+Kt/A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Ht-Q-VHXOCmwHccSBfWjeg-1; Wed, 30 Aug 2023 09:46:35 -0400
X-MC-Unique: Ht-Q-VHXOCmwHccSBfWjeg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a1c758ef63so61292566b.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403193; x=1694007993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=Z258LUH5jyuX4jc8Lf8rysCHR4CjAQUtrcHFdXLSBorL9yyLnIUY2yufjaaK6uuv0t
         3tC4JvfXn3aKf/LS9Yc5xsKf1JcNLf2uz2Y6mz/Hu++NN0we00GpLmgHFNhZX8zY4/hN
         CPNDX+OGO3o640AQceGZl8vAq2mYeREGQSZeWClsBzFk7rgS5fI1VDXzwXzfoDU/6glj
         8H1jXPvNNHS6FjAytqGrmmvehaGbWeVhdmyljBsg7BWOvoFz6ZOvDnfFA/ciDjAr64yI
         ZZWL39nwuO3R3dTrg93tbAbHNFjrx0cZjGYalMQB0L6wyMjCamSFguDRqv0nnqTcaQl1
         nL0Q==
X-Gm-Message-State: AOJu0YwrAnLb2JLzdCGrg+4Q59Jzh9TQaIBrwTn0QzcSPZWlMMeGAJhi
        qXFvVb907VIYkneBJ1sip84SxQ8ukbOdVlQ9aQMfGMftb7bn0S9dlAbEJeXUJkCdPYL8SsN/yOk
        25iSLmOLIx7G7AYfISu8wULxSpnCh
X-Received: by 2002:a05:6402:51c8:b0:522:3f32:52f1 with SMTP id r8-20020a05640251c800b005223f3252f1mr1737282edd.3.1693403193056;
        Wed, 30 Aug 2023 06:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9jsdBfXtDK6B3l1XAhb6uC/SE7H2eq+xyXHHwbpGSepkZ7/eGDvrY6bR1kwu2ebD+wsHwg==
X-Received: by 2002:a05:6402:51c8:b0:522:3f32:52f1 with SMTP id r8-20020a05640251c800b005223f3252f1mr1737265edd.3.1693403192770;
        Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d4c7000000b00529fa63ef6fsm6811782edr.57.2023.08.30.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
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
Subject: [PATCH 3/5] kernel: watch_queue: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:54 +0200
Message-ID: <4168bc2d9313d5d1a1a2b9ca0b9fc2990d499506.1693386602.git.pstanner@redhat.com>
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
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d0b6b390ee42..778b4056700f 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -331,7 +331,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
-- 
2.41.0

