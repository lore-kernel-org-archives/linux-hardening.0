Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5EFC64EC0
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 21:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbjHQVWP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355271AbjHQVVu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 17:21:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B945CE4F
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 14:21:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565e6a9ccedso213387a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692307309; x=1692912109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J3DqWaHfahBV9Rbr3yh7KAOpaU1Qrxqc6I4ImPzrlLc=;
        b=UQ7uRX4vRNQm5Z1sJYuCD7CcUxrybgqiowuOcHYmTIa+UxxHl+7ZiRrKxaJsYHKXSl
         tghA3LlYPIhxoRFOaBp0d8yN1G+lOTQ7cPNzwU0zy8KoWJJ8FeqBZVPOZ9GXVcu+DC+a
         WJuLP8C7DeUOx2LPkDjxFTZoe1hdtJHUVj33s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307309; x=1692912109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3DqWaHfahBV9Rbr3yh7KAOpaU1Qrxqc6I4ImPzrlLc=;
        b=bm+ZiyHUHvAtvkUA4wkbwipU71C0OmdFoMC9836Hjgz8e+QfnsCJ0wig4xv4DwM5Yp
         xn9tL6pbwdhE/oRc74rNCpk76N7qJJ6U6OrljZKucHIp6AItLiAbOACXJUYOz4EnDseh
         KL6LIvYvS3W2FcDr8vXBeY2HtQOkKULdTYLA3toAKCUah8+VAwWILxWhcjTgQ8bErgP6
         +9gG+FVnvU1Or68AsxC9/GSt0B+qKzBDRUMYN4D5yPP6VYJ7I2SVRpCMSjBjAY2LA+yN
         jZw2vw5gTQ5jzgUjgqm4G7A1hOMAQiSKV1WqVaFoc7GMPBoAZtBgsCwIMryiMNIQp+5m
         8E0Q==
X-Gm-Message-State: AOJu0YwXXxHVlxUt0/kB3CrpNaAuTv+rBHKepL2a8u2W128vc4vV1ETn
        We1Vw/alHygvT4cCtOcwgLE5Bw==
X-Google-Smtp-Source: AGHT+IGLTsZ7rAmRuWTP/8uOPKu4TBwkEbweRpAvs9I0Ep65lCmKl19f3lVNNKXui6CukdYTJl8/rA==
X-Received: by 2002:a05:6a20:5493:b0:13e:43df:d043 with SMTP id i19-20020a056a20549300b0013e43dfd043mr1160826pzk.9.1692307309226;
        Thu, 17 Aug 2023 14:21:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b0064d57ecaa1dsm212143pfo.28.2023.08.17.14.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:21:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: Annotate struct io_mapped_ubuf with __counted_by
Date:   Thu, 17 Aug 2023 14:21:47 -0700
Message-Id: <20230817212146.never.853-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gGwvg9zntWB1mDIg2ohTnF8pwVm/bQVoon3uykHOFBY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o9rT8q7sPkI7wrB2u8kChmsyKUfX13Pp+tuK
 oLdx7grdI2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6PawAKCRCJcvTf3G3A
 JgYUEACXsvCYFPjTGIHR6p6P5j6Q+CqT4ShBQzC+FAh246rLYugxhD6lIIPpdrTaHK4l5M9CzwO
 GaAhIq3GI++x8bV8cMf+54lzehI5pc7jWE7EkU+klUDyGudmNuaOFHdaQmPG4OlwK92DnJ94AH7
 S+jsgIFmk0IY0AJZzTGHDKBH/PPPJEW0Ncw68YUD0n0sVkb3zR3AWhiswF3HD0Ve/j98jTpxsQz
 cinCJ/a6kCl4LYa7Skni+3AL2Kmt6dSTAvv2fD1aVKerTNpWIfZCHb0c5pEzQIlvEnBQMTvGMO8
 7bPlPGOs7+27ogbkBtban+QdipHMzaGvkbbMWGKYuU6ThfuaG41UQPRVuapuqdjch7hWocfnkfM
 Ry+OdHte2BNoXP7WZPZD7iYhJh0XcOWTj8WQLVbXmTNC1fHhv6wIQymrL45b4luR2W8aNTs1rV3
 H4Zbfps1xF50ZU76LImcqObF1FgYJHa1/vKm3oX3q93wMRD2VHzFwZsaCjcQVZCSVNRU2KrEMS/
 j23mDxvATtLGv8SG5NPAi2za7QlL3I1jUYrYmzL7RAPmgzoyM9fr9cNRQ28nUl+e3dULnWPQfUn
 0GiO7o7orv/pWyfyHzZrhmIEKANpH8EhOHyRccTApqCjNBNcG3guRn0YKOdQKy7vsDsJX/cX7CY
 70L6BhK j2bZt81g==
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

As found with Coccinelle[1], add __counted_by for struct io_mapped_ubuf.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 io_uring/rsrc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 8afa9ec66a55..8625181fb87a 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -54,7 +54,7 @@ struct io_mapped_ubuf {
 	u64		ubuf_end;
 	unsigned int	nr_bvecs;
 	unsigned long	acct_pages;
-	struct bio_vec	bvec[];
+	struct bio_vec	bvec[] __counted_by(nr_bvecs);
 };
 
 void io_rsrc_node_ref_zero(struct io_rsrc_node *node);
-- 
2.34.1

