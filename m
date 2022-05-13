Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB1BC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384124AbiEMUWP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384121AbiEMUWJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50762158F8C
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g26-20020a25b11a000000b0064984a4ffb7so8208163ybj.7
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IxHEer1R7aVI+23m0/FmYa+I+TASlrgBBKCjzC35/is=;
        b=OxMA8KuHb8XyzEjNcQew0ArZPh+FVcPLuUudPe8Jic4JWJ2qN0iVlwiAZZSV9Gtzwv
         7HrYwsvduCROdph8yijbuUGSiOimDaejwPHZbVJ1M734lxldw057vMrtMmT4JDtTWicN
         LFtVcyF/iv6fifWYUO8WReZUA0eigVeQwl1sgTgmQEQ2c5FaP2Mr+ePC13K4wuaZayO1
         d8+lzT59gwHtCXP+id4mRPGTa9D7RNmpX55+YjUZbLnUUDJp3++JVBGJgL1r3FL1rFgD
         9c/LZv5mImy0vO1Qkn8xvEDuDTkaHE5SP9oiguHQSFWAB0RU+W3gKv3DkAA64d0G0jNq
         TI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IxHEer1R7aVI+23m0/FmYa+I+TASlrgBBKCjzC35/is=;
        b=5psJTPkqDPEDSufKasRypzlfmIF59VNrLp8HMG6NU2DbxuDFYiISc0vXWEctj0wZrA
         7Ga8GPK16HIqFcjWAc4bdYOsNsuySu5K3NsmSZoT+9/+RZJmDsdBndbfTlSixPTg6FXR
         okR++1FSiQqNXdCU8ueS2XFdPutBpEGmTYtNHN4Z9imQa6laZKWCKfW162kPyQqyLNPn
         9wJp0DSkc5MYUE55Y6ox36fidCT1RNXhmPAhWhEkT9J/IlkULwBFDVryMeJsFobcPpeA
         S8QwisNgIB2fU96WMAA6qKjSDT7XajEznp0Ti0abM4xV71fnk7OdY6v8z57OEvn4GjOe
         DHeQ==
X-Gm-Message-State: AOAM532WAphs8hDu/o7dqnio3Ypg76Cf6+2oA+snpskMQ17vyYUjhgO9
        PUzb34+zBR35G9mkIcm3EBuLSKCNTgQoh1QR3DU=
X-Google-Smtp-Source: ABdhPJzUS09TySpKZNXM6m4ea8HNMDMOfILnzeEqlsd04WIi/iMakGhB41x1yNg+3tqOE5zhpyksH9HH+6A5s0pmUMM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a81:5607:0:b0:2db:c245:5ff4 with SMTP
 id k7-20020a815607000000b002dbc2455ff4mr7860740ywb.244.1652473328452; Fri, 13
 May 2022 13:22:08 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:41 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; h=from:subject;
 bh=nqUrm2wetpzQHlcH5NE19NaoXqu5E22beF1fMMwNKYU=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3iMv7g14dMbgfDCXDLb8bbUgmfd0gW8V9AeL1O
 zzXtTTuJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694gAKCRBMtfaEi7xW7iEdDA
 CI6z4FnJ7PlqvcN6HOYf/c+XXnT7MWbgCS2HoVv2P8QoFQ7TpgbvN9zIdJ2RqY6xEuuz3emRk6Ah6L
 m3BDCj8zH2JvuDhGU8CvazPYASgz94v/HBmS7NVikbjwkqCaqgwWglXdD2apJxu5anZhqnCpft8QPP
 bsIYUu1URvNbcxZKEGTmZ+CfaHo8s7SG6cXjrxevYWrVVsTwtujQ9JyLn0OoTcm/Fz7e+vQTkJ8h83
 tVq2x9/I247t3sHmmcB9KPidgRSvcn1f9jJq0P1G7rSEDpVyZu2g0xj0mridXoViXt4rnsB3q1jmCE
 BVikAZnVI/yfasdkpS9g3uH/FygOBkKSfIT27/K+DLNc7XcLJJfDlhBepjYoQ2RwC0/vfOhr+7iq8Z
 S6gs/HjMHr5L+Y77qMjwRSwMNE2rdV+mTed4i9qBwlRWYaCWx3uwygO/JhgxJmegZ36M5eaQI+mxtd
 OYZMFi5iejcuHT5TOPjKY0v8Ia7ODn5SOlEwOFOqDPNMs=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 03/21] kallsyms: Ignore __kcfi_typeid_
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

The compiler generates CFI type identifier symbols for annotating
assembly functions at link time. Ignore them in kallsyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..eebd02e4b832 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -118,6 +118,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
+		"__kcfi_typeid_",	/* CFI type identifiers */
 		NULL
 	};
 
-- 
2.36.0.550.gb090851708-goog

