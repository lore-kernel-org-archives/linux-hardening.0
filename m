Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4914C001DE
	for <linux-hardening@archiver.kernel.org>; Wed,  5 Jul 2023 06:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGEGdZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGEGdY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84191716
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 23:33:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55b83ae9be2so2667714a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 04 Jul 2023 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688538799; x=1691130799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDvL7ekfNs3bVJSGPqpDAjABE5c0UvJWFUFVDP7OcnI=;
        b=HCLhgdyCq90YfTQMjaZdIjt+ewIGHr1WoJsIV+nau37DwSwAOxCl2fjO89N/8iyvzE
         H7nphOWHQcnoXDeIAAzONINmvw/9M+OF7ptZ2nYwtk03J6Xr1VIAXJFgzI89yGveGEEn
         GqQXrdDg26hwQ58jRQ8CVFGH4yq7UNJvF82E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538799; x=1691130799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDvL7ekfNs3bVJSGPqpDAjABE5c0UvJWFUFVDP7OcnI=;
        b=d1Xh5pyKKprjan5EcJYNGc3uCH6TghgZpIolvEeV5N1Ua1PIikFEfQ6v1wBnjUjjLG
         nYiQyX8YALpnL3NcO2TCoc8AZBnbKH5wZCPsWlf21Gc+nfmd3EiqUXGWB+7TL/CZyrgT
         pJOjjjPvNfyc/ljkfRZ1pWrbd9EBM+aemVUaTdSN5QVHzTYdT+QtgfYYXu7AWbSRLvGV
         if0XGy/AiImQ9pmKMc58QeaPMCYj3sFCFhscjzE6INjSNW8rF+h4n87xXt/7mJToJPe3
         YBvV4RaYoSntH9HmV/eYtI13CfhQt0BWdFM2seoyC+TS17LUrDA/RnPa9fQIYiomJesG
         psEQ==
X-Gm-Message-State: ABy/qLbMHfbuWFI1LBnVur/iNGcpSYIsAfKCZF2UhYh0syOMxYIb5bGR
        VkaOP+YfJhbbRtLMZ6MpG8sLIg==
X-Google-Smtp-Source: APBJJlFpuOviESDRC+8Eczf993gvvtLCwtBHrHyO+U2M+unQGYqacus88aSVN0CInn963UVCfuJ9qA==
X-Received: by 2002:a05:6a20:8408:b0:12f:6500:8504 with SMTP id c8-20020a056a20840800b0012f65008504mr3750180pzd.46.1688538799000;
        Tue, 04 Jul 2023 23:33:19 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id u23-20020aa78497000000b0067aa2a70179sm13271590pfn.46.2023.07.04.23.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:18 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] mm/memfd: fix sysctl MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Wed,  5 Jul 2023 06:33:13 +0000
Message-ID: <20230705063315.3680666-1-jeffxu@google.com>
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

History:
V2: fix build error when CONFIG_SYSCTL is not defined. 

V1: initial version
https://lore.kernel.org/linux-mm/20230630031721.623955-3-jeffxu@google.com/T/

Jeff Xu (2):
  mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
  selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

 mm/memfd.c                                 | 57 +++++++++++++---------
 tools/testing/selftests/memfd/memfd_test.c |  5 ++
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

