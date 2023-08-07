Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE50C001B0
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Aug 2023 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHGVSH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHGVSG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Aug 2023 17:18:06 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61231BC
        for <linux-hardening@vger.kernel.org>; Mon,  7 Aug 2023 14:18:05 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6bc7afd0498so9710542a34.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Aug 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691443085; x=1692047885;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mfCIyPm2aO7x0iXfdEGub/+bSKhcssAHTeROw2F55I=;
        b=iXvXoonIYBdhMFviyOkoygmsJIyTGeBeq4/AOnBxytLBvQQhjalGqFzg7pCH7KQxfF
         eKRi5WxgelqBpHePErOT2Bt5zN88BKI9miy34Avnyz48BfPkNp3qp1t/NvRGeLfMSMBu
         ZKa+3pwQi71GXW9fVgOgw5fIB079W+CRsJHTp+GUGaJsCoY+4M1QuK58KCYVKIgKNQhZ
         MDzIdOWmfwnJvoSd7P4iHZp6p3yo4EwP6d7k43C+57isSu04UsZzVLz9k1QVhs9iHeMp
         JDzFnnEmAS8cBGV9g1gv2aE9flzX+CV9jCKD2QZUmxpSkE8tujbKDIBT7w8/Lgv1ixP2
         1iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443085; x=1692047885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mfCIyPm2aO7x0iXfdEGub/+bSKhcssAHTeROw2F55I=;
        b=WiDdkjk/S0z90KQYIBh3oLIXvLu5IhKTsRnIr5vLkiVPtTs0mCYtmDDUFfwMPw98Fz
         3j7EhGk09WOg9tUYv3X9osySdeRPFTuK0CoFnxlUNh21nMkwxzhQY1DfF9bljEtg/Ws+
         8Y9T1kNPNORInRfojUBOqSV79MTMcxxlk9r4c0q3sWe3b41bjhthpA1NeZ9fNPeAHawl
         eFUxAPqX528rEvAynNUS3zNjJYchESWKkLQCjJCrgK+XNhTBqf3jpHSMGY0PxM/L4gnY
         vGzXCk/UEQhNKRfb2TTCXxwZeWnmNqd7yLK60YFUotmtfkNza2AqTywoi2JsgQIUN5Ii
         6JmA==
X-Gm-Message-State: AOJu0YwjF2FYukFK+HcRkWYuMc9uYICTzyC0R1EVc8rS5ECAqmTim+xy
        FmpxjUa3Tm6MqaYmhfC6AHZYEtZu7PA0a0taPQ==
X-Google-Smtp-Source: AGHT+IGr5rwXC6cUJHtMMxiCQlU0uuF7YpzxMjNzb/DWy220WGAU/2ZgbGEhlaruYZWPZNrBVnzaPnyS5y+0Klm1ew==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:3a0f:b0:1bf:d7b9:9960 with
 SMTP id du15-20020a0568703a0f00b001bfd7b99960mr7527734oab.2.1691443085255;
 Mon, 07 Aug 2023 14:18:05 -0700 (PDT)
Date:   Mon, 07 Aug 2023 21:17:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAINf0WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3cSi5Azd0lxd49Q0IxMTQ2MTI/NUJaDqgqLUtMwKsEnRsbW1AHb 5zV9ZAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691443084; l=1886;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=29NvDKooXX0ph89b44s4wsreDRVLQpWCZn8WSLtPy8Y=; b=E9ZtbxM3R6Zqci4MF+SDmmhn3TxUgdCPU66xW4h3e6fKqBfhSZq9iL/ienwg97ORyGw56fXX+
 9sD/afEHAV+BT4wvqLe0apqEsuO1EjSbbcyG+J/cbR93lW9E0n3XX51
X-Mailer: b4 0.12.3
Message-ID: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
Subject: [PATCH] um: refactor deprecated strncpy to strtomem
From:   Justin Stitt <justinstitt@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use `strtomem` here since `console_buf` is not expected to be
NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
instead of using `ARRAY_SIZE()` for every iteration of the loop.

Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]

Finally, follow checkpatch's recommendation of using `min_t` over `min`

Link: https://github.com/KSPP/linux/issues/90 [1]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Notes:
I only build tested this patch.
---
 arch/um/drivers/mconsole_kern.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..fd4c024202ae 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include "linux/compiler_attributes.h"
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -554,7 +555,7 @@ struct mconsole_output {
 
 static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
-static char console_buf[MCONSOLE_MAX_DATA];
+static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
 
 static void console_write(struct console *console, const char *string,
 			  unsigned int len)
@@ -566,8 +567,8 @@ static void console_write(struct console *console, const char *string,
 		return;
 
 	while (len > 0) {
-		n = min((size_t) len, ARRAY_SIZE(console_buf));
-		strncpy(console_buf, string, n);
+		n = min_t(size_t, len, MCONSOLE_MAX_DATA);
+		strtomem(console_buf, string);
 		string += n;
 		len -= n;
 

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-3ef24413427e

Best regards,
--
Justin Stitt <justinstitt@google.com>

