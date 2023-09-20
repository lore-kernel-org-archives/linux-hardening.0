Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0470DCE79D0
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 12:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjITMhr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjITMhp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DD93
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48G0tj5zzQRFiALYPkyRPndfaCR4k/8e83lXW3c50mA=;
        b=YpUDeJXdDyrtyjlFlGd0i7UqaOERsM8tlEZe2Z32DwTZzTLbqxUEwWodbykwe9WmcgMMj2
        lCwDLTvbiggpqiISSnipylMUrEQaENH0crfC4k24zvASrs+KdWkD7Q7TTeRyVaKW0BcRx7
        /aeZyOlOWCYwz3gM/MJ6aj5p13zSswA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-WPuGF53MNGKaGE4iY3cEjQ-1; Wed, 20 Sep 2023 08:36:50 -0400
X-MC-Unique: WPuGF53MNGKaGE4iY3cEjQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso154936966b.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 05:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213409; x=1695818209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48G0tj5zzQRFiALYPkyRPndfaCR4k/8e83lXW3c50mA=;
        b=vWD2VP6tFREUvgMcczLoA4NC4l+SiPjOL2TSyfO2WQJ9aAAQC61F39qXm/SCM+WLo2
         yKD4lIwdJeb2kqjSgc0+E91dQ+ByH0lgn5Jb3hFP7bLDgr3UcHy03khNmcbRf0aFW05L
         UC29Fi69fTFcOUzI8LP2/YnbHFPpU8SAA60vBRw4k12TxxP4/LckpTEFjhuPKv15EmCz
         bjw7AYuXpridPzERzjiPqtyaGAfacuqcinGp1ZRrFIV1udK3J+ax4X2QYvJbAlH9Esx/
         IB2OP1a3hIjvnb3Gmfp1Qs3Jh6wWrXzaTSEbtEtwKG/gb8l7E9/Uy65TlEvj7t7wR/a1
         gs1Q==
X-Gm-Message-State: AOJu0Yz7W8J6WdegTVeGm0T09+wrJk6cI0N94DXyZF7kNGqIqb5sihsv
        /N0KIo1ETCZSQCr4LMqe93yi3UOdRtruLGF5elj418ca0w9sT1ymVHTvuH06vm/PBiaYAU5Qiw6
        vbxj41TJ/bLu1/WJzKcW01LHxKC0o
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1444618ejc.6.1695213409771;
        Wed, 20 Sep 2023 05:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmJTym5YvZ4MH52qjmmgnlm70HGxEIyE84IZpdWdDkioxeqQ+sBFeg2a5b+qpjuhd9RNuOjA==
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1444608ejc.6.1695213409547;
        Wed, 20 Sep 2023 05:36:49 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709064ad100b0098ce63e36e9sm9447247ejt.16.2023.09.20.05.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:47 -0700 (PDT)
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
        David Airlie <airlied@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/5] kernel: kexec: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:10 +0200
Message-ID: <20230920123612.16914-4-pstanner@redhat.com>
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
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 107f355eac10..8f35a5a42af8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.41.0

