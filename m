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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C3C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7656124B
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbhDPUjr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbhDPUje (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674BC06175F
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e9so7483212ybq.22
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kUjWBT9A/msvknG/cBSgVzJVzGCrFgBKQbJ1Wr5vaYY=;
        b=HWvfsSkFKcVS3GXzWZGlVPwe/U6VSnnLVtNnq9itoc5ZhNefPUwxkiyXJCUJ5yFG/1
         YhFdMCfzR+5s2w/vxcgc0o4SZl6bVC7wvQB5BzwXQz+1ss13GAE3Vtd65Y4zyY/rAzYA
         4dlbGfJrwsjubvOmqz7AAGrv8BivEv0XF5XpWSZLEPfK0XCU4+Kien6N+M2cLrcqA/Hq
         J+5C+kh7umgtKCslhjK6a6P8EftqVKJFIGJEbcgxxmdrDnW7miCL0rS8XrbMw1i3+cOU
         2teO18lNpxs6edMFlkNQSR5PfY/9l/ArhaBHdUPgaK4SHNEj04G0rtCULGAoAw1QUaTG
         EBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kUjWBT9A/msvknG/cBSgVzJVzGCrFgBKQbJ1Wr5vaYY=;
        b=XX2/rO2iMZwJJrSoXl6J0CRoij5SczHFvkQvDTsHi8wLORdLw6MzwDUxymhwjnxNO6
         q7eRyi+Z5Nd2nNIY/vwoVEGqnlarR3hvE83VPqgEyK27gl0dAR5eSjVYtOe2byki6YzE
         /ym2jEPA7QNlZySPDYNxiFd5ENAPH2vECeQE2Vh48V+S6fv9x5eSu1PtEKa123hgMvrq
         yHKr2mbbwQ8FvsPia0U8Q4YPpDfosjBqxF27N8FhAa70BAI9fh0jXsSXXFOEz1ngQkvX
         TTdmx9M3jF58R7SA5VCY31aOVCED9w1pX+/4qExgDv/R08fppnN6M+cKpyL3/vaSe10E
         zs3w==
X-Gm-Message-State: AOAM530CjdGvUz8flo8MEp/crfn8szGJ+be/UhKIkrZLzBriXp6TqmBB
        a2RQHb0BkaYHsgCOMsepRe5O4tNdSMGxFeA90f4=
X-Google-Smtp-Source: ABdhPJwEdJHNHT5PAP3B3QWdIgcQCAtMECPZ/qV3N3SLx4cq652X4cWMT0J9smvuBPU7Y9rSHsPWY9fZ/gjEGVI8EeQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba85:: with SMTP id
 s5mr1478504ybg.336.1618605547874; Fri, 16 Apr 2021 13:39:07 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:40 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 11/15] x86, relocs: Ignore __typeid__ relocations
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

The __typeid__* symbols aren't actually relocations, so they can be
ignored during relocation generation.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 04c5a44b9682..78516ccea0c8 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -48,6 +48,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__typeid__|"
 	"__crc_)",
 
 /*
@@ -808,6 +809,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			    symname);
 		break;
 
+	case R_X86_64_8:
+		if (!shn_abs || !is_reloc(S_ABS, symname))
+			die("Non-whitelisted %s relocation: %s\n",
+				rel_type(r_type), symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-- 
2.31.1.368.gbe11c130af-goog

