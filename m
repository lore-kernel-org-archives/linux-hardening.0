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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F160C4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6698461423
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhHWRO2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhHWROX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:23 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85EC0613CF
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:40 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s206-20020a3745d70000b02903b9207abc7bso12332669qka.4
        for <linux-hardening@vger.kernel.org>; Mon, 23 Aug 2021 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BYMhGy+epBtHbIYQT2/VbUiIkPl/Kv4Ems36NpeUGps=;
        b=wT0V05nbcLtKte6uXnUlxE52FOtdLnLKCupQHGQRJf16S2rE9Ids9NA0gz3Qev9arc
         k/a1BmTpNar/ew1KuYgFbWsa9Hd7abezUfV1EGIX9ItkLJlPMAtrIwBQm1SUyUfRBcvR
         Xr+kamQphUmQtMBsy/tgLZtXd7i/pWvsYgWSlVO20GdhlNLif9AyfKvI72ySabnAk1AU
         YQSTOlYLxjxC64U0Z8LllnN2Uf28waRqdV/5NjfXntrfjzJ5yDWPUyc7XJ6ViBnDUri0
         erHfjBnjz9nZKsQTvtmmke2PwOpW7jBd0Ij27ONud4W+BXjk+auaDZp6zw3J1QJGv7NN
         tG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BYMhGy+epBtHbIYQT2/VbUiIkPl/Kv4Ems36NpeUGps=;
        b=diDQa2QgHAHkGtyVBhw0UEwgSu1GEbpY4gcEFUGN6Ko6ifxSJO66iT/g8am3KbJfCi
         YaD53aQwhgmO1gkaJhh62K45vP6kwazeuFcPXI5c+lg2Ro9WjknlCA6cQyAZuSHTIUCh
         ILE9jT+0K71WxtUMtcB846iDsnFkWtKFg2j00MNt0QG29Nun7iv0u5YRsUiEcETZFiZY
         UA7Hc7ZEyNLGhK+fDEaYT9JnzCV0T9n9OfE7uKiSpt0JqhX86ku2MBiFFK4XXmdScx3b
         lSDHZcIWB3NXDeyiIlgdUuxhCpu4NOWGUHQX7gmWURMtUkp+fpSD06CY/J6MIxPuN/Ny
         +Q0g==
X-Gm-Message-State: AOAM531fJft6kNq5eHzzwNfL4nT9xc0AqYpRVNssD/kCuTOZUxqSzn0R
        R0U8n1Q5l9mIKG09ZYiL0BZB5SIVpDG+Ty6RktY=
X-Google-Smtp-Source: ABdhPJwiVYYbpwCgNO4jaCxSi5gp0M4KQZKNZEPiQ9kbx3ytaOBPYGiiWpIefhbqdr1fOsij3cYx8walgEP31P0VulA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:2623:: with SMTP id
 gv3mr11237178qvb.9.1629738820095; Mon, 23 Aug 2021 10:13:40 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:12 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 08/14] x86/extable: Do not mark exception callback as CFI
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
index e1664e9f969c..d150d4d12d53 100644
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
2.33.0.rc2.250.ged5fa647cd-goog

