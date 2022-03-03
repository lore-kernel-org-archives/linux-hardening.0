Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA4C433FE
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Mar 2022 09:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiCCJHk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiCCJHi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Mar 2022 04:07:38 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504A177774
        for <linux-hardening@vger.kernel.org>; Thu,  3 Mar 2022 01:06:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c12-20020a170902848c00b0015025f53e9cso2595399plo.7
        for <linux-hardening@vger.kernel.org>; Thu, 03 Mar 2022 01:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2bQdkuF0SOPnoGthP45kPV6bs5nvMHTPUBqrBi7KDmE=;
        b=CwcLSYEWIYkwRIiSSoxKp+6DeCkwVywNCvkORnPKqsNTneqEIEtKoa1z3mwpqSO5W4
         C4EHKgRYdUXjCIOSBiph61mK8NoMu3VVGZdQoh1vzbAAj6PmbcMhAyb+4ErMMn/svnDL
         FP8rthWhTrzh2Va1j3Zfzp+FYQz4qCJD1gVJd7MbjNd/ghRt2JDE69B0eP4rYOZJWtNk
         iy8+/9w5gmFETfLE9rVgJeZuSKmAoHiJKgxbZtHPkGMaD2ChCzD6jJS3mXJoVYXdg2Zb
         Nn0/DhX7zv8c3bY7H6zzF0hk+Q/LD8THdUGTyGynCcth2eoJxJBm37j1FQ/tcNYb/tBi
         a+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2bQdkuF0SOPnoGthP45kPV6bs5nvMHTPUBqrBi7KDmE=;
        b=a8MIhv4LQEICpvvt5iX0MzlItPmfubPAlzR3taxVdpL8MZa+g+EkVFHDqcut1E41xh
         yIVbqBcCL1hfBODd8YDYKonZOLlAz2PmmWv9C2Zfc1yyOJG8/oP52pzkPizEwvJYgqN9
         8M7YhIVbtq5s4+L7TqNm382o3uXf8orlXHQAyt+wyzWKfH/C2+ABW3ACFHRdinZrwbhQ
         bKhF7xi9nTVuRKgdUoRJfNIAKdAI61mJj035zsfs+zQZVda7FtlXQbKzRkj17KOncwWb
         H3TmkjXne8RmjTvb7aa0c08o+EtiVNzLwBq1/lsoOqbW1EW4K6WipS9qUkXYI/x1xjU9
         g8zA==
X-Gm-Message-State: AOAM5326uzrDSoGuMPt1heRQSxOz15CYvhyKytGDROdru1l+fIhJk2J+
        RpZT33l9kxeFn1wAqo7f30Zp75bsiMsK/Q==
X-Google-Smtp-Source: ABdhPJxF438b/WEu22WxHZgv3A03n8SRdHWfJx5cX+REUymSJzQW01Ac5BTggzKnp1cW4D9MmVLPr1IGpLealw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:4b52:b0:1bc:b208:dc5c with SMTP
 id mi18-20020a17090b4b5200b001bcb208dc5cmr1023750pjb.1.1646298411425; Thu, 03
 Mar 2022 01:06:51 -0800 (PST)
Date:   Thu,  3 Mar 2022 17:06:42 +0800
Message-Id: <20220303090643.241747-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
From:   David Gow <davidgow@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The things built with USER_CFLAGS don't seem to recognise it as a
compiler option, and print a warning:
clang: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]

Fixes: 744814d2fa ("um: Allow builds with Clang")
Signed-off-by: David Gow <davidgow@google.com>
---

This warning shows up after merging:
https://lore.kernel.org/lkml/20220227184517.504931-6-keescook@chromium.org/

I'm not 100% sure why this is necessary, but it does seem to work. All
the attempts to get rid of -mno-global-merge entirely have been met with
skepticism, but I'm guessing that it's not a problem for just the UML
"user" files, as they shouldn't(?) interact too much with modules.

 arch/um/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f2fe63bfd819..320b09cd513c 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -75,6 +75,10 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
+ifdef CONFIG_CC_IS_CLANG
+USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
+endif
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
-- 
2.35.1.616.g0bdcbb4464-goog

