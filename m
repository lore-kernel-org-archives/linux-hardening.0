Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0831CC43334
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350991AbiFJXhb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiFJXgx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9E2997AB
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:36:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128-20020a25dd86000000b0066073927e92so550941ybg.13
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NebnbUevd7O3L4DZUnHH2cfPN5CPKXFBfrXdmTOrusA=;
        b=KKJz0ETKMeSBcMXnJZjZzeLcSxRSw/g6ohEJqB/0rJWBgf4O7ADHPH5kU9Xluuy/XT
         3SlAe7Z2V+5bh51W0KcedotGu/qgjThHz6ojq/xqG3z9PbC4K4Xz+xgc6hTpQzNLaKgi
         Xbsix6EkV+RvNC/YiWwda98NnsfGpQ4h7sS9l+4FoYRnJks6OhV2lU3T8FOmsDsgUBBT
         3Y06pvNAxA2Sooe8D9naqKp7IjcYWnBD27Ep2iihcbGhxM2a9yPNv/UsuM19hWUqiHxo
         crcwgtBlgH40phoQX67UjusAcKfvxfyDl2nXhnMBPgQWXrpXgZb+17RxEgaNl/ZxRXul
         UJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NebnbUevd7O3L4DZUnHH2cfPN5CPKXFBfrXdmTOrusA=;
        b=xwgC1CPtKpXAPNIyt2ROANLHHKzx3xd57A7OIhRROOSpHD/VwJw+w7ZQ6Ozs9zlTcq
         aBlk8srBhnIN/UVaPjLwn9pnV+fh0t/ICvpiF1AQIGduXS7JagoT9HRvlMal7VkGu2Il
         hxs6LwFKzfzGWbf/zv9++3FYPnHRSk7K5wztP4LTGygsVqrcQNSp84pS04ncYxbEWRqW
         DbD4Jjy+l29/OGUioBv+3P17/0dI2YlYZ09RI0dOF9xw5ov3j5h+iKfQb/+Yk7zulhn5
         U4sRZy4RrmtflSMzkLrq9QU6h04NbK+p/p/kMRwubbXB7xBSfOaNTcYIxS/yZ9v2273L
         TxYg==
X-Gm-Message-State: AOAM532knLjuiFtQSDu3f7LHPC/kIsxxiYu1Z2vmw9mx/XgTYd5RSTV8
        He1FveuqBQrtLaRtMNDKwLNWqg4dNXYF2Uzuhug=
X-Google-Smtp-Source: ABdhPJy73NkoCpX2nYrYNZCDIlzOJNtXCf9DaSoyKSy9IAHEUYo9ySkQOZFLTvi0faxx0KI52nrC8nXKkuoc7+egsDw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:905:b0:64a:2089:f487 with
 SMTP id bu5-20020a056902090500b0064a2089f487mr47802874ybb.202.1654904161997;
 Fri, 10 Jun 2022 16:36:01 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:12 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; h=from:subject;
 bh=ArPYWKwU35vK9Q7fuJlo1ALDBI9fX95H0CE4usoZ/3Q=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UvnQCq/98P6oNAklKJC8WEg93jIEEZ3s64nlfE
 jwrc2t2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLwAKCRBMtfaEi7xW7vmmC/
 9Qrdc+4b2GDVRqmqvGAW33iyBJiMYbCO4QDRAxsqvRUhT5K1vwyy6qVCAUsRMiltfbmxmPfrsqZJ4N
 hVmPqbb/xFmJ4/2VWkeHN4jV/0Ms9EUsFTVsPjSguMqImRg0ydJ4IIkrzddZZATwLAd87WWt5x6woP
 CtHUksEZGn7o4Pp5ct3NUz83Hb6LHo2m9mjOGPg1r33oforu2vx/OfVCEjx73Xcxo6RDIH3UsDuD/g
 /s3THqOg4srXhMfFGuDwEKmrtvLlhmpsNQIsAHYQMsq+8GlhciaZg121OkGkS4sL/rnpTey/W3To3I
 duP0DhDBHWFptNY8nhoygvOPOT7N9DVYfAJ0SrSvoOo2h7FmdAi5XhhyvjVZvys4tcp6shnIG175cb
 0lmK0RZFZpwqCNOr1PORsFlHiTeRUcKrve4AplmbR9zGkRHED1lI0LtXSbIIcWu+5IP8ooqVNxOVYr
 sCtJLXG/F9yAngLbw5kbgWwO7iZTHLWHbfFTd8TAmbaqg=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 19/20] x86/purgatory: Disable CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54d7959..b3fa947fa38b 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.36.1.476.g0c4daa206d-goog

