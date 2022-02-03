Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52FC433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355624AbiBCWBU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiBCWBU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 17:01:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C283CC06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 14:01:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j14so5929724lja.3
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cOwd+xKfDb+D7R22x2j6Xg0Pm7V5Bcnv8frM7DHB9xc=;
        b=qKsj1zmJmC2rY8CmZCR0DCeZljuwB+1GIt7MSX+2QKBdlC2+BViC4sUv1bjz5ARufw
         hJgAlA/W4VOwD6dAz3cHxdqo7tBWIYVnoir/9uEY224JYvoyNYLfxkYCx8LyzlfWz0lA
         bj31FK2mXLBjF7KKOSt5d8+XdN4eQ6vQwe8cbZUvYeASzTIjousJwPMWo1ceQWFEifz0
         sVSNqXr9PtiOpb8QJ9UpuG+xpjgzreUqj3WoFo37jx3fu+SR9LUVMg08PpgM6nJ3Rahb
         13vOkA6Tt+t2kuHqc82flfDTgP2Au9cVCbB4Fx8fzUAbzP562SCKrRoGzHhqkIp3zKbs
         tlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cOwd+xKfDb+D7R22x2j6Xg0Pm7V5Bcnv8frM7DHB9xc=;
        b=ejWl5JnfuC/bRGGPPIOyRg6PpMsdzlPvHDdMIto2ZMk9hN0eSH/L/vL7KaKCx/mpoI
         NvcgDmGg4VjYqHVp3ZBM3nVlPjN+LzMOcCI7rmBnUBET5wfl6oCzHnUDSGlmV371HyEo
         yrzpUpDKb7Fj4oXqsfdL7197oO3iZjkzQ9c6c9VQ6io7E1Z/2gtP5V2gfQXJWXRr8moy
         dekR/9K+sZy4cisGKj96x1MRyl4lRrbGNyVxtq1lejtqeyFlLQWnprfgf+sye5NztkgZ
         d5EGJQt6JXMRaGXzXLmCGneHLnbvkkp8ZcUKgxHCMozlSONJkcLLfBGRdWO1aOn2C6RV
         9ddg==
X-Gm-Message-State: AOAM5308ERDLEYeJE/QWD/UoTqAlfC8vR419w+nrvkP2BOzSIJW4u+Ml
        pE3Mo1EnlzeCsK1oYomx+us+I4yMKvd1D6Gl/4uN+w==
X-Google-Smtp-Source: ABdhPJzYUKomEFSrUBdXf5Ui2PKnaYfgpYNBueMKfPHNY8RPYyDrGoF0s3abGsoFXIZCiigrqziNFDooOPrV64adGU0=
X-Received: by 2002:a05:651c:3c7:: with SMTP id f7mr27644ljp.62.1643925677879;
 Thu, 03 Feb 2022 14:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-2-keescook@chromium.org> <CAKwvOdmzdQ+X2BsUbuVBWzFtaE2Vst4=ihNNR=LmOdozqQ5Ukg@mail.gmail.com>
 <202202031247.4F3AC598@keescook>
In-Reply-To: <202202031247.4F3AC598@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 14:01:06 -0800
Message-ID: <CAKwvOdnUHFi=1+9VxsfwxNAkTFEytg5FV=Aii7awSx+ioRaQbQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] Compiler Attributes: Add __pass_object_size for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     George Burgess IV <gbiv@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 12:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 03, 2022 at 12:18:24PM -0800, Nick Desaulniers wrote:
> > On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > In order to gain greater visibility to type information when using
> > > __builtin_object_size(), Clang has a function attribute "pass_object_=
size"
> > > that will make size information available for marked arguments in
> > > a function by way of implicit additional function arguments that are
> > > then wired up the __builtin_object_size().
> > >
> > > This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
> > > to Clang's __builtin_object_size() having limited visibility[1] into =
types
> > > across function calls (even inlines).
> > >
> > > Since any usage must also be const, include it in the macro.
> >
> > I think it might be helpful to quote the docs
> > (https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-p=
ass-dynamic-object-size)
> >
> > >> Additionally, any parameter that pass_object_size is applied to must=
 be marked const at its function=E2=80=99s definition.
> >
> > One thing that's concerning to me is though:
> >
> > >> It is an error to take the address of a function with pass_object_si=
ze on any of its parameters.
> >
> > Surely the kernel has indirect calls to some of these functions
> > somewhere? Is that just an issue for C++ name-mangling perhaps?
>
> AFAIU, this shouldn't be a problem for any of these. Nothing is trying
> to take memcpy, memset, etc by address. The macro-ified version of this
> change proved that out. :)

I thought Sami had found a location where memcpy was invoked
indirectly as part of his kcfi work? Maybe I'm misremembering.

https://github.com/samitolvanen/linux/commit/46a777fb35784a8c6daf13d67de8bf=
b5148adc2a#diff-a27660992abdf360d01deac6364db31836d0d98b5d9573b7fc10a6785a6=
69975R16
--=20
Thanks,
~Nick Desaulniers
