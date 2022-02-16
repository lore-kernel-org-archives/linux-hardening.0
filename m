Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE983C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 22:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiBPWsC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:48:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiBPWsB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 17:48:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC0135708
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 14:47:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id e5so6571435lfr.9
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eQzUlBBbN3LIoyK9nl/nS8qXfRu/+keDWNHs9SzLBE=;
        b=g9doDMJjI1xslX56Y6WS/yYmKio6ItRFaGZv+X4uBUWvSLqPjRG55zm9KqzcLdvfes
         SD577cJ+p7QmIMM4gFrcL6m26/ljjceK/VP4cJTdtfZJcT6QExtosH38yW2+m+Dryq+R
         p8wBfVVB8tcEQpZoIDeh354XEK2cK8iUxZp/G/hyutnnAReJHFFecYqTCbSEZ2dt0+Q4
         LvLfqQEpypggjDStspmJQCwl44uFgZKwhm97qqiGpLM8KWEx7Bag0B+jl+c6Du5R2dTq
         ayjSLl/X58B7nFoBoZdD1o2rf8B3msWlO2jFe9Iyy+QdFIHX/HRd2M3gCvVW3WKLFLOq
         p/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eQzUlBBbN3LIoyK9nl/nS8qXfRu/+keDWNHs9SzLBE=;
        b=EziJMgmf+DuRB2uTelcJQuR2ndFTeiKgDceuJcBXiLyTiPMYpYqijxibNyZt2PX3JR
         jaxNZaHLKEOiJazpxeE5hQVQOZPGUd/4E3QP6jmED40FwE48VKHkm/2axAvC6EWEPffG
         9+ddxrJ49AaTt2Pc5PpZrGb6IlYPXMOCPb6Fx0yGTUl68ShNORIDlSayM7mzZsKMkLMG
         YAPabzAJmGI+nPDKnP/TdwB883m4BivBC6B7XafXSEkYORuYqggmnSUauxk7YRaufIwG
         qcm+hWDjSwAKQIQyubUMRj+ATfxXvB8qYZqAnlJ2cwS3JbXhLmdIjQvBFXyN2CfICbg3
         0OZw==
X-Gm-Message-State: AOAM532LOswNTcatQt+sqbvXkdMgpjmwab6f5chMQRsmFDCxI2MZqKua
        zrcg9BXufgrYFuiiwoCHURjxH2r616dZI9xK9yfsTg==
X-Google-Smtp-Source: ABdhPJwXgiCBqMwy6i/HD2uHx0cjX4YslKBZy0bAbLJHM2GmXJ3FdSpGpa8ZrEEvi/P1eI0Z6oalbN9Q6+Mn3ao5sGc=
X-Received: by 2002:a05:6512:208d:b0:443:1833:7473 with SMTP id
 t13-20020a056512208d00b0044318337473mr133778lfr.651.1645051666773; Wed, 16
 Feb 2022 14:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20220216224153.2242451-1-keescook@chromium.org>
In-Reply-To: <20220216224153.2242451-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Feb 2022 14:47:35 -0800
Message-ID: <CAKwvOdm62iA1dNiC6Q11UJ-MnTqtc4kXkm-ubPaFMK824_k0nw@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 2:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> Convert overflow unit tests to KUnit, for better integration into the
> kernel self test framework. Includes a rename of test_overflow.c to
> overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
>
> Cc: David Gow <davidgow@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Assuming no one objects, I'll carry this in my for-next/overflow tree. :)

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
