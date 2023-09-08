Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C3AEEB569
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 20:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbjIHUEU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjIHUER (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30448E
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=erlHO7hbw1szw2sDthqNrRren8EIUJBQBZDEb1so9d2UwIJKUsDsRAw46vChsz9Euv/NW4
        w3oKxm3+OfcFWl9j/LR89hmWMvfk5NhsRas7Q85XPBGk8bPAPS4au+1b7OdVEM7P78sk6X
        DXUtfiFORk5hCn/FgwIuzAVI4lX9phg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-xwx28b8JOg2d0tmicZlUYQ-1; Fri, 08 Sep 2023 16:03:21 -0400
X-MC-Unique: xwx28b8JOg2d0tmicZlUYQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40559875dd1so4945761cf.1
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203399; x=1694808199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=v41iUWslGIwf7BgY1aie88UHSxOxHx6CT9GnuvicGaxqSyec5rELYOPbfIesGgfDja
         7am4ZBPdw5RtA4Fu4wNaKvoRRybmgRb/6Q/IeQYxVvtLVuTeAfYXa4xVVouagUim9OOu
         fdbjY4VvwIMyc6zT1kEujp6KocMtViZyR6T9wLRBtyuHxdJ3ZCUkcAOTMyUxMdf4Pnhx
         vgswje3ncmpytBjOf5cQj1AMVZD7rTc/Pj1zQyRG5KSvcuvd6gGbkthsVlpdC7nj+FEM
         05gsLKJ4ni33e5XbUoRsj44L4q8HhPtTXFWjNFF3Qb91CgiHkPvNJbOO8BdyOZKk7XMl
         OrxA==
X-Gm-Message-State: AOJu0YwEnPJ4P5eDXmm5BkUMNoNj17SqSnkBuCg+jEa30wxBSpZXDSl+
        XVfULqB3rrPTKP6PYLgpUbS1NN9REKf4oxj90KJSiqHhwpRO1xtoYT0sArii5xLPrNj07QwR0CU
        d+HxPpfWX7Xd7zPw6xcoJnoCkFmD2
X-Received: by 2002:ac8:7e94:0:b0:412:12e8:8538 with SMTP id w20-20020ac87e94000000b0041212e88538mr3683934qtj.1.1694203399546;
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAKN1YnAkZtTcGtA674mV4f8NT9irZONaAKXTHG61Fqfz6xPH+/e15CARdB3FRUjLa10PQWg==
X-Received: by 2002:ac8:7e94:0:b0:412:12e8:8538 with SMTP id w20-20020ac87e94000000b0041212e88538mr3683913qtj.1.1694203399274;
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id bb37-20020a05622a1b2500b004116b082feesm843284qtb.75.2023.09.08.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
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
Subject: [PATCH v2 4/5] drm_lease.c: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:43 +0200
Message-ID: <bca4966d616f417267ba02f66ff9891fceffd7f0.1694202430.git.pstanner@redhat.com>
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

