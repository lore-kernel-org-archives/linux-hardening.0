Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D8C432BE
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBB260E77
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhHYVSS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYVSS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 17:18:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C9C061757
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:17:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so1745290lfg.9
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAlJBNQn16JjUkHYdCuHXibhY5cJqMeU9e15H1wH+kQ=;
        b=Twvb5JwGXq7g8xGxqMloGmKOTKjL4Cpr7Hrkzmdj1rM9cAtIDoJQlHk/FubuEVlXUS
         3YA89nJqolCmBl0X+218EiNXgod3K2tHKBNueNTJp2dhWHaoQEjCYliDGM3Jp+P8jrp1
         U6incOxlb5XMQ5WLp+xztlf+F7edMQ0aSrHv9TPi+Ll75CedhDDQBSBjY3vID9LJG8lU
         IceClHUlaGxSZPYAuCqKx7xqyW9uslzP4Lp0rDx9Yl7618mw5Og/JVlsPgflydKIzjRW
         nTv08AP6n7WDSJXmhx0111VHP64plhof0Gy4X0XfGmjg63JF8AVQ1FVrFBTQ5ppldxFD
         DVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAlJBNQn16JjUkHYdCuHXibhY5cJqMeU9e15H1wH+kQ=;
        b=Cnx1a2kAkCZgIps3nCmB/HKvLBECRV+Z3GmUpPWtMIDE1nfu9D4SJvRHHoi0lBKu2a
         TWBdxQ/k6ONZGw9rvakfrc3Yw7HhpMdl7338/Y24Da+RyXcE9XK/rJYHoyciQRJTwK7T
         loKfQGynYP4/Pytfogrs6dyXj8f7HydPFD00RK+Gy9pmt3JhLscXf1CSJyGhtv73P2R3
         q9aZRtQWvkQZ5zm0dLdpsCaaJ5PWVG9DhNB546aXydk5P/dlEVIykqtppTAfqP8wNtYp
         BmnuEPz/1emPM8Alo7++OhgPfHsTbRgQL5XZ0d6c0gIE2lftFggl9iWhkt+W/nG6B+3H
         /1Yg==
X-Gm-Message-State: AOAM530XWESyV5P/u/7BoxcL2ueYtOh0lLCkbLuSToeNcwkple9XK/bs
        OcVtAd/8H7VBsl6t8ThXumYHp9kCxsaVDpaugq/ny5R4bmGdbA==
X-Google-Smtp-Source: ABdhPJwfpYIvlODDHiRHyf2+aTCddGrNRBCe0ubiEEwEmq1swxye6qx60WEAreo9vIgjPwwCEf++BetmgbXXELUhpN8=
X-Received: by 2002:a19:5f04:: with SMTP id t4mr88603lfb.297.1629926250176;
 Wed, 25 Aug 2021 14:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210818081118.1667663-1-keescook@chromium.org> <20210818081118.1667663-6-keescook@chromium.org>
In-Reply-To: <20210818081118.1667663-6-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:17:18 -0700
Message-ID: <CAKwvOd=bcs5W6eEDXGn5ROR2EuMiSp_2e6sLFxak=KK6yLWcvA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Makefile: Enable -Wzero-length-bounds
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 1:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> With all known internal zero-length accesses fixed, it is possible to
> enable -Wzero-length-bounds globally. Since this is included by default
> in -Warray-bounds, we just need to stop disabling it.
>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index af22b83cede7..3b6fb740584e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1071,7 +1071,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
>
>  # We'll want to enable this eventually, but it's not going away for 5.7 at least
> -KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
>
>  # Another good warning that we'll want to enable eventually
> --

-- 
Thanks,
~Nick Desaulniers
