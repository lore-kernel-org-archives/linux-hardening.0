Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0DC433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 22:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEFB6105A
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 22:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhDAWNt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhDAWNb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13414C0617AA
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 15:13:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y32so2428067pga.11
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOIPmpuTpYu/DgWdR2yqBo3+vizrBGynByA8gUlCbew=;
        b=cQExDcxo3OoK2mxwYeUFka8uI9xHUTKkU8RyEKfqZ1RZN/sSFJE+2N5pbNgm/YFQ61
         6cj6rbkFPYePaSDv3GdRZpz3odVN2y73i4lw2JOJsdHtIlztHidaHZv+6srccig5fpHH
         4h0d7C3pV7Jy4Hjoc3pPCqU98NbNAjzBuZDiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOIPmpuTpYu/DgWdR2yqBo3+vizrBGynByA8gUlCbew=;
        b=EU7GrnYWPP3lrZ6D8M11B32bzisDXjbMXYnzKAc4l8sYrbZQyT8qbtpE00+8BASS8m
         KVqZooOG2AMbaWRQ0fArz1gyYZJpkc3h9P8ouIC0ngTjK4zamXYEDcTflNq02xdiCi42
         8j8Djf6A3HxIM8VXkvdz2P99mjLCU0kNm4lfFug4Gb6XjtMKoq5ffuv6okKICp5kOHi+
         GzC/WCWwLYtpFVVrGJYmhTOwKgddt/K2aZTOc6cz8qqhJ8YP0tlhz3Xjf28vQg5zekx5
         jNZBkPILJfz/Hm/1NtwMhC1f+dLGToDk73hlaVZUdccSkMEejD5VxPv1Ml8/MbBwGD1d
         IrIA==
X-Gm-Message-State: AOAM531VaKTO93EopZ2oymxhtri9ehzQk2fOGV/cuqfywOLAqMRu84+w
        OfiWCLnJauZe5IH20ux3X1xo1w==
X-Google-Smtp-Source: ABdhPJzqcC4ByIZFeQrIwo8KNlFb2Y/g6f2p3afwwogKHitzzyYi+ntwY6nHe5d5rZF1Se1DYCo+pw==
X-Received: by 2002:a65:41c7:: with SMTP id b7mr9147045pgq.237.1617315209553;
        Thu, 01 Apr 2021 15:13:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm6508328pfb.98.2021.04.01.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:13:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/3] sysfs: Unconditionally use vmalloc for buffer
Date:   Thu,  1 Apr 2021 15:13:17 -0700
Message-Id: <20210401221320.2717732-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This series improves the defensive posture of sysfs's use of seq_file
to gain the vmap guard pages at the end of vmalloc buffers to stop a
class of recurring flaw[1]. The long-term goal is to switch sysfs from
a buffer to using seq_file directly, but this will take time to refactor.

Included is also a Clang fix for NULL arithmetic and an LKDTM test to
validate vmalloc guard pages.

v4:
- fix NULL arithmetic (Arnd)
- add lkdtm test
- reword commit message
v3: https://lore.kernel.org/lkml/20210401022145.2019422-1-keescook@chromium.org/
v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/

Thanks!

-Kees

Arnd Bergmann (1):
  seq_file: Fix clang warning for NULL pointer arithmetic

Kees Cook (2):
  lkdtm/heap: Add vmalloc linear overflow test
  sysfs: Unconditionally use vmalloc for buffer

 drivers/misc/lkdtm/core.c               |  3 ++-
 drivers/misc/lkdtm/heap.c               | 21 +++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h              |  3 ++-
 fs/kernfs/file.c                        |  9 +++++---
 fs/seq_file.c                           |  5 ++++-
 fs/sysfs/file.c                         | 29 +++++++++++++++++++++++++
 include/linux/seq_file.h                |  6 +++++
 tools/testing/selftests/lkdtm/tests.txt |  3 ++-
 8 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.25.1

