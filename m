Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8828DC43219
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707AC619F9
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353101AbhI3SHl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353073AbhI3SHh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F275AC061772
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207-20020a2503d8000000b005b6fc088578so4434943ybd.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fPre9riEtsWDn3nT/Sr4LcMmmeeCRXoVSu1AIB6M7IQ=;
        b=WOqKG4pCG4OG7NbKOjdPUlyrET1QwyjhNoXM+aIOZw4h0mqTSFrygPNgZWNl3rJbMt
         ML1pg1BjoWcbeGwL9iWhIBhRu94ny8XE0YqMSBcYge2bqQCuYxe6MX874k7SY90mzw3Y
         jII4mgP4SW+9kJcE8r5WwgwTH67+Na/lflvYaG9d2yMhYIbQaWYy6157X3WkK+fwEAeZ
         TFeIKl7Bl19j1EM4wzKjC/hLn/0dDGGmOKStF0nzGx5lrmYtksNqbTpx4hRMh8ikb6g3
         3QNQuzIAKHhNiAI9PEpmiGHCmsLVSSCwkoYoAnvMyKiyBHS8WVu1OkICCZv4IWS8SnCI
         rNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fPre9riEtsWDn3nT/Sr4LcMmmeeCRXoVSu1AIB6M7IQ=;
        b=q3bKU6R+Lvj0YdeGqbAAZHCTbou8zrUca7DCpHHhIE2o/BHXyOByBVW0FF1EL/oA5x
         PZW8+RjDmPyrIESMQ+HGesGxXZLYzuMGpWzDd55Ejt9WZaPgESmK3ZU5upAaEKMorDSc
         V3G4Fssa430+/3i3X7o7HegmZJtuaVFYkfZVjxAefG4OTsXqJ45xZhZZLpxpnno3xNL8
         7RFFN9Y34aqP1Kstvuy5KTasq/lAnhQWBdRSikev7CGLkhIzz2X14HGnPPq2jvdtyAFI
         ylaG1CE8L+FvXblHYJ4MmNLbGJr0Vo7sMD1k2aALWf+Kr9PbatYkh9JxpNBLSsetmsC6
         hUjg==
X-Gm-Message-State: AOAM533DC/xDUyAFLrgEvnx/a1wKyl6B1P+7Tlg2M7rCd4ZT97M/Oakr
        tkj3ZCm+sp06g9huaM9QxzpStfUWZmDT6ISWU24=
X-Google-Smtp-Source: ABdhPJxSAVWIMsARi3nfwWxlFk7SoNUuPOxAnFKLyn/tb5cb4kWVXe1gudHXrJc1oNAyYUvYK7dAfI4tbix6w58R9is=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a25:d48f:: with SMTP id
 m137mr655048ybf.109.1633025154238; Thu, 30 Sep 2021 11:05:54 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:24 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 08/15] lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use an opaque type for lkdtm_rodata_do_nothing to stop the compiler
from generating a CFI jump table entry that jumps to .rodata.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/lkdtm.h  | 2 +-
 drivers/misc/lkdtm/perms.c  | 2 +-
 drivers/misc/lkdtm/rodata.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c212a253edde..2da74236c005 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -137,7 +137,7 @@ void lkdtm_REFCOUNT_TIMING(void);
 void lkdtm_ATOMIC_TIMING(void);
 
 /* rodata.c */
-void lkdtm_rodata_do_nothing(void);
+DECLARE_ASM_FUNC_SYMBOL(lkdtm_rodata_do_nothing);
 
 /* usercopy.c */
 void __init lkdtm_usercopy_init(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..fa2bd90bd8ee 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -151,7 +151,7 @@ void lkdtm_EXEC_VMALLOC(void)
 
 void lkdtm_EXEC_RODATA(void)
 {
-	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
+	execute_location((void *)lkdtm_rodata_do_nothing, CODE_AS_IS);
 }
 
 void lkdtm_EXEC_USERSPACE(void)
diff --git a/drivers/misc/lkdtm/rodata.c b/drivers/misc/lkdtm/rodata.c
index baacb876d1d9..17ed0ad4e6ae 100644
--- a/drivers/misc/lkdtm/rodata.c
+++ b/drivers/misc/lkdtm/rodata.c
@@ -3,7 +3,7 @@
  * This includes functions that are meant to live entirely in .rodata
  * (via objcopy tricks), to validate the non-executability of .rodata.
  */
-#include "lkdtm.h"
+void lkdtm_rodata_do_nothing(void);
 
 void noinstr lkdtm_rodata_do_nothing(void)
 {
-- 
2.33.0.800.g4c38ced690-goog

