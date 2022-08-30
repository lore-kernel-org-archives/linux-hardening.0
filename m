Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209DDECAAA1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiH3Xbx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiH3Xbu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245D472EC1
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33e1114437fso190869017b3.19
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=V3t6t7JIbAvSA8Tk+dwJ0EP+zKfoVcWxCLBhZzDbf1s=;
        b=BJZRO63b+6qTZ95mYkmggV5gs8KD4EmwXqxKHDYQCmIwLDm3YgniZ/250yz/gIN1o1
         UDhgouP28HoSfLMlxUzyUrie3RqWCd1jAJOvkD9cnYfXcC653F8P+perCbezg0NqrJNk
         fMkszVMmG821mLizP9xbJci3/UVQzvsFSAjQusVLzxh/dfx2EtyYJL4EkRKZB8oJo5BX
         YIgzdRMqwTd/pdX/aPujuGXBfS+1cow9p06p/eOjzy5gj+RcIfTa6TkVDGBQaIaT8OMp
         TFBlAR0jRBgRhyDixp6R7SlS1vciR3OouPWVAX03TeXSLEtbzJZVJS5goMVzv3JfQDBu
         ZFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=V3t6t7JIbAvSA8Tk+dwJ0EP+zKfoVcWxCLBhZzDbf1s=;
        b=KQ/339KNlcbj/BD5FkUBcewnMj03viw7WtUs1xkvC7LhSRGs2aVPa/AeFpSO5ETTRs
         I1ROr/nm5IbZDSEk+1LDwfiHIO/iuA9HTgiMQ0w3fTDcvi9GXFT2/GIXUy9pCErPtgdb
         lF5+zMP5B6k/PKE6m/7XGWQkCAp2/otHgViCueGutjcR6wtJI7mlI3aUUwsMRr8L4jrR
         86THAyuBTwpB92tltacP1po57FZKEyzsXybzuS8iAZsCEOgsNpoFuqFfa9tTeZYNEFnW
         2OtZvbzlyMKCq6ck9YTDRkDopnzUgyYzC+HZONXhjlLiPo6rY+sMiJ7PPZtTHxnGB98w
         +PFA==
X-Gm-Message-State: ACgBeo20owWw4RhZD7t84XjdxE88H21oetdVTL54ZRUwQKgTiFabtcyH
        BLCn+CpEjIFXBE+a6EmCSlXOxU4hhthzzpoYQdM=
X-Google-Smtp-Source: AA6agR6LXRk/vsm3io9GudAaANlg3qlqmbPfZYO/5+9wavftY3qTlNqavlUs2mptfr8JHyP3G7J0i2tYgLtM61K8Nyw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a5b:3ca:0:b0:676:e468:2879 with SMTP
 id t10-20020a5b03ca000000b00676e4682879mr14158623ybp.239.1661902298407; Tue,
 30 Aug 2022 16:31:38 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:10 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=samitolvanen@google.com;
 h=from:subject; bh=ZsdbFV1rDPVMEEnz8gpkcJ4SEVi2nPPUZtGW8C9VlOE=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3LuiRNOIXF6iWJdViGqd3zv5mS4LojAiJ+2zw1
 RBe4TiiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dywAKCRBMtfaEi7xW7hbdC/
 9dH+eF9FLRfbAZmIKkZfKGLDEV4GpzyFt3DC0T+XPYawpv8d4hIHcmWOewSokNp8/RlQxEqhucG9Zn
 axIaqhwCi2QhLKvRZcwmhKgvB25LWwrp6pMh94YrnGXvlD4ZGovDQk7afANRYpvaJuBWvNDjJMfcM9
 IMHPn/dIoby0cmKnGFT9OKty5s0M6RvrxxqzZZEVxwms885iZiHHnH1gSB2c5RlKNgSxrpvfzr6gB5
 VgzIUn3LcrpQ9eYEcaYRquZJotPXSZwdymKNF+l7zsSqZZzMkyXcLEY8JSPcDyhYBdFlHyA9oq+hqf
 FOCm74Um/Gr8A1LV7ognHe7JEPGjOh7sx3AJcXUtyPCn7FtdZU2V/f+thDRCL7FfgnF9UDZs0DMpqq
 PT0C1GB58hHVS0/Y/twOGM7f//NBSc140Y0yOTXRWtQuwHvAzfA6mSE55KlboU2m6pMC8JKeSW7PsL
 +uWT5s6GcBEfGDclqFu6GC1EpRCfJ/6w0iOUYXTCADGSE=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 02/21] scripts/kallsyms: Ignore __kcfi_typeid_
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
2.37.2.672.g94769d06f0-goog

