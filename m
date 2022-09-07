Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98C4ECAAD3
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Sep 2022 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIGXeE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIGXeD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Sep 2022 19:34:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B718AEDA0
        for <linux-hardening@vger.kernel.org>; Wed,  7 Sep 2022 16:34:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o126so7143380pfb.6
        for <linux-hardening@vger.kernel.org>; Wed, 07 Sep 2022 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=AjMdKLS9zg8LBW4xTb7d8FA2em3gULmNObnLlCHRonc=;
        b=fWaYY7bydrFt2200xDTm5H9GvwS7xkLEiFesjWCQuMDvi/r5em4q1MnL27DUzgQWB7
         g1aemiI1UdQ+dwEBfNLelKAyTRbnamDQfiRruCWafNpnmTq1GMTTnrExOoX79tt0mHy/
         CpZH/oOfIlhHPG10GZeFL9tBZ7CYOnbJ+sLS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=AjMdKLS9zg8LBW4xTb7d8FA2em3gULmNObnLlCHRonc=;
        b=Lm1/1GQ4fI0Z8UMPrWb8tBivzRQsqHy1+k1kVOX3pZJryoRLWysBC8ATfrwsVvRa7K
         OeyJMShKMlaqQdDBFdEEougLkESZsN+s8Z/fg30ycMKyrb+whZJS+jm6l3fTWTpud7l7
         wVZBiEEtBvuBEcQwSCt9IUV70wZAj3SRkwKDQzTinoC/sQcccHu8mj0S9c1wdHieD7fC
         t1WlF8IkUjjEO5dru4Fdr3LFgUeKYVV4LxEBd0BLCybP2xOn+NINqflNMZVBZD0Fp4MK
         WU0UI3583fjjEG6HuGucYINPumhDUHpB+shnt5Z8nwps3XdYF97wCeoRlrVb5g9hqJmd
         FqpQ==
X-Gm-Message-State: ACgBeo1tzegmkRs1f554q/fXi3n/G+9QmMO40FpfnNqYgjjXoISgu68J
        9ewwfBEcnVSqWzpD1mSvE7Tmkg==
X-Google-Smtp-Source: AA6agR6HUp/+opH2R+zrq9l7ap8rDj4OFq7++9auPTDHU2yuiK2GAl3Sh9aLx8eVv/K1HEyNElS90w==
X-Received: by 2002:a65:6d87:0:b0:42c:5a17:15c8 with SMTP id bc7-20020a656d87000000b0042c5a1715c8mr5371415pgb.409.1662593642048;
        Wed, 07 Sep 2022 16:34:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a064200b002001c9bf22esm232294pje.8.2022.09.07.16.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:34:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] kunit/memcpy: Avoid pathological compile-time string size
Date:   Wed,  7 Sep 2022 16:33:59 -0700
Message-Id: <20220907233359.95875-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; h=from:subject; bh=9L3A2cOu1vWSmZJGv5/YRTBHfOEVr2D10dN/D99gwts=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjGSpmHFHBjwqnPJ/LPfYne9k39BgSe5R7L/6Hm2jE IJRsbueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxkqZgAKCRCJcvTf3G3AJjTHEA CBZbMLFFI7xBrSAbDdmne950VfZaQTUeoN34as/YKGDhkpuQgaSAf6qYu2JDO3UIOx/peuZMmQAtJQ XkgpPD7DQZnzVK7B/mxN0FLAhbS5UrQHmeBQR7uWyeLpvWOHZjI7rAGsCvI8BSzs+f00DUKwYoeY1q 5mkt76ZZtS7MJ2UMTi8QslHEmxXEBPFtBNFQc7ALWAjBXz85XQVUKqQ0tHB6zI+Q4hw9O7seZTdCcn On1HpC/0GKYvKfwcTyg7lwC80Qox/+gOV6Bkhw8l58IFdJH90p1eVUXvZCjs4xyHPz6HgQqL3XAtnV p3sjPtiNonk3FNhyaij6ehDJOcb/QX3W7T9lSaAlMOv0LQXXOB96l7k4gQsIOvYRw7CHcbCQmce1CI /rcYuuBD2DxS3T6EE8k+YT0J5CxFbD55STLqs2F2a4v3cBA+qkmKFDRIsO1nuT/xMzQyGtdyHZiN7H n27DWPdkqQf34XO6nqobSuR3Flo/eDC9+H6592Nfwg4P6blXSjX+m2eM09jb5fscrCeQ3hcKzauKJd Zc9da9cZgzwNxpBjgAd0Lsb9RXZEsOlDP6dQwQi2D08pkyE2ndS87bRizRVIuPYZeEzzAkfFqGQhGE q5BiteZAlj5LRKNs+Dw3zcjD7SkGAGLU6i5d6y6Kikf0jepsvWLk1NG7dKXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The memcpy() KUnit tests are trying to sanity-check run-time behaviors,
but tripped compile-time warnings about a pathological condition of a
too-small buffer being used for input. Avoid this by explicitly resizing
the buffer, but leaving the string short. Avoid the following warning:

lib/memcpy_kunit.c: In function 'strtomem_test':
include/linux/string.h:303:42: warning: 'strnlen' specified bound 4 exceeds source size 3 [-Wstringop-overread]
  303 |         memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));     \
include/linux/minmax.h:32:39: note: in definition of macro '__cmp_once'
   32 |                 typeof(y) unique_y = (y);               \
      |                                       ^
include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
include/linux/string.h:303:27: note: in expansion of macro 'min'
  303 |         memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));     \
      |                           ^~~
lib/memcpy_kunit.c:290:9: note: in expansion of macro 'strtomem'
  290 |         strtomem(wrap.output, input);
      |         ^~~~~~~~
lib/memcpy_kunit.c:275:27: note: source object allocated here
  275 |         static const char input[] = "hi";
      |                           ^~~~~

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202209070728.o3stvgVt-lkp@intel.com
Fixes: 14fa26474621 ("string: Introduce strtomem() and strtomem_pad()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/memcpy_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index d22fa3838ee9..2b5cc70ac53f 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -272,7 +272,7 @@ static void memset_test(struct kunit *test)
 
 static void strtomem_test(struct kunit *test)
 {
-	static const char input[] = "hi";
+	static const char input[sizeof(unsigned long)] = "hi";
 	static const char truncate[] = "this is too long";
 	struct {
 		unsigned long canary1;
-- 
2.34.1

