Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FBAC43334
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbiFJXhJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350866AbiFJXgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72B2914DC
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v127-20020a256185000000b0065cbe0f6999so518310ybb.22
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y96fv5Twtvzm6CyIpXWKw8Jd94PeG6V8wybz0+yAnX8=;
        b=IOPZc5JV3nT2LYllhUNSqQYadg1pAF7x0nJHGRfuoOldyA3IF4MfcUfi28kwW9bjK3
         ZkOn4EyemcOKcBZ4lvbRoM88zdr4pP/X6pNrmQS+Trrh16VsFWzR/ivvrnkgTFcOEBeq
         zh4c1XSjaFca/mNv67WEZZRQg6ZyEcv2WeJgQKjPKDJ+6inRCnLsR02LvK76lq7rrygX
         kc4b07GD1ORl1Vkg+OCQkeYlNtADbEXYf/V4ORhUII4xOAh9HLKlgJsAnnSOy3K+JaGt
         GLg2Vk1h8xnuWJsYbO4m9Twpc05icIIuVq5OYgfBIvRgF9MT/sXYCcHdZ4chr4Z9vQ5Q
         kXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y96fv5Twtvzm6CyIpXWKw8Jd94PeG6V8wybz0+yAnX8=;
        b=krYgr4Pm14+iBEMjkWObAj5zrYOGEiaR5lBHyd72IqHPXsCv6iGA5BDqlmIKJgUu5b
         hG0D1AGxsOT3VyNnBm3v629TLypHNbHI0a3d6vqBQpBlFirRynHYnaUzu32LJLKizA1g
         VMEGBDE0KMtagRiv/yH94rnYKz28xoIMvRVQeYmCdPvQazo03WPdu/yMEodONxR3O7hp
         gUK2pqoBX36PMKSsXYTiv1ZusI7ZH3xTFlBDSNI6+pAd9zjlWE7w/Yjqmvb7fGAKShpk
         BhQXGkKtGW8R3hnXuww5nvnsEPe1aApVF1IUfGaRo4CFsGtgs/QEmzAx1DOutVduGmeE
         sndA==
X-Gm-Message-State: AOAM530ay/5Ou2FDoMOi1h8DFXvXkN3BxEPI5Zw3TVchrbPkXRYmYA2g
        XHl/kPtpUQhSPhZUim47C6SUQAMqqgMlvzp6/lo=
X-Google-Smtp-Source: ABdhPJy9bfekC1t933fOPbzFYENcQN+eqW+7EGnrnrzBGcNrDj6mBwpdrX+ZIvaajj0sxXWUKj9zyhS/v8ScejPId0A=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a25:7901:0:b0:64a:a1d9:43dd with SMTP
 id u1-20020a257901000000b0064aa1d943ddmr45895436ybc.271.1654904151760; Fri,
 10 Jun 2022 16:35:51 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:08 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; h=from:subject;
 bh=BzYyCCjIKMVIFOaxytMd//v1RLhPm9T7iP3/4Zx5xVM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Uusl/O2s6wYiJP/kbTa1chVv26D4F+cGeoouVP
 CLXe2fiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7p5VC/
 9Ik3mkvkfwpcvMaILAG8ecfZFaAeyupedPFpv7JfK5CDJfRdYJy6I8IwkF6zyaPwEpszbFtzIngJp1
 9VLVbi4oBQefo3DpNAVs92FiUcWdUCTKkV7FZtf1KHmTbcXiDaSei1A+sMXqlbWgwS5aukcZ5H+NRj
 ez76Hc3KoZRoN4iKlxLcKRNHKXpC6fe9Zie7IPO1sMkA1OXATSdGQfVw+6gv4q0+ae1ZMD/7994o7H
 svydE+m5htCfP8PK65SJBa8zHBM6ew01HQ1rYygo/X2Sc5yi/4w8Z/ysL3lacG7Jweqr21P7GnS2fR
 EkYD/xUbl9UA4W+IlBSY9HuJiSpiS1MbhICEI2OvNo0BakVlcF8T6rhqcGPF8IKLB7N5SjJnFWHOtd
 5iRHPAaDebe6mi//sYNB0DF52K4EuYa7vPMeX54NUVHcDgamHQlZhqAna7cOgDvpSiS34oTlsond2r
 LOwD6icdz2QqTZkK/eZRy2JwR3ZYdCMaJ91x+ll6SUcLM=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 15/20] objtool: Disable CFI warnings
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

The __cfi_ preambles contain int3 padding and a mov instruction that
embeds the KCFI type identifier in the following format:

  ; type preamble
  __cfi_function:
    int3
    int3
    mov <id>, %eax
    int3
    int3
  function:
    ...

While the preamble symbols are STT_FUNC and contain valid
instructions, they are never executed and always fall through. Skip
the warning for them.

.kcfi_traps sections point to CFI traps in text sections. Also skip
the warning about them referencing !ENDBR instructions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 864bb9dd3584..337b92c3b755 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3207,6 +3207,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		next_insn = next_insn_to_validate(file, insn);
 
 		if (func && insn->func && func != insn->func->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (!strncmp(func->name, "__cfi_", 6))
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
@@ -3827,7 +3831,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
 		    !strcmp(sec->name, "__mcount_loc")			||
-		    !strcmp(sec->name, "__tracepoints"))
+		    !strcmp(sec->name, "__tracepoints")			||
+		    !strcmp(sec->name, ".kcfi_traps"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
-- 
2.36.1.476.g0c4daa206d-goog

