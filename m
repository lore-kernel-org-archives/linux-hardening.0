Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F9CD37AA
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbjIOUOF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbjIOUNw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E730E6
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-56a8794b5adso2067185a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808728; x=1695413528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaNuUJuW11NFNseyUchCJwnKQBn96YBnagapJs4sYso=;
        b=eF42z4GEWwRThsG61i0rxJ/t166E7yblV3VYNI71u9207fanZ1hDNZWRbnG2KDQBtv
         6paNIJIiISNUrSO6ym6fN2rnvwrn97GG6THTQb5AehNe2/NZb12luZkJ+pP5tx1LZM8G
         QQRANJJjttv5zTaTdbINq+y6XJ7ZlWgY2JrzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808728; x=1695413528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaNuUJuW11NFNseyUchCJwnKQBn96YBnagapJs4sYso=;
        b=S0tPzG2umcYlYjJVEq4Pk3yoAF/lxqgn5enBQjB+EiDygN1hsx/qL9o8GNTgllINK+
         SRUE3Qst0aoqeRQPIRbaVUTBFaH76CxuOJiNE76Ms3OlATAz8hzcvj1pokqFl6tuDUjX
         HJUO/nqLWlHWVIR4QSrSccu19DL2PlGnwCTLAS8hr2GTobr7mXxFbADbhgdLVbe9Ygzt
         xo1OSQ7XqZzOQi9Ic8vXbV4AdDxm37gZP5ZkbkZy84b6V3IvvvKHpt44q/VE+M/Aw7NN
         HXY4KstezrVUn/3WNSGfUqPnUPPfBtZ/nWdoEzhxLxEeCzeoLhnWvU6p9NwuebyX1Q0s
         1jZg==
X-Gm-Message-State: AOJu0YxejGlEHlaVXY+CvutGJbbWuDWgsCXVNJ1NIHvOxvVEWsI2gC2A
        6YuvlwGIdk1s/Fr/GV9ebZqsNQ==
X-Google-Smtp-Source: AGHT+IENQ+3ljrMvkLNjV5WcuTAeCHeTqiHUCoaqBNiK5cW9S7xH1rsrjHRo+U8DYzSeMzsRRNUnqw==
X-Received: by 2002:a17:90a:c981:b0:268:3ea0:7160 with SMTP id w1-20020a17090ac98100b002683ea07160mr2561819pjt.0.1694808728027;
        Fri, 15 Sep 2023 13:12:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w30-20020a17090a6ba100b0025dc5749b4csm1923373pjj.21.2023.09.15.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: cfi: Annotate struct cfi_private with __counted_by
Date:   Fri, 15 Sep 2023 13:12:06 -0700
Message-Id: <20230915201206.never.107-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kJgErR26UlIfECbb6XvY8Wt1mjzpcX6fBOuJe21FNYc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqWagQwTd4LDC+TCrz67AZZmCb7zzFJT3Wg+
 FjYR7jZxCuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6lgAKCRCJcvTf3G3A
 JjaoD/462fmKAJmqNZoJP+mdtzZMTuK5Ftpvj1hxiYcJHGsAvHIjskTS6/QIhml3KId+AW/Z/9h
 3o9kD9vTeovneN67dHl76ayl35/i72aMm0mtq24r5wGFw0zjc+cdbDX0q4Qo6IZp/tk2+X1LvfH
 Z4ajg+xMKjB6ioDbCl8IPLC4q1syKk8Ka86gpC4n3Is24kUoPD9TEHkN0L3wCoxGpe57ipbKawn
 typcjdBmfXci+xlk8ib6bsm8MXHEd6YuvHvgmla3Ls6PMV1M7CqGDxhri7CcgGMLyj0oznNIGWn
 BeAUmpnecYm7pMfB8qGaaPdJK2JZg0cQEJiEJbydaegKkOP0LBX+ARtgEl6/YqJLRxOLqAa+lhl
 zbJfIMw73QVehDJRd5tMFpx3uo580CHgYtL9AK0jJdl2/GI0RA5QJ3EJagXbJqlEFmf3Zd4dlsB
 9T7le0v+qGBFDn8YTwH1ANVE+8ZKb+DpSmGJ49TOm8BVE5lM3IWRqyKhnARx4yFVbqfj/A+rSYR
 RaYwA1HC6rE7lNzRB8pqnCye4X5ZZvugfwxMPLqx4aN0j8KQ94DrwplD97QrMSxTED+OMOdd69R
 Z1O1uOE31Lr9YOlurQ7SC22SowmH2dFId0hd3dwkM/Y4/UV5sa4Ayld7UzlEOtMZTYHtdeuDiGq
 FI7fa3+ p30cf+Mg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfi_private.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mtd/cfi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index d88bb56c18e2..947410faf9e2 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -287,7 +287,7 @@ struct cfi_private {
 	unsigned long chipshift; /* Because they're of the same type */
 	const char *im_name;	 /* inter_module name for cmdset_setup */
 	unsigned long quirks;
-	struct flchip chips[];  /* per-chip data structure for each chip */
+	struct flchip chips[] __counted_by(numchips);  /* per-chip data structure for each chip */
 };
 
 uint32_t cfi_build_cmd_addr(uint32_t cmd_ofs,
-- 
2.34.1

