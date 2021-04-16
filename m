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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62299C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3731D613CD
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbhDPUjQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhDPUjP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE4CC061574
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:49 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w3-20020a05621412e3b029019a7b97dd69so4951342qvv.14
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RbFM/FOV0/3txgisl3034f4RrM8GnTQruaePZt0Evbk=;
        b=f7Bw46plZOqlptGDXST+MXI1hXmLkbQvqIezCVQGQqI4O5mhkaRHCID1vyZcdPONT3
         jx8yEYK7mIJZXw/SCKURxP3wAK5L4o2KyTJD2LFYiL563Y5zofxqEHaKqSWqo+hay+LB
         z3MYRqy6T3UyLWZy/O3/fhDwMg2PJeVsUP5cjdUgB7pFaWj030kAUPnYmtuWfSHvOk9z
         AeVa3xvxQ+dGCZVN4QKtTSnobHUDAzaINOlnc/arbM6EXDg5GO+mhurjQe/xFj0Jqykn
         S8iV/y2tecn9ldXNpCyI99vVbhC7WyrCQw/o8t7uQeOdkTQEw/9//8k/gATMWz7uHIyF
         1yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RbFM/FOV0/3txgisl3034f4RrM8GnTQruaePZt0Evbk=;
        b=fZ46+EXH0UBqpR8GsEAu2Fuef4uQ3HyeOhZc/FIdfQKdYSYUezcXhkMMQIf1Xc+OhY
         8z+16u2jq70sYrVSp6eKeVKAC8K+BClqPVmokxMdpflyzPASvf1++TD8uOlCTByW4s+h
         /pvM17GNY9cIEgwmPOYvaZyMcVGP7T6s08VAwGLYW+SDbNf2mPRL3nRU2CgjVZEMFmWP
         fg2eEx4S5T8hx4G7OCait0SOoE4P6tALBC4YaFh4vGQZw36hozl2TiZGFLLo7LvC0sPT
         jl/rUSniHX10aPv6M1fi1IuV2egEgCOhCDh9C2zEgwVhK1C/sbttdiyYxZls8JcQJxJr
         mjAA==
X-Gm-Message-State: AOAM532iOmdbXSKIuKDzsE9rF5dg/MuS/m15glyrmADsdePNyvuJYs2n
        aaa5Wz4G5ecfkCWef3piGmUCIdAeUyQ/tP/NopQ=
X-Google-Smtp-Source: ABdhPJx14/HIHrgP+PDvi3GMAUmLbEk0HIqe60qxMsDGjOaXLdLsX3bhei5pkhEttzRftHK0AOKlKm8rbOh7gvJ0+zc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1d0c:: with SMTP id
 e12mr10335145qvd.0.1618605528476; Fri, 16 Apr 2021 13:38:48 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:30 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
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

With -ffunction-sections, Clang can generate a jump beyond the end of
a section when the section ends in an unreachable instruction. If the
offset matches the section length, use the last instruction as the
jump destination.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a0a8ce61cd4d..5fd60e055a5c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -870,6 +870,10 @@ static int add_jump_destinations(struct objtool_file *file)
 		}
 
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
+
+		if (!insn->jump_dest && dest_sec->len == dest_off)
+			insn->jump_dest = find_last_insn(file, dest_sec);
+
 		if (!insn->jump_dest) {
 
 			/*
-- 
2.31.1.368.gbe11c130af-goog

