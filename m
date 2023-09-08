Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4815EEB566
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjIHUEN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjIHUEM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C2186
        for <linux-hardening@vger.kernel.org>; Fri,  8 Sep 2023 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=KCRLv7MUEt6Q0udobb7lP1jekmzhVia2f/RZ4M5uqfLqVYA+7MDEupYLccbWaAQXwetsyj
        e/7eDyGSGd1KvoRizwWL7CWOjdvkKMET2uf4cNXM5VlrvtVaN/7SyS8+DTbR5uOwlRd7pY
        vuv4sljZSwe5mYLb4yOe9+xlBkMFP6g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MyeEWRL8OryOgDGm23HhbA-1; Fri, 08 Sep 2023 16:03:11 -0400
X-MC-Unique: MyeEWRL8OryOgDGm23HhbA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76f191e26f5so58808585a.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203391; x=1694808191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=d0XhTcnPdOgp4agu2Lm8ZQ/EP6k61LfcMdGPUwvWqlBzMXACn6lTvzfLOR+txpwTis
         af1gYLcSoXzEbaIjHmLLD0wTjV9dMVa/jAQ1mL5CLttur3X5jBcQtVvid92c8Uj3glRZ
         sUSbfzpkSWGiSNx61vMnZ6vGYZZL4IEqeOTbCMCSv4vaj9/fRlzorYkaD34FCbEMPvaf
         DK7mIGvpmrHJFGtJ6rNNNliaY9Xtl393FZbrzBsHxirEuahfLmOnwqfk5dZg7HfREseH
         SVXO+MVIhzAfJky9myI25vXRBfNiHi7srLo/RxqINBOOEOwsUf4WcwSYSoaJ/jjPZVZ0
         HW/g==
X-Gm-Message-State: AOJu0Yy1b1lbsgQU7IIDWUbBpXoZ+3Yd5sGQH90La6lMoos4iS6fsaMf
        In6+2O8WMJZaRyEZMv4w5N/Q1aOPduTKpqAwc/Tk46dcvY/ztQmrA61Le+YyjfCY573sLUndyT4
        Z/A5xyGui+8ooCILcXV1H0MkTs96U
X-Received: by 2002:a05:620a:46a6:b0:75b:23a1:69ee with SMTP id bq38-20020a05620a46a600b0075b23a169eemr3480485qkb.5.1694203391485;
        Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuCpViWH7IrGzpUqlTBi1h+iY/5ABj5ubmz/i5MJtwSQDaqOps3aQUe1r5isWfpnPKjPasBg==
X-Received: by 2002:a05:620a:46a6:b0:75b:23a1:69ee with SMTP id bq38-20020a05620a46a600b0075b23a169eemr3480460qkb.5.1694203391259;
        Fri, 08 Sep 2023 13:03:11 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id c17-20020ae9e211000000b0076f15f2918fsm825920qkc.63.2023.09.08.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:10 -0700 (PDT)
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
Subject: [PATCH v2 3/5] kernel: watch_queue: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:42 +0200
Message-ID: <b333514f0be426385b5215b47d24062b4f551584.1694202430.git.pstanner@redhat.com>
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

