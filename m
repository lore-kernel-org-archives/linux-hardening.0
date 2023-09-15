Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44584CD37A9
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjIOUDw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjIOUDY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:03:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263422121
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:03:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so2445841b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808198; x=1695412998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqU6w0o7wis7lXYiV/PtYRUS9jkyqSgo8jH+nv7z2lQ=;
        b=Te06Ig6yNLnKo+W5QXpfQ3zaH+vcXPDIKySu+D0whY4WIV1UeT8xtsBEYrVekWnXqH
         JIZzAOcFg4WzkXLSCD0rUvE4HgEnstk4MPd+iAVc9CfRWQPyxAqFrkWgQt6sILxaRGBU
         7gWmfwAU/AHDovfFDnbFcqVq5XXabFHUAdeWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808198; x=1695412998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqU6w0o7wis7lXYiV/PtYRUS9jkyqSgo8jH+nv7z2lQ=;
        b=Tknx2m2c8SFLN2qoZqky2EHDjfeAj90LwxFpip49wNGhgKR+EoQKN+1U1IlwwzJiJM
         QaM/dMv0VeNZH76zxmXh8MpZWoE+Qss7heXeP2qoLKgpNLpbefF8leaZHDrtzmDunnDW
         kFC4QR4HjepIh1zaR67MUXhUhF94WAcnuMT3OdyAkvhMVSV9RbZr7/aUx+4CRTxW5sHm
         L/KtH6Hqg8k5ABNTqC4fHI6JS5cfFjtf6j069E+QDmVLOAQNqoRwhpFr7ewkZLCjD5lW
         Ep2BpR/iy3iAJdqRAzNrNdE8wzN00nYQpQCnDzGaVpTqvcJbgUv9F8koeoCdqhZD8ABT
         FV0Q==
X-Gm-Message-State: AOJu0Yy1+DZC74VamdMFJyrfgtS9VFeqmiXcH6q0lrYTqdXJBhdrUigv
        R5p4otz2NWXLnKKiQ/tt7lEcUg==
X-Google-Smtp-Source: AGHT+IH3OWyboutDfOfAciFvlgHKuWSpCyEFwnnry4+ZcBINS25y0aQgfc+F80nwPUf47he0MSKCZg==
X-Received: by 2002:a05:6a21:3d82:b0:155:bff3:ea1d with SMTP id bj2-20020a056a213d8200b00155bff3ea1dmr2858114pzc.58.1694808198682;
        Fri, 15 Sep 2023 13:03:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0068be348e35fsm3327629pfm.166.2023.09.15.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:03:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] drbd: Annotate struct fifo_buffer with __counted_by
Date:   Fri, 15 Sep 2023 13:03:16 -0700
Message-Id: <20230915200316.never.707-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZUSAvLi9vR+UNAa6nUlqpsYdl2ki5xpNFUW+QWpv+Gs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLiE6lCzis0gsISR4JNPawG7ZHd60KeU/nnbd
 V8maTMUfi2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4hAAKCRCJcvTf3G3A
 JkJlD/9l0pF1aFUgbVK4svrSUi+5O9iGRCXOXyoA8gV9689PopMTI0ye6wlfzm8Md0iYuPfhPXN
 PiDaHZayfKusmZu960KmvoYn86R3PC7vusckxDFxIgZLKpHbUlrnIEvHyffN6rhQz/U0x3f3FOZ
 Zo/+lHw5TwwltaJ0UuG4XxTzBmorhPU5VRUUvs8vN9MbJh+Zemw3EIECqisOwSLvIb44xn2EhsQ
 ik9K5alDkuinwcoxqirtInCYXfVkatpA9hycu0y4BxSbpaHfeLZ8bD7qFGFWPWuSPEkoRqag+5a
 I/lOP+ADDanjP1tHpdyL++/bWKhxpdzJQ/V4i6+OwO4240bpcoULvIZat0qzQ/Kc4O6E6V2FYEQ
 If+FqC7XhZfU4OxTEaOECJUi4i1ziEZcD2gyrR4ZOLOD6WhZr7lqtDXhRDtGvCD1vl+/3u/frmE
 5DpKvhGaM0oE+x4HjT7CKuptyzLPaNpdjfbLBI26/9nHIWMorznDsuAigef1YyWMjfRg7mDsWyv
 Wyf2UTzCBZPa4ezkhWjsFB9DAllI18T+IPzhY3S0g70qdnZvZDlJ3fDhraSbUyCE/e2jVgPbvJW
 6Tc6rXSm54n7WhP2cU6JIa/9pPv2J0rVcbUYyOqICMjEek0DhJ2EUyUa2umQjR49gGfT1cnVha9
 e44QrY/ OHYIMW1Q==
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

As found with Coccinelle[1], add __counted_by for struct fifo_buffer.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/drbd/drbd_int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a30a5ed811be..7eecc53fae3d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -553,7 +553,7 @@ struct fifo_buffer {
 	unsigned int head_index;
 	unsigned int size;
 	int total; /* sum of all values */
-	int values[];
+	int values[] __counted_by(size);
 };
 extern struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
 
-- 
2.34.1

