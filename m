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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118EDC433ED
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89AD613D2
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbhDPUja (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbhDPUj3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:29 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01148C06175F
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so4592230qva.9
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gU1hOjx3K7IYMK70RtBuGAoh0CWdKH9ubIz9k5V8HEI=;
        b=qnTY33/TYDr9Xvg5TYrpjX+9v7evpKhX+xdQCGNu5E4HtLXpDdp8wSbAU0J2BsOxwD
         KA8muBta7k72GkBdRtBSqH1brqL6Ycbe2m1pQ8/lq9lhaikv86shjHyMXNuO+fhlMQlE
         /CryjQTT5qVpt+pPBec2b3fKR3MvJ5jFf0WHv2LauKYtfORG1xa5cC9/sXGKGaS6v01l
         LWo8YYdakTDtVSqEVaDmQQ7ItC+FPQkba8mWEDHKKBaEkEk4PuHopVzWU0wWYNSEV93B
         mh2CEdnxEeEPFnhVbVF1+QGqL6jsaqwfXF9+Lh1x4oAo3/SbE0nii88Jx5RLnZUbgkId
         o/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gU1hOjx3K7IYMK70RtBuGAoh0CWdKH9ubIz9k5V8HEI=;
        b=kp7V2Cz9HVVNfuOpJz1VDWp8oK3hOiCakbzszaLkRfryJ+6BnHjbU4VS7oD4pNma9l
         ByRHoXPSmhNq9M5Yg2rJna/9Mr5RT1RAG9d+hr0D22W1Dz9a13HmubnVWhKzK3nS62ex
         8aXt5FsRAb/VNYnLnahHRA5c3siRAf+8b+lpWJlgOD8roLD8u7Tc95sbf3Bp+s+/XA9t
         +/3T6AsNJxdfPhAQuNNlsOejc/f7oHpj9aYetEj6ZljLfHkTuZ1p85vim85Zdt/yltNC
         qqbTYzA2yag1pU8vNSmWkGcxrLEsSU9r7VLEIe4tgdUp9w7fnNDKZevR4wVen0Ebus7v
         aRjA==
X-Gm-Message-State: AOAM5329FVpVb91QDm6PQ4xBkwlD6Hh2Pk9A1xCpVSugwF2ZHMv9bJDz
        2s7rXmR3dVT2hwjiAD44VRCVN25SP7az58Ro2JM=
X-Google-Smtp-Source: ABdhPJxteHgJbT/1BjFZeoPfDfJRxoTqi9nMz9MOu5KRn4NwNpdjN4ilFRIoY+2W8/Iu08YaFgTQY0npKfuaR2h8jzM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:176a:: with SMTP id
 et10mr10444816qvb.23.1618605542149; Fri, 16 Apr 2021 13:39:02 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:37 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 08/15] x86/extable: Do not mark exception callback as CFI
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

From: Kees Cook <keescook@chromium.org>

The exception table entries are constructed out of a relative offset
and point to the actual function, not the CFI table entry. For now,
just mark the caller as not checking CFI. The failure is most visible
at boot with CONFIG_DEBUG_RODATA_TEST=y.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/mm/extable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b93d6cd08a7f..a7eae1c4c59f 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -155,6 +155,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
 		return EX_HANDLER_OTHER;
 }
 
+__nocfi
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
-- 
2.31.1.368.gbe11c130af-goog

