Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56FC05027
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 19:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBCTfe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjBCTfd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 14:35:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FDBB83
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 11:35:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b5so6304292plz.5
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvUs8BP1QFZSewF/m6bdsAoeM8pQF2b3ljROYp3pHYI=;
        b=Wo7EVfpzK2Vu+hCC9dVmiLcXLk2irn3OUwLcHGOJTjnFJRqlgvmJW74iKOA5KguYXm
         VWiYU47+CLX7AKrwGppSU3/DZAVctOCDUnbAiN6RN6Av0nLxIhDoQdUsMwarv6lO+FKA
         h7xlUrKCmsovyJt/qraxRySHhUgeZwIw2P3Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvUs8BP1QFZSewF/m6bdsAoeM8pQF2b3ljROYp3pHYI=;
        b=uVKb6q0rlm3x/VB0TCyNCvUGwRxuZmMntvYmQC6HXWWiv9kj53QguprYpputBG3cnt
         HVmBgMAmnyu4zf2Qzlzat2+SliHTHdoq/N7AtGZt0wKYjLx0m/Y5zBiggHYZgWy1ON67
         Y7BVfD4zP/SFhnnLoZz8T5AfniDY4x68OZUYHrinrxzCy0239BG20CmQjnIhUfpb8qlX
         +D/mjNdJ339fzIIgeNKPNrwqmyGVBJ+1AbywW43gzvJCsZ8SsgjYO0a2WGb0uuj4RWrc
         ruqiswiAcE+crlGhp9LAhEkKKD+SHFXb/Lhpepy8QadFZIW182x0I9kIBXqrsFlb0xpp
         ieVA==
X-Gm-Message-State: AO0yUKV7ojalfgBCokFxA1pyfyz7CLHmL/2WpJDI2BgxoShleQTv3QiB
        SIPn9zvHZ6KtJsKp/M9LrJf4Hg==
X-Google-Smtp-Source: AK7set++zOneAO2Mp9HqWBPBLeUtmj035oBpi6Eoy/GGYEuVVN3IaS8CNiFik9jiKmgZbWjQufesLw==
X-Received: by 2002:a05:6a20:a026:b0:bf:233b:c1d5 with SMTP id p38-20020a056a20a02600b000bf233bc1d5mr16314883pzj.61.1675452932027;
        Fri, 03 Feb 2023 11:35:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709027c1700b001946a3f4d9csm1983157pll.38.2023.02.03.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:35:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
Date:   Fri,  3 Feb 2023 19:35:30 +0000
Message-Id: <20230203193523.never.667-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; h=from:subject:message-id; bh=JaskZktazZWKslmrhW7YWiTBitigdDEJ89tAc0Y7+Iw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3WICh9hpitrATWdEjIYkwQKDQRwy/L7hCU9QciGm D1ARXaCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY91iAgAKCRCJcvTf3G3AJpHzD/ 9zMw0bCWvC1WayWf83B1nnv6vTJ5OFQ1/ZKuKCZHpRGLyCciA9eCOkKoLxj0zzLIjbx8MLfSg5LInn iJhQoEm/cEQBO703QG+82B2oEgBY9F2pqyqPWKayEDcIsVMO86zkY1RdtBpl7ICutcTQne+lblhEk2 4pRGqmpa9ohz7oQhMC4m4VzXRjADiUyTtqWK9h1atuXTIcbxOeUbYtO+l0xbIvT0U7IuUvHOuodkvO q/g9fySXo6fPmjsHyuZIT7RPHoHczCLE5kM+vW/SkcCHRC1FmoAVPvtP0SUlUSGNTsNeNp9TBLw3vs CoeskyAsVHcPFACcq+3Y179JM6acQEcOJ/1pu2kRkUVTMjoWEz1pCDTq+N2MIlS1dxEkZ8m6AK3WJV 6gNFn0WdRIOWrQ6XEFwxtZiNfe366wk6zuCW1QcYfiOdALETukcCbWszQlS1T8LvGOERt1xirf0XTA p7DoHU9tyfBtn4A+DAWEJbp0goKNoKeT39dfe70SHc6FeYW1Lt5jHuxO7o297KK+AaDu9XtkNxpzXb PySXYzBby+s4TjK0D+pMRyq5fyt+YnHkEC64vW/BAoU10I7eBYfcemQp59OGlK0kAxp74Na2iSYbaX cgFLkepZLwB/yIuu0ZLkADP1pwq/UXPvnTGklNOlEWD1Ma0zerWvR+r16nAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While there is logic about the difference between ksize and usize,
copy_struct_from_user() didn't check the size of the destination buffer
(when it was known) against ksize. Add this check so there is an upper
bounds check on the possible memset() call, otherwise lower bounds
checks made by callers will trigger bounds warnings under -Warray-bounds.
Seen under GCC 13:

In function 'copy_struct_from_user',
    inlined from 'iommufd_fops_ioctl' at
../drivers/iommu/iommufd/main.c:333:8:
../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
   59 | #define __underlying_memset     __builtin_memset
      |                                 ^
../include/linux/fortify-string.h:453:9: note: in expansion of macro '__underlying_memset'
  453 |         __underlying_memset(p, c, __fortify_size); \
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/fortify-string.h:461:25: note: in expansion of macro '__fortify_memset_chk'
  461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s, \
      |                         ^~~~~~~~~~~~~~~~~~~~
../include/linux/uaccess.h:334:17: note: in expansion of macro 'memset'
  334 |                 memset(dst + size, 0, rest);
      |                 ^~~~~~
../drivers/iommu/iommufd/main.c: In function 'iommufd_fops_ioctl':
../drivers/iommu/iommufd/main.c:311:27: note: 'buf' declared here
  311 |         union ucmd_buffer buf;
      |                           ^~~

Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index afb18f198843..ab9728138ad6 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize, const void __user *src,
 	size_t size = min(ksize, usize);
 	size_t rest = max(ksize, usize) - size;
 
+	/* Double check if ksize is larger than a known object size. */
+	if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
+		return -E2BIG;
+
 	/* Deal with trailing bytes. */
 	if (usize < ksize) {
 		memset(dst + size, 0, rest);
-- 
2.34.1

