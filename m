Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F615C4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A276140B
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhHWROV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhHWROQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64D6C061764
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r15-20020a056902154f00b00598b87f197cso6757353ybu.13
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k0Gm7u8L5tSmKVW+xlotholGa6yE9iw0uF/tHV2p52o=;
        b=TefnZXsw1ovvynSraGlA1+As/q+9xVcCWyqpliHonvceW0VLYAx3sHV+wdbEQip7lT
         iM5QchjhV6rqHETKec7PF3/RImK94FljwLXzqSwhmxMMZzWqBgPU3RmtvbGsvFX/kQcs
         IjWfGPaxtlqqYBA9FY4jYD7leJMhO2e7VEtxJDdEy53fDXTlZwiXZfqufANNMF8Aqn1q
         HGuqbVqmWADNt5bqD5J7zQZYtnljw7wx2N723QjvftDxWCSDxGmV0j9LaVB+hGANmDIq
         ylQRAbOgPHhcp4GqoR60aXUyGlMriolzJODHNkhV2QmBQNNJbYvJQSiRBxVckimJGDkz
         yKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k0Gm7u8L5tSmKVW+xlotholGa6yE9iw0uF/tHV2p52o=;
        b=U3iJe+2WPqqKGiFY/aR3QkQjru8gkPPCNUiK84ZVVSS2/hHV3tAgoeFFvAr64SaQhY
         VY2zppC22Y5z5JuH2dMDwl8h2XqwEFT5DUmHVmUQCfHrLi7xdUd6UNxnhgbWWGbcY3Hm
         kgWNV7IWKlK7NW68eoNyi3oOhRMpsTgHdKWlXUqclXDMSuz3K6KGMSk12ScZ4ixbRBoS
         YqBI7Xo3HBfIOjsqZyeUKD1stfzLA2n3Lz2s24rMUi8h85+BtVTBu6+MgjQBujoTxFcg
         svd9OXQf4Y3ntjGI6slTRdaFw6Nq33bB43iZ0uFNtEOlPUNruGG/Lh87Iik43AHW4sEv
         rwhA==
X-Gm-Message-State: AOAM531wbYokxfbXmARkq4votZ4kfxuCho+RkOigoC8c8g7Ufd4pUaM+
        pmhJTEba2k6r8NJ/ZtB3aG8XwFGGdDAzKidFYlM=
X-Google-Smtp-Source: ABdhPJyx/GQSOWYSoc1Zbdbw/tpxR1dF+HznFS7w34jPMlo0rvu3YqqIMH8KRsr/ZDfW4oKqcK49kJ0r/p8Q4qeFtaM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:2b85:: with SMTP id
 r127mr44980616ybr.232.1629738812933; Mon, 23 Aug 2021 10:13:32 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:09 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 05/14] lkdtm: Disable UNSET_SMEP with CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Disable the UNSET_SMEP test when CONFIG_CFI_CLANG is enabled as
jumping to a call gadget would always trip CFI instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 88c218a9f8b3..bc3e54e580ab 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -366,7 +366,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 void lkdtm_UNSET_SMEP(void)
 {
-#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML) && !IS_ENABLED(CONFIG_CFI_CLANG)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

