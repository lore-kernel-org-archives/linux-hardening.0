Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E41ECAAD5
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Sep 2022 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiIBPuT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiIBPty (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Sep 2022 11:49:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6F5280A
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 08:40:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so3237613edc.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZZViECBQIPeE26/U6PwpBaWGPbv4WEHDCGVI4qLmJb4=;
        b=Hng+Qdrwf6aoRL5qjOrDdX9dneBrnXK9dEZGpGEBFIBlyH39qCfY8ZchTBiQ96Q0QZ
         mo1ow8E2D91zJz9YHExUeoBbqrfgZfUkW/zpThocnMs6/uZURRu3lnitylvOlee0a2YS
         lKyPusHcdynwJfmX3iErtGSVR6WZ0pz0wERuQ+gOVoitU+TXKIMwyvIXxJ6kk3/xB1YN
         jVYY2LL5WiN4duAlJTouZHUSOGLWZAnS3r024F5fHcDu6W/sH2j8IaYiIBvia+Jl5ABU
         AzAcOSRqtsQoQZ3ygVlgucKeGyZsGK/jQqOSKFjZ+4s4BXtjIAoDokHMGxn5B73siZhJ
         rs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZZViECBQIPeE26/U6PwpBaWGPbv4WEHDCGVI4qLmJb4=;
        b=kexyHYNPlzdZCxNKEItHmT6pnkhXEFg8FlUumglpf5pfIVCYZTOg4WnEsPPIAklDje
         Lgu3lnxcODEOA8pWw3+C0XA3cGvezHxaahleuBme1Rjb0eVknPjmAU5tha4Ogf9qUwy1
         9qXECzxecA5bvYtiSTTdYyL+j/fijX6DnHHl1qpkKdM8p4mFd3W8wwr8GUhJM5ymkI3J
         Nn3WcL1h01uRgfuBwESxN9MM0zwtdGZhRaV3p0WMeerubAYsFZlG24oH125ZYXit/umP
         TfZeq6V5HIVvDsGZkTFnREvJjA3nhd6mazjls58cTlOCOIpfmm3tAmOaD0EZoP0cGYg9
         s9rw==
X-Gm-Message-State: ACgBeo0pwk5BtMgTlxgy2boOy+ZZePo6q2R18Y22NWas6zDS8Se9nSVw
        OhKTDUeC5ZL7aWKBn2JAWKOatm8i9dWkW/HbadGiJw==
X-Google-Smtp-Source: AA6agR4xxlZQqkE3iOmxpnuJDnHFAJqpyc3JD/HdUdWEisfmE3Z6rtHXdERjcLrMLI5v9gj6USv11x2Cp3VoRzACFOg=
X-Received: by 2002:a05:6402:3227:b0:448:706c:185d with SMTP id
 g39-20020a056402322700b00448706c185dmr20812932eda.357.1662133205628; Fri, 02
 Sep 2022 08:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
 <YxEh+pLyOyPalW1u@dev-arch.thelio-3990X> <CABCJKucP5nXGiCTTCEPUGYo5Z9A9qaQkJ6_kXTOfw-o-=TYH0g@mail.gmail.com>
 <YxG2DUEBnIpAMKF2@hirez.programming.kicks-ass.net>
In-Reply-To: <YxG2DUEBnIpAMKF2@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 2 Sep 2022 08:39:29 -0700
Message-ID: <CABCJKudRywi7FgNOb8V7vmS39k59fbO1D3dwfmMZmBpApRX5eQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 2, 2022 at 12:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 01, 2022 at 05:33:29PM -0700, Sami Tolvanen wrote:
>
> > > I do see a few new objtool warnings as well:
> > >
> > > vmlinux.o: warning: objtool: apply_relocate_add+0x34: relocation to !ENDBR: memcpy+0x0
> > > vmlinux.o: warning: objtool: ___ksymtab+__memcpy+0x0: data relocation to !ENDBR: memcpy+0x0
> > > vmlinux.o: warning: objtool: ___ksymtab+memcpy+0x0: data relocation to !ENDBR: memcpy+0x0
> >
> > That's interesting. I can only reproduce this warning with
> > allmodconfig+LTO, even though the relocation exists in all builds (the
> > code makes an indirect call to memcpy) and memcpy (aliased to
> > __memcpy) doesn't start with endbr. I'll have to take a closer look at
> > why this warning only appears with LTO.
>
> From just looking at the patches I'd say patch #19 breaks it. IIRC you
> forgot to make the SYM_TYPED_FUNC things emit ENDBR.
>
> Look at how x86/asm/linkage.h is overriding SYM_FUNC_START*().

Yes, that's the reason, I'll fix this next week. I was mostly
wondering why I'm not getting this warning with my other test configs,
but it looks like IBT isn't enabled by default.

Sami
