Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A471AEEB566
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 20:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbjIHUEG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbjIHUEF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3051B0
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJlM81Ad0uqQunhdFKofh1JwhP2kaFm8hxSxz8OfTMk=;
        b=bzizTypi9G7KWH9+PtT265OdytWC2oMLvDmw/JF+v8zLtKgzPnt08nWgNQnUu/Gr1R3yd0
        L3ylLkMq8CQN7RApJ8t2ny5mifzEXa2uK67ibPgBjHnX5XDnApTl7XCd5M+s/TD2xkXKrX
        q1amT77gWvHci9kD+vDtBtAzr62wh5M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-oAHmtuwLPLmOP3MEQjNZJw-1; Fri, 08 Sep 2023 16:03:02 -0400
X-MC-Unique: oAHmtuwLPLmOP3MEQjNZJw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-64a4269ca98so6043416d6.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203382; x=1694808182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJlM81Ad0uqQunhdFKofh1JwhP2kaFm8hxSxz8OfTMk=;
        b=TMcvSPpRpwRC7blFGJ08X11AUcLgYS7NYBu8uSPHQ1+rKwciZqLaqwcUVlYNWHxzd8
         tcDd0uatxWfIfrDi18W4kU3Xdw79RYucHhjdsDGyxVkFPp3KyRDjYuworLLwIPW7YUaP
         NY+SOswbbc1crepjy1xHjG7hoC61HUsYXkQCxleLvtOKN/qvh61xFgJY3qfLNQqw1Qzx
         FSIVqJsQPwQ3xnzJ1+qzSpnHQ/8YMkXDaAyz+fIPeJ9s/+mcAp2x3OOgsfmhhfs21kTV
         hx+c2ckYorFDbc9VFpVGBRChC2FmH4HrhrEXjZucP92LliZtHNtMQgyK6/doesi3X2lN
         jHWQ==
X-Gm-Message-State: AOJu0YyFEVEHKKTM4nFUSvlBy5sTyoZ1pVx7lPCXQy6n/Aj3NMXSw7el
        vByPsfNlfC89OZI1okd9aNI0D0BH4bN3tlnD8+HRPdoFtkrKlWsDgyKfIju/Q6PEeVMyVueQDEs
        6akWBlrcF6FQjGi6m4bP6p+n176X0
X-Received: by 2002:a05:6214:234b:b0:649:5f43:245c with SMTP id hu11-20020a056214234b00b006495f43245cmr3403719qvb.4.1694203382304;
        Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkpjEpC3M4jl16uIjnS3PMQJTudw+DmAKJXO1LGuAkwNI/2h/IQUepIX3UGSH4cUrAf1SALA==
X-Received: by 2002:a05:6214:234b:b0:649:5f43:245c with SMTP id hu11-20020a056214234b00b006495f43245cmr3403702qvb.4.1694203382095;
        Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id r19-20020a0ccc13000000b0064f523836fdsm959242qvk.123.2023.09.08.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:01 -0700 (PDT)
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
Subject: [PATCH v2 2/5] kernel: kexec: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:41 +0200
Message-ID: <31313a8a1dd1baf9dd3c21fbe8dd46b9e111f20c.1694202430.git.pstanner@redhat.com>
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

