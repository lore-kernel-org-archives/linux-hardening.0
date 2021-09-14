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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A9C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51C461168
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhINTMo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhINTMX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491DC0613C1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v66-20020a25abc8000000b0059ef57c3386so248654ybi.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o9zlvChvYLfCJPEAl+GNaYLnnN7AesCgwEyyTetB+tE=;
        b=J1J4RNJCG5IJxhbVrSYN57KH0YqrJhz5QqUeqgt2MQNz++/8rrWon/Gcs0IyKlZjoi
         T8crJmahsGvezL0mqxB34RBHVghRkfcMAsmq2qTfrhI8kJBph9GdXVwW/kpRAVIDckS6
         WZw+RxaC3Zml+gZeTtJ6jBd6DGhZ8I8xHu2VIZMqyTiRPRxSf6ZhJTzCs+FFFE95DvWL
         gc1abnUI2+yB4TvitfmsxyRYpY8UJF1IBQK/87GW/06AiPbLLYzH7vrSlP1BWC1/y2VJ
         BwrGnM4AOyN5waosw4wPU4VDHQDYiX3wD5Lak2+25H1CZmjh42l8xLsRcJtqV1k7HYhE
         60eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o9zlvChvYLfCJPEAl+GNaYLnnN7AesCgwEyyTetB+tE=;
        b=XfhvRroaQjDPuo6VPiSLVstgA8xWQzwJAKSjZh8DivyTguY9N6wwaPFRUxPi/lJ1lj
         nTnMcmMEg4CeXJmj9J6qyn1DFwQTbsUUqSKimc7y5CYqL3+8MCwlHZKYE39dp4LLw3Sr
         PtJ5c+6X3sUa6pTLiqB9YLtW5zgA6DjKorurJiiWF3NCyaHX753QB8iXsTiOyYODNDKC
         hSngKsjgBpywBQ/TsTseQhM+aOkI2kpirY/Ki7bD+bffIlmnEme2JnqXlt9CuJgm2cpX
         iawdJx0rOwtyirmE8YeygzESZhy3C+Hs9RWWIME0yzPBo7JPldGfxfKaPsGlq0Tmdh9U
         jo9g==
X-Gm-Message-State: AOAM530IefOUFxj1L9ygX0Rfkj+if1S4QsULFLUnQLS6N4vhzOVbZJ4/
        wINhJUPW1Yj5PF5GkpH9aYIxxyECXThQ8SUmmdw=
X-Google-Smtp-Source: ABdhPJyi7hm0g2zkjI9/ykBSTrcxC9ke6Ap7VbM9DhYFuL9m1yjgDLj8f389qGWKaSH0X9otYN51fwy+XF1I+rx2TUY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:1d86:: with SMTP id
 d128mr995357ybd.406.1631646664490; Tue, 14 Sep 2021 12:11:04 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:36 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 07/16] lkdtm: Disable UNSET_SMEP with CFI
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
index 4282b625200f..6e8677852262 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -367,7 +367,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 void lkdtm_UNSET_SMEP(void)
 {
-#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML) && !IS_ENABLED(CONFIG_CFI_CLANG)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
-- 
2.33.0.309.g3052b89438-goog

