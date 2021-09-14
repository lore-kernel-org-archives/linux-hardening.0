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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53EC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6578661246
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhINTMU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhINTMS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:18 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C1C061766
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e8-20020a0cf348000000b0037a350958f2so793279qvm.7
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9mJIyUqootgRNTBiBt+8dXdqm6+1gSNLr/rJAR02zA=;
        b=Pf/yJENmsDHPVrKOCs7o0dEbd5TU3p9BMGkHoeSTGNwEHhjRdzECfmow0BqmDVllQz
         WKMtAPK4Pk4TXKh+amiaqRBh3Z3ALCtQ+FoD9wpIk7jwBrnXo5xYiPQMvtgOt8qpO1Fn
         vyNMoxgcPqs92XItc5iiF6novLQFrcrVSeLVUB7OQXAIS+DzFr+YNd9WsbP35QBUGY/w
         CoHeipLM8r6/4fIjMDyjZ9Fa/xBaOvjx+2tFlFAhJ7bSzOV3gKce0DyhFJk9ifg33+RT
         gnj+Q7Ex/GF/BS40DWaQVwVC2SCGv1otH0UsAaqDOZaX5fjAikeCuE1uEpent+K6JVXz
         Q3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9mJIyUqootgRNTBiBt+8dXdqm6+1gSNLr/rJAR02zA=;
        b=xlLpHkl1Xnc9QVLTHbQQvvOjLMa+G6NH+fVFEIAZbtMUoYEQfC2bQxcrBrTnO/Uj8+
         mE5xYn7RDJDeROhMGykxZ5yQ70LCm9V8iwEySGO1qThybqAjPvKC+1Uxw5pmmQTwa4k8
         0sCHDeCTdoH0FQtetwr/JP35sZYwUQbB8toOpd8XZdLMjU4kinzZX2537T5Ga4+WWf0C
         3q8ttuv56IqvDsdHA+5bPb3vz/GlrMy4Ecn1SgJqjSe1NHgdWUT4WI3V002yf48aFNll
         eUDpk7J1MScVA4JGXGMJWD8PfYXtf6V60svypjVVtCNiH5Uo81NsC6lUlYxDN79jK/8a
         LomQ==
X-Gm-Message-State: AOAM530SiNc/E4tgMJEt7v9juZIk3BUSWEiJ8jIsk58f0bZmhk3ls+CV
        /alDBvVCKtcUBj6SIaL+HA/pTiYZ/8M+9WZMbIo=
X-Google-Smtp-Source: ABdhPJzHZdT/l7HIAU895z7Y+lhZHXrnjfKLISS83BOwvoTWOV5t3zlx6Jm6b8gbenEqLpa7OhId1hiwrbltZ8OOHvI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:ab08:: with SMTP id
 h8mr7159579qvb.41.1631646660085; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:34 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 05/16] tracepoint: Exclude tp_stub_func from CFI checking
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

If allocate_probes fails, func_remove replaces the old function
with a pointer to tp_stub_func, which is called using a mismatching
function pointer that's will always trip indirect call checks with
CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
tp_stub_func to allow it to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/tracepoint.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..58acc7d86c3f 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -99,10 +99,7 @@ struct tp_probes {
 };
 
 /* Called in removal of a func but failed to allocate a new tp_funcs */
-static void tp_stub_func(void)
-{
-	return;
-}
+static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
 
 static inline void *allocate_probes(int count)
 {
-- 
2.33.0.309.g3052b89438-goog

