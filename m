Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE3C63703
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 15:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiLFPHf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiLFPGq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5FE2AC65
        for <linux-hardening@vger.kernel.org>; Tue,  6 Dec 2022 07:02:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so15074398pjb.0
        for <linux-hardening@vger.kernel.org>; Tue, 06 Dec 2022 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6szhuV271WBRooPiUYxdjBS9FRctTnZzx3+BuNL+4Q4=;
        b=Z8e7g8VSkg7JqHkBqAjKdN+QFOCeoevDFoGXwOSAd/ee3qA5UWiZXi7Xby+6W+6LXD
         4TIjYL9Ufdb4C2aZ3GsGXLaCICrkTQOgEsQ2gEIiM1EBmjFWB5wpWVyVQ/1/7i661MBg
         rsyxjrSh1hIQJGUbYpSgIhT2a55Msluvqmhps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6szhuV271WBRooPiUYxdjBS9FRctTnZzx3+BuNL+4Q4=;
        b=XDCERrxfHvz1FmE/jCJ8bFLsp+zxxIhcyTTFnY0V1Cb8oOXnusotb6LuNs6xdqe3Tk
         Q5uZnbKTL7lOeVXfP+2YEmIoSn+Lchl+4h6zAASHL50iU0Lk0anklQZi7wJV6P5kmmP4
         4ADGAx23/CHtEdxb0MBW1qXqSWFKRurImm8J/H2L7h+YeEr1oVxlXHHOHmrBGezd2p8W
         T+tFi9rK5pPgOQ7if+F2D9rPZbAMMD5BwJIoa0bWmKcauTfiuyg8XkkQWgDtLkTgtZKx
         ToxrlrQm8LbHaguARHiCzdwn4d/Kb1wJsl6jcND1u2EAYQ5ZGud4ZDIfNSxdjUH4/dzO
         Xpfw==
X-Gm-Message-State: ANoB5pmaZRTq6KaQdA+X6n7EbXz9mw0B7sVPrNQDLxW22dSZbhGnVAAo
        A7OyflFz/tE/8Mmx+z+mqlENsA==
X-Google-Smtp-Source: AA0mqf73o+/ioSQzoTjsLzlyHEzPeoFPnI5gs96npnnroF1tNidRpEvUBkwQWbI4ZJLPCmhoyBrZqg==
X-Received: by 2002:a17:90a:1bc2:b0:218:8bdb:de3f with SMTP id r2-20020a17090a1bc200b002188bdbde3fmr85820069pjr.225.1670338975208;
        Tue, 06 Dec 2022 07:02:55 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:54 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Tue,  6 Dec 2022 15:02:31 +0000
Message-Id: <20221206150233.1963717-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206150233.1963717-1-jeffxu@google.com>
References: <20221206150233.1963717-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application won't be able to modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example: 3> shall be right after 2> in steps below.
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.


Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

