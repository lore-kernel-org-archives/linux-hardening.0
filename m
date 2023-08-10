Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69720C001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 18:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjHJSkb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjHJSkN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 14:40:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137AE421A
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 11:39:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c1903ad3so16166697b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691692752; x=1692297552;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9s/VShouY5UecShKdRRU+6iUoUZRUswiXCe+DYQQHMc=;
        b=iu3wIj0hrSChbkmbXE8YRK7qQMDFnxyfxL9xH4h5buWYXje/v9DExUqA4AGyVrqEQK
         GEcz0VT6GDwvVqm/rLr5zRKeOiIzE5XzDl6byKRnCcrRAV26nllvHU/Y/B2zRvUHyQjX
         pOywS2CTntHwjYSgM/5a1a1My+TepYis1+/gqp0nTAkppUPD8J6lMC7/qnVsG6/LfVwB
         dvKS+/w2Y+2gvSNed2wlajBMBC3y3XLUj2NUgCtaxNMsx8LxNCuxu164jCdL+WFJ5rNj
         5lSQ0eaIduXwSUxkONLhL9zf4mIuEO79oC6g3RyVhRsLeSklSR2VjyH5etCqZnzrHjN4
         Usuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692752; x=1692297552;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9s/VShouY5UecShKdRRU+6iUoUZRUswiXCe+DYQQHMc=;
        b=I5uHTWq5km0XPP5R6jBxqDO1dGVvYBFgUK/vZpSgqjRTRLAc5WMgJ55JOvZJfzmW5A
         TUi8KDOcgOKTLWsWF+eGYplnUwaQkMg+vVbOAeCXA3bctRAx+e5n0x81arge1A0HWfMz
         gD+xPfh9dQvPAPD50r2Mo0ZimNPpfEQPfKleBgwaDXoMrkg8iySaypHwYRDE/08f/M6D
         tGC7BMGpX85/ksEH3F2+pdOWbrqMNUOUbf7pDTxOfYTWMJik+JfXIscPJUIlSh30YhqF
         Ih+Nb6DioBOgoIYbOlhZ6WiNosI2kI2xNff8nygwbmISU0LOiOCB7OEf2SyZQa3u7DsK
         CPGw==
X-Gm-Message-State: AOJu0YzoTFZtDHJQf/NebR8UobVKAeh6j4RHBXBQ7mCz6JPnvxEUIJL3
        9j7Ch6ldfsJ03u760kS3yv/d0pBhVxjgv3NrMw==
X-Google-Smtp-Source: AGHT+IFd/BetrjKTvc+2UKvsj3Xl2aqeBqnWIgCBibfJD2tswKguWZfZhsx1vj78xyqo4dnFURE7yVJC6tcvaqhFKw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b609:0:b0:583:5039:d4a0 with SMTP
 id u9-20020a81b609000000b005835039d4a0mr55197ywh.0.1691692752000; Thu, 10 Aug
 2023 11:39:12 -0700 (PDT)
Date:   Thu, 10 Aug 2023 18:39:03 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMYu1WQC/x2MywqAIBAAfyX2nOAjwvqV6FC65R4yWSOK6N+TL
 gNzmHkgIxNm6KsHGE/KtMciqq7AhSmuKMgXBy21kVZJkQ+OLt1iYhcKtrYRajHeaDv7brZQwsS 40PVPh/F9P858Y0xkAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691692751; l=2010;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=aXS5AtkQbMqazJ7/YYIzdIPN5iWfiNdlNiBoDrKML1c=; b=4OnNBtGbw+0TcmcgHLZW3RtqHKsRbDxE7jZ+jEJGUYUpPJ/mIRl49NEwoSjr4tkFGdavlUEKT
 2ZUXdFZnghwCk7IMHYL2xzzS1o6VeUhjChRT4JvTADIQtj9TAeke/OP
X-Mailer: b4 0.12.3
Message-ID: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com>
Subject: [PATCH] arm64/sysreg: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1]. Which seems to be the case here due to the forceful setting of `buf`'s
tail to 0.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, there is some behavior being used in conjunction with
`strncpy` that `strscpy` already implements. This means we can drop some
of the extra stuff like `... -1` and `buf[len] = 0`

This should have no functional change and yet uses a more robust and
less ambiguous interface whilst reducing code complexity.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
For reference, see a part of `strscpy`'s implementation here:

|	/* Hit buffer length without finding a NUL; force NUL-termination. */
|	if (res)
|		dest[res-1] = '\0';

Note: compile tested
---
 arch/arm64/kernel/idreg-override.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2fe2491b692c..482dc5c71e90 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 		if (!len)
 			return;
 
-		len = min(len, ARRAY_SIZE(buf) - 1);
-		strncpy(buf, cmdline, len);
-		buf[len] = 0;
+		len = min(len, ARRAY_SIZE(buf));
+		strscpy(buf, cmdline, len);
 
 		if (strcmp(buf, "--") == 0)
 			return;

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8

Best regards,
--
Justin Stitt <justinstitt@google.com>

