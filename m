Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF63C38145
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiIHV5L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIHV4c (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A4E2924
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so154254727b3.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=XmniUTEr3IsWekZR2qFDZKEfj9hJcfqgCneNiF7ztZE=;
        b=WCxXiMf9jt0TJXqJVxEGpO5FIe1m1i3ZGCw5CoV/rJ85nw+sR7A+6ka1r8pSYvcykj
         fdhPJfWapSH0tUHrJ7JwfesE8ueKIfcYHTxrBbgThkGTRj8VuUmZhwmCQ3RzlNEM2ecD
         z8ix+vkJAFymmihF+AY2LlKW9zCy2OxSuz73nD3s3LFpsgclOFOYtOtx3tG5ZwDIz+bP
         A+khvfFMbTOSY81mGX3NqvYc+QXhfp46q/BRrc+yAFDotGxiveN3rjh0XY2tB1HOxaXY
         FYx8Y77WPZ5fIYqlsyAut8OvfzqgiV3dRvDT5sKW7C/HCJM6xuapQF9Yzw/zFOz0vgK0
         uWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=XmniUTEr3IsWekZR2qFDZKEfj9hJcfqgCneNiF7ztZE=;
        b=aROH3t8cC6SzN+ZK2/kuWVvqn3hM6VCs6UL1UXbKyw7q29dFbDNw8BNtGxlDcS9haP
         rs9Ila+Ktb9mDebuS6vL0HSMQvb0DXJOH2DywzbsxVHZ4XpabDrdp+huX/ajvHW/mP5B
         rz6ytfgA6YRuDbPZ/sEGKu/kn4LyouTa4/W1kwZ6Feb2KfnjhA/DtW/RGFIV8yWRmi/M
         MEn3zoAyL6RHN01Q/wJPH+y4e0ImH+xHYNk2hME1w29w2uGwt1ke2PFJyByw7B6gpZTG
         Q3upDDzqeI9OdN28HrAiNWiZa00Yj+RCQaN8g0tzxM/wXAI3HmI33ajY6ZLxEX0bTcxq
         ybMQ==
X-Gm-Message-State: ACgBeo3xt1CFuo1uc9I0hwNrBaWV7v7yHRI2rRAh8WC2lZbZG0Mc6vHs
        06c4wVo1ec8EFymoL+XMIBxEd/B/BdEP/2hr5y0=
X-Google-Smtp-Source: AA6agR6M76LG+TWjK8L+F7Pickv1R6NBQMbIyPbnehQFyZI7o5/G4d6MfhU8IvsMdeYW6PT4y2h9Gv6HjQVCTyH+TGA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:8a81:0:b0:33d:829f:644d with SMTP
 id a123-20020a818a81000000b0033d829f644dmr9392736ywg.439.1662674151325; Thu,
 08 Sep 2022 14:55:51 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:59 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=samitolvanen@google.com;
 h=from:subject; bh=NWDsac0IgzNSFTJgx7iH+qos7yriFkDjm7ciN3deLwc=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2QtXco+6cnttk3ziU1CPssT9FS0Gu8RLffJMX
 DuiPTDqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7laHC/
 kBCEQg3rEEpwp43GQ48GjqbCieliDghyyZPPBekjsBnBNrdnG8Vm9GOSBSH6jHBKRoAaPBYbHnmBxJ
 hbAnIoe8iH/1aMV4X2XS0DnwRarAgGvwIT41btmUEvxO+gDCKbg/1aKwS3k77DRva2rgu6fxSqbY2s
 OprIgnrE7+GivPv5e0Mmvr0Hm9YIpYVHRLl+3eLqWZGc9nzlWEmVmnZkVM+RbbwCUfzbxeQ1BY3ykL
 ZvfY5iLCkg0vVolw3s6qlVYn2LwCoGvB66ee8Z5DiX8ZyGfNaPypyV/1qr5xvpAfJroafshKOsowU5
 +v/x6ze8NdAuOZ+7YdikfQwEELuZ9XXt63bCQ+UD/J8pjGQ8KBUSaXQLOKPmBga5+06qVi4a+PEfeq
 M84OhWdJiTRngnFB9fEWgGdP8L+iNYPNVB/x/IwOzi7A2pgIj0eJgShn2uIHPaPynu8nokZaaRX8EM
 Lm6ye3lWt59SFbyI0JEQFniLfVDG47lRJQZrTQ4ptFSUs=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 17/22] objtool: Disable CFI warnings
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

The __cfi_ preambles contain a mov instruction that embeds the KCFI
type identifier in the following format:

  ; type preamble
  __cfi_function:
    mov <id>, %eax
  function:
    ...

While the preamble symbols are STT_FUNC and contain valid
instructions, they are never executed and always fall through. Skip
the warning for them.

.kcfi_traps sections point to CFI traps in text sections. Also skip
the warning about them referencing !ENDBR instructions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a..48e18737a2d1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3316,6 +3316,10 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		next_insn = next_insn_to_validate(file, insn);
 
 		if (func && insn->func && func != insn->func->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (!strncmp(func->name, "__cfi_", 6))
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
@@ -4113,7 +4117,8 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc"))
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    !strcmp(sec->name, ".kcfi_traps"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
-- 
2.37.2.789.g6183377224-goog

