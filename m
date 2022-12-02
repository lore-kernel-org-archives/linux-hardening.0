Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C4C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 21:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLBVG0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 16:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiLBVGZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 16:06:25 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575F6EAB48
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 13:06:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl24so5715770plb.8
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+Cwu0oORJoqtBf3SwedAguHYFCuhYbPDgOJRY8RxDc=;
        b=eTjCt2wyDeZrFaTFP2qLMErlY0YdrzSBrPZhKR0WLOuKHEKfcJBdp7tFzCGtTSLbh1
         kmDWxQa18M/FQqLL+dqsSTz0qVBAp8o1fc833wIKkIqXjXnvUGMEzIdo5hdEwQzR3PuH
         Vyzb1d4jqy1v0Va24229nMjG1lyIWKPucvJrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+Cwu0oORJoqtBf3SwedAguHYFCuhYbPDgOJRY8RxDc=;
        b=PdX5fYH5K+Q0wGvrLWAEQsNdBD3jufSfHShepE7nc7glp4DU5+/P8ubk3bjT2xmmz7
         e+GGl3vtb6BVnaGi1nHQntJjqOzPaJCKwtZEtSMUv4gmUkAffF8wwfRdISmW2nSgH+05
         4KrXBScXvCpWN+3+XIJxikuxFnSc8r/dWzZrDTCOaXk5vfsJpRj7P3iOmt2gYe8BRUTc
         kim/Z3SvM4WKjYgS/Fx7hczwedc6Vwih8TjEMJ63ag3iIyaHHrYaiQOxNx7aB9DDvXXN
         XxnoDwfCQg7qTehoOfRK4as1n7lrsVzpgGcN3vVR5WsrcK/AhFAHqX0K7SLE5bnaAqa5
         ltKg==
X-Gm-Message-State: ANoB5pkkX/yYWEUQ3qrZFbusGYVfsLCvkvICB3T9AAfy9VsBPkIoa5gO
        BOEZ59bEIMYTFJJSuXMQxSe8Xg==
X-Google-Smtp-Source: AA0mqf4zpsh2KC/91qSTab1MJ4Ka12sB7hBmIJ2N8rQQU05wAOJlARV/Zb9E6UOyKlO8/S0IrUq3/w==
X-Received: by 2002:a17:902:da82:b0:189:adf8:54f8 with SMTP id j2-20020a170902da8200b00189adf854f8mr13076731plx.81.1670015183731;
        Fri, 02 Dec 2022 13:06:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0056d98e31439sm5703448pfl.140.2022.12.02.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:06:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] exit: Allow oops_limit to be disabled
Date:   Fri,  2 Dec 2022 13:06:21 -0800
Message-Id: <20221202210617.never.105-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; h=from:subject:message-id; bh=T618w/j0axgITyjfLRoHa8B3lQ31JWaln373s8Gn90k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjimjM6qX21BtN+gD442We20DY1hyv1ftI0+cWAqVS K5tQeg6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY4pozAAKCRCJcvTf3G3AJghuD/ 9UFGZVzFXoKQtfKm4Z7rtqz7Bk0KS/u8l0ck+I/oBsHNXXAjV+6tN2P2nqF0DQl3da32+fwwQHh0i6 Z6ZKIDsRx7EBxTEYlabrnE7QECT185s0e/iICdJgafEOPopGz+Bl774b/2pOGTJ0uQu6nGP2SqQIPt Wmv4NiR8DEpWPrXyZND8eT51yallcOhfqfR6xkLc522a9eOxUWcucdx/gedtRqTknHTQ/i/dV6hzOK GXrZ8QM51UOYjbd46kEemIUjC8/qTk98x1fPszQ0/qV1NZN8LMLTRXd1W7hSXcL+lQ9QVcvIL2kRGi KahFf4+aZVlmGDa94Gd7LWcPrHjjhH+TiVr+xB1OewiC8A37NCf2XiH20uH9M4CYw2UZkc6V2CbBGi qwXUYkk2uK+QAc/h5o0a/cwYfLjAlCBeZHEGJlTCVno2PXrOugFNJWPuvhtiWEtklH9Bpz348otyIi xyDnD4fpFIvgGtNUHo+SuP4jp0a9XiATdUBsE9nDsT9U1jnALIdN2rX9xxRPpvTJpwgpHJHokmpXkP 0vScld0Rz0VVyCwok2o560CtbEUjtN9H3D27q9uq26BIIbBtxMeY+LmPKBxN1xLMGiQsunmP5DPYKi Vkf5P1XIF/5L19BTArdDGeArZNtd78UqtHN1iXYTeSny1jM65A8zU9w/Ua1g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for keeping oops_limit logic in sync with warn_limit,
have oops_limit == 0 disable checking the Oops counter.

Cc: Jann Horn <jannh@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I've changed the warn_limit logic to match...
---
 Documentation/admin-guide/sysctl/kernel.rst | 5 +++--
 kernel/exit.c                               | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 09f3fb2f8585..a31d8d81ea07 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -671,8 +671,9 @@ oops_limit
 ==========
 
 Number of kernel oopses after which the kernel should panic when
-``panic_on_oops`` is not set. Setting this to 0 or 1 has the same effect
-as setting ``panic_on_oops=1``.
+``panic_on_oops`` is not set. Setting this to 0 disables checking
+the count. Setting this to  1 has the same effect as setting
+``panic_on_oops=1``. The default value is 10000.
 
 
 osrelease, ostype & version
diff --git a/kernel/exit.c b/kernel/exit.c
index dc1a32149f94..deffb8e4b1b2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -954,7 +954,7 @@ void __noreturn make_task_dead(int signr)
 	 * To make sure this can't happen, place an upper bound on how often the
 	 * kernel may oops without panic().
 	 */
-	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit))
+	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit) && oops_limit)
 		panic("Oopsed too often (kernel.oops_limit is %d)", oops_limit);
 
 	/*
-- 
2.34.1

