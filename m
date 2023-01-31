Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28BC636D3
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Jan 2023 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjAaXkO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAaXkN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 31 Jan 2023 18:40:13 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08131F77F
        for <linux-hardening@vger.kernel.org>; Tue, 31 Jan 2023 15:40:12 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id i185so17840862vsc.6
        for <linux-hardening@vger.kernel.org>; Tue, 31 Jan 2023 15:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNWJjiHZ40BzwBFNd25x6TMl8GnedoNNCYGCd1mQAeg=;
        b=Nhou7RN5fM5f5cI/iVGIMo21MZVVTKgkyIJL5ORf8vkscx4DIfYfx71Gf+Fu9zwbhI
         jKvjlDNed0CaPq2PJhGvQzp7IjTBlAqw1vBWFiqixPH1NoHRTldioPZEGhWzJQyaUvOM
         QT5DWZTE7nGsM0k6tTPQ0S8mB289q3k5fM4brPNxyCrIy+Usx+m/cH3bFdWUmlouuURb
         USBnNE8XbO5WB5vrnN97xTXbfmeVijTWmnIxELq/aWzoqP6QZzimfRKRCMNzCw9OrGn4
         vcvlAo/7Stbrg8A9eE6oB56vVwKhqzKfQb/NnSDK0PIwV0M/8hEHOKkxCBnSWmX5ge/t
         7BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNWJjiHZ40BzwBFNd25x6TMl8GnedoNNCYGCd1mQAeg=;
        b=z8C6/8GxuXlxML/LauG1OMwJXRaDANcMu9PIVB0fvkaGIfyEeMkBxcFJmprOvf3fI0
         YUS77Ch4qmlN6/v5d3wecxzfQprFis6QRKfqIW8rOhN87PP+AJ1iuA8vQKufQqtEoOY5
         yxbNYTIxV7EJr9zC8rrBoBwJVz4y6a3vEbJeH9J2pWPWGrwBDkTgRyET3UHRDkS4T6iM
         fS0bHVyqIb5ktlwllc4NArxDNRXYzUb+ueacMTAJbCelgVT9k7iLFq8NzwD0n9JHWaMz
         NSosn7EOV0v8IMJOYyP2M/Qy3UgV9O2ypBePWXKB2r4KWiM9YDD6T30f9VRgza6t5M3w
         3xOw==
X-Gm-Message-State: AO0yUKUG43J4+Sp8/7UJ7nZRCrBKLQyHCRZ0YEVg/hCaZM1rjaZq9ht3
        mouu+8U/mDqJJ733JqZ8gquG4EbgIp08QfnANblOcXXO4ObC9sNT
X-Google-Smtp-Source: AK7set+LGZpVBUq8jBYUp23fV64plVr7SG2DY47NRbmas+5wk9V9BIThjG1yn8uBo52H/ysiEC+SN+XZvlxAE8uICa8=
X-Received: by 2002:a67:e19a:0:b0:3f7:528b:d25f with SMTP id
 e26-20020a67e19a000000b003f7528bd25fmr138820vsl.9.1675208410993; Tue, 31 Jan
 2023 15:40:10 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Feb 2023 05:10:00 +0530
Message-ID: <CA+G9fYsPSJiTXouaMUSeoU3JEwym0baq7OGOAMFNWgrgEWOHfA@mail.gmail.com>
Subject: Re: ACPICA: Replace fake flexible arrays with flexible array members
To:     Kees Cook <keescook@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>, devel@acpica.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, robert.moore@intel.com,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The qemu-i386 boot failed on Linux next- 20230131 started from
next-20230125. Please refer to boot logs [1], [2] & [3].

The bisection pointed to the following commit,
# first bad commit:
  [5f7e8394a70761036e416c7529c937f309e4680f]
  ACPICA: Replace fake flexible arrays with flexible array members

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Reverting the above patch fixes the qemu-i386 boot problem.

[1] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2L4mi3ZZDct0vwmV2tIVY5AtNr0/logs?format=html
[2] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2L4mi3ZZDct0vwmV2tIVY5AtNr0/logs?format=txt
[3] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2L4mi32cqUyZvCIhJlV5nR8CuQk

Bisection log:
http://ix.io/4mIP

--
Linaro LKFT
https://lkft.linaro.org
