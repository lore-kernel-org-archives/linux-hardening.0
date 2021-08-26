Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A92C4320E
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 05:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6953A61073
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 05:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhHZFFt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhHZFFs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 01:05:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F9C061757
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 22:05:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mq3so1382669pjb.5
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 22:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3i6KrEuw8h/peN0IKoJcpFVyDg8pYoLtD7AuzkMA7e0=;
        b=GR2qZqvO8ZL1f8QcgP5NMic9fmn3Bu3LEuTBeKGAqz576PlcHL5FRcdPB+y+DtSziH
         SCt+ZSgZBZKIP3V6/deb7lOg6KZ/tQkPnDeH4jMKwPMjt2s8Q5WErVQ2mzFuolTT9MGL
         xMblZu7rJBKQ7ioxj9UxSTcVGTXJXdUGnESlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3i6KrEuw8h/peN0IKoJcpFVyDg8pYoLtD7AuzkMA7e0=;
        b=hR8iH+YTNluyT7QxTLNhOf2xtvpKVbrhbfM0QQ/JkN5MOfV68VrLz8OnhFD6VSxQPz
         Im89FHY2I7gerRIvXQaJSOgdTVhrKdVqTrxaV0RnYfCFVdDR8qsaEDaZ7w8pw5K9XqAP
         N85sJwPOHCPZ3dHdR7Vbyr5NhhFrMpRr1AORXLBiMcIYf/EQkqjHpRo/Q54qRDh8SoQx
         CRewd1xLcn0ojnWWDisTkekptgkMba6M394jlmn8VadVoX9t4vRTCFVExqbkmo/3oa/L
         HAqnwn0b/raekrMHeaOvD56gCmonYTf/3q4243K3X2Rqyx3FUk+oObS7t3DgBNNRIaBq
         llCw==
X-Gm-Message-State: AOAM533xVK0/Xw6NnRLRDpZeeK9wcqEeRZcVy51kxPmkdfsCLdpYoFHd
        9caM/QgdxOAmcua/2UYxhLKSdw==
X-Google-Smtp-Source: ABdhPJzZzctAvayc5CfKqFINU+WLUtveCPJ37aet1tFft/jE0ucb7YpvQ0eWIezqA8P4Yll7krYoNg==
X-Received: by 2002:a17:90a:4e:: with SMTP id 14mr7628062pjb.180.1629954301543;
        Wed, 25 Aug 2021 22:05:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4sm1053437pjc.46.2021.08.25.22.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 22:05:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Date:   Wed, 25 Aug 2021 22:04:53 -0700
Message-Id: <20210826050458.1540622-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; h=from:subject; bh=o7TIWnomune4Ws+iBo2usi7oveKXrsEW70VtvNJKH6E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhJyD49pr63WOG14n7u9Nv6gB4HAdHH/eZ+4L58ymK 6i6X+PKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYScg+AAKCRCJcvTf3G3AJm9sD/ wP1xeYSoDkz6OHHs1AZ8bLJAFBNcvq7/HqNNu2d8FS649foInCIJgrj2yPgkBbYLVrF2l7r/0+ujAR xuCHPUUUQBVSWgXs8wogZczPqWEg4E/MoB+UzEeFhEhHkTOJ1ZrrLZA/9DhKL9Y1tZT6kllGZBmrjn xEyhqmZxBemIQA4HaluuJNlERn8WWf/1F/BzwxTQGZHip5bFxG62+Vh3PHFpY2gUZ1M5ySlbDxeZZV MZO8a3E139AamKiYVRr06/8nh+lKCubv35uhbdHdFWTZkVJ5jks+M7tScpnIPNCfd7i+qsusD8Rtin 3gZ7LGUZOfRL6+BH05pvBUeEDwo/mSmsgEbfNnoIrDry+AvlppSE+JZfVe5A9YKQs4D1q3TSQVj2G1 UqutmhlnQmW8QmfS6XdKXVCIiTkEBLZupxhCQqFzXR51jNAj254IaH4rGZ4T0tx4mDhk6rQv+fa8mq O0UGVoJQlCbh+945iFJbck86t8LnqA58DiSSFgov3Ya8IY0+bBCmH/FasPoQ7oh9z298CXpURzaEuV 0WdquMzeg+R4RDuT46G3JEjb4F3woT27AxGlJBMsZuuLVdssbXvjVbSB7ciZuqiAxrw3Wtc6EaB6nu vYUkMn1xQ0tKlckECwgF6fQP7jYs8sPwnutBxZWJBV/QUWWQG7I1i51asEmQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

v2:
- rename flex array helper
- split flex array helper arguments to be more DECLARE_*-like
- added knowledge of flex array helper to kernel-doc
- added reviews
v1: https://lore.kernel.org/lkml/20210818081118.1667663-1-keescook@chromium.org/

Hi,

In support of the improved buffer overflow detection for memcpy(),
this enables -Warray-bounds and -Wzero-length-bounds globally. Mostly
it involves some struct member tricks with the new DECLARE_FLEX_ARRAY()
macro. Everything else is just replacing stacked 0-element arrays
with actual unions in two related treewide patches. There is one set of
special cases that were fixed separately[1] and are needed as well.

I'm expecting to carry this series with the memcpy() series in my
"overflow" tree. Reviews appreciated! :)

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
 drivers/crypto/chelsio/chcr_crypto.h          | 14 +++++----
 drivers/net/can/usb/etas_es58x/es581_4.h      |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.h     |  2 +-
 drivers/net/wireless/ath/ath10k/bmi.h         | 10 +++----
 drivers/net/wireless/ath/ath10k/htt.h         |  7 +++--
 .../net/wireless/intel/iwlegacy/commands.h    |  6 ++--
 .../net/wireless/intel/iwlwifi/dvm/commands.h |  6 ++--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 ++--
 drivers/scsi/aic94xx/aic94xx_sds.c            |  6 ++--
 drivers/scsi/qla4xxx/ql4_def.h                |  4 +--
 drivers/staging/rtl8188eu/include/ieee80211.h |  6 ++--
 drivers/staging/rtl8712/ieee80211.h           |  4 +--
 drivers/staging/rtl8723bs/include/ieee80211.h |  6 ++--
 fs/hpfs/hpfs.h                                |  8 ++---
 include/linux/filter.h                        |  6 ++--
 include/linux/ieee80211.h                     | 30 +++++++++----------
 include/linux/stddef.h                        | 13 ++++++++
 include/scsi/sas.h                            | 12 +++++---
 include/uapi/linux/dlm_device.h               |  4 +--
 include/uapi/linux/stddef.h                   | 16 ++++++++++
 include/uapi/rdma/rdma_user_rxe.h             |  4 +--
 include/uapi/sound/asoc.h                     |  4 +--
 scripts/kernel-doc                            |  2 ++
 24 files changed, 115 insertions(+), 65 deletions(-)

-- 
2.30.2

