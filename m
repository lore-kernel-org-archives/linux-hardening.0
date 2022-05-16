Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BB3C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 22:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349541AbiEPWDl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiEPWDk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 18:03:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB82A25B
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 15:03:38 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f16645872fso168548587b3.4
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjaOHrJPxQNUMk++gKnFcKFfTSw8FlwW+UyobtzjVj0=;
        b=CmIEj5n1Rl0HWNhLuhDFskWScqMt8sTZf+nhjXYfnm9nlgr/YXq9h82Fae9Y2KTq1g
         KryZOd70RTA6tPdFd6uEglWV6hKFFIZmg7ZFv30zU1JzLwvckRRLR0MEMdF00hjHIHDf
         hVEuQ8BqEIRE3mG//CqcrOWdJM1NQz8jL2LfiBTS0Uvbwue/yEjA0leJcwc3aoJbKFUo
         HsYsHIyfIVblYlpHWWLtcT5unFYiki04NZBQO/jfec+mhGllAxhTLo9QATAqOOLauq7u
         ckKDPDyG+lHdQjd1OuL/8h39HKfWcmiAhNYRkNnJwcWE1smI+GnPF/PAEkdRN2Dzzitq
         q0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjaOHrJPxQNUMk++gKnFcKFfTSw8FlwW+UyobtzjVj0=;
        b=BuWGphXpSMWcUOtvq/VNSZfEIa1g6UDAqFMY82SnTDC7lJoIz130Gm/0Rr1u0aCoMs
         feWLGVmvg9FyIFTCmb1FUonLSIZPhoI0nHErMiJq9lhqwIa2P0AtDMFY4qBwt32wPjrG
         ZSdjvoUgxCpfb64ba1pxWdFdOVIcdiycV/SHnDhGWAeYl7fC6JLRb/VLRCnLo2H9ygSV
         4gW7DEq+HegFgVt1StTKUhKFwWXJykp35boekS3akboLei5HYTfLEwG7vdMbOUQekPgg
         iTR8Md8ph9nbUv5IQbNWmjhqiKU9kBgEC4qsPQRSWF2kAtxxgdYFmTP1p4pyUbylUyed
         t55Q==
X-Gm-Message-State: AOAM532CDp3UyXp+nsudU46L2CqcCMQKECKVEXd0pqZVxCTvccRfnzGZ
        x7mSLGqEAp116uNgHr8MnT0Gun4xapr34p0w6RcTnQ==
X-Google-Smtp-Source: ABdhPJw3sBkLaeksICo+46rO2UaS3Fk7vsTQRrcZQqDXNASr5C339hIh2SUj2o4+spHZoBL4AtjH3f55xJ+hksTEK84=
X-Received: by 2002:a0d:d747:0:b0:2ff:22b9:9281 with SMTP id
 z68-20020a0dd747000000b002ff22b99281mr1573852ywd.305.1652738618031; Mon, 16
 May 2022 15:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com> <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
 <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
 <19b3e040302d4d8aa240eee43427dfaa@AcuMS.aculab.com> <20220516214414.GR76023@worktop.programming.kicks-ass.net>
In-Reply-To: <20220516214414.GR76023@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 15:03:02 -0700
Message-ID: <CABCJKucPMgMQ-D_yByvMSx6yutjsBXGAwirmheOYejWHARi9iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 2:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 16, 2022 at 09:32:55PM +0000, David Laight wrote:
>
> > > The compiler always generates this specific instruction sequence.
> >
> > Yes, but there are several ways to encode 'cmpl imm,-6(reg)'.
>
> Yes, but we don't care. This *always* uses the 32bit immediate form.
> Even if the immediate is small.

Yes, that part is not a problem, but it's a valid point that LLVM
might not always use r8-r15 here, so I will have to check for the REX
prefix before blindly attempting to decode the instruction.

Sami
