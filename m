Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E43C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63ED9610F7
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhDPWGz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235258AbhDPWGz (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 18:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DCCF6115B
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618610790;
        bh=4Xl0tR28PauSIlcb3tBpyyEncZpSiEx2m3KQJDq5wWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y3R2rSFSUVZv99sZNOekR5WG9rg1NBv+7D3lqRSmSQLegp1N73pGA3rjjL+aMihDa
         +U9l6yWgBaWUjVT3OJy1Y+iofHd7i2Q0/ll0BVm0MccS1FE+Nknqs5c+hgjlvaaArL
         sjb+ZvfV8As2EmApjbI2hew3OkzRmKcrU3YS2mABR+EYPg4Q3yqL6cLnG1QQ06oSZU
         JfvqIouVR9zCa8lsM+5gu4VFAYH17k2RjBUUop+M7u3y7PFPf6Lt1pP36qyfLidiDy
         wrpGTLiHW9zXwckkTXILQjSspxTAxMOvLBM4+bkK8I5P+34lo3DxLfTfn8GmzX+Vy2
         2jqN2u/39S1Ag==
Received: by mail-ej1-f41.google.com with SMTP id u21so44205611ejo.13
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 15:06:30 -0700 (PDT)
X-Gm-Message-State: AOAM531zR4bpacBIBnFfRFK8wLJxBWCAXb5AZOUlHzle8CARYcw88zwe
        tTm35cILfy4yNhs2tRHPEXO+ntDxc9zWQOcj9KFG5w==
X-Google-Smtp-Source: ABdhPJwTkOpDm/66xnifL1NOzABLFP12oHwsSfQjdb94ivueAF8wcH+5AKK4qaUllhuWLW59ACn7qCe5GAjGnJVK5yc=
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr10503154ejz.214.1618610788798;
 Fri, 16 Apr 2021 15:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com> <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com> <20210416220251.GE22348@zn.tnic>
In-Reply-To: <20210416220251.GE22348@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 16 Apr 2021 15:06:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
Message-ID: <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16, 2021 at 3:03 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
> > __nocfi only disables CFI checking in a function, the compiler still
> > changes function addresses to point to the CFI jump table, which is
> > why we need function_nocfi().
>
> So call it __func_addr() or get_function_addr() or so, so that at least
> it is clear what this does.
>

This seems backwards to me.  If I do:

extern void foo(some signature);

then I would, perhaps naively, expect foo to be the actual symbol that
gets called and for the ABI to be changed to do the CFI checks.  The
foo symbol would point to whatever magic is needed.  I assume I'm
missing something.
