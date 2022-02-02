Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684AC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbiBBWxa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 17:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiBBWx3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 17:53:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C85C061714
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 14:53:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so561336plg.6
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 14:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPOGjmoDh+fnvSCSK8zT1oohl04D24duwddzgIk3nEI=;
        b=DSgFXePcmMMfWdOEhQeZbRpAjykr8OqvlykT3vCxMLBrsZRkn86Hvb81D++0cC2O7P
         eaiNtWAwguoFP7szwvwShBZmO2pc9mHzce2wim2ngtRcdJkVeEeL4U4vUYdUSyZ7DMmZ
         vroJKfx3Nnfi/kZ93LGkWU1daDD1zrRjLqRAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPOGjmoDh+fnvSCSK8zT1oohl04D24duwddzgIk3nEI=;
        b=ENMuB/EFj00JiPemKTsRZ+l8Lrd7pVUagT34s+WHZ3rf8Mt6pL0DErxXzNy0lTC6Nb
         Y6YQkHHtIlo8nVsXQuTS39kd3CnEJYoj5+btf83NUB0YwDDnFyc6eqmU99kjWwEQ0nNx
         ENgzdUTSvpCUKqj+D1AGgMwCXYemxnK84pTDNaXh+1c8Q3taKrlH/RkVgEJQo49H+9Gw
         Pl0O7hmAkO9qakzsHoPvtQSAOg09lNy7Yxv4P13PAvmRE5treBfLqjvY27tyuvrkgGU5
         tiL8nV8K9lChvtWxQKj36omzdzPKw6zZ/gKYvp8ZuTFGtjb6Wz4y/quZV+1OAinydudX
         wfIw==
X-Gm-Message-State: AOAM533D/vGQ5nq35DdfSqgDsNiM9XV3rN1zHi6yxXfjO5VWnUvdxN90
        6iXQ8+Dh6phvpSn3Rv252pWLfg==
X-Google-Smtp-Source: ABdhPJy46YbgYX/2Q0sy9QYIAZD2Glw5/E490qFkjT5TsETXWbOxhTpw8AgDHSKiaI572HENl1BfAQ==
X-Received: by 2002:a17:902:ec8a:: with SMTP id x10mr32767661plg.107.1643842409322;
        Wed, 02 Feb 2022 14:53:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm24093086pgh.67.2022.02.02.14.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 14:53:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org
Subject: [PATCH] m68k: cmpxchg: Dereference matching size
Date:   Wed,  2 Feb 2022 14:53:27 -0800
Message-Id: <20220202225327.1544295-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399; h=from:subject; bh=NU7D+OEXrcXgfft/7RjJlfx2jx9vXFgzFYyD/JEV3D8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+wtm8ge1jg+Y66KWK4NHs6Y8l51oU5IKktstmzgP 8aFbX3CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfsLZgAKCRCJcvTf3G3AJo54EA CcDIB/M3H+2sLSu4vwe7wzdgtnDCvYBViuTWvKj9z6jyF+/0bEwDwZtCByZtayJmHpkrULNUlR7ge5 sJeji6qeS9CF1nEDQ0KUUeQ+qc66CSWudWduR8j7w/di4TG4AW09Tqlrvkm5/MCNw68uKjR+43iHRf 2INuy6H/p6OWXhgrp4XUQPpyZc+VxSGDp0nRJrZNTKYl454nCfljSzi7jwNVMG7W5Hvqk1Lt5txAr4 Mg11KaGr5xQ/TeOlpcXRnMHEXYpvRecdV0zBiWx1OW3FznjNcgKVWInxf03Fi9wD6GDnmjvOItrNOf HPQKlGbHXbsE2MQQGKrsmW9gys8j8L0wVNOH8dBfhA54Nk+5JDxEmsXKQPCgxuaI5I8VMkKRSbxQjZ 01Rjh+YCTTeebOq1ByPU1by4zI0OKihA1QVv/cPBcgQ7Ja7YKL4yaAf5W1HtmyOz1aV1wnscX1gRpr SAXKlyva9J/EzaQC5gIT+C6jfsX/IGvKWUE691IQGNMzPN/PNJeSWSjbpcbDdbmZN+MMNZEXN5uFAR 1AoQab4fNBAKcrRRPBQnonpliW33MWJ2gZmVre8aQXIy1BbcSUmAQ27qGC5/R7p9KyVIkDhCNtyyct wfDsT4TpBTKUjnXdfGTVOck+cQVJELGXZwGm8cB30kwnD5e6KiAubfaXqt6A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Similar to the recent arm64 fix[1], avoid overly wide casts in the cmpxchg
implementation. Avoid this warning under -Warray-bounds with GCC 11:

net/sched/cls_tcindex.c: In function 'tcindex_set_parms':
./arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct tcf_result[1]' [-Warray-bounds]
   64 |                 __asm__ __volatile__
      |                 ^~~~~~~
net/sched/cls_tcindex.c:338:27: note: while referencing 'cr'
  338 |         struct tcf_result cr = {};
      |                           ^~

No binary output differences are seen from this change.

[1] commit 3364c6ce23c6 ("arm64: atomics: lse: Dereference matching size")

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/m68k/include/asm/cmpxchg.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index e8ca4b0ccefa..6cf464cdab06 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -4,8 +4,7 @@
 
 #include <linux/irqflags.h>
 
-struct __xchg_dummy { unsigned long a[100]; };
-#define __xg(x) ((volatile struct __xchg_dummy *)(x))
+#define __xg(type, x) ((volatile type *)(x))
 
 extern unsigned long __invalid_xchg_size(unsigned long, volatile void *, int);
 
@@ -50,7 +49,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 			 "1:\n\t"
 			 "casb %0,%1,%2\n\t"
 			 "jne 1b"
-			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
+			 : "=&d" (x) : "d" (x), "m" (*__xg(u8, ptr)) : "memory");
 		break;
 	case 2:
 		__asm__ __volatile__
@@ -58,7 +57,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 			 "1:\n\t"
 			 "casw %0,%1,%2\n\t"
 			 "jne 1b"
-			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
+			 : "=&d" (x) : "d" (x), "m" (*__xg(u16, ptr)) : "memory");
 		break;
 	case 4:
 		__asm__ __volatile__
@@ -66,7 +65,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 			 "1:\n\t"
 			 "casl %0,%1,%2\n\t"
 			 "jne 1b"
-			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
+			 : "=&d" (x) : "d" (x), "m" (*__xg(u32, ptr)) : "memory");
 		break;
 	default:
 		x = __invalid_xchg_size(x, ptr, size);
-- 
2.30.2

