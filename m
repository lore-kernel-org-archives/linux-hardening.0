Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB02C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 22:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbhLMWdi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbhLMWdh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2CC061751
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:33:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so14510288pjb.5
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNRoX2Q5eG84v1KKqWC/pAWv5+ytHkK7Pi2rzc9j+W8=;
        b=ZIZ1200E7NRcHOqudUbF/08LxAnlIQ8OuG2CU75sqi2R95UGUPD96DC+S9u6BpJDty
         RrburO2PAqxjE9N1LWf5GRt05iAr7VRe4gDrV+ZiMZekA7B7Gg6fcY1MpBkzZRKXJadM
         aGxKvFKjIEHlbPGS0eNrvuLaHAb39OyZ0Mg1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNRoX2Q5eG84v1KKqWC/pAWv5+ytHkK7Pi2rzc9j+W8=;
        b=kAR92DWZNu3NQN7kkMf0czyTJIz0ImeBGiZnUlpcAkricCjc9/lp/vizqJwmVFYI8J
         VJc1sV711xhOeyfVwPU/vfLClorWTTCOfQYUcNm/2Z+WnMFsCO/0NRL6052XAltwteuu
         HoNUI+zg1xmB/gGl8bxNhBJeIamZBTJwvvkMIgXhS0fF4rKLlcjaN6op3IKVpk9rYbcX
         tYK52iYArfZte+pGAn/aVYrTwZhfXgwi+oebwEC0hm486aZ40YVRe/mAKTJ6NopPPatz
         y4MrId8x3nlm6pwWtRRXklM0lsxspbdLsRAktspPUSv+SqENujWfiLbzx7TgA9RorJvM
         4+tQ==
X-Gm-Message-State: AOAM533Ob7PQzj+1ew+GJ9ztiSdvyMwKA9Gro6PReTWSxv0CieuV1gwE
        yMIVXfaWBgfvr322hTRoGy0UhQ==
X-Google-Smtp-Source: ABdhPJzAEQkO0JB9lSLQ0zAyukzPVjgctysuKOughUVvG64FQ+gCYJrmTfmhH/pFqH6KE/Z5F6Useg==
X-Received: by 2002:a17:903:2445:b0:142:830:ea8e with SMTP id l5-20020a170903244500b001420830ea8emr1057879pls.54.1639434816697;
        Mon, 13 Dec 2021 14:33:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm3889626pgl.79.2021.12.13.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] Enable strict compile-time memcpy() fortify checks
Date:   Mon, 13 Dec 2021 14:33:14 -0800
Message-Id: <20211213223331.135412-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5182; h=from:subject; bh=rNT/QIX5ecDglR0ljeFNH2woOLGFYihwPD7eHSWoACw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o2RZ29iQX29tv9x7BLMw90tL3TRphdmxRiQm+H Itt1c/aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKNgAKCRCJcvTf3G3AJpElD/ 4gR5Dfxq8M7EJh81EJtv0DuadRnp5hEkg4ffAzLKR6o1bL6H1uC57d2Wgwb3OIszQlZncoOmCl/xAE YH43cIOmwio4EeiqfRS4dIvy7m6MWvPjspKAQ22PaHC7d/Ub1+V2faWdk2elAxM9vLV/MsRkvBnY5S vp6eTrC7sdFL4L6XWeSdELOub6XnBWOovpxXzBXvBd4NL7eZBnPpZKN0z52IswDA89/7NaxgQkkVSl EtGsvIfw4qi7sAHpd3FoNlWIAKczOXEuhAsCgONC/C6pkVVp7WFa+Obd0aUw80ZjlL56fx+8qpUXvq VEXWlMWjlrTeF65fv6oklzsT8a0Fu9IC3N6CGFiS4d9ji2C21P+aAjo2HVwlkG7t96SmCTS/TjBu2l Xkzq4h3zK7kdQAip5qZPMkv8XtUp80V4zWIU28xupgvMDKA39Oc0YjNKKEzKSKNHcVp8+gPQSYP8LF HZ1xhoba4UM045mKZVUHpbPwajSbLT4K/0fvK7IJZLGno7R7qgMw5azEjoo9aIvsD5UTR0p8Doo4Pw XdKtoIoqtiQCE3juzu2c/e6lf5mumRQy5PqVDAM1klovY2N6VkU9saEj7KVa6c9ZdGwnOBF9SQY9sf 4P9h/1Stc7Z1oRCXRqhRsf3gk/D+CLqh2tY5+P45P87+nuoE2XVcR46RP9jQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This is "phase 2" (of several phases) to hardening the kernel against
memcpy-based buffer overflows. With nearly all compile-time fixes
landed, the next step is to turn on the warning globally to keep future
compile-time issues from happening, and let us take the step towards
run-time checking (and towards a new API for flexible array structures).

