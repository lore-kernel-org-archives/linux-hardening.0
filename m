Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B6C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 18:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34EB611C8
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Sep 2021 18:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhIQSmZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240839AbhIQSmY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Sep 2021 14:42:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E1C061766
        for <linux-hardening@vger.kernel.org>; Fri, 17 Sep 2021 11:41:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p29so35825990lfa.11
        for <linux-hardening@vger.kernel.org>; Fri, 17 Sep 2021 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cpak71tpwGIH8sDgLDrdJbMzVDQHoqt6rJZasCMwdzc=;
        b=PPZqYKySWRBXLCmQqLignaVRzeemkJWbOSVm4Nk3LB3/dwYqxZT99gFitFC859Cqmo
         5dHLqIWjBbL09xTf3eNTCSAzEfwW62QnHoObFrYVOWn0PPzzY6lksRvKhahbrO9bPfvT
         /jfwN2l8iu/pKIRl254LqCHUDuwZMUECiAh00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cpak71tpwGIH8sDgLDrdJbMzVDQHoqt6rJZasCMwdzc=;
        b=b5yY/NS7ibxhf/XXMy9kp6Rh/Frs+bj7XzXjz5JSd8aJ6SwfNIAw0jMA2/nZrR5xwW
         7cSs85XL4465Fh79LkKQtv5S0EzBBJgBmPtxQ/0Y5NxQIwI/HUD1aCldaiSPC8xvpJvK
         NX8dKCagVaaLgXdpL2ir9yfHsCKl/dm6chyKyATWtY0iquOkgsp8gH1T7EtqIkANN+Gm
         kLujzWmFbqGKaoOm84Mu+xqjBQw2eO3b/YXFs6WW0bd+jmPLAUkc70MlVAnn6MCKry7Q
         1glkJt50fc3JNSDHbBzjRjmrLxMAeBtm4oTb2uUUmH+xIHMCni6n3Os3CkhoqdtrtULq
         7Mlg==
X-Gm-Message-State: AOAM530FxWqX4bOgxWXGDA4O5PSwtjveeVCYIMKCP6RKJr33fkHmlTbX
        p1rSl6uu/dMqCKvZkoFF+CsPf3MbcoMjM0AU7Cs=
X-Google-Smtp-Source: ABdhPJz0kzkzThsnf5bnxpGzJF2o63UDwJnoweDkTl4B3S1gli2Wufl+ndBoF1XsAUrYx572PlyT9A==
X-Received: by 2002:ac2:4f8f:: with SMTP id z15mr9031912lfs.361.1631904060330;
        Fri, 17 Sep 2021 11:41:00 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id r11sm786050ljk.71.2021.09.17.11.41.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 11:41:00 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id bq5so36824995lfb.9
        for <linux-hardening@vger.kernel.org>; Fri, 17 Sep 2021 11:41:00 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr9099719lfc.402.1631904049054;
 Fri, 17 Sep 2021 11:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-6-brendanhiggins@google.com> <202109170856.8DDB49112D@keescook>
In-Reply-To: <202109170856.8DDB49112D@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 11:40:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whck4RtO7yp-jKK8QQc0bCDZBkdHc=3pGiFsFjwnQ+-mw@mail.gmail.com>
Message-ID: <CAHk-=whck4RtO7yp-jKK8QQc0bCDZBkdHc=3pGiFsFjwnQ+-mw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] mmc: sdhci-of-aspeed: build kunit tests without
 structleak plugin
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 17, 2021 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> This isn't a stand-alone test object, so I'm less excited about
> disabling STRUCTLEAK here.

Yeah, please don't do this for things that aren't pure tests. You're
now disabling security measures (even if I hate the gcc plugins and
hope they will go away).

             Linus
