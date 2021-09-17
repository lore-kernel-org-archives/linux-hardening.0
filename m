Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B919C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DA5611C4
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbhIQGM4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbhIQGMx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10789C061767
        for <linux-hardening@vger.kernel.org>; Thu, 16 Sep 2021 23:11:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w17-20020ae9e511000000b00431497430b7so49499114qkf.12
        for <linux-hardening@vger.kernel.org>; Thu, 16 Sep 2021 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=I4FOT8yOHsLhfAzdZiAF0l/kcO/QKiXi6j8WbW9LXJI=;
        b=UY3TinilJRju1u6lzAykebCAKMTWaSuBZvn8jYC8UK4+LbXvIlCflfwHlFEphBHs8B
         1iFMgEZGban4DYDF7Ng4Bxjo8NRN9zOf3LLvDcjhZho+zGb8eIYgXkYwA0Otb0f/FShE
         yCmK2uqakDDxdXMcri2Lg+CMzpqgtphiucDdAVEWrO4iTlv4H6bq8Gawab6VO22To9bF
         X7RxLGWNSjvgLN+qQRj6LibXm4BaLGhu5Xy+N2dBaNZPk7IY2MX6VGtuGBV+XMHGYz17
         gK2smKuDIdXkivtrGOnp7UxDzkVWma4nv+Xs6OV5VYWRjcuzPSQps0HL5bUHRRb0Qx+d
         Iq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=I4FOT8yOHsLhfAzdZiAF0l/kcO/QKiXi6j8WbW9LXJI=;
        b=6hKNqS2T3EQCHMKhMzS+vckmsI2IjGjghud0SjtICgnZoaUMaQ/hpvQODQK7Wat82o
         Npw2WShw5NLXmu0BrM3MO5CWE3upMDZ8gcCOBGy+GZegJLcTHoZl+VCbPVke/ElkKe8i
         SikOSpdJ5rvzZM8ASkdTZCWCpgrs5g1qkfZQyP7Rk5AaueiGjt1U2sIAzm/tnMHHoyPJ
         Hu04WMx4gkowIYTgiacQC64xh7+ywkUmWxAYgMNvGqJDw/EfAQGP31Vy31lLMk7UUV2J
         1PwAfluCyBbxkcW6bwac90LRloHAgZ3aDO2STiVS+9ftfNUBiikOZwPiCkoa7PTbEBqM
         lQxw==
X-Gm-Message-State: AOAM532ozUg87YPynDLO1Xxo+xcx71d19AkQ9qHcC+MyLPeI3d80zUbj
        62g9Pn220C7hDpOTARN52dE2vvTplnwUPA8XNLVKqg==
X-Google-Smtp-Source: ABdhPJxQU9dA2VoByCENV7Js4YP5bqWeXxiNL61cyojxtkYNrLzgmDJAwC0DC/PduGlki5LgIsdKe1pz5QUxEe86UMUTvA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6d43:: with SMTP id
 i64mr11100758ybc.252.1631859090133; Thu, 16 Sep 2021 23:11:30 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:00 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 2/6] iio/test-format: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit:

../drivers/iio/test/iio-test-format.c: In function =E2=80=98iio_test_iio_fo=
rmat_value_fixedpoint=E2=80=99:
../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336=
 bytes is larger than 2048 bytes [-Wframe-larger-than=3D]

Turn it off in this file.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/iio/test/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f1099b4953014..467519a2027e5 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,3 +5,4 @@
=20
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_TEST_FORMAT) +=3D iio-test-format.o
+CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
--=20
2.33.0.464.g1972c5931b-goog

