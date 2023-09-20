Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059DCE79D0
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 12:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjITMh6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjITMh5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA0BA3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkUiTYo02brbH9rdldgLT7YiM95DCTjC6m+zHLs+f1Y=;
        b=amz9ztIh2WqHpki1KC6uHy1zXJICfGQXzAcYtXaOGfsQ53TsLMaIIVqvhYhkteyhuo4xI6
        ifibXytfMIFe7uzk1/l4yUWaB+fGA9Mb5OgL5NGm2g4sLOFs+2fnfoEMY6BK0numYkYExK
        e+tuj6x+yXS8ocL84bgtMPWWlVESyhU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-p99wu9POMeKuk5_n9vJjyA-1; Wed, 20 Sep 2023 08:36:59 -0400
X-MC-Unique: p99wu9POMeKuk5_n9vJjyA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2be48142a6cso15826071fa.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213418; x=1695818218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkUiTYo02brbH9rdldgLT7YiM95DCTjC6m+zHLs+f1Y=;
        b=c8vSz5okLTTBzYON5ekUkK/PZZD5xwlg88KXUKvI13FjZJA4LcmjssNUc7rdLRo+hu
         0So3L5N7kpDmRG1yqm3lyCh0jwJ+P1so3byhLpnwg+pI5d2PqhFnoURnoaItAqR2wnH6
         Uy1gXxKpV5IpmCYCSdH9FEXJcb83lNG0XdX8+Buur4Q41epQ5TKAoJQ7sIDVuqkj4Pos
         eoSx0PWQny3QVQg4njme93empzAcH2nrk4ywRvxM6OEJouF+C+GwnFymUlXIQVqh5W3S
         DDfvcl8jI57DT6NP7w0vCLC/VPJfy8yUKBqLxw4clBZat3M0kU52PotjDn7ZaOR5idqF
         Iy4Q==
X-Gm-Message-State: AOJu0YxkI52LC7F+c7NQqMe49LYEIUMQrXDu2qWnvQOZLiCylYUIkAWQ
        Hpgh84qy8rvoiBjwqGhHdZUCskL4Azi/Bl2Y7p/NPdX3d7Fnx75tYOrSEnH3p2tCBSL/Q9rFxrq
        4neSO+fxmC7ApMv8sCz29hMA7tQVB
X-Received: by 2002:a05:651c:1693:b0:2c0:196c:e38f with SMTP id bd19-20020a05651c169300b002c0196ce38fmr1921139ljb.1.1695213418530;
        Wed, 20 Sep 2023 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGtYN79a4/Uyeq8meM3+9mCAQ2LGvBXOKnKduArpSa1zP3qsVYH9Wh1PFHrd4S88GImDITZQ==
X-Received: by 2002:a05:651c:1693:b0:2c0:196c:e38f with SMTP id bd19-20020a05651c169300b002c0196ce38fmr1921120ljb.1.1695213418185;
        Wed, 20 Sep 2023 05:36:58 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id op15-20020a170906bcef00b009ae4ead6c01sm660073ejb.163.2023.09.20.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:55 -0700 (PDT)
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
Subject: [PATCH v3 3/5] kernel: watch_queue: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:11 +0200
Message-ID: <20230920123612.16914-5-pstanner@redhat.com>
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

