Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE83C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD20261019
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbhIQGMv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbhIQGMs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED2C061766
        for <linux-hardening@vger.kernel.org>; Thu, 16 Sep 2021 23:11:26 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d202-20020a3768d3000000b003d30722c98fso62593429qkc.10
        for <linux-hardening@vger.kernel.org>; Thu, 16 Sep 2021 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3zrUVwbKEfBYS+g/qOMTeXZGXa+cM1Fx/id4TGcTnuY=;
        b=aqjshXeHh7KYq65oIgapr0BQjil3sP1rDi7xaSzByT7HUdNhTaI1Ys3Wxlz/Z7g3Am
         +hOjpH810t+0u4G9mpxQRBffRfJ62rH1ddXs4ULDpEQR6Ts6jBfJ0gjcpO4kVp8wCOHQ
         Vl8iN8hld/46cAlQUMTAiAhB/6+eDCE1dhcnqKSrsGDeqrAxl6t2FhBn8Bsl4kzSxqNL
         NAWZ+7xfiGeYj9Qd6nT39cNlAK7qfcwkxHdx1U+CIiom21GYWoJX+2VtAip3VlCuFz1w
         jGyqNia1LYugFTCoMyC2dyRJTvbrZO/b7LutqymMpftkHK3U8/75gDv5A0e2jD9U6hVB
         ilXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3zrUVwbKEfBYS+g/qOMTeXZGXa+cM1Fx/id4TGcTnuY=;
        b=Y/z/uUNA6s42vkiobwS5LgZst3o2LLDUhhyocHgziAmuECAvWhVqTicsn/t9s5Zwav
         7s5sBQE2UuWM8SlmjgJliaLSGi45U7p6VxdLImKUdw+mAQlH3vnfhLv5AbLqMMSFbKKS
         5Eg3Gq84obmAHH5pQXHoY8nyundwESgVy3nMng5rTwObX8Tm36ji/XRep31RMMsVmgca
         cGZMNYid/boXTgUfYOBUkVI2aF/ndJYHky52GPokk2cDzAM7kZWowGGzGhiAQGWoocTJ
         YIRYtPQS3O3YoaxqaLVTY7usFbyCSHv5B2JpW+Gs8vRIVF8oFu2uYvbh2EFvj2EBERxp
         +VLA==
X-Gm-Message-State: AOAM530LmgE9EL1ZdnT38bRx0zcAQCj3zgGySXa2D6ltb67hm1g4X/Es
        gDhw0tXR0hZhdhBoNTZQv1MSOuIBy8S1OG4xe0WcNQ==
X-Google-Smtp-Source: ABdhPJycuTlpICuFt0WKNwqUbICZRKz0xI20vVDuhSpUpfdHDy2C99ZMkURQuV1YTT5+M888e29TyWCs6BP2z006i3tORQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:ad4:522c:: with SMTP id
 r12mr9348777qvq.17.1631859085422; Thu, 16 Sep 2021 23:11:25 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:10:58 -0700
Message-Id: <20210917061104.2680133-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 0/6] kunit: build kunit tests without structleak plugin
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
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit; this is caused because KUnit allocates lots of
moderately sized structs on the stack as part of its assertion macro
implementation. For most tests with small to moderately sized tests
cases there are never enough KUnit assertions to be an issue at all;
even when a single test cases has many KUnit assertions, the compiler
should never put all these struct allocations on the stack at the same
time since the scope of the structs is so limited; however, the
structleak plugin does not seem to respect the compiler doing the right
thing and will still warn of excessive stack size in some cases.

These patches are not a permanent solution since new tests can be added
with huge test cases, but this serves as a stop gap to stop structleak
from being used on KUnit tests which will currently result in excessive
stack size.

Of the following patches, I think the thunderbolt patch may be
unnecessary since Linus already fixed that test. Additionally, I was not
able to reproduce the error on the sdhci-of-aspeed test. Nevertheless, I
included these tests cases for completeness. Please see my discussion
with Arnd for more context[1].

NOTE: Arnd did the legwork for most of these patches, but did not
actually share code for some of them, so I left his Signed-off-by off of
those patches as I don't want to misrepresent him. Arnd, please sign off
on those patches at your soonest convenience.

[1] https://lore.kernel.org/linux-arm-kernel/CAFd5g44udqkDiYBWh+VeDVJ=ELXeoXwunjv0f9frEN6HJODZng@mail.gmail.com/

Arnd Bergmann (1):
  bitfield: build kunit tests without structleak plugin

Brendan Higgins (5):
  gcc-plugins/structleak: add makefile var for disabling structleak
  iio/test-format: build kunit tests without structleak plugin
  device property: build kunit tests without structleak plugin
  thunderbolt: build kunit tests without structleak plugin
  mmc: sdhci-of-aspeed: build kunit tests without structleak plugin

 drivers/base/test/Makefile   | 2 +-
 drivers/iio/test/Makefile    | 1 +
 drivers/mmc/host/Makefile    | 1 +
 drivers/thunderbolt/Makefile | 1 +
 lib/Makefile                 | 2 +-
 scripts/Makefile.gcc-plugins | 4 ++++
 6 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 316346243be6df12799c0b64b788e06bad97c30b
-- 
2.33.0.464.g1972c5931b-goog

