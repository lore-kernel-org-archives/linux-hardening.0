Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA5AC0018C
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Dec 2020 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7481D207BD
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Dec 2020 17:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLCRiI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgLCRiI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Dec 2020 12:38:08 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B3C061A51
        for <linux-hardening@vger.kernel.org>; Thu,  3 Dec 2020 09:37:21 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s27so3926541lfp.5
        for <linux-hardening@vger.kernel.org>; Thu, 03 Dec 2020 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAYzt5aWmV7k8rYu1oRqo0Iimqerq25dwLnLWK087IQ=;
        b=g0RuxTC/9WXibSwY5+tIOu4MFx49cSGSc9R6BBeB0r2N/EwzO3l5hiz5zRhoRxTjkr
         /6iZvATcu++ZOkyFOL9z5bNa8MptTxwO92Sq8SlrhC4i9hnYgcuER2QESiIS5hyddN64
         7B+S6BMI/TOidGb4AUDbKQSxvIkDJJJ/NGFPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAYzt5aWmV7k8rYu1oRqo0Iimqerq25dwLnLWK087IQ=;
        b=kJ2rk1HtgqKFGNf8cEyXG+Xq32FlJTPBCIqp8AhWFmrJrsmXuGzGPHhm1UDhgADuPx
         5pnVLRL5KTFJQHbrpNRCUWsMBGMWfx2+L5HaxbGjdovbZQGztcmaWHfKsU+WhM3SYMC1
         9BwJaf6lF3ZipEDSfIHrTszbHzlKuhZuz4S9SbSUy0VF8YpqAU9R/Dz+yscJW8oljMfn
         vSJye36mfsyHDgtJvaq4KO+N0/N/qvvy+YF0GVkOruS6XitDf6AyWTTWeeTFcce11XX6
         ryCcjoh9lCAKvJrcbWG0vsh+iLPdfDG3FQ8n0JbWfUsEnu76bKR7hv5BfyqHl0Xu2VMP
         +XLw==
X-Gm-Message-State: AOAM533pWAsXTXXGzlARd8uEGRiwkyiBq8BSTh6cxkiuhhVXo7vzHKC5
        Gqil4rCkuZLEwkRfB5hvx05uE/YgNAc6eg==
X-Google-Smtp-Source: ABdhPJzA4Oh+kNL3aDutV4YApopG9ounKhGijhEsHrmmpLScVl1Hwl1oBvMtSjGqibiR8RzWai4K2A==
X-Received: by 2002:a19:4a41:: with SMTP id x62mr1920057lfa.398.1607017039696;
        Thu, 03 Dec 2020 09:37:19 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 131sm743567lfb.248.2020.12.03.09.37.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:37:18 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z1so3459969ljn.4
        for <linux-hardening@vger.kernel.org>; Thu, 03 Dec 2020 09:37:18 -0800 (PST)
X-Received: by 2002:a2e:a543:: with SMTP id e3mr1691756ljn.421.1607017037787;
 Thu, 03 Dec 2020 09:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20201203125700.161354-1-masahiroy@kernel.org>
In-Reply-To: <20201203125700.161354-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 09:37:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRV9VHO2RVwn+iMfH_WFjQV1dsZtEQhgrUBQfM9QBPmQ@mail.gmail.com>
Message-ID: <CAHk-=wgRV9VHO2RVwn+iMfH_WFjQV1dsZtEQhgrUBQfM9QBPmQ@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: simplify GCC plugin-dev capability test
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 3, 2020 at 5:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Checking the existence of plugin-version.h is still needed to ensure
> the plugin-dev package is installed. The test code is now small enough
> to be embedded in scripts/gcc-plugins/Kconfig.

Ack. I think the "plugin" directory name should be quoted, but that's
a pre-existing bug.

          Linus
