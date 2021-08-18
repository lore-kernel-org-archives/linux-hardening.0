Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA507C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 08:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2060F58
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 08:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhHRIMC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbhHRIL4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 04:11:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADBBC0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 01:11:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e7so1448423pgk.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY8Vy2Gwyp/6ClqTLbufHKX/EBwR8IarJAz8L3RIxlc=;
        b=YHDlqivsdPRMc7k7QuFP49YWPnZX5tqBzJZyKfK9Aqg/3i41FY7PvHSffQz8m5Jsqt
         wg5mZ2IO/8YSKAUhDL2fczpSbua4Y1ajalIN9avI7hnp3bgpEt7s7aeUFbGZ0p1x6VTT
         geSf8CMBCO5c/ec0G1wW8P6rUX0bRuFRKAlag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY8Vy2Gwyp/6ClqTLbufHKX/EBwR8IarJAz8L3RIxlc=;
        b=ETiREa4SNfPYfuAy1IDdYxtFxWoxMXhGl4jeKW6UN1KXRNDY/fFB5jSHcu7YVNpLnM
         hlVNjongWvvZivhEAw7QZPq3jYz6qrd8w2I98qQHZJCWXKL0Fxf31KYSW7I21Zmc9gE8
         brbji4djE/LJUzP9HOPSdMQhirzS63ovBw8xx4F0RTMcro/5L1HJlJjqy/yg+RYkmlvf
         PXGXGfLs1IDd41NfraBK4vA5REROy3D0R2RPTJrFE4UQwWHLNck2EHz6fpfU1bOeF0MK
         8evBK95UencCSjiTEIcgIhd4kQvbfJL435INPC723fvIsjLjmRlLyfZqxPcqtPVTQF8/
         AP8Q==
X-Gm-Message-State: AOAM53375xxSHn8fTgmiG1U72PlTj3d5rNU3slVIA4diOW8izNUcOQNF
        u6gasmAOx0oP0Jo8Vp3B+0tcbQ==
X-Google-Smtp-Source: ABdhPJx5HYsMHa2HyoaLEeJ3ss9Nj8nYDUPuCRY2mLhV6Ni48pmptgwwRam192YCN2nv8vx8MAJ0aQ==
X-Received: by 2002:a05:6a00:a8a:b029:356:be61:7f18 with SMTP id b10-20020a056a000a8ab0290356be617f18mr8090194pfl.29.1629274281741;
        Wed, 18 Aug 2021 01:11:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y64sm6025462pgy.32.2021.08.18.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:11:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Date:   Wed, 18 Aug 2021 01:11:13 -0700
Message-Id: <20210818081118.1667663-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; h=from:subject; bh=+3PbFLzhuXuKeiP367B9yvw5C8+1fj6n3ISBhfoxQDs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHMCkSUiloWdfwIMtIoPfyPuaMV2HH6ioubUcVTij 9T1WEYmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRzApAAKCRCJcvTf3G3AJqm0EA ChSv0Nffl6FINd190zgIqcanz0y9aCYtQjW/WBWmWoBHBtLl5zrJmrWacWwc5ocQAkJjaNeIGAxuY/ QHS/tN0fPkWSc2hToXFjHIdJZO1ktvd7QgT8mUfwFqe4Eaz2qZ3XzxGgqB2YzMbL2FYNGvlcniCU/D c3xjyFdgptWVtq5FRm2Dm0/XkDSB6QHlGiy3CmwAX6My8J3cofejb2UiypApunOhy8z9b2O+lZ9QOD Dhzqjex3OvFlJ2Jzyuv1Abo/2QojMbdJghlPzywS9j9ex+gcLxW5GDnguz+ccucqhETH6xC/epZI5h SMYB/DGuWABAN5qGYDTgaJJZpv9KOlSPB5y8VMBbBvaL9FcCc2/wDnzNFYwJf/XjOsC5NXDSTbazmi Ao3IgNbmpJoyX5ZdNLywMf/aaG+PiHVI4wyaJZ9KZeLaK99SofVDXl1cIS/GV9ZG+tUnM9TMw+y8UD cLO8aujcSG+nndIvYgcE4CWJFMAG2gduJ/bA1shlWcQlFPKevKg8mufGF/woJLAMBg5VqIgsc1aCyD bx+5hRr/EINK9i6JNUR4Z0gjmKByzxnfjZhRDipz4KCYd5oA2GJl+VGktm/tdYPXDhzlk0c8TfeVBd BEKphz8q+u/33EhssPDlx4YX5cJyBRvfp5ZIUbBO205h1nFGhvu/LF85Majw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

In support of the improved buffer overflow detection for memcpy(),
this enables -Warray-bounds and -Wzero-length-bounds globally. Mostly
it involves some struct member tricks with the new flex_array() macro.
Everything else is just replacing stacked 0-element arrays with actual
unions in two related treewide patches. There is one set of special
cases that were fixed separately[1] and are needed as well.

I'm expecting to carry this series with the memcpy() series in my
"overflow" tree.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210818043035.1308062-1-keescook@chromium.org/

Kees Cook (5):
  stddef: Add flexible array union helper
  treewide: Replace open-coded flex arrays in unions
  treewide: Replace 0-element memcpy() destinations with flexible arrays
  Makefile: Enable -Warray-bounds
  Makefile: Enable -Wzero-length-bounds

 Makefile                                      |  2 --
 drivers/crypto/chelsio/chcr_crypto.h          | 14 +++++---
 drivers/net/can/usb/etas_es58x/es581_4.h      |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.h     |  2 +-
 drivers/net/wireless/ath/ath10k/bmi.h         | 12 +++----
 drivers/net/wireless/ath/ath10k/htt.h         |  7 ++--
 .../net/wireless/intel/iwlegacy/commands.h    |  6 ++--
 .../net/wireless/intel/iwlwifi/dvm/commands.h |  6 ++--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 ++--
 drivers/scsi/aic94xx/aic94xx_sds.c            |  6 ++--
 drivers/scsi/qla4xxx/ql4_def.h                |  4 +--
 drivers/staging/r8188eu/include/ieee80211.h   |  6 ++--
 drivers/staging/rtl8712/ieee80211.h           |  4 +--
 drivers/staging/rtl8723bs/include/ieee80211.h |  6 ++--
 fs/hpfs/hpfs.h                                |  8 ++---
 include/linux/filter.h                        |  6 ++--
 include/linux/ieee80211.h                     | 34 +++++++++----------
 include/linux/stddef.h                        | 10 ++++++
 include/scsi/sas.h                            | 12 ++++---
 include/uapi/linux/dlm_device.h               |  4 +--
 include/uapi/linux/stddef.h                   | 13 +++++++
 include/uapi/rdma/rdma_user_rxe.h             |  6 ++--
 include/uapi/sound/asoc.h                     |  6 ++--
 23 files changed, 112 insertions(+), 70 deletions(-)

-- 
2.30.2