This series is based on latest linux-next, and several patches here
have already been taken by subsystem maintainers but haven't appeared
in linux-next yet, and are noted below.

-Kees

refactoring patches expected to be going via subsystem trees:
    sata_fsl: Use struct_group() for memcpy() region
	https://lore.kernel.org/lkml/23527f89-d098-ab6b-f3c9-a8a395e32df5@opensource.wdc.com/
    ath11k: Use memset_startat() for clearing queue descriptors
	https://lore.kernel.org/lkml/163777372886.11557.5551795598856429949.kvalo@codeaurora.org/

refactoring patches going via my topic tree due to having no current response:
    net/mlx5e: Use struct_group() for memcpy() region
	https://lore.kernel.org/lkml/20211118183748.1283069-1-keescook@chromium.org/
    net/mlx5e: Avoid field-overflowing memcpy()
	https://lore.kernel.org/lkml/20211209053402.2202206-1-keescook@chromium.org/
    media: omap3isp: Use struct_group() for memcpy() region
	https://lore.kernel.org/lkml/20211118184352.1284792-1-keescook@chromium.org/
    drbd: Use struct_group() to zero algs
	https://lore.kernel.org/lkml/20211118203712.1288866-1-keescook@chromium.org/
    dm integrity: Use struct_group() to zero struct journal_sector
	https://lore.kernel.org/lkml/20211118203640.1288585-1-keescook@chromium.org/
    iw_cxgb4: Use memset_startat() for cpl_t5_pass_accept_rpl
	https://lore.kernel.org/lkml/20211118202335.1285836-1-keescook@chromium.org/

refactoring patches going via my topic tree due to Acks:
    KVM: x86: Replace memset() "optimization" with normal per-field writes
	https://lore.kernel.org/lkml/202108181605.44C504C@keescook/
    RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
	https://lore.kernel.org/lkml/YbByJSkBgLRp5S8V@unreal/
    intel_th: msu: Use memset_startat() for clearing hw header
	https://lore.kernel.org/lkml/87sfyzi97l.fsf@ashishki-desk.ger.corp.intel.com/
    IB/mthca: Use memset_startat() for clearing mpt_entry
	https://lore.kernel.org/lkml/20211118202126.1285376-1-keescook@chromium.org/
    scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info
	https://lore.kernel.org/lkml/1164349c-93a5-ebb8-94aa-dbe03957c40f@gmail.com/

fortify changes going via my topic tree:
    fortify: Detect struct member overflows in memcpy() at compile-time
    fortify: Detect struct member overflows in memmove() at compile-time
    fortify: Detect struct member overflows in memset() at compile-time
    fortify: Work around Clang inlining bugs


 arch/x86/boot/compressed/misc.c               |   3 +-
 arch/x86/kvm/emulate.c                        |   9 +-
 arch/x86/kvm/kvm_emulate.h                    |   6 +-
 arch/x86/lib/memcpy_32.c                      |   1 +
 drivers/ata/sata_fsl.c                        |  10 +-
 drivers/block/drbd/drbd_main.c                |   3 +-
 drivers/block/drbd/drbd_protocol.h            |   6 +-
 drivers/block/drbd/drbd_receiver.c            |   3 +-
 drivers/hwtracing/intel_th/msu.c              |   4 +-
 drivers/infiniband/hw/cxgb4/cm.c              |   5 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   4 +-
 drivers/infiniband/hw/mthca/mthca_mr.c        |   3 +-
 drivers/md/dm-integrity.c                     |   9 +-
 drivers/media/platform/omap3isp/ispstat.c     |   5 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |   2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c      |  13 +-
 drivers/scsi/lpfc/lpfc.h                      |  90 ++++---
 drivers/scsi/lpfc/lpfc_init.c                 |   4 +-
 include/linux/fortify-string.h                | 245 +++++++++++++-----
 include/linux/if_vlan.h                       |   6 +-
 include/uapi/linux/omap3isp.h                 |  21 +-
 lib/Makefile                                  |   3 +-
 lib/string_helpers.c                          |   6 +
 .../read_overflow2_field-memcpy.c             |   5 +
 .../read_overflow2_field-memmove.c            |   5 +
 .../write_overflow_field-memcpy.c             |   5 +
 .../write_overflow_field-memmove.c            |   5 +
 .../write_overflow_field-memset.c             |   5 +
 scripts/test_fortify.sh                       |   8 +-
 security/Kconfig                              |   2 +-
 33 files changed, 344 insertions(+), 164 deletions(-)
 create mode 100644 lib/test_fortify/read_overflow2_field-memcpy.c
 create mode 100644 lib/test_fortify/read_overflow2_field-memmove.c
 create mode 100644 lib/test_fortify/write_overflow_field-memcpy.c
 create mode 100644 lib/test_fortify/write_overflow_field-memmove.c
 create mode 100644 lib/test_fortify/write_overflow_field-memset.c

-- 
2.30.2

