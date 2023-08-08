Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E01C001B0
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Aug 2023 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjHHRUi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjHHRUN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 13:20:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259A77282
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 09:08:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f1240a22so5635299b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510875; x=1692115675;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=frvcjSHU9+qDHY4YZC4he2fEZsvOzbP34ouHk5d60vI=;
        b=adSwNJODpxtCw9/7mAwJgSmxtH/uijEK5h6USSytejdZCjloRrErG0vEUfO++n1+kb
         fCJ4hBMT7bTKglz+gc02W0KK+ntfweHcAX62dJClqx7n1ll6p1mKv8oQUiwrZ5L4BdR8
         bqY/nNYvNgxywaJKejMBIl8uS2VHYlh/EqhJMDQeClskFm0jZHY+SJUEq2rv9MbW89dX
         NwxZOtnWE2k2mJeSOb5KTXTrE87ZwqHwiLN4wLH4fcCzgnl83BDAUNEA6vRElewIwwLK
         YYIbt2fG0pLauHlsNyhJsHSB4yVRoEOFBfrFvaUZd1OT1V0FEqnr5DzhWhenPLITthQe
         Qsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510875; x=1692115675;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frvcjSHU9+qDHY4YZC4he2fEZsvOzbP34ouHk5d60vI=;
        b=izB+hkq1fHaBNw+aHluRftRe3UnMeTepBH7t6Wp6fbVYhgA9Doupc5DWHA45LjTDf8
         RatYt5Q/T6FD8XK98KPT6cxaMhFnD6Mh21xb40R65AXO4h1Gp+TWxIEnYetIXGPMuINW
         CBRsCd33+Yz9B2wiCs9nN+FIjtUEZ0nC7reeP63nddoKBnBJuOTD7Glv+C2iyBVmQIDr
         evLh8T3khtGfQ0qRYCdiciz03YrGkHtBtbtwBMQt5vohE/caditDwI5PRMXWXuvynD/e
         bTs4w6LpN2lBkdSB6AKXLz/i1+8IOUrgQIx641+W4MIc2MmWsVeJzd4BxV6vCewjWQ0x
         ZQsA==
X-Gm-Message-State: AOJu0YwaOLpocbFp4AVRV/1U1+BCTwDz6CbEKUOQZpOiOik9zEtcuZDe
        ovHbMN1el7mVhUttWJFw+f2ZT1n+OCxka6o4CBZjBiRxhUGAaBvJG+I=
X-Google-Smtp-Source: AGHT+IEmrwbdceoImr/R1pVLTPPsMVZl7KMGyvlgjYP7+OdE6wTnFjB1sGC91Ej10qjfVOUgq8HfN0LbTnuvsAMOdpw=
X-Received: by 2002:a05:6102:3172:b0:445:202:d278 with SMTP id
 l18-20020a056102317200b004450202d278mr4303132vsm.32.1691472461928; Mon, 07
 Aug 2023 22:27:41 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Aug 2023 10:57:30 +0530
Message-ID: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
Subject: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC 13
To:     linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

LKFT build plans updated with toolchain gcc-13 and here is the report.

Stable rc 6.1 arm64 builds with gcc-13 failed and the bisection is pointing
to this as first bad commit,

# first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
   gcc-plugins: Reorganize gimple includes for GCC 13

Thanks Anders for bisecting this problem against Linux 6.2-rc6.

Build errors:
---------------
In file included from /builds/linux/scripts/gcc-plugins/gcc-common.h:75,
                 from /builds/linux/scripts/gcc-plugins/stackleak_plugin.c:30:
/usr/lib/gcc-cross/aarch64-linux-gnu/13/plugin/include/gimple-fold.h:72:32:
error: use of enum 'gsi_iterator_update' without previous declaration
   72 |                           enum gsi_iterator_update,
      |                                ^~~~~~~~~~~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Links:
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.43-111-g565bca90c30e/testrun/18861637/suite/build/test/gcc-13-lkftconfig-kselftest-kernel/details/
 -  https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.43-111-g565bca90c30e/testrun/18861637/suite/build/test/gcc-13-lkftconfig-kselftest-kernel/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y-sanity/build/v6.1.43-111-g565bca90c30e/testrun/18861637/suite/build/test/gcc-13-lkftconfig-kselftest-kernel/history/

--
Linaro LKFT
https://lkft.linaro.org
