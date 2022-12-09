Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB544C04FDE
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Dec 2022 16:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiLIQFZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Dec 2022 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIQFF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Dec 2022 11:05:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085CA6C73B
        for <linux-hardening@vger.kernel.org>; Fri,  9 Dec 2022 08:05:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q1so3802937pgl.11
        for <linux-hardening@vger.kernel.org>; Fri, 09 Dec 2022 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=h3FquO7MkL3Xkcl57UR0vuuniHUg5+pjAS+449C9zKHXjh3bfCzGniHHohZYn5ZJxa
         PimfhG0DETXRYTKLCZGzQghCrFbpOJpZG5Zr0M0bfkbC/VGkO9Ut1cdT7lGwEdufbrrc
         PnxV8fbesmJTL6d00qwrsh707SkFtLJvebIYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZNFa0Som2cEXdyImA0PHzAPIxujgLNI2oeSKx5nHZI=;
        b=mQJNhrjgrQRDZpV6RCuSNn7TozrTMzYIVeVe5/WZePXc2Do8hOS3Pi7pGCkFGA0zNW
         1swo+vIl93Fib+zj3gqxIsVxFuWJ4TuygRuMi1q8nuLt2FkmdFyr1ewL8JlL/GM67zey
         yrMplSY1hA222Gt763qdRe8pLKd0S5k5e2niXk5APZHdjrUyAdexLYfWCtP885YraXA8
         SHqjLZY2COxqDTUDZr687A1HfrDx+3GaUGVMmwE5thGny9HgLWX/TJMDIlhy7sc2NO3P
         B9d6yalqLotsqVgaswHjqOrSDAKebWcqYFvvY7fZKboS4jhsE9+P/YAMeWhf99qZzvvO
         nT2w==
X-Gm-Message-State: ANoB5pmjmJCXYtOAXTGcCOq4qkDxTcftWQX3xAfWWYW5UpXdDAYxxS3Y
        jyUZtNNg6N0GiVr+oIzdnSrU9A==
X-Google-Smtp-Source: AA0mqf6CmbxiVSZwu0zBPseh9ltyuMQpEJZ+0MzUajuKI0ToOlPtqG4/ib2Rp5GkK3d0hKasOROV5Q==
X-Received: by 2002:a05:6a00:a05:b0:566:900d:6396 with SMTP id p5-20020a056a000a0500b00566900d6396mr8624787pfh.22.1670601903758;
        Fri, 09 Dec 2022 08:05:03 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm1460504pfk.93.2022.12.09.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:05:03 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Fri,  9 Dec 2022 16:04:51 +0000
Message-Id: <20221209160453.3246150-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
References: <20221209160453.3246150-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application can no longer modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example:
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.39.0.rc1.256.g54fd8350bd-goog

