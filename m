Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A81CD379F
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjIOUPl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjIOUPK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:15:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A852121
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:14:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c434c33ec0so8236075ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808869; x=1695413669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Wh5MfEW3doYb+GVlaZ1d5YV1bGIeT17SJ+vtMao2k=;
        b=QEepu/aLtY4qccwIvqqABP1w/H5WEr5RFGpEbJoComvzU2Ma0vlgZLz39dELfEPlh/
         Zib0Szi/qK+/dE8Vsx8ym4naerTfh4HtNo9788bMMaTGDKrMV/B+WQytjXdPKeF8BK8F
         oh3YZEeUTWGQMzeU/5g9boONIJKcfvn6cCAKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808869; x=1695413669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3Wh5MfEW3doYb+GVlaZ1d5YV1bGIeT17SJ+vtMao2k=;
        b=aJT3GcVuya/qzK+yTKfLR/g2RnFWPLIByDhmxmgrVLNBrs6dHK6/AxgXRBT0ZisVjR
         8Yu7iiWDovEMlR/io7GhUJmp1CnF3fCzbyLSDDPMm3lWFfZ3Hye4GfVcZTyLuhZbw3Ja
         1Q2Kii7JN1J5V9ip4dPxdcG6LxZE9cBDqqu0GoGHFSxpsukeBJJj4zjNJ8wxwWNj9mxM
         cRPEpmP3dpXon6kcNZtuD84xXV9n9N6EK/wTldnXqcyTUchg3h0oI3lCCQKZlNLqVmNl
         fCXQbzP++t6vxV6dknZ9H9xcZ7r7kL1NGOlAfODVIrtSJzoderB3EY7sJfqLAUhqymOT
         WC4Q==
X-Gm-Message-State: AOJu0Yxmhg221U1sOPuFWPdfFt+HGDKXi+YP1QqLs6KEtD0wX6FmUUmP
        zD4w5Wef0siP2z0XoTjQwkyNrg==
X-Google-Smtp-Source: AGHT+IFjEYcnYF2l1R11y3riePthlRTy4BhFCC7EKD3yzuegAEdhz+e0FghE7BPVrngygglfbrCg4w==
X-Received: by 2002:a17:902:d50c:b0:1c3:6e38:3943 with SMTP id b12-20020a170902d50c00b001c36e383943mr3120478plg.56.1694808869471;
        Fri, 15 Sep 2023 13:14:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jo5-20020a170903054500b001bf6ea340b3sm3862047plb.116.2023.09.15.13.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:14:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anna Schumaker <anna@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-nfs@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] nfs41: Annotate struct nfs4_file_layout_dsaddr with __counted_by
Date:   Fri, 15 Sep 2023 13:14:27 -0700
Message-Id: <20230915201427.never.771-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=keescook@chromium.org;
 h=from:subject:message-id; bh=SaTfK3lpyJSSyLqYo6bry2dArg3sE8XflweiHaoI8UY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLsj9eKEqvjp1mnrSMAJ82NDlddaXaFNP2mEl
 nX0LeLPnkmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7IwAKCRCJcvTf3G3A
 Jvx7EACzMY8uhS+c29WkzR+uaQe8YM8IcRIE0an3Tp3hKSe4Qsn1YrfptQ703/ZjufltQQYwTK3
 6crA9Yqboe7PhB0+QXPWy2sDykXcFrS6Vp/KnGPy6cOziCBe/5r9+SduZZFUM7kurcHYoPCRL3a
 CYFSSoc0FbnHy4/I/lJpEjD+d/k76EhTwB+gshyW3Ex+75+OVjbhKm2NRWL1aFaaxeEJ10+Qnp0
 KN5Ij/AJSHXVq03irD6Iqb92YAAWXBqOhdo1TtabuKyRlGMdu7kjb08LbqpT615kH4fA2tdPaxg
 Fd1x5FBMj4k+f/9czeX3Zd/cr6rfbWLW2U5V04s5lCfITXMi+HoZRpqgQq1YGa4hnFab+wEf2Qd
 oaWkKawR6Li0KzJgKwW/OjxaMdCePA0hgElbqQF39q91h1Kij3CJYRVgO2lBBOCRGNAfGtggf30
 7LJM2oJGbnRSclIUk6put5bdwX2nVY2K36q4Yw62aNAkK/0ByIRQW8hF/JFK0aFG7TxkIuTXQWA
 GpI0cnh6EFwilcg2I83Kwehss0Ap5NENU4OV64sWydaTwMMd0FcR/fOZ/1SUTABgqKmFUObRZL9
 kNg/SgUzv8YvFDXlSyfqW2siixtbL+sg6XdEwweO+Dp14SLWUYsHV8UWWdYHZwM2cj+DcaPOmoP
 MKF+K9t McubGENA==
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

As found with Coccinelle[1], add __counted_by for struct nfs4_file_layout_dsaddr.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/nfs/filelayout/filelayout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
index aed0748fd6ec..c7bb5da93307 100644
--- a/fs/nfs/filelayout/filelayout.h
+++ b/fs/nfs/filelayout/filelayout.h
@@ -51,7 +51,7 @@ struct nfs4_file_layout_dsaddr {
 	u32				stripe_count;
 	u8				*stripe_indices;
 	u32				ds_num;
-	struct nfs4_pnfs_ds		*ds_list[];
+	struct nfs4_pnfs_ds		*ds_list[] __counted_by(ds_num);
 };
 
 struct nfs4_filelayout_segment {
-- 
2.34.1

