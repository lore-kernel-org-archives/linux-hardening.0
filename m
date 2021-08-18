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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC5BC4320E
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EC860F58
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 08:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbhHRIMQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbhHRIMC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 04:12:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D35C06124A
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 01:11:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n5so2100305pjt.4
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSxasQLMQ7BBR7TdcGRSlk0G4XKWZX+xPade0LLrxhk=;
        b=CbD0utKdxlAbg80iaRSS0Xb6pLNEjcmYbBaAJJiDGVcJsKm/Z+RsreJpCj9b6d6Ir8
         6w6a/erDZZcGrYPtyhF+5wsjm8XMPdN3FpCXfgDRBBGOWi4cpK64IqKIPGveb/bv9yDF
         5vfq0f1lnRE4ok6eQsJvms0oFN5mUKMxpGzz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSxasQLMQ7BBR7TdcGRSlk0G4XKWZX+xPade0LLrxhk=;
        b=J4lsJwMPbFK1l9xi2ju3dQxrmLbvum082XFqBVg2AWINrG94cNoIhqptIZ+k7FM1Tp
         poHH0q6E7eJWof75+BV6/BO6Kmmj8cpSTeMOjUEsygBaGRq/0MpJEsQPSs3o3c/isCbl
         xCEwZ3bytiagIWqIdkXUs4OrhobVVn/PBy5GnAucfmcGiTNW2PY6JXVxlboWT1KyDSf7
         13/59Xkik8QnyPDB8et4OKofUB47y0DA0HrAMPM0fdINd6QhkWKxKMFSfbL1aWK3oY9l
         5XTp9vT0jN8mGkb7MDO8wuZGYT1sL03xd4oU6oaQR5l+PTnYi1V4EI4gTBxERoN0mQbJ
         7xvQ==
X-Gm-Message-State: AOAM531arUPLLXt2qFzEbiI3vHSTLjkbE2dEcCcK150GMHnhq16gTtaB
        QaNzXxvb5mzj0ekl6l9tqYpmzw==
X-Google-Smtp-Source: ABdhPJwf27RIHYSHTUVepdi/G5OFsbeIeSVlAlxNNQ9SzL4IkTFIp9ShdwMf3Yl+vyH2kf80Ho/7TA==
X-Received: by 2002:a17:90b:1493:: with SMTP id js19mr8213217pjb.53.1629274284900;
        Wed, 18 Aug 2021 01:11:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm6254086pgl.23.2021.08.18.01.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:11:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH 5/5] Makefile: Enable -Wzero-length-bounds
Date:   Wed, 18 Aug 2021 01:11:18 -0700
Message-Id: <20210818081118.1667663-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818081118.1667663-1-keescook@chromium.org>
References: <20210818081118.1667663-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; h=from:subject; bh=VMkL66yeOij4K1iaHsjPblzabYjjgbbejH3VnhYGySY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHMClHULohfwlYl/hV7Z7Tw6ENdG87mPM0BxkmZ03 6QqKgdWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRzApQAKCRCJcvTf3G3AJv3FD/ 44FfP1SqqRlWkqqnJ3WgF1Uq38Ay4cWhio8wr4PJxqluecJNm245E9vOGSWxS1NPyM/1K9e2Lnt5lX UzX9QSCQSQeklVqfDkGhDayYKmK5gHcDUXimko7elgaYN9OK75FunT5OZiSPResOHFK1MqzX0cfSno e3BJ+NSDveGnxWgWsHV5pHof55dXEB8KYcG2dw5pw00PGIN0jcQEoKMT/xrPDTzGhTVoFCiSxkz3SB tv5zcDPaBoQ5p2R41J+wmH7Vwbv3MAcb6frYqpZNg1NcWqyIvcK+xUJ5YGV+8WBwdPH8UkOGTDsoq2 uodAFvs/3zjZ/wScjZYb5UuWSGIhsE+e2WYnW3VTkYHzcHbFbCMTcWMdVRl/DQTvYQkWmUa4ruhpCU dh1BKMgOUhOpdHeHIbUb4/aQJouuUWUm/TVZCOEcIteBGmts1sXS7y+JFYYscebKa4qaiBGstkvq9u 1BSSawi2FQdm3tUyDc824Eqt1fQbv6w/ohNmVyUQCuBfjRKpUyC7EXVpm/YOKTYfL7bJkivNuXSqzE 279DBq7DcuRW4x71TRLrb6SFcKoP6YsT+hFyjflGTHsbzfIuyM/8hqsPQ7xYvd+ZoVPcf3FY6Ckij9 ATm1nXyJhHf9YqQRBcP1Yu8BSi8UkrVo+8rcX2SVGlOO5oC+wg6yqEhAU/wg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With all known internal zero-length accesses fixed, it is possible to
enable -Wzero-length-bounds globally. Since this is included by default
in -Warray-bounds, we just need to stop disabling it.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index af22b83cede7..3b6fb740584e 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,7 +1071,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
-KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Another good warning that we'll want to enable eventually
-- 
2.30.2

