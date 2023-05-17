Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD4C77B7A
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEQX2K (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 19:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEQX2J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 19:28:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ACA3A9C
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 16:28:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso443420a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 16:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684366088; x=1686958088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oq6EIfCd1DWK+kQqrlggmZL7rv0W2xtPvCE8aaDM25g=;
        b=bK1syOrg4KcHv1cZga7z9IDPfeKUE6G/ewfi3LivMauubHYbARj1WyhUjsicWFmkRy
         hhtxca52TtrJE/eSwQbcgFHNCIrfIYCKh83yABuDYaJGgPr2hG2mBtUAMDVlghPzW6eg
         vJwjLnEWD4nAFVGDe1eLssSGxm/wrIVH0vLjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684366088; x=1686958088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oq6EIfCd1DWK+kQqrlggmZL7rv0W2xtPvCE8aaDM25g=;
        b=CJKqDS5BIFf42tz9ijtEKmYIz8g/PERQDC7MFcNBiKCpb1E3O81/jdpSDOuqZAzafy
         67I++R8iYhiY6le0cljc7OKSh1Nk1Eth+jrZ/hPNED+PGFYRLE40O7t+xZgtISnoLUGr
         E1hXHHGtTCLzSuFWtJ4UVeSn/6t4XWP4sVQ/iHROO6UvH6ta6W2nCDgVmN91LckBDkMs
         h6DdADrxJWnKnnfHFsl2BxhYQPM1B4gdFR/0acyrzd+jYPpJx1alPnZfhhOKY4TOtLUg
         ZC2XOPmlQBg9IH46cXM4SV+ScF6kIUXzoJu/bUa41eCEo0FTkSMP1PSNXWGdUqwKvJWb
         UuHA==
X-Gm-Message-State: AC+VfDzIDQ3U8LP0gMVgR5ig94JagHMYI+WvMq+j1c3+tp5/xzywoQ5j
        md8UqvBfIDPGVEKenAotE+BBBw==
X-Google-Smtp-Source: ACHHUZ5BYM1yKZmIy2acx9+5IUvVjpdmJ82nLcBIjRHGBG5CWjjqKZj6aAsvfUBlpC70XaVi7ykIGw==
X-Received: by 2002:a17:902:e541:b0:1ac:86b5:70d9 with SMTP id n1-20020a170902e54100b001ac86b570d9mr244717plf.32.1684366087694;
        Wed, 17 May 2023 16:28:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090322d200b001a1a82fc6d3sm18084743plg.268.2023.05.17.16.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:28:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] kbuild: Enable -fstrict-flex-arrays=3
Date:   Wed, 17 May 2023 16:28:04 -0700
Message-Id: <20230517232801.never.262-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; h=from:subject:message-id; bh=LXhfRY7mXt3C0oCQx1LsfUvuZ3kBo2weV0EYgwDtdrM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZWME6/e5JLOSrYTsK8DQdfEWyd+XRx8NCin2Eo8x rcYYPc6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGVjBAAKCRCJcvTf3G3AJqnWD/ 0blEKbkGEGsVJr82Aj1sTDGDwQwhCnkOL6SaR6J/GLizMPxDgCPo/MHDt/3RIlbYyoS46MDraNN/4j feIxScKAO8NXrJj4rhwWmqTsObXrIQhDRpJjIr1LSdp+0hhBn1sMmSSn9jqKKydPaphiy2sdWVZRD6 l1MXwLcZ6hjs8waxUltfYzhrQjeS+2gNnwQ4rBPbEeeLL8HILPnoK1JhPA+lg95j6B4g37PBGtA8t8 QMBwuZ7F7dUQKBCd9/JO51T+fU1nnBgm3lLgQjt+Y877gkftne1GvXuzG1o/6AKa0gFYMtD3Ij/Stf oR4Loq6iuMD9tfG/VlLQr/YYQQdgUKZ33padjA4GAsO0lYj/ZTuKH35RoIKnD2rAmt5GuBdfVPGmdx vTmaWVBHVh+ejMuUVeCQ8XnnslFsdI7lCu/LsjCCQHLVXK8+XdleSp5+9l1BneC9pEBitwMEFM8ASE tItpFooXjaX8VTGo0VIA0nRK2PlXcE6M4L52iavhuWK51AlaDthO1JYTRejVGofjLJ258ginIx51X0 8tTvUDNkB80LBd25Bp8XeSUvy+/eG0cPbc2wpouBOEwYNiok0Yh1r60ugibumenEDbSVQf+iH0N780 qSlTA08gzonNqbnusp2SrjXLQO8tiDX+yY7qMWfCQwWwdyqwL8dQm3fW1Pwg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The -fstrict-flex-arrays=3 option is now available with the release
of GCC 13[1] and Clang 16[2]. This feature instructs the compiler to
treat only C99 flexible arrays as dynamically sized for the purposes of
object size calculations. In other words, the ancient practice of using
1-element arrays, or the GNU extension of using 0-sized arrays, as a
dynamically sized array is disabled. This allows CONFIG_UBSAN_BOUNDS,
CONFIG_FORTIFY_SOURCE, and other object-size aware features to behave
unambiguously in the face of trailing arrays: only C99 flexible arrays
are considered to be dynamically sized.

Enabling this will help track down any outstanding cases of fake
flexible arrays that need attention in kernel code.

[1] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html#index-fstrict-flex-arrays
[2] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-fstrict-flex-arrays

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index f836936fb4d8..07e5aec1daf5 100644
--- a/Makefile
+++ b/Makefile
@@ -1026,6 +1026,12 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 # globally built with -Wcast-function-type.
 KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
 
+# To gain proper coverage for CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE,
+# the kernel uses only C99 flexible arrays for dynamically sized trailing
+# arrays. Enforce this for everything that may examine structure sizes and
+# perform bounds checking.
+KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
+
 # disable stringop warnings in gcc 8+
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
-- 
2.34.1

