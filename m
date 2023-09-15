Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55293CD379F
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjIOUNB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbjIOUMh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:12:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7472D46
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c09673b006so20388555ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808722; x=1695413522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHWelds/0UMwcBpnWos/aLtztFrXjkfJbKPQ2m0GJNU=;
        b=Ccr4eaICflYTAiXTu0fiX7maWWHomUy+vUaA5/t/PzrgUBuYggq15LtWP8MUHsJfkH
         pxgBLGAkdcwy/s/3jMX+g0JajNWoBZFCgX6WFif4R844Eg+IWo5l8dHqYNpI3JrRYOy3
         4UUasTgHAsHgBNzGSLwZauWwDUWjuPRSz9hZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808722; x=1695413522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHWelds/0UMwcBpnWos/aLtztFrXjkfJbKPQ2m0GJNU=;
        b=YxyGE6VdPoPW3PzOdCImNrbY1xqaR7B0oi6UCKnvxUMmfozu62xzqjWbf0gVxoWJZy
         eXESc2Jaf0HdJHHz9bp6IoxA8g0JdaD/2sW8SbpzxhvHE46Yw4mktRjcGC3GDpa+r5hO
         m2ugqQ4lzn1HGg53VJFfH3EB0yf8xo3SudiXzR20ms8S59gqXpSW7pzcBWDMrUQq6cxJ
         mAoimOLF+k3JLuOUgaZerVuH6V2WKgVxZ9+LgZYji8cMjSuAoBUSFWe4Mk/L/Ns5GpGr
         dqmdcmblaY0nxfu5T8xKTMP7RmuTfVi6j8Lelih+k2rfpsDGAtkndUSCM5uw/aYogrVP
         QiPw==
X-Gm-Message-State: AOJu0YzuTJLn/VqR7BTeblSuOXtMwfRDFoivK8iT6Mx3oCK8QY9wkY1v
        vQKYozsASlaEcjPAJfosrPx4og==
X-Google-Smtp-Source: AGHT+IHiNyqrliN/74dUaaMOB5YH/EEzt/xoauvDLOTN5wb5Fju0foAYEpaV6viOplTZo5uTNSDJMw==
X-Received: by 2002:a17:902:6bca:b0:1c3:a396:25b5 with SMTP id m10-20020a1709026bca00b001c3a39625b5mr2401710plt.61.1694808721930;
        Fri, 15 Sep 2023 13:12:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001b9de4fb749sm3898447plb.20.2023.09.15.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:01 -0700 (PDT)
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
Subject: [PATCH] mtd: Annotate struct lpddr_private with __counted_by
Date:   Fri, 15 Sep 2023 13:12:00 -0700
Message-Id: <20230915201159.never.112-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gCkXC8MpJaPT99ttxM470YlQxkUzCuh2ydBh0veT0Pw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLqQdMeeixNUCF5z4zedCX95mr3jXFz4Nb5Cs
 5V4tlXbBCCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6kAAKCRCJcvTf3G3A
 Jk8yD/9mHmYeZ4PilIA7bE0IVUOPX8xWImvE2StXacFdcKWj6g3dT1Z+QnG6UZ6K8E0IVbwxtWx
 0/u6hFgLlJcs7VYdQYDz6zlzN2DcqRSOQ2IfFjqwHVOA0VxKOMIZRLlsz2ZXr9Vgx4Lme5dVV+5
 WSjxLhY/Aa77SDYccaT9iTj5whirBeTZ/+vPA6YK7bUhNpaRPqACjOUXlOhpwyirFk+PtJe1rci
 unArKIBK5LaAqs+X0rqDR0pO3sL3YLFldvjdN8siCHGt6iEcP6G2Zp3AV9wjqnjH8UWylOIQX5t
 fBXq2LKhG2ubRtRStk+p6y5uCBHE1/mhxLP8nflD1p74ErUwtR0wgAmkwQ5LQhNX0doFZJIVnh5
 5bnGARcrRIi2/9J4R5T9e27gNXb32m9ldgD/vE+nWoAd78lQuJ/zp/ElqbJ0riOEXSw/Ug+Pjw6
 4zAmyAm0rIrnzbZIezZ9boeyfe7ZalC5ywHALmoK4I5ymlp0BHznG/ylHJKuRCKB9usocw4mMkH
 PkD55lpZ3U7R6j7pjvzZQ5C+9Mlf2siik3YLwqlhEl4kP6MI3UZnuZv0iGx2hMayqeo0ouuOI8V
 J+rkTGfqayqeMzppAHp9ib6o/ji2/JoJYvT2rhZd5I4OllXNs2Rg3m97Ee0Iq0UEYje/AB9V/Ro
 46ySS5G +6Rqb3pg==
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

As found with Coccinelle[1], add __counted_by for struct lpddr_private.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mtd/qinfo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/qinfo.h b/include/linux/mtd/qinfo.h
index 2e3f43788d48..0421f12156b5 100644
--- a/include/linux/mtd/qinfo.h
+++ b/include/linux/mtd/qinfo.h
@@ -24,7 +24,7 @@ struct lpddr_private {
 	struct qinfo_chip *qinfo;
 	int numchips;
 	unsigned long chipshift;
-	struct flchip chips[];
+	struct flchip chips[] __counted_by(numchips);
 };
 
 /* qinfo_query_info structure contains request information for
-- 
2.34.1

