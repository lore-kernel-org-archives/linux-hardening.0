Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E6ECAAD5
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiH3Xde (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiH3Xcw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BD832CD
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f12-20020a25b6cc000000b0069a9e36de26so876192ybm.16
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=QaAhiBNrHu6GYkLFA3B7rG1GS8UtnkRvQfTpKHPiaFU=;
        b=Uzu0hS7fYpQn9SuqY6pJYAs0mwU+Cbcm7VfqttztC5Y7vvGMMQbw4wbd/rsgMajhX8
         hCYkTHXcE5WgpL526ftRFAS1iaJreodEJpABN25rLzozJPt3fTcwLmVcYcs0vcC1nhlH
         yp59OC26/dM0xfLKycIeelmnMx/ctiemiWAngqrglcx45erw27Nl2sLJAj1c3kLUftM8
         0iSFHBjA1GYjEC6cZmd4UeYpgAKFk2VTxcYmGZKFX6zgfodGL620Sb3emlMY85C3OcAo
         bE5fs06VNU0/03FLltVrwNWpMmfeDGopu8w2Crj1CckQW60JmF6IEikz1fcox97zq9e0
         FlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=QaAhiBNrHu6GYkLFA3B7rG1GS8UtnkRvQfTpKHPiaFU=;
        b=1qF83QxILBIkyMCjPvPkIHgujZVDkm4CpG78BziknAtystj6qgz3C6HEAw29+lRPwP
         1zgE6xy4R4kDS4sr83s+hydKC5bqHMMHc+HrFXJXfnBx1i6vr5oFNWEE91boAWlYuvkU
         p/DVXFu2+wg3LrqxM4Z2BWWS5TetuH4mpXsbE51MpSNrv79hfqMiF7VJ+9bqkfsrCsWj
         zotAb0XAK9AA5hnPfFFeCuNKl24VPOFlcnvcxwCAr2loB6mHY2NeRZOfpiCccn5hGGnc
         k/W4NkVc0MJ0AKALA7m+M2bB9HWIZvtvZcGxRU+VjFlVnKWSKxxUyYW0nTUQ8RgLnURk
         c7qQ==
X-Gm-Message-State: ACgBeo0ni3FH0F4IwtDb8qcO1LBGrKgOBTFKx5LK6F/KxUdRfdf4bZ/Q
        X6YaXGbUNeZO4a2Enk0bYdd4NiP3xg2S8aBlbB4=
X-Google-Smtp-Source: AA6agR4FDK+ca8ExoQOJuxzStWcPg0UmoHQzTdwmwi9npQMvWgOYplZw4nRfd6yLznTzYg9mNTUtUOCVf41ZKmBVqKc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a0d:d850:0:b0:340:d2c0:b022 with SMTP
 id a77-20020a0dd850000000b00340d2c0b022mr13497429ywe.469.1661902336610; Tue,
 30 Aug 2022 16:32:16 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:24 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=samitolvanen@google.com;
 h=from:subject; bh=jQm92I9xQfCJPH6jkHCDpzvvJGb/s+FwIZvLF3ZcxmA=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3OLXWXp4dv7z7QEAEH5wDVXEoy6vQwE4MAgTih
 TKcGqJ2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7uhuC/
 4mLD2OTFFRM6dzC+U3G8nSByx2EP7YNHOfYlhOKl0Gv/CfgBF/GmPU6h3gd2FYTdIVAmx+Jt5i7jod
 yHHS4gZDl8y9ik+cOIJfaq9PCplP1qzBI5UZveW67TQSOg6aWHjQltgyelJnFQOdFAyzVFhcjo1ZT4
 RasjgLDZdDZaCQZXWXBTkwjmqg7yGU6nx6FTkZor6xheRDX2kEOcxc/tAIWc/F3tCwLKZO3b2OacxU
 kLhRFXfTjDHGI8CEMPaaAiF2HgUeJEAfx8o4vhL4zMeTDaKFmRQlmf7F9COJc6E7kag2I6rBVTMLaT
 FWl2SlSRnYF0zOFsCumLTWzpoCgAijPhDKp/uWc4Bl+x2WAveRz8IYR1rkvZSXXc/Y0/ys9658hItd
 QLTUDCSGboZ0fd2TFzIbCfImlNrGKDomVDfTKP6XcarqWEI1dc/zyJKjcz0KqduDH2E4Ieu9sxhkpl
 Xw4LrtrfDpSWz1SEU4GR+7wRiD1adQkP+R3N0lIVY4BnU=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 16/21] objtool: Disable CFI warnings
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
2.37.2.672.g94769d06f0-goog

