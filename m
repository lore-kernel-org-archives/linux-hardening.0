Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED5C6FA8F
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbjH3S4Z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbjH3NrU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314D132
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uG5M2Lwpie6cChdlBf2i1g6i8ozHuD8iPPR+2gMyfYc=;
        b=BY7VJof0QjqigpStiZgPE008ec1Pwqd9JQBEpTmWasug6HnaNMxnmp2zpkQJfXw+kSJEfy
        mQWmwsuxYvZpW0cqozp8NxQjQC1vn3B1r1k1Gbl6oeF8oRIyRbIQPsdzVoW6NICsktgtTt
        iRn1r2aMXZcX3f4PQdUOQP+2jfVuMt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-jqPAbMeDOxahyqHqhLO1Sw-1; Wed, 30 Aug 2023 09:46:30 -0400
X-MC-Unique: jqPAbMeDOxahyqHqhLO1Sw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso757011a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 06:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403189; x=1694007989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG5M2Lwpie6cChdlBf2i1g6i8ozHuD8iPPR+2gMyfYc=;
        b=O9PQc/LicNFW6zQpwafTBuZrxTFTvNCeOOY48Tq/QdWv2MWis+WafB6w7guox2H5fq
         7bYBEUrtvJCAjbM1+7XPEUW9Jn85N1WJxC/VSgTaR1uyoBFdNMYHW8KM5Qb41Sg/8rCb
         7ApHdQGrnNjeboIfBtWWAJuJ++UBd2FvXMm9YEkZ/TNP0kNofsBIQgXTaiHrkHoY+CzR
         ocMXELkW1LEU81h7ySYir6ZUE4kB4osEtaT9chIuxPwREgYmfTn0+fQu/gMpXwhkwWm3
         77VrgkYpg5vPKFTPFOOjbyHh9qmvpSLO3e/auztkaaFpc0tEeFGiQsX39f7FBlh90qhN
         pr2A==
X-Gm-Message-State: AOJu0YwPqIaX7Fq2PWoS5qaFY/C8tjSFtak1xh2qgRi1vR57X/SpjYGa
        JoJQBhe5bt/2mr9cTOGFRdopvnPtlvFd5wfPZn8LOS5j1OS0QmcftBmlbTZNQqhUlpVJr7g0mBW
        jfIOYcETBAyZM33bycvPoWqsN65a1
X-Received: by 2002:a05:6402:50cf:b0:522:e6b0:8056 with SMTP id h15-20020a05640250cf00b00522e6b08056mr1964355edb.4.1693403189067;
        Wed, 30 Aug 2023 06:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpKYbKxrilyWwmvyGSQuR3YdE5ziBNReJitKpOxi4O0anKghb3+MxxX32nil6cbORrhxRuFQ==
X-Received: by 2002:a05:6402:50cf:b0:522:e6b0:8056 with SMTP id h15-20020a05640250cf00b00522e6b08056mr1964344edb.4.1693403188914;
        Wed, 30 Aug 2023 06:46:28 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7d297000000b0052595b17fd4sm6683260edq.26.2023.08.30.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:28 -0700 (PDT)
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
Subject: [PATCH 2/5] kernel: kexec: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:53 +0200
Message-ID: <0a3f1bca273792edbdc41b64c454a6f7f499c9a8.1693386602.git.pstanner@redhat.com>
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
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..f6067c1bb089 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -242,7 +242,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.41.0

