Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F12C04A95
	for <linux-hardening@archiver.kernel.org>; Sat, 22 Oct 2022 18:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJVS34 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 22 Oct 2022 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJVS3y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 22 Oct 2022 14:29:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19E3FA2A
        for <linux-hardening@vger.kernel.org>; Sat, 22 Oct 2022 11:29:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i3-20020a17090a3d8300b00212cf2e2af9so4650703pjc.1
        for <linux-hardening@vger.kernel.org>; Sat, 22 Oct 2022 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ke5eIvvI5eCtYNiwclKDnikzCwvckbCDiYPF6Tj1imc=;
        b=QfWGXv74zHYsCEKCzs3pzxyb+u6ZpsB0kuEN3EiocCOVBZ5RpHvOthGsvzoJbhiDXQ
         2XMHJYJu9Ww8+t0b5jg8cRXaJp40iqUSwQ4xnY4FKIwoKitZnWES01K4AcZacx5WNnxg
         bQTy+Ulra75+KaiIu0XQNYaUOVZs6/tuHBi1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke5eIvvI5eCtYNiwclKDnikzCwvckbCDiYPF6Tj1imc=;
        b=eLVBGZttjo9qzeFlBm710w7zSF+isJPQE+J+ep2egRx2X+iFfpWFbWU0++LUKZSW0d
         yPmiyzzPlHJ4dgtWgdXglqF1wL3ynH6W+ajd/LIYBsC8/fF0dVy2JHq+codae/EFvcYt
         Vh3pVyhFCRVnqM73UbETFv8YFeUPIfE0vAOQ2bKwOZuEVCksc/agvy0SVyUN30Uk5wuW
         qFqbPpqI6pqklzCop/4Tm1Jy9i5FbxEOBjsX5ygr1toVlt0wfxIHSG2HLKI9czvXGO6L
         8acGwBnl6s6khwGuJNBEb87LD7Ne9P9srn62hnydt479wFqygCQyxXdcibQYWhCuESuO
         QeTQ==
X-Gm-Message-State: ACrzQf3F/WcTSIB5JRAgSLosbS9uZZkDwlZQWVvZPwRWLKOUl+ghXYVW
        Dc2EVwnHP3CY+Ly5iVd8SBqXVdkbUQSjMg==
X-Google-Smtp-Source: AMsMyM75WuszreNn1hsHB7Pxuapw+PwlrCbIloKlGUfcGQMN628JRLLilodjU+kZh72YpXF7fQVdTw==
X-Received: by 2002:a17:902:d3cc:b0:186:9720:b19b with SMTP id w12-20020a170902d3cc00b001869720b19bmr1498965plb.3.1666463391490;
        Sat, 22 Oct 2022 11:29:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b001755ac7dd0asm17211091plf.290.2022.10.22.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:29:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Date:   Sat, 22 Oct 2022 11:29:47 -0700
Message-Id: <20221022182828.give.717-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; h=from:subject:message-id; bh=iR9JEWgQAWvHWSX99nEJpgLePgBlLNOFiur1YPdjibQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVDac31LObe+GNfv3yrM/Q03eDe7/+zs//PYJn4/G MUdzvBSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1Q2nAAKCRCJcvTf3G3AJrNuEA CMljYUKxXfT5CJr4I06XcaaWVGW3cyeVLcKSJrY5HisrklFSz2k5LB2CHUV6s6q4BTB3XYjDj80Qcx 71CmuKS4+GI5OPslOgWYtse9jcUY5K8ThaayhCb3aWyTAENxXcaS5Grc8RT+dimb6Pw7R0Q7W/KbX2 YJIXKNnBPzj8OMRjEixt38CCWTZQg5+J1JTuaKhu9HNNRE+IOiQyANAKz5WoTtvZDhbJGY8Ilk52/p cfUEgLssA0ekTy4vuaHecxpDj7/Z9OJqRiD4l48ivKXgS1BXkW4BmdZRPfreeZ+4S9h019nFED7i2K HMrTW97+ZoE9hA+agq0UDYhYk+YgTC0pk2wjL4TjMEezNMSperQB96f/s38F3JDSetS3ImorQpWOFl 3O0jJK+07hbKogfytaa0YMDEMU4mxA4071amKllxrcpCpEZq4lSNOA1zQB6F6nc56o4W1IBcigs8di lVMHO+totAbiVv89nAZ39nvzv9lUvND9G0afK4LivTadK8R4VXafY8+dKIOH/L88ppAyGrhkh1hSea la92nxd+VY9HxvDWwBgp7nGQcOdH5Sjgqq4hbPxKkAUUS5h3vxiGgbCJrWTTa8hgRJ4riE52dvBAbn G16yfHMmdcaDfkK++mgUGR/injEMhDT59adWLdZXNuZ9XT04up3OmPvBFChA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

v3: make sysctl a bool (Jiri)
v2: https://lore.kernel.org/lkml/20221015064222.gonna.435-kees@kernel.org
v1: https://lore.kernel.org/lkml/20221015041352.never.966-kees@kernel.org/

This is so very long over-due. We just need to do this and put an end
to this legacy operation.

Repeating the commit log from patch 2:

    TIOCSTI continues its long history of being used in privilege escalation
    attacks[1]. Prior attempts to provide a mechanism to disable this have
    devolved into discussions around creating full-blown LSMs to provide
    arbitrary ioctl filtering, which is hugely over-engineered -- only
    TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
    TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
    had historically used TIOCSTI either do not need it, are not commonly
    built with it, or have had its use removed.

    Provide a simple CONFIG and global sysctl to disable this for the system
    builders who have wanted this functionality for literally decades now,
    much like the ldisc_autoload CONFIG and sysctl.

    [1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
    [2] https://undeadly.org/cgi?action=article;sid=20170701132619
    [3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/

Thanks,

-Kees


Kees Cook (2):
  tty: Move sysctl setup into "core" tty logic
  tty: Allow TIOCSTI to be disabled

 drivers/tty/Kconfig     | 19 +++++++++++++++++
 drivers/tty/tty.h       |  2 +-
 drivers/tty/tty_io.c    | 45 +++++++++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ldisc.c | 38 +---------------------------------
 4 files changed, 64 insertions(+), 40 deletions(-)

-- 
2.34.1

