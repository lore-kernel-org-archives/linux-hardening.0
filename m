Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C218C7EE25
	for <linux-hardening@archiver.kernel.org>; Wed, 10 May 2023 18:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjEJSeh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 May 2023 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEJSeg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 May 2023 14:34:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE4B4EFE
        for <linux-hardening@vger.kernel.org>; Wed, 10 May 2023 11:34:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf7067647so53076415ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 10 May 2023 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683743669; x=1686335669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRjSTeKVaSeHOGoAF38z8GpTE5mDcr1s8fb1MR5ncQQ=;
        b=J48bmcMYPTBxc7NY29p9Y/M3yvVSOjj2esN3F5CQ44Yhbr7aD/wdU5tVIrkzyL6kws
         t1FU0K7ijV6wKfFk5YoEM0C/YuCRxUV8/DFoL3gWdKx2hDMdAURAY8MH3D4fU3ntuAJt
         +xeeefYWhE0CKhn02lMrr9BeYKI0h2ck4xszw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683743669; x=1686335669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRjSTeKVaSeHOGoAF38z8GpTE5mDcr1s8fb1MR5ncQQ=;
        b=A20A1YF5y4Go3tvkBtgcKAw5Lacez0+sd1RseXmQahL2fIjvy8nuw3rK6Uf1JJEyLk
         IQ5kJf3rYMwjqkwQY7Jw6M9J3NjES2V/LUkRwS6VT9hpZco2n75PtuFkpPEZ9CuqjBSR
         Fs6dz9MvsP7u4Jc6OzgEr0U8+BrFNZ+ZSoO6GGopyHkSsgcGy9d1TDFjBfern8b9t6aO
         4VFl/EQdF2MjLVP2sDJUnCxAG1rie4MjFojHQrcxaTgLHqxf1wzTsB5eiI1DoPK/ssYe
         hd1kAuIAx9OwDo/WHRxqpIBr+FgW/YtjQYBEpp+y8XLPqt7e+C7QvrguD9YIv/7KKMBd
         NtDw==
X-Gm-Message-State: AC+VfDyY55OFBxJRPLT+XLMtFlkh3QH1N1KOr8OzeUeVnU27FvL0tmXN
        i1kz6uEI4dlv3C1BbjOD41i1aA==
X-Google-Smtp-Source: ACHHUZ6qee35mddcQ4bNqIojlG/tUCnPEmOC6VZW3K8+COimPQKLpKDr2ykeF+1cgSXIj3v5Ni02DA==
X-Received: by 2002:a17:903:41ca:b0:1ac:3fe0:d6ad with SMTP id u10-20020a17090341ca00b001ac3fe0d6admr21337510ple.65.1683743668783;
        Wed, 10 May 2023 11:34:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902b94b00b00194d14d8e54sm4116575pls.96.2023.05.10.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:34:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: submitting-patches: Discuss interleaved replies
Date:   Wed, 10 May 2023 11:34:26 -0700
Message-Id: <20230510183423.never.877-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2245; h=from:subject:message-id; bh=62J3Py/xWz6AlwkgtpxlRn/9sYY0pprOtTpQVwzh/Q8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkW+OysP6gOL4ASHG7jWh1uOMcr8jtnn94Osy5E0HQ fc8kCQ2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZFvjsgAKCRCJcvTf3G3AJvQsD/ 9z8s9JuH+k6UL4au4I11PpdN5X1n/sgyE4XsY/Wd8C00wOZ+BIY1WVIbGDgquguLIOtBCX6Mk5oqwW 1sYQWrB9Eol+pazYXf7fvdIOsHTcQqBsXVI+TVAA1KVoi10YmxATRKIPr6Iy7dRLMHsbmbMmPQP34s 9iTw5Keao/nF8Ug4XBZJJD63p1zizFKA85py+RXnXe6D1c5FPpIvxlt7ipRyWqCuunxPHG2vNUdLU2 Y1Js5UhznDgh9RznZIYxmTc6I9eNymyZtlBQ7qqxOsHw4aOFUwInXDh6//OSpcfVeFR0Np2d1f/Dcf ckX6bVfUzui4JdgynpKoG6OFr5HqdHGe72hy6MKUpdSkoPhxaumlSFHiLdHrmeTS5KlSSQWl2rwmnM bde06LFSGPW5M7KDCkab6jIfMra9kqgKEKsn9Hy+YqxLm+PEJ/dDtmHEQIFq7I1km+6K2rgqyJgVt/ uXe/H2dECvorifZDR3v3bn35G3FUGDSGPDqkIOdFf6h1D3InMpHtUcfqz28hM8pVQ8ZB7dvirqD0W4 yXDNNzetxNqtGS//uNp4FlA1vo3Er7PtlwORxTy50sVi/tc21iKC0/jbVtuXADBUdgAZseYAZqyPwL GJEtRBennd45PSR5J2ytgom3IKqxRT8AXjPYm/XpFrDzKxQFB27BoGurPcXg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Top-posting has been strongly discouraged in Linux development, but this
was actually not written anywhere in the common documentation about
sending patches and replying to reviews. Add a section about trimming
and interleaved replies.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Rong Tao <rtoax@foxmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@foxmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/submitting-patches.rst | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index eac7167dce83..3e838da8822f 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -326,6 +326,29 @@ explaining difference aganst previous submission (see
 See Documentation/process/email-clients.rst for recommendations on email
 clients and mailing list etiquette.
 
+Use trimmed interleaved replies in email discussions
+----------------------------------------------------
+Top-posting is strongly discouraged in Linux kernel development
+discusions. Interleaved (or "inline") replies make conversations much
+easier to follow. For more details see:
+https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
+
+As is frequently quoted on the mailing list:
+
+  A: http://en.wikipedia.org/wiki/Top_post
+  Q: Were do I find info about this thing called top-posting?
+  A: Because it messes up the order in which people normally read text.
+  Q: Why is top-posting such a bad thing?
+  A: Top-posting.
+  Q: What is the most annoying thing in e-mail?
+
+Similarly, please trim all unneeded quotations that aren't relevant
+to your reply. This makes replies easier to find, and saves time and
+space. For more details see: http://daringfireball.net/2007/07/on_top
+
+  A: No.
+  Q: Should I include quotations after my reply?
+
 .. _resend_reminders:
 
 Don't get discouraged - or impatient
-- 
2.34.1

