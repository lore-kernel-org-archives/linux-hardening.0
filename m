Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F5C432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jul 2021 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F2F60ED7
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jul 2021 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhGWVjM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhGWVjH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Jul 2021 17:39:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E526C061757
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e21so202053pla.5
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/aIOHI86Md8+7aRLP6KogpBCvx6+c9epmyU3U5xlb4=;
        b=drtY9R/lcyztqSAm9e5BJBDsuyIEZNAw4hLUrjv9cTfDMfx5IFh7OrSlQy5MozZ09s
         7TaZuaxpvuZBsPPXRojRxMeR9/wAiKlOR7GdPPL93Ij2MpxkARzzChMFKBIQxlHYRxmP
         GHDB6v2f2ocKDqtkjdNMUJtzkSifapJumuzbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/aIOHI86Md8+7aRLP6KogpBCvx6+c9epmyU3U5xlb4=;
        b=ZIh6P0wQUP2HrOjnxHl/VbutJ4eouaNKNm2sv1/KghdD2XGHkXlObuVGI/FXjLY8Cp
         m0W1i8Zb3nZ3kk0ZISyHq0CNYRX4mXvjrR0D8igXwDhR1jewQhs3OGdxx2X0Wh9pRE4F
         SkCJhXGvkCprUnTGDpaicI4rPkn0v+0ZksL44Ji5nSuViP56UmUgHi8ToUfM+tyrZgyk
         fFep/+sXOGg4+7K+wp6HnaDu2YQvSQubssywmozfEsC4W/fiEJhZNLB9SE9I6XkMWE6i
         sAxKZw0xuSi3XsZLD4st9v2xH44zYkuSD8W+Bhn0Dy5DU69OeEYMV1Cjzj4gQAki5rxS
         Am5Q==
X-Gm-Message-State: AOAM531ZmAzc0sb8GR555Or5nmsP3imSF8hKrezygQPdrtHD0Vt8qHt3
        i2xooKv54jQKkMSBFG4pPSC65g==
X-Google-Smtp-Source: ABdhPJxxNULsNhrwG19c1Nx2g4DrC1PCMP894UgkBDoQ+D3jvgZD0QrkLJXHnmIFeVvfSLvBCpJwvw==
X-Received: by 2002:a17:902:ab88:b029:12b:d2ee:c26f with SMTP id f8-20020a170902ab88b029012bd2eec26fmr2627086plr.38.1627078777847;
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h21sm1883548pfh.67.2021.07.23.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 0/3] lib/test_stackinit: Add assigned initializers
Date:   Fri, 23 Jul 2021 15:19:30 -0700
Message-Id: <20210723221933.3431999-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=609; h=from:subject; bh=DHN1AJsInnHOFrkW5ZzfccEROoE6nwehLp5ORzOE8hE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg+0BzuLziN9AOlXnW/3Ztg/LucdLyHqlgjAXuQRJN L0r/J2GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPtAcwAKCRCJcvTf3G3AJvtTD/ 0TjMl/42NgHK+OxQAvHpf/mSTqJz0WN6sQ/5C6N24iZ3u6ewuA9yLVsU8WsLDz2thue0NhvF+VvLw+ DVQlK3w+8kEP5aG7M+uVsfbgkf+WF5zypJP4FEBC29whN2h1bywM0b3Ewh5WlyrWeWjYslW5zKPgzx sTvNxbA0SWQL7gjTwHTD4Ky6PtSCuk93DJwe8hK1Aucr09fRrdWO/SDI0ya6Y5K93xRqui7HfPtOHu zQaACEyxvnnOWNCbYN4O6qtMrM/7/cCkMx0iRW73tjSRg3/d1P0gseoeiwhOkUCcmVh2hHK2kOPqIq ThA7h8Y5cYnXGjBFxIlb8c1PHgRIq/CdiNuhUlk/Ik6AMY41XfJxHjwM82A7LqytQ0cyfuTxycWzMX 3l/LLIcouRdyKgSpTOFsR6k6kOQQxih7t1FUrAy1ctfPnnslCjJSLR8PvyrSJq7DJaZUvD+2fXdIRa b3lyy7O1MQt4QT2qcBKj3evhHjCJ3IlwSXbejalCdT65SEfUqxs3nR1yopKvPoABb/WpMEyDJX13tx d7eR7PEfogSBPpIijz/ZomF5QL7192g22GGPXjssAJD6WxmB9EYnqnXJD7AD6QP56bMWvBaaIs6tOu 3b0zf+IHKIgNWjXUlHbTqMtfVQ0Qr7iP/XhKHIBs28coregy3k2Hm8+X7UBA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This is a series of changes to test_stackinit.ko to expand the tests and
provide a stand-alone build, in support of the recent work in GCC for
the -ftrivial-auto-var-init={zero,pattern} option[1].

Thanks,

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2021-July/575224.html

Kees Cook (3):
  lib/test_stackinit: Fix static initializer test
  lib/test_stackinit: Allow building stand-alone
  lib/test_stackinit: Add assigned initializers

 lib/test_stackinit.c | 252 +++++++++++++++++++++++++++++++------------
 1 file changed, 185 insertions(+), 67 deletions(-)

-- 
2.30.2

