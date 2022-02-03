Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F95C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 22:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355643AbiBCWMC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiBCWMB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 17:12:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3FC061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 14:12:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c7so5889191ljr.13
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvLgSYVGM2996ioEI15ojDQMy+E3HZDVmRKeEYykM40=;
        b=d+00TCXqREwctnhJC2Vz3mHrLurwPMNF8rFaK2ZoUN9UE7RX2igGNvTuW8fgOLewhw
         OOgkfYYCVz4oDaNHM7Ixgb6VHD9qnBfO13Wl3Wq5NapplduLQjYFtBNk1fmjfCBWq00j
         r0vW0gVU8HhLUMGSTdHdrw0WuaBYpz/ZIwSXX7XZ04wGfllcNcJXtLPQYA6/nEWvHccZ
         B0v9/KUCpixTg0BQmk66EiQpUjLMNiscv7khu0X/VkvagSLHNUW1YP6kkSsgKVJORwhW
         F97K+SZup9eAr0XfOrLzhg1tayDXjlpdwrqOic13Od4CADVoDAU/zrEGPWHc0pEmq4wR
         B6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvLgSYVGM2996ioEI15ojDQMy+E3HZDVmRKeEYykM40=;
        b=NZJR4kWFms15+atY2l3LfnxqmY7G8Un2eKh1roVafngqHeybKYi3A5qjFPaqapAP4H
         UGcYPSGH0+C4ARgclg85xqBe+5r9G/oZb6r3AERDla+O/tZOx/Z7k10JGZaa8EhVdfrP
         Oq/Cs6fEyyHObX0bG+dclaUV4uBLD15K9i/jcsMGXJsYTN060Fxoy2MzyCKm3WsOz2Pw
         fy7fq4y2MmjpBLeO8jnCZibTw2vQ6z0CgisqPF+GVZHdWBlkP01KVfJcaqCpATiq7irS
         1n5AQ42L2s1aSUP87CkLaYOxKxEzeyvlaDg4sRIm6o1s3+/JzJUf42u7GR1UPdqwiYiL
         OXyQ==
X-Gm-Message-State: AOAM531NE0+muXc1p9TZQGYws5t1Nu0aD9b3f9ya72L0Z6DFyg2UD++8
        25u115NXrOtaSL2XDhQKe+STHntNVzSO5dwc7mbY7w==
X-Google-Smtp-Source: ABdhPJx4xwSIhl1CWKMd+BeSstYj6x7/c4rQegMzqm29e91gX4A7J7U22wJThBU+MEd0EovNCPT+zJO+7qLu7pGf59A=
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr34894ljc.526.1643926319521;
 Thu, 03 Feb 2022 14:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org> <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
 <202202031301.437D8FD3@keescook>
In-Reply-To: <202202031301.437D8FD3@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 14:11:48 -0800
Message-ID: <CAKwvOdm-_uGYrm=2LTGSR7yhGK08NniGdkhLj_sM-QD-xdKVtA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 1:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 03, 2022 at 12:26:15PM -0800, Nick Desaulniers wrote:
> > On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > must be marked as being overloadable (i.e. different prototypes).
> > > This allows the __pass_object_size versions to take precedence.
> >
> > Is this because of the `const` additions to the function signatures?
>
> That might be an issue, but the *real* issue is the implicit mutation of
> the function into an inline with _additional_ arguments. i.e.
>
> char *strcpy(char * POS p, const char * POS q)
>
> is really
>
> char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)
>
> (i.e. what I was doing with macros, but all internally and still an
> extern inline)

What do you mean "is really"? 4/4 doesn't change the number of
parameters in strcpy explicitly in the definition AFAICT.
-- 
Thanks,
~Nick Desaulniers
