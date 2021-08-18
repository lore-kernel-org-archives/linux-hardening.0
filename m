Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16877C4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 03:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3D560F38
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 03:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhHRDSr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Aug 2021 23:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhHRDSq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Aug 2021 23:18:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4DEC0613CF
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 20:18:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o2so792689pgr.9
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5+GyHW/4S3DPa6ifrE4AkuMeTrhrVLTRLEjOxHyD2Q=;
        b=jvz7/vMzC87FldKmkHelmV6pkdk0P1wtKugQDFaobnoogyZyd9WTlD+2gY3JoPs3a4
         uNgNQ5EYnBU09ao/wHlDQhOnOvFmC6o0zsSadfSlcMQo1CzXJaGWWkVwTRrOZ72SKLBh
         STpOMnZlEgMrj5TqH6O0zTJQp5fRZmJGUaQqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5+GyHW/4S3DPa6ifrE4AkuMeTrhrVLTRLEjOxHyD2Q=;
        b=NoBag1Rb8bRuMZ0oIU3hsp3bNjDe2xvVcjCXdkv6X49ldoy48srXdRr5Sag7pt85xf
         b87SlY6EYOStf2K1IJukoEC0nz7UpwC3UpFWM1upOBTrnD3XT6H7ee0JjhuScbkE+vkb
         u0zap+QoeBgSWzsT4LdF3M4Cx8QlhIYpSdgMkfi8G6cfZjJSct1oQP923spat2n/jpwI
         t2Xt+w/nJuzzFLxHwyJk6+1NS+82Y8mAlKfKBeIrK8pCKtlBKIi1TpZsw4Elnq5dBVo6
         c0clC5a0ecaN6eXcpMSaKRee4uatCXnoLfyPWq1uyCHhfp9KKS9AfEW8XWWF4GA/4+ON
         cIoA==
X-Gm-Message-State: AOAM530y5f6m8DoZrq8X+LIYdHLVfx/a5aUyO0POrvXn1h9t8KDdRGxr
        qMWbaYstkxcaSgAgSo6Yw624iA==
X-Google-Smtp-Source: ABdhPJxHgAcD+t24XepH6prWsbYT0xI/k6k9nDSdr1WcHPOqrmKg34/1qtWr4o5hweEMC438oWNP3g==
X-Received: by 2002:a65:6a09:: with SMTP id m9mr6595093pgu.269.1629256691973;
        Tue, 17 Aug 2021 20:18:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15sm3984352pff.149.2021.08.17.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 20:18:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] parisc: math-emu: Avoid "fmt" macro collision
Date:   Tue, 17 Aug 2021 20:18:09 -0700
Message-Id: <20210818031809.735689-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; h=from:subject; bh=BAykg0i7p0/8eJzpRw9Ux1XnGwbtnouiM7jianmwKDc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHHvwNns9GPVFId5XpY/rjNKgrEk3HM9CwndqYGZ7 iLquAeSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRx78AAKCRCJcvTf3G3AJq44D/ 0Rww7PARe1v7Xrgq0fvsUfOXkQFNiuN9/WGA/RNTsk7WD8KC5I6eMlNvPOB3pKqFkiHbjneOi4jxp6 3ISKQJZgvNBDN7w+S1EEA3/NUHPdx7JTNXPubGlGknV7ylACCjzmoWHEP6LkDV+WGX0Del8/uGkgsb 8glYxbiKMGmM90igS0t8WXnYA8Z1f1T3943k7gNMm0DysLq+8SjNquGNlRCvMSvkbLjrjA6oCB3RTz i3Ki9kTg67GPto1gQFrLigc0mJkYmHQ93fOU9x3THcxoEVd8tATIWW4GLTiJaahlWnPrVqADOlf2B1 w/SQJmuIDYd1B4+V2RBQFnT1T1WJWM0pvgIN+9P9QeB8atEaCt69h74iMqpZJvGKEpMOL3evxp3qIr 64WWCoFh9VIH8yJvUrc2fsZlK8DcpubB52SM5m30/5SredsM8am0AzHv409+4ZyQnmr9ivec/VpD2g ZcM2Uht7+Znwbv3VdqH7PTgr8y6lfBZPcda4tiQ/KxJlUDAvLq7qGlLqF1B1Pr6Hd/6rbRUN39t3Ko BColCL/X+f5hvu04ZbIUic5OPjBu7ZXEvqoIE6za///Fz93Gigi1aMkCENMpm6PRnJ2iDO8zAkywF8 YobNhFKAqeftYClqJvOMkakeyVc4X7NmvOQ3WC1jVB1LHj7mgVIf6Ri1mMLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The printk "fmt" macro was colliding. Rename like the others with a
"bits" suffix. Fixes a build failure:

arch/parisc/math-emu/decode_exc.c: In function 'decode_fpu':
arch/parisc/math-emu/decode_exc.c:49:14: error: expected identifier before numeric constant
   49 | #define fmt  11 /* bits 19 & 20 */
      |              ^~
./include/linux/printk.h:379:6: note: in expansion of macro 'fmt'
  379 |     .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
      |      ^~~
./include/linux/printk.h:417:3: note: in expansion of macro '__printk_index_emit'
  417 |   __printk_index_emit(_fmt, NULL, NULL);   \
      |   ^~~~~~~~~~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
arch/parisc/math-emu/decode_exc.c:339:3: note: in expansion of macro 'printk'
  339 |   printk("%s(%d) Unknown FPU exception 0x%x\n", __FILE__,
      |   ^~~~~~

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/parisc/math-emu/decode_exc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/math-emu/decode_exc.c b/arch/parisc/math-emu/decode_exc.c
index cd8ffc6ceadf..494ca41df05d 100644
--- a/arch/parisc/math-emu/decode_exc.c
+++ b/arch/parisc/math-emu/decode_exc.c
@@ -46,7 +46,7 @@
 #define SIGNALCODE(signal, code) ((signal) << 24 | (code))
 #define copropbit	1<<31-2	/* bit position 2 */
 #define opclass		9	/* bits 21 & 22 */
-#define fmt		11	/* bits 19 & 20 */
+#define fmtbits		11	/* bits 19 & 20 */
 #define df		13	/* bits 17 & 18 */
 #define twobits		3	/* mask low-order 2 bits */
 #define fivebits	31	/* mask low-order 5 bits */
@@ -57,7 +57,7 @@
 #define Excp_instr(index) Instructionfield(Fpu_register[index])
 #define Clear_excp_register(index) Allexception(Fpu_register[index]) = 0
 #define Excp_format() \
-    (current_ir >> ((current_ir>>opclass & twobits)==1 ? df : fmt) & twobits)
+	(current_ir >> ((current_ir>>opclass & twobits) == 1 ? df : fmtbits) & twobits)
 
 /* Miscellaneous definitions */
 #define Fpu_sgl(index) Fpu_register[index*2]
-- 
2.30.2

