Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4D2C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Feb 2022 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiBNVii (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:38:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiBNVif (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Feb 2022 16:38:35 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006716BFAC
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 13:38:26 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id l19so25673455pfu.2
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvhw2mfiv5vz0PCotC2YerW2zjqLoGJP2/g8au3hNsU=;
        b=LdBODM3NM3N1GiOpNb4ADxNX+JW7wrSSwfa2J/4h6Jj3vpnIVxT9nhn2XX7X4vjbaF
         MEJFbUosMkvl0k9lkkfo322Co5jxhyYFoNX/VCnJo/jygZBi+kJ9Senvf+nukrpGFbT/
         4H3DTWAL9jlo7NBGm+E/u+3d7f3H8ta0fYT2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvhw2mfiv5vz0PCotC2YerW2zjqLoGJP2/g8au3hNsU=;
        b=bVTY67S0d/WZi/UxuIsK2qNsMjfBxTRQJ1kMiTV3FtBGg9ZyM0OzbywP4Kkdt+I8SG
         VWnHdrk0iQMU5dxMS9kKumKJ+9utlyTCmx3gxTE/1u9xg70swFM0VawIxEskyUEbLBAy
         qsvXZBjX/ICn1wFhv0Vw59TKCaGX34oVf2RrhW13tTi7eHY/2GiwU1M99Vd0V/uwvYM1
         pHPKZBV/5l9nkAAMG2whnfQovKrRoppV2jqSDuibxrKyjknT3/of9Izx/fH+iepLj5lx
         7CLAsEGaoBnUFxOKgKtOKMdvtBAqCVuzIJJRO+G4KPff021TQYw1RWfxyrJPXm21Xtqw
         lW5g==
X-Gm-Message-State: AOAM5332Eew9Z5EwVMjSEhLMGEa6GfZOLUP0gpLwmDHjTxVAgJrtbi4F
        2gf7sF2ex6115JNyZjwhPNQEtA==
X-Google-Smtp-Source: ABdhPJxFrstnucpwd4+VXOVxZctVsNoLCvi/po5w2kM4Ks5Hhv9SmqpM2gZ9FqLO0ndFYnRLPI+HZg==
X-Received: by 2002:a05:6a00:194e:: with SMTP id s14mr706046pfk.82.1644874705659;
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g126sm451499pgc.31.2022.02.14.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] exit: Introduce __WCHILDSIGINFO for waitid
Date:   Mon, 14 Feb 2022 13:38:21 -0800
Message-Id: <20220214213823.3297816-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; h=from:subject; bh=ysptg2kG54PmHPPdsG3BCY4dg0JapIzNFbAp++ZnfKo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiCsvNfYT+JnkT5mppyqxgRiYxE+8aeRlwqsDKM9gg SkGO3J2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgrLzQAKCRCJcvTf3G3AJvPuEA CTVicJCnsllg5+N2h+fxsTBUmOvVjyAlR72ZZ3kFTzCNL1wO/WWCxTVib5GNV7vz1vnN9hFnLI9ii9 YhbIwfQW9FrtJjAbtbr2Y9+PxfkzKfNNCpjXd0jH4Sk2QYSqXRS4VZDyOtvGxVuhGQXE77bY/I83Lo qQnjkfCI8LZmyPQT6OK8G2rCjE8GAXyEzEIy5Hu632u2VBzyO/OXoz3tNxPRY73dI/lIIAwVGXRIw/ LNBtpNvycxCzsrbQtRP/gSuTj/YKTwA5Ls+KwAey7uPUWY29aor3Jv9hu99DDfaNPcdlvp3hSJofZe i9dGOYAFDZthtgqZmeUPKBurLE+kt4ppmgVEyygsOoMrkkMjVlOI5Onppj+T0Q9v0bnyZ3Mal2VFIl ducLqjo37raIwukB6eouHQq6TL1IYTrV4jhSz3eUAI3qq5eCsadKiCBeldjACUeEGTH0BP6agxX/M6 6u6JrIEBwLPTTR1RIb3caOxBtqw/cEyAk3G+55/aecKlzcAm86WBIAd6P/vR33uvdjS3gqYEfDrc91 C1qat4lPUY+IPxHNc1trg2vamwGrzdRxuQb4L3/wIcLJ93jmWru/2sZ6+enMuw+2ROHtX8qp5l9miD zFtEl2/q535MUxORWa0hiW1w15g6UhfIPjl7bdJJZhThtuvF+W1GSFH/ORew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

Okay, here's a working version of this. Is adding 48 bytes into task
struct worth it? Can this be improved, and is the non-signal-exit logic
for __WCHILDSIGINFO sane?

Other thoughts?

-Kees

Kees Cook (2):
  exit: Introduce __WCHILDSIGINFO for waitid
  selftests/seccomp: Check for waitid() behavior

 include/linux/sched.h                         |   1 +
 include/uapi/linux/wait.h                     |   1 +
 kernel/exit.c                                 |  23 +++-
 kernel/signal.c                               |   4 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 130 ++++++++++++++++++
 5 files changed, 155 insertions(+), 4 deletions(-)

-- 
2.30.2

