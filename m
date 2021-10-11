Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B348AC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9833760E78
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhJKR0M (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhJKR0M (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Oct 2021 13:26:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6EC061745
        for <linux-hardening@vger.kernel.org>; Mon, 11 Oct 2021 10:24:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so76343116lfd.12
        for <linux-hardening@vger.kernel.org>; Mon, 11 Oct 2021 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nu4G/4LFT2B+dN7Ud24heVwfxO4x4OPVUBz/3Y6zfcc=;
        b=EUjn8oMwIJr6hI/Bj9RHyQtE8rNarSGeAJzHLDRlf0gs56UilEaSyWlLkJkqtHPbXs
         ZEODFTtC/dQJ5P8HlTZ1hq6XDtsIsYJirGNPl2h8K1eNe9bIivfDbjjYmAfIe3Q5fZAU
         O6taffpbbG7GOh8ZSbzYa1GAvKvy+aZgoj7QJkSX0v56ptHUMjXpUKrA9FXnQpjapUyb
         6ehm8hxJJwznPBHD7rrBhXrHkHfIE+hzuNQ5rZAlJtPEbnFA/y3jGQ1YwicY40J/NweQ
         YXADeHg47bCpGEvT/Ug3U/QSUMUuwIBm/d6R+zxmKWJse000kTWSS4znRTrxelOAg85V
         fC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu4G/4LFT2B+dN7Ud24heVwfxO4x4OPVUBz/3Y6zfcc=;
        b=B4X3jsO2qV+WOakKDnAq7snGVo5f9+v2ux2qWlK/F59kvR3hz46XxX3OGLaC9vPq4j
         kjvJQUqAtBftxYYyhepIrpztPaxndR8WGBy2ovS7+En2vePlfozXrI8OE4nH8alduEiJ
         G5ouoy5MPY1nyt/uFXvF2lQiOyq2axk3DuwQVKKeXIlDQ5M8M61A1BLQknxpPHAleIOk
         /nqwfRIxXg600T3KJNESdYxrmOliEt0fc+a6YRO4qa+/EawmjqtN9Us0yJPg1K7QdDTY
         ZJj0saw+L6bcLc8FS+WKPMtKHtMOdT5GvBI9ZQpvoZSFhsK21CQ48Tt3Nc9dd95KFzwC
         FFmA==
X-Gm-Message-State: AOAM531JY6g2+YFqXMqgSZuwmqdpa1rx7eiGfEtxbW7P3Zjlph1xxjt8
        qnHCaWcdFrAcodjDtQGnSMN7rI2KL458OmBUoJTwkQ==
X-Google-Smtp-Source: ABdhPJx8Wmu1eFUyMMOc2Y6/MLpi/jVTxrWxVNHptlry0/segS30TKqsljF5elMMFSgFv2p74FpCXhrQjYRj5WhX7lE=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr29139566lfu.444.1633973049612;
 Mon, 11 Oct 2021 10:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <1633878992-32884-1-git-send-email-ashimida@linux.alibaba.com>
 <CANiq72nBqiyrcaW47ZW-6i7zJ6HrmjZWSOr==HkEuBR5rXmpdQ@mail.gmail.com> <a25b9286-fc1f-d398-150c-ce073eadc6c1@linux.alibaba.com>
In-Reply-To: <a25b9286-fc1f-d398-150c-ce073eadc6c1@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Oct 2021 10:23:57 -0700
Message-ID: <CAKwvOd=D=UvGfHjEyeYPk3c=ksg9mF8nUX-9jyJhkX8QbugMSQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH V2]ARM64: SCS: Add gcc plugin to support Shadow
 Call Stack
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>, frederic@kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, yifeifz2@illinois.edu,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, andreyknvl@gmail.com,
        Colin King <colin.king@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 11, 2021 at 8:42 AM Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 10/10/21 11:43 PM, Miguel Ojeda wrote:
> > On Sun, Oct 10, 2021 at 5:16 PM Dan Li <ashimida@linux.alibaba.com> wrote:
> >>
> >> -         This option enables Clang's Shadow Call Stack, which uses a
> >> -         shadow stack to protect function return addresses from being
> >> -         overwritten by an attacker. More information can be found in
> >> -         Clang's documentation:
> >> +         This option enables Clang/GCC plugin's Shadow Call Stack, which
> >> +         uses a shadow stack to protect function return addresses from
> >> +         being overwritten by an attacker. More information can be found
> >> +         in Clang's documentation:
> >
> > Perhaps it could be worded in a better way? It sounds like it is a
> > custom plugin for Clang as well, e.g.:
> >
> >      This option enables Shadow Call Stack (in the case of GCC, as a plugin),
> >
> > Cheers,
> > Miguel
> >
>
> Thanks Miguel.
>
> How about writing like this:
> This option enables Shadow Call Stack (supported as a compiler option in
> the case of clang, supported as a plugin in the case of gcc), which uses
> a shadow stack to ...

That sounds reasonable.

One question I have Dan, what is your sense for getting this feature
landed upstream in GCC proper?  It's neat to be able to use plugins to
support older versions of a compiler than when the feature initially
lands; I was curious if you're working to submit this into GCC as
well?  I didn't see anything in GCC's bug tracker for "shadow call
stack," but maybe there's a different feature bug tracking this?
-- 
Thanks,
~Nick Desaulniers
