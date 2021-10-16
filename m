Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EF5C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 16 Oct 2021 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA4D600CC
	for <linux-hardening@archiver.kernel.org>; Sat, 16 Oct 2021 21:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbhJPVOQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 16 Oct 2021 17:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244652AbhJPVOP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 16 Oct 2021 17:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634418726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjDNk6B/N6Q1irkDiWN3RyxwNrYWGdj8hgHHx1uvt14=;
        b=BuXiPspPwsAMdcZs2o7EHp8y5M1CGBolb0e+l8k7e3E/MJBgR7wBur5BIf3ddENmynWv0P
        LyagOhsnQuB2aUOvFXGQmLcOj19w37FWKcpSwkmwBTnU7VXrjhPqwJAek18DVX8p7188P1
        X0bWTPglFbDDWUG30Pem6g1b1cNjgtw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-4co_7VfnPN-bnJlV2c4mDA-1; Sat, 16 Oct 2021 17:12:05 -0400
X-MC-Unique: 4co_7VfnPN-bnJlV2c4mDA-1
Received: by mail-qv1-f72.google.com with SMTP id gi5-20020a056214248500b00382f7a7c7e6so11143485qvb.21
        for <linux-hardening@vger.kernel.org>; Sat, 16 Oct 2021 14:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NjDNk6B/N6Q1irkDiWN3RyxwNrYWGdj8hgHHx1uvt14=;
        b=NHpTMXRdFw8P04GCOU7BlqA5oOmpK9CXG5OW0iQwfD/N7+qS9O30bwhMxgw0m8QmX8
         qh/Xq59G6v0tX4g8wNfdTdUl3ACBaQqwiQiITHm//ZL2h+N4IDb5sEAzPprTzw6HLvs8
         bEAqsAlTEbNRWzGdDMPtEPxVaM458Ook3voE8JhOem9RW+TcxLH4Jj0JUKIjk7NXA6AX
         arUZTs8P53GELlBCV/uORuM3OUf6HchD2htNl7F3sDYeXvNjm4ZAI/br/qB1wcLjb+iF
         +HEZl7TiCHmApz9ggZyNBRZJsge028JSw20A7LTgQ9zJd8jikir2lCNxxRQtFsnBl6nD
         t1Hg==
X-Gm-Message-State: AOAM531hzFUeqVnGbQrJ2bbLq8c+BISHCGlzsMybneinc5SPPRY7LXyi
        0KsnDKMCKy6TKh+BPwISS3dAWxU/for2WTKp48Pt8OFnFLUTlWCHRlAokzjgfifCxfZuXmfjnFZ
        cO7V8oDOfAEG+KNKPqfJfbUlIQeZU
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr22223718qtc.266.1634418724704;
        Sat, 16 Oct 2021 14:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVGk5UnzfsoIArgonptC4VlypIIv1AYjcxHn9hf+CT+hjv4CCjkR/qLas5v6PvM1LoiiypmQ==
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr22223703qtc.266.1634418724447;
        Sat, 16 Oct 2021 14:12:04 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z186sm4435014qke.59.2021.10.16.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 14:12:03 -0700 (PDT)
Date:   Sat, 16 Oct 2021 14:12:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
Message-ID: <20211016211200.umf7okyvtet5ayrd@treble>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx>
 <87zgra41dh.ffs@tglx>
 <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
 <ecbe49c8-b30b-456c-931a-cc65647b0958@www.fastmail.com>
 <CABCJKucuun-n8w3=U6i43kVGkCgYL7kmz5wx8nYxsxUOCfzBFw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABCJKucuun-n8w3=U6i43kVGkCgYL7kmz5wx8nYxsxUOCfzBFw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 15, 2021 at 01:37:02PM -0700, Sami Tolvanen wrote:
> > But we *also* have the read-the-address thing:
> >
> > void something(void)
> > {
> >   /* actual C body */
> > }
> > alternative_call(something, someotherthing, ...);
> >
> > That wants to expand to assembly code that does:
> >
> > CALL [target]
> >
> > where [target] is the actual first instruction of real code and not
> > a CFI prologue.
> 
> Yes, here we would ideally want to avoid the CFI stub for better
> performance, but nothing actually breaks even if we don't.

That's because there's no CFI involved in alternative_call().  It
doesn't use function pointers.  It uses direct calls.

So all the discussion about clear_page_*() is completely irrelevant.  It
has nothing to do with CFI.

Same for copy_user_enhanced_fast_string() and friends.

> > And this all wants to work both for asm-defined functions and
> > C-defined functions.  This really is orthogonal to the
> > is-it-asm-or-is-it-C things.  All four combinations are possible.
> >
> > Does this make any sense?

Not really, I think Sami debunked most of your theories :-)

I think you're misunderstanding how Clang CFI works.  It doesn't
instrument the target function.  It hooks into the caller's function
pointer relocation, so when I try to call func_ptr(), the compiler
hijacks the function pointer and forces me to call into a
func_ptr.cfi_jt() checking function instead.

> > I kind of thing we want the attributes and the builtin, along the lines of:
> >
> > asm("call %m", function_nocfi_address(something));
> >
> > or however else we wire it up.
> >
> > (And, of course, the things that aren't C functions at all, like
> > exception entries, should be opaque.)
> 
> I agree, there are cases where having a function attribute and/or a
> built-in to stop the compiler from interfering would be useful. I'll
> dust off my patch series and see how the LLVM folks feel about it.

With all the talk about function attributes I still haven't heard a
clear and specific case where one is needed.

If you take out the things that don't actually need the
DEFINE_NOT_CALLED_FROM_C() annotation then all you have left is the need
for opaque structs as far as I can tell.

-- 
Josh

