Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3287C0015E
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 18:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjHISTl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjHISTk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Aug 2023 14:19:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE72106
        for <linux-hardening@vger.kernel.org>; Wed,  9 Aug 2023 11:19:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso1670387b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Aug 2023 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691605178; x=1692209978;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9+IWZmGOXJH6TQW7TrBTS32AvWqt6FCCDY8aKxFBjc=;
        b=RH6NAR3HPdnAujcthLTNkfqMgMO/gZFXu3pAy247EtYZv7AEyeT6rW7a3dF7bt4t1K
         Ns5gMTpuaZ0NzSKHwUP9D7wle6yt6iTpcCM8L0rXvYhcYC5qEocjnXhwI5qb4Aj+iJWl
         j526OvzmzAb83YAkRWDy3Av3Fjt7vzl0O1W+Id2YO/7AUktjkzoS6ThAMaOvvFAFArSz
         xbQ+kkaEGA49j8RS/1N2dEIzJ9m1nBTYKNo+S0/WE5oIbaCSG3iSPyI/q/H38rPT0hjF
         l/iS9ZIzREp9evcoCEAAlfNbISIIW6lKjFv+SAEYcAEpNfWoZ6TMyo6HwgV/MKdhqR9z
         vjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605178; x=1692209978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9+IWZmGOXJH6TQW7TrBTS32AvWqt6FCCDY8aKxFBjc=;
        b=EI+LiAOlwVYUrP8sGw5bt/XtgKwy6nxkIRtBF7//aYBFx0TUMb8Pn9iB8qk9cNsfvA
         f51bfimsvMQ6/7MJrYTDIdUn5wUwkBs4J9Bo0uyN0Q6XZmyWHow5+bO8cBzNMRG1i7Lj
         bpH5eGRyOvwiX/v2lotXi/ixU4jxcPBNkJoLH5+d6z9pw15gEm1gzq9huXdMsuPi0cuG
         ykZlo7nergiKOcC9lHgHLu3Je5YV1iDhnZx6PAwIeGoIdUAyCqFc7i/HWJJJD7ira1Be
         A9gj05DnSwP3pKmJn3+ymHl2uXMWW+KQhKZmkndAPieA5Jtn91HktEgkOnQmSTzPkHcs
         N66Q==
X-Gm-Message-State: AOJu0YweWII5la8ilR+nr08VcwFS8Snbe8A+zB5JTRcHwf5zVw+WBAN5
        Fq2COhMONirPQ/0Tmtt0HSfKrfFa+iI1Glseqw==
X-Google-Smtp-Source: AGHT+IHnpy+/J/C+D4Q4JPgAzwlXMTPI+h6CwminUuHwP+Cql0xghqh2RomkGyS/8mpup5ykvjSMYLYD4xsftvGlAw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:70a:b0:586:e2b5:f364 with
 SMTP id bs10-20020a05690c070a00b00586e2b5f364mr4614ywb.4.1691605178129; Wed,
 09 Aug 2023 11:19:38 -0700 (PDT)
Date:   Wed, 09 Aug 2023 18:19:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALPY02QC/2WMyw6CMBQFf4XctTV9AC2u/A/jgpZbaCKUtNpoC
 P9uYaPG5ZycmQUiBocRTsUCAZOLzk8ZxKEAM7RTj8R1mYFTLqiikrTBDOQxEoGWlyUTJZcI+T0
 HtO65ly7XzIOLdx9eezixbf1vJEYYUXWntdVVI2lz7r3vb3g0foQtkvi3qD4iz2JlNcoaW6sq8 SOu6/oGENOyE9gAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691605177; l=2213;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=23IC5Bw+8KkKs09S0EaJWss3x1p4d4hD+7BkZ/ap4cg=; b=gfF6LynUr5OZNkVjBs6fVzSf9HY8BE2EsZGdMISI5wxTkkPFSBAPa8s8UwSGy9Awn7YZsIbB+
 XjEWts8XjrNAywzyWQ+e03kVuL94vwtZkqCoKKelbu2jA/dn9CwrB1e
X-Mailer: b4 0.12.3
Message-ID: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
Subject: [PATCH v3] um: refactor deprecated strncpy to memcpy
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

Use `memcpy` since `console_buf` is not expected to be NUL-terminated
and it more accurately describes what is happening with the buffers
`console_buf` and `string` as per Kees' analysis [1].

Also mark char buffer as `__nonstring` as per Kees' suggestion [2].

This change now makes it more clear what this code does and that
`console_buf` is not expected to be NUL-terminated.

Link: https://lore.kernel.org/all/202308081708.D5ADC80F@keescook/ [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- Swap `strtomem` to `memcpy` (thanks Kees)
- Link to v2: https://lore.kernel.org/r/20230808-arch-um-v2-1-5fbe76eaf853@google.com

Changes in v2:
- Keep usage of ARRAY_SIZE (thanks Bill)
- Remove unnecessary import (thanks Kees and Bill)
- Link to v1: https://lore.kernel.org/r/20230807-arch-um-v1-1-86dbbfb59709@google.com
---
Notes:
I only build tested this patch.
---
 arch/um/drivers/mconsole_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..ff4bda95b9c7 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -554,7 +554,7 @@ struct mconsole_output {
 
 static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
-static char console_buf[MCONSOLE_MAX_DATA];
+static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
 
 static void console_write(struct console *console, const char *string,
 			  unsigned int len)
@@ -567,7 +567,7 @@ static void console_write(struct console *console, const char *string,
 
 	while (len > 0) {
 		n = min((size_t) len, ARRAY_SIZE(console_buf));
-		strncpy(console_buf, string, n);
+		memcpy(console_buf, string, n);
 		string += n;
 		len -= n;
 

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-3ef24413427e

Best regards,
--
Justin Stitt <justinstitt@google.com>

