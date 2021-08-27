Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C720FC432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 16:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBF660E99
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhH0QbN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhH0QbK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Aug 2021 12:31:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6172C0613CF
        for <linux-hardening@vger.kernel.org>; Fri, 27 Aug 2021 09:30:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 7so6111852pfl.10
        for <linux-hardening@vger.kernel.org>; Fri, 27 Aug 2021 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+ke82JqnNzuF+ETLARNzezEA9Zqm2D4YO8akYC5ijQ=;
        b=e+LKzFlkLmCnm0Uy0SnczxQ2uaSczRmJXNF59sh3lJBigg5vC629YE17XCpHD+FSoi
         J5MHuadPZDPIu2eF09UqeeazyZBC2HvFM7F9u4P5hA8CJTmcjOn8odWBRpUoWXwl7U5Z
         a0mg3f87URQ4LuN2CRcXnyqlblbIOuMmkrwTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+ke82JqnNzuF+ETLARNzezEA9Zqm2D4YO8akYC5ijQ=;
        b=ognP9s4b6GEjKeMmzYhrJFr7RlcHaPbhmwp4X7SxYM52rCorxmmbAqVE77og00cTel
         0r/j8QKqWyTzxuNeBle6Y5vtFs+M7owd1D/Ns04LsLSMriPGgymxQSO4e7HWl5NzxqKe
         GoK42rR704hCGl+SaGuGXTNxGpC5IJZnmkgyMQ8RVJg4jcOm45YInq12zFH3SpZ+3Sir
         oFmFUmeDV3CEPhl/QwAr/DFPZD4rirloiJZN/faFqF856hfTcsj4NyHYCa2QhL/GGU34
         WTdiVmFVqbpqMwJCW1Sq84Wlz0tSNzn0mSObHc5v8oo3+m8s1y+0IGTtsSx7teByK+Lm
         nlWw==
X-Gm-Message-State: AOAM530K8UsyjshGK6wSJPvDNEkm/DIVR0MeJQg7pyRUB3jmAQBq7TLl
        8pwrHnhSae95nGU197xMQ9JDlg==
X-Google-Smtp-Source: ABdhPJzVWD5kE7Vujy3R3rBTbCRZ8VfJ1Z6Z6J4uxCGV5F6llmErtgFAj9B8vh5uJImuxxBnOoSpAg==
X-Received: by 2002:a62:6143:0:b029:3c9:3117:c620 with SMTP id v64-20020a6261430000b02903c93117c620mr9956209pfb.30.1630081821279;
        Fri, 27 Aug 2021 09:30:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm13041500pjq.10.2021.08.27.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:30:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/5] Makefile: Enable -Warray-bounds
Date:   Fri, 27 Aug 2021 09:30:14 -0700
Message-Id: <20210827163015.3141722-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210827163015.3141722-1-keescook@chromium.org>
References: <20210827163015.3141722-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; h=from:subject; bh=oefMcHZzjrqvoOMjUB7suXN8EJKiDU2oIYgtW+uUBtg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKRMXaFIio04DmLvoRaIim4FnyDX46vN/W1R6TAc9 7X8LHOKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSkTFwAKCRCJcvTf3G3AJkHDEA CS1lNg3ppEL752ZcERsA8g+c+eYjHTxh15ZTmzUnEtLj6BwMfdbA4/x1xXrjYx1Bg3dJBsGFGhhpQt ozHruyY7Oo7N981nkjQ17v62G45VttSUW0Da9NH4LAmLVzsxHD0eNX4PVE5ZDbGbbH6eE5CrpdTzRJ iNUg4Bto8WHejlPUM/iWswUDI35C38Ckinp80US2/WBXEd2+4PmvnF2qkZGkmZ65WqzLdDZRh3LGu2 HBBxun0qKGvwYwui7oSaKwzCgWZKOkedPVBzfLc3xYcVrLu5swuJmTPLb7YT5WXPH2HdZI7FYqB/Py PjJtQhMrIn2yB8i83VdeCbOZ1IV70o6Eo7mSwFigYSWvtQnG3RZroi9sq1Agy027oHBW07Rvv/umF1 JhVtAHQtTEGjfr3kW89UTaY4HfFsD1JF4oi+CR12uO9+ci9R0DYPRkBFqjL2Y27danaiOyoY2u7yTx mZ6JPA0BHivZtZe/u+uSimSgojZF3B50suFMGmwa7kF/oonGQDz6IrnMy3twHYH7wzin56Vaj8oVVw B+4BrvUOeXYtj8To2ctra/tgAK26O/YGcMht6SuqX/ErTpO7QbpHL2fFyYf1kbmbIJc6vgwVesrVHg iqwNiKHwsWkpf7q4OjGMI+O6JX7fdDBcHhG2QRelqvzBoga7Vkav4a26D+iw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
coverage, it is now possible to enable -Warray-bounds. Since both
GCC and Clang include -Warray-bounds in -Wall, we just need to stop
disabling it.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index e4f5895badb5..8e7e73a642e2 100644
--- a/Makefile
+++ b/Makefile
@@ -995,7 +995,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
-KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Another good warning that we'll want to enable eventually
-- 
2.30.2

