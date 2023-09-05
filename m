Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020AACA1001
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Sep 2023 20:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjIEULF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjIEULE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Sep 2023 16:11:04 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7C194
        for <linux-hardening@vger.kernel.org>; Tue,  5 Sep 2023 13:10:31 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1cc7407e507so3311849fac.3
        for <linux-hardening@vger.kernel.org>; Tue, 05 Sep 2023 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693944623; x=1694549423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4pmzv+LLCuNutmWDx5XVz6vIet3weuj1okr6x6iIDqs=;
        b=TPU6mE8hSKglsyJ4Nxkp5or/4zoZ5VLI2BO/lYaPBoQ7YKnDiXYRSojEB+RYItZQN8
         AHBoIHmcYPUJRBKEnulPf40GcFHIC22nUzTIJjPlQyY5b52wFm51WQxVgl1tChM7Wglw
         UBWmKRkOftMZgqVJ6pCsekrCRQgSIVFjXbEghL8FDKin5IGUR3KNDKgnIHi3dlH9QVvX
         60CWj5JEymFV9um6Mfz73g/n8Rs8Wi5UR0buM6ohElkLFhmksKxIBOIvXFw+gO4vb66X
         GgS9tE3CKoF0DhU+XuatGRzvztaJ5MRjwW9/Zs2W0/44BJ3s1ackmB/WdWiQcPqTZ7HE
         harg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944623; x=1694549423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pmzv+LLCuNutmWDx5XVz6vIet3weuj1okr6x6iIDqs=;
        b=KpHta2HUXDY/UKCwc6UXOEJx3zaaekLwgiQlZmara8gPeksAkLCQEMbNUc57b4fnAX
         ww3wyqQre0YThP19fy2wvqnmDrHc+mauOAA90Z7LbpdPwSwvQeX7qdTY8+pVz0dzQKSr
         Uv+bXlooGQVW6Nu/XJYHpEVwmzmQHCwWhQdHj9Oi2TCm2Zt3Btgxr/ylM1H+1GkqqATe
         7ABuSutx3PmqTrzBseHrpbzBjpuzxgN7IXOAvA2V+/VXkpJWW/Ni06zgR6PQaqPAJZPP
         4pi6WL2xAzTKV+aEnnZHuNprB/3eVjC4WCMGvnxvuN+gQcIyc3JqwYkmo5q5WavZAFz2
         /doQ==
X-Gm-Message-State: AOJu0YwsjKptfeiFpEfdgczDosgeLEPwFFPqMTlnzDkw7qUmAOuTVG6I
        8OZvMCJhTa1Kj1f0AWlsiMp9mR6ErAskEFcm4A==
X-Google-Smtp-Source: AGHT+IH0UAhU/aEXaLYwKV529bYDq2+IrLYFkojxcQXZZrpNvgRPipYWy3B0aEIwkrHJxkLEyoHB42gmo8sADZGiSQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:98b3:b0:1c6:7d66:d47 with
 SMTP id eg51-20020a05687098b300b001c67d660d47mr350044oab.3.1693944623730;
 Tue, 05 Sep 2023 13:10:23 -0700 (PDT)
Date:   Tue, 05 Sep 2023 20:10:21 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC2L92QC/33NSwqDMBCA4atI1k0xDzXtqvcoXeQx0UBrJJFQE
 e/e6MpS6WbgH5hvZhQhOIjoWswoQHLR+T4HPxVId7JvATuTG9GSslKQEscx9HqYsAy6y+NVc0w
 sM4wKZS5KoHw4BLDuvaH3R+7OxdGHafuRyLr9yyWCCbZ1Y1ktKm1qfmu9b59w1v6FVi/RvUEOD ZoNJQUHqayVRv0YbGewY4NlQxulCDQgKyBfxrIsH3BtrsE9AQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693944622; l=2237;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=t/5OxQrRWKo7ANfBmo93SLcVLgmcGRCwdycJFf2MN74=; b=3u23MHg/jPWsU7x0jAafSrxxG4WZqrLPGQs34EinIy6nacmqUYB0HuRg2pkyCwTWc6oyA62E7
 wNCh34KUVbPDkbS3QVngsClDPBUK9kMKubaBgFgZcoSnQY/jTofVttO
X-Mailer: b4 0.12.3
Message-ID: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
Subject: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mostafa Saleh <smostafa@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

strncpy is deprecated [1] and should not be used if the src string is
not NUL-terminated.

When dealing with `cmdline` we are counting the number of characters
until a space then copying these over into `buf`. Let's not use any of
the str*() functions since the src string is not necessarily NUL-terminated.

Prefer `memcpy()` alongside a forced NUL-termination as it more
accurately describes what is going on within this function, i.e: copying
from non NUL-terminated buffer into a NUL-terminated buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v4:
- rebase onto mainline (thanks Will)
- Link to v3: https://lore.kernel.org/r/20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com

Changes in v3:
- Fix faulty logic and use memcpy over strscpy (thanks Mostafa and Kees)
- Use '\0' instead of 0 to make it abundantly clear that `buf` is a NUL-terminated string
- Link to v2: https://lore.kernel.org/r/20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com

Changes in v2:
- Utilize return value from strscpy and check for truncation (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com
---
 arch/arm64/kernel/idreg-override.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2fe2491b692c..3addc09f8746 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -263,8 +263,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 			return;
 
 		len = min(len, ARRAY_SIZE(buf) - 1);
-		strncpy(buf, cmdline, len);
-		buf[len] = 0;
+		memcpy(buf, cmdline, len);
+		buf[len] = '\0';
 
 		if (strcmp(buf, "--") == 0)
 			return;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8

Best regards,
--
Justin Stitt <justinstitt@google.com>

