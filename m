Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921AC63706
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 15:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiLFPHI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLFPGa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E51B9D8
        for <linux-hardening@vger.kernel.org>; Tue,  6 Dec 2022 07:02:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p24so14188490plw.1
        for <linux-hardening@vger.kernel.org>; Tue, 06 Dec 2022 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhBDV/Z8hnxkq5EH3sr+xFSqw/SOYTGLnS4fXDD4TjQ=;
        b=af1IJpmx8DAIf0dBdHOanjwfNi1rtPFXiQV+4VzEitDppNrmdXLLzybn9DMpm1DlNR
         XIYgg4i/Ylczd0HdCoBUhDS1irOESyxtl3+5jjEj2qqldkYqHNg+rLoXUFXvTVqHgL9X
         H4jkOAzi6UgxIKJV10ouMPtsvGdIPsgaatcRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhBDV/Z8hnxkq5EH3sr+xFSqw/SOYTGLnS4fXDD4TjQ=;
        b=Ct/ihlfseWF2InW17pN2vge40qRULiV30LwC1zx0c0jamcRYWaH5ACEWDxEuJYvuls
         WltHQdy2lJloiUJBGHDM8d/5Jbud/KXtRSF0bOn29w5KfJ6uT1VziJWRPZ/VQ+FZRhzu
         M3LgT2XQuXcWB8mZRxTxHpwa1ap2mDb5zZZLYbkM75tmf7gIck7zz6/ZCP8/yCJeE9k/
         SUSkd2O4MHwjQavGc00m+hp9AVW6RiL4GP8y/4Q/H9+pSKE0Rz8/P3JWdvT52nW4mAB6
         wSX65Zxh9ISQu078k5TfLA1GPdZbHG/n8GJ2b4eKRDsrblJfs+JlM3PWpPCWBWwRepgM
         dFXg==
X-Gm-Message-State: ANoB5pmMx1tTTBpyQj8vc8i1Ga22LtBnagnA0KfTov5rC81WkBIt9g7Z
        7sftF2qARj/z3JdBMajCFx6Jug==
X-Google-Smtp-Source: AA0mqf6qblx42JoKDSjnTf+U7lxx39QANcvHeJCpg3SWy8a16hQUUXTjzHDB199NarPxRc9E1/2YfQ==
X-Received: by 2002:a17:90a:d3d5:b0:218:845f:36a1 with SMTP id d21-20020a17090ad3d500b00218845f36a1mr89183328pjw.117.1670338963543;
        Tue, 06 Dec 2022 07:02:43 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:43 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 0/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Tue,  6 Dec 2022 15:02:27 +0000
Message-Id: <20221206150233.1963717-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

Since Linux introduced the memfd feature, memfd have always had their execute bit set, and the memfd_create() syscall doesn't allow setting it differently.

However, in a secure by default system, such as ChromeOS, (where all executables should come from the rootfs, which is protected by Verified boot), this executable nature of memfd opens a door for NoExec bypass and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm process created a memfd to share the content with an external process, however the memfd is overwritten and used for executing arbitrary code and root escalation. [2] lists more VRP in this kind.

On the other hand, executable memfd has its legit use, runc uses memfd’s seal and executable feature to copy the contents of the binary then execute them, for such system, we need a solution to differentiate runc's use of  executable memfds and an attacker's [3].

To address those above, this set of patches add following:
1> Let memfd_create() set X bit at creation time.
2> Let memfd to be sealed for modifying X bit.
3> A new pid namespace sysctl: vm.memfd_noexec to control behavior of X bit.  For example, if a container has vm.memfd_noexec=2, then memfd_create() without MFD_NOEXEC_SEAL will be rejected.
4> A new security hook in memfd_create(). This make it possible to a new LSM, which rejects or allows executable memfd based on its security policy.

This is V4 version of patch: see [4] [5] [6] for previous versions.

[1] https://crbug.com/1305411
[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
[3] https://lwn.net/Articles/781013/
[4] https://lwn.net/Articles/890096/
[5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@chromium.org/
[6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@chromium.org/

Daniel Verkamp (2):
  mm/memfd: add F_SEAL_EXEC
  selftests/memfd: add tests for F_SEAL_EXEC

Jeff Xu (4):
  mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
  mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
  selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
  mm/memfd: security hook for memfd_create

 include/linux/lsm_hook_defs.h              |   1 +
 include/linux/lsm_hooks.h                  |   4 +
 include/linux/pid_namespace.h              |  19 ++
 include/linux/security.h                   |   6 +
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   4 +
 kernel/pid_namespace.c                     |  48 ++++
 mm/memfd.c                                 |  61 ++++-
 mm/shmem.c                                 |   6 +
 security/security.c                        |  13 +
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 304 ++++++++++++++++++++-
 12 files changed, 465 insertions(+), 3 deletions(-)


base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.39.0.rc0.267.gcb52ba06e7-goog
