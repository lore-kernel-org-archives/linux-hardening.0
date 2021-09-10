Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C8C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 22:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF8F61205
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 22:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhIJWf1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhIJWf0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 18:35:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC78C061756
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 15:34:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso2536209pjj.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1KMn3Fshg4uYr8YfRrHZ2vdSz5a1cpY72wgBiJJOF8=;
        b=iRDDOgnP+G9JHVtoHxj7l9ciH2Y1GMZ/mQySobNB24uIVa5ws523vhwyw3pEvHfWBo
         F0MI4A6gWjttoyo6/WENSJRusiop4COlgJlWls48nIzh0qppc3wFVTBITDgInzkrBLfU
         1GR8LE/sJUGbpqXfj+NDfTLRTTfhTBnrfRJxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1KMn3Fshg4uYr8YfRrHZ2vdSz5a1cpY72wgBiJJOF8=;
        b=I4dRRCp9vadW3od7ZrgdC2Oprc+gjek/Ob0GWx5qS81d4PeNNFLLCkh6PgbXtSUuVc
         2BA/IHFgyOyRRQ2OTQQ0CZyAshvZGeBIw6MxfOla/WDpEyiZCANkryGvQLNChAPxxmcn
         3iTNNRkiq3dFqJtmFEDdp9Ld85T03ukqbpBkYiyGswJF8Sl4z006PRRiRVW9FYC2exiq
         8juTI34oeQvRAUYaqWt3LpjBeQG1zzM1620/3gJ5KLIu3J4dKRGwCYUrMNLtkTVP9dSV
         Xu1DLfi/GGl7UWmnyD9cNej/HCzUJSZNqKS4DNvoPAPZS3iPt+QZ1cAcn0YGHf4ZoGvI
         9CIg==
X-Gm-Message-State: AOAM533undPXOKWGnmJa2XZJgZvjLc8azMCBwmu/lXlLUlMR3kZpsLH7
        D0fk+zh+mmoa4dmyQK+xJ9/gtSiZDGtYjg==
X-Google-Smtp-Source: ABdhPJygkmxYfXcBhG9ucJo4Ua7e6TcbLt11eckqwgIrmoDz/+2To+4buTIyxJKWp7nD2D+nuLWn7A==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr11824590pjb.135.1631313254984;
        Fri, 10 Sep 2021 15:34:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r22sm4102pjp.7.2021.09.10.15.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 15:34:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Subject: [PATCH] samples/seccomp: Avoid alias warning
Date:   Fri, 10 Sep 2021 15:34:09 -0700
Message-Id: <20210910223409.3225001-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; h=from:subject; bh=wgU1RhPfSkz45p/Y/24CHuUYZ/13y0E8bzJ8zxSgP9E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhO91gDwTnOcX5A85kax/+FJgIy4j/fwoHUSkxzYqd u4vsAfiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTvdYAAKCRCJcvTf3G3AJkxuEA CAHSEmtwsQzUKSdRi/evlh881hhI01Tlpuji21Z2aamUm7ilGB2bFukE5ZSI0PKLSjt4lpQ4Z+aULR uqTDxsXAdnHqQxS35eQA9/UZB6xKP5C7fkh+4k6TZtzWmVkPw1hCAkXc6vgpsnO+BKtxq1OT91uLf2 BwAZtGa0Y+b6RaPZ1xncZUKpBi1DTYmao7QWIx5pb3MYM2kF+PtZmTjARDNuxz2qvW3RQ2JeHUTh3Y 5cw/UkyEZicifQvrJq5ks5EhMp1WP/rfB30FeM/Svby9GjhOF4PvSscGCcAxc61ycMhPo8fRUNhPFF Fisfo5f4HatAOtvnv8QTw1zOdhx2O5iMBdUv3qISJn3MDTlLaktfitvfSL1McyF/rSXjiWUduSH7Og SMCoUV5PsJbRIrP5hfPHoq9rV2jhj4+1G1N8qGcG0F/5TgcUNF3tpsOb/7LkDMyiGrArMNeiYZ1Q+P e0e5DuH6q1kBLqVLBMSFJojFirgRcfXeo7GTC3+RCr0Jlk6Uno0F1lIXdVSlKjcS90oWs63gkMZxgZ GoYVJpQQnz5ryAd4bf5aW3UeaFLWvfbuOYphEDlVbjf6O+e7LPJPKSqoLH49NqPXTSgJPWJ/haMn4W lBLR/EnXyLFPqzvgIBnspMggvemTkv8XqFlPnYXKoTU5qzJrxWF4oCFmBgyA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Under GCC 4.9, fix the warning due to missing -fno-strict-aliasing:

samples/seccomp/user-trap.c:50:2: warning: dereferencing type-punned pointer will break strict-alias
ing rules [-Wstrict-aliasing]
samples/seccomp/user-trap.c:83:2: warning: dereferencing type-punned pointer will break strict-alias
ing rules [-Wstrict-aliasing]

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 samples/seccomp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index c85ae0ed8342..a3a3ef20a8fc 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -3,4 +3,4 @@ userprogs-always-y += bpf-fancy dropper bpf-direct user-trap
 
 bpf-fancy-objs := bpf-fancy.o bpf-helper.o
 
-userccflags += -I usr/include
+userccflags += -I usr/include -fno-strict-aliasing
-- 
2.30.2

