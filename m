Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FBFC001B0
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jun 2023 03:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF3DRc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF3DR2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:28 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E33598
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 20:17:28 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b74faaac3bso1193892a34.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 20:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095046; x=1690687046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4tMW9nYu8CG1Kx5U0JNQJGDDgvExBfXDekuGxOI5L0=;
        b=KPAc3EBdnLrZTuhZ0JBA91GkCQdZi1yBfADyAF7KOgyzmnpDl4S+IGni/BtmgUcrH3
         sbgYHnHSeF3KErNlwH76FXcDGpT0YJHsPG42/z5A2rpu6t71HdZ1FdW+/DfA4ASgCAHE
         ryqzVSoM0Cg4D98+NoLyA6oKWkl5NF8mEgGUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095046; x=1690687046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4tMW9nYu8CG1Kx5U0JNQJGDDgvExBfXDekuGxOI5L0=;
        b=F2WxHy5I9vfmqn2SaoDHnfekX6hXWcj5Cv+dqOTgjRAoIfzAP82A8VsX1+r6McApse
         LxTTMn1FImy8hJamzHYO00LDdpEksG6YGm1nhQUhd9wHEcBWs2y20wrkjC7jiLKoUxIj
         6KDwymd1yKsE2NObmTeO12RWbf9FqzoRPyhhj6pFrhSoccDHXrSsOtqLdJdUHI3L3/8/
         lNqQzXouPe7vBPNWdnerT1hFPWPzxa0pD/YTP+nxkDUUde/6a+MzcstWTiPc/K7miMgq
         FiM6s4WHSH88gXr1Dsbm+/IFqMr83+vchM9ofnGisw7V5G4ZJlti/uEpvD1Plo7fH4Yi
         xsBA==
X-Gm-Message-State: ABy/qLZfbFCFyh4xh5FqSXvq21fqq652OTSYOWLRQmOKFs5EKbHXxhkU
        osJqTx/JRc0NVwYb0i0D9PVq9A==
X-Google-Smtp-Source: APBJJlEJphhEXB8Hvzt4GfIdNcqhB5iF/w0ojswIeIzAdwLdkQe+337jwOl6sU6apnlxbfP2RALgMA==
X-Received: by 2002:a05:6359:bb0:b0:134:cb1d:6737 with SMTP id gf48-20020a0563590bb000b00134cb1d6737mr1429484rwb.7.1688095045912;
        Thu, 29 Jun 2023 20:17:25 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id jh2-20020a170903328200b001b3fb1119fdsm3668851plb.297.2023.06.29.20.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:25 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/2] mm/memfd: fix sysctl MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:18 +0000
Message-ID: <20230630031721.623955-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

When sysctl vm.memfd_noexec is 2 (MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED),
memfd_create(.., MFD_EXEC) should fail.

This complies with how MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED is
defined - "memfd_create() without MFD_NOEXEC_SEAL will be rejected"

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported the bug.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

Jeff Xu (2):
  mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
  selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

 mm/memfd.c                                 | 48 +++++++++++-----------
 tools/testing/selftests/memfd/memfd_test.c |  5 +++
 2 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

