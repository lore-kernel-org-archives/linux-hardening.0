Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C3C49EBD
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9725A611C1
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFWUmK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFWUmI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C6C06175F
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so4562935pjb.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weOFYHnAt9XHzyijtFN46zZa/bge4PQn7pFxvS+uscM=;
        b=PINKBfWpr3gvTyJ0eFnAv65n6MifZbR/apDoNhNeYQq+pb7Y+nHfI6/29jpyhKRsrA
         kSmtPGNKM36+xWmlgXqHNtUo2kVWovxkLqFL92N+B8M0nbpRfCD32Nat5OMJ3EJp3QwV
         KrPvrHdngyt40imWa1hgx+IPHVy1nFGR4oZAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weOFYHnAt9XHzyijtFN46zZa/bge4PQn7pFxvS+uscM=;
        b=W0u7aKI8UTv2/O1XBCG86Dg+3aaqpjJCH4ykGzyMPIMg0FDz6xSeAXhLhfnABQX6fI
         jnRsQoXhschUkAbu/tInFjfRBenT5epta2bvcU9yBO2vaQDcDp6JcQJ3pKc8cAmjAWfQ
         KVz/oTLIlj8jvPRWO5DNOAIqEfVaIMSqDK00wDXcOnnYTHI/ucdk7lFxezTopqnCKYtQ
         Uq/yaCCcS/KTzWdV/NIX++6YXFGyNq0Cb/pjE5XsAM3l7hz4AqdSvrSUQ6FjZAd+vJHU
         kiKZNayBXH74sQ2TWi49FTgvqXxQVEiadFOlI0mga+y15OgAsLOBeuHA/2hfH4F0uimI
         MRCw==
X-Gm-Message-State: AOAM531Pbf+DqmRAuQhQvItryEwyrtlUiQLNTTpb1OWZob3mVU6NqQtm
        VgLxHqcEnFmeLny3a/LXB+olz+OFWOl0ag==
X-Google-Smtp-Source: ABdhPJx1ypcWLUnUHJBbnBIjhX9m3ZNAxwtdnMUAu2WOpDwAvnSgoGuRx7tr0mmBARqaMdXFPQlhRQ==
X-Received: by 2002:a17:902:c789:b029:110:4933:71ce with SMTP id w9-20020a170902c789b0290110493371cemr1194211pla.56.1624480788561;
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5sm640523pfe.79.2021.06.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 4/9] lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
Date:   Wed, 23 Jun 2021 13:39:31 -0700
Message-Id: <20210623203936.3151093-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; h=from:subject; bh=Ug1zxBYqfqGVjk6HZPE+S2IQ++k8iErOOapO5olSeEg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wGnJvmDSLi1MPOx05nkNSD/27SmvDUPYKaSZ+b ABK1bYKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBgAKCRCJcvTf3G3AJhiJEA Ciux3+IGOay7Jw49WbIkgIv0TxSZgcO90q+vD3qxYri5Kve5Gl362F2aW0FCOlOtxfzOnGmC53o+vL mnCazUpoqn0dW/Y15W4dfOo+HoN5/Afr2nMEj2cwPYh7e2v3kQ2/JK4gaqP9mMDegUGCvWynQbQq54 md3YCttGo14SuaAMF9Wgo60xgxde5gIvQadm2WfvXU0BLyeZBBQb/iHJb8A06PBRzIBP06Nu+NmVVS 4gjNsMrbg6ltVcNDZ67UJ4sjzuFEP2hO+bd3d6/D/d7os59xJd11AHlpBYfk1gCBMC4wl/ZHgbOsaY ew49zKobbo1qt1K8F7Yct3U3IZZ9e2Ny/XCdM/rQMR0KlGYK/LXREO8mEubV2DBQzQidihoy2cFwBk 5gEjXn+w2QmsY5GXkuCXxsRXVw90q9IyT0Qt6kyJ44vqmTKpUFpcarqthBP1/2nXx243B73YaVCB12 6nd+koQb1m5NQNvzwZ8i/jObt5py/ucSDlpCVQ/PCl3NUt9sRB0S8MRNKXxgEJuNMGGs/BUSoYK5AE 51LAiLpudvJPuDuLgHUfzx1Ig+tAVem+P/7WoryLM/rDXtXqsXoyyHzBPcZGczV6nPm7xCwdkviySP adfzxjhgaQrqToXPyTkus9c6NYZDhVyUcK6oihTYUAjfRzEQc+F7f3grbaNA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When built under CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, this test is
expected to fail (i.e. not trip an exception).

Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 0e8254d0cf0b..9ff02bdf3153 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -161,6 +161,9 @@ void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 	if (*p == 0)
 		val = 0x87654321;
 	*p = val;
+
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+		pr_err("XFAIL: arch has CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS\n");
 }
 
 void lkdtm_SOFTLOCKUP(void)
-- 
2.30.2

