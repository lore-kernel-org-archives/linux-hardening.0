Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76407EB64DD
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Jun 2023 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjF2XfJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 19:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjF2XfB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 19:35:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19A2680
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 16:34:59 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b72329b63eso1115899a34.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688081699; x=1690673699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG0p2NxJxfYPPHk57XaDb7PRgK5Ncrcc/zrK6bcWJBo=;
        b=V55WG+KNmomp8p6ckLhRrH+LXm07woxdK5aExRC5Ap8XBsUXarBgSTLvYxJcJOWLaH
         SZ94W8McRnwkd8EJtqtJiuP1Mqbaua+C+BgrqDU+dRC3HJ6HjxS4ALWXnq5izdYa0aWa
         TIiVjfq4PS1K8Y+0KXOb27kFxC49e6PrVjVQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688081699; x=1690673699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG0p2NxJxfYPPHk57XaDb7PRgK5Ncrcc/zrK6bcWJBo=;
        b=BT5RufwiBeK4JsmrNrOrro3wQ0UA6SuYvuSTt4LcUmBy5I45KiD9W6WVJt5+7c3wnN
         hBFMn8QLE0/0KstDD83GCFM8jUPKxr57KOtIMuucP/WC8ZRmqMyF2zy857HgdTb/J/P7
         8eFAEDg9XB2n8Euq08ng9U35UmO0PhD4+FYRgoAceFhhP/SQuVEmRP/miSuN/bFWIx56
         92SB+nCYaucbsodwYgme/suI8u2C+9hGBGdw/rNR+gMOXo1+9CT6uD96mlNiD4LjHR//
         +g2TrEnnsAT5l0f8CqSb1ksrfSsPhrtsH0Hh4b1DijqPfYKQ3rmFywimaZt1h8AAEnrG
         sBBg==
X-Gm-Message-State: AC+VfDxJdsRfBRPlzYiuViGjbtpgVgCJDikUqMd5r33FV32D3nxOpWzP
        T4AWVqb5LRPXy6YQ7OAdN9FT59bqrwLhRRcoNT8=
X-Google-Smtp-Source: ACHHUZ4zm9+O4p+Sybi08lceONGhN6p+USDHiBG49m/rR5eMzi1I2db76dpbjYtp40INdTnI3DxXkQ==
X-Received: by 2002:a05:6870:7c13:b0:1b0:432d:acb7 with SMTP id je19-20020a0568707c1300b001b0432dacb7mr1706353oab.35.1688081698833;
        Thu, 29 Jun 2023 16:34:58 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id n59-20020a17090a2cc100b0025bdc3454c6sm12441785pjd.8.2023.06.29.16.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 16:34:58 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2] Documentation: mm/memfd: vm.memfd_noexec
Date:   Thu, 29 Jun 2023 23:34:54 +0000
Message-ID: <20230629233454.4166842-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 45ba1f4dc004..621588041a9e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -424,6 +424,36 @@ e.g., up to one or two maps per allocation.
 
 The default value is 65530.
 
+memfd_noexec:
+=============
+This pid namespaced sysctl controls memfd_create().
+
+The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
+application to set executable bit at creation time.
+
+When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
+(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
+be executable (mode: 0777) after creation.
+
+when MFD_EXEC flag is set, memfd is created with executable bit
+(mode:0777), this is the same as the old behavior of memfd_create.
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_EXEC was set.
+1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_NOEXEC_SEAL was set.
+2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The default value is 0.
+
+Once set, it can't be downgraded at runtime, i.e. 2=>1, 1=>0
+are denied.
+
+This is pid namespaced sysctl, child processes inherit the parent
+process's memfd_noexec at the time of fork. Changes to the parent
+process after fork are not automatically propagated to the child
+process.
 
 memory_failure_early_kill:
 ==========================
-- 
2.41.0.255.g8b1d071c50-goog

