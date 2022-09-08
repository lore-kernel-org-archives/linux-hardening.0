Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2AC38145
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIHVzO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIHVzO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73615A2DF
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l12-20020a25ad4c000000b006a8e04c284dso6503ybe.11
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=E5MP4taEQT0v3MmrVmyzRF+/DATosXuoXnrYsLQHUt8=;
        b=L0Iv4WoX7t7oX0WurXOJImKj4FKAQ7re2UnLEhWMqBVV2Fb5NfTnuW2Td8go+/9K6n
         SkH9GL97wuofrg9xGkIn5kyIhAmBJAxgkLl96Z8R1Hjdeepd7iLXs16r2vNEOmNfB6NN
         pYrZR4o/znOy912UFas2yKeS6IxtwYS6F8YZh49Y9glgRCjElvb2XKYZ6p18HeHKrID7
         gF5K1Aj4DpSyZHEytLRiRo0RwLicqziomG+WI7ZrmK+m7giLGz5jMh+TDkwJpV28iRCk
         HI/6sbkn6jWBGV6ukL1Xo4ySP8vpvjZEZELv9aNq/CpXKxA+cVnME5odPvthvt74Vh8t
         PlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=E5MP4taEQT0v3MmrVmyzRF+/DATosXuoXnrYsLQHUt8=;
        b=I6IMF9IPhr6PBF4/k+947O768LerE9wuzj8wncMZjr3D4QOkJ/0WpMnqDei6UOFCZB
         pSiQl3/wsChSNcSIqTJdpRhzgfxc4BfzAOJ46T1/L/ca0DUWhCYxpFTJUyiyktuuos6E
         Zrir2cHiy04cDyUa1Scrh5sRxvLLQ36uUaQIPsN1yeioPMLe1OXAB+FKkzfY/bZSXLQg
         QXLF/4vUOqJ/7pCkVPlVFk+cp7CyiULtw5m5GSsJosqnHn5jVOeCovIC5FbFbiU/G2TZ
         bsanSkCdvrhGXsh/Ae5uCyUZoyYqxmauyQluCc0hooewAlcxMldkE65c268SH/7qzHQX
         tO1Q==
X-Gm-Message-State: ACgBeo1/afqmXLCwfsWFEaD9bqa6AwmhEgLqvXqliIZhUQpQljrZDwkM
        4gdwD1VPVvtCVHkRqYjJn5adMXCj1nnQPJlr8Fg=
X-Google-Smtp-Source: AA6agR405k5ikQwnvuDn5SVwnN6wLe5SN+NO6wYS+1bv3HntlAG2SOkyPiCtLnlkgBLkiab70NT9z3nfmFmzqG8/h4w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:e401:0:b0:66e:280a:98cd with SMTP
 id b1-20020a25e401000000b0066e280a98cdmr9395449ybh.540.1662674112156; Thu, 08
 Sep 2022 14:55:12 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:44 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=samitolvanen@google.com;
 h=from:subject; bh=Lh36Gb4BQjSISqwOnlA1V8paDgitJ+WqG6DvavOOD2s=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSzrVY+vd10oEbk9xRXIoCFu1ml2ON/ucyrRCLU
 kFTNLaaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpkswAKCRBMtfaEi7xW7vDdC/
 0T+hmkD8EM0RGtayG8NWtUqkvZSj8cNhp4JVPo0ZmXjPbKX0vB4cnrvRNfMCAxxWkXMiyIOjn7rlCU
 ZT0vqj0O4durfcDKdeoLvdOpmgmdpHgeuGIjsJ6Bqg/jOiZ9BRWRbkeblhhIkdJYQ3zI7S20k1kjFd
 juV/s45NYG82Qds/KpEHXqoyNySmSHrowOYqaUonQv0u+PklBZpEIup6A5zb3x/lMx79rtigk0VOIY
 eSXbPLsufZXtaU7R+VIcyMoovGSY+rkYZx87gGozk1NcVMZONyXqiKnH0giKpRZYXyl8w2cnxubMVF
 SP2csMdnJJfFebE62u8kNREg86O2VLozoKYT9wYD3c0u9hCqJ7R/xjsqrA2wmQ955d27tD0zmjg0Db
 N+VwhZoKY+QMxOSysQScJ8GNMEv26OEHYdgsVW3ptZoDLv9draG1Lpyu1Hmgscmc0wyrHsn7UMpIDy
 18ZZT/0e58vrIeERnxIJd+NH1H+wNp9jN1zHiWOlpKV0s=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 02/22] scripts/kallsyms: Ignore __kcfi_typeid_
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

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in kallsyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..ccdf0c897f31 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -119,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
+		"__kcfi_typeid_",	/* CFI type identifiers */
 		NULL
 	};
 
-- 
2.37.2.789.g6183377224-goog

