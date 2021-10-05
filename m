Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650DC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 21:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DC3611C1
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 21:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhJEVz3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJEVz2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 17:55:28 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E1C06174E
        for <linux-hardening@vger.kernel.org>; Tue,  5 Oct 2021 14:53:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s4so874369ybs.8
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlN4jfg0gX2LZZN2w0PrP6x9vQI3f2fSsuMkV8Sa4Xg=;
        b=WxlCMf9yLZ3Uuf2DfAUeuTFIC8NL1nt/7BhNpeBIFVemwl6QReya/4bK0JXGKlCZQR
         3V4RPzA4g7R8Rm2RZjCgCJpQ9wA5YtXHHrs6b/CmzpZMhUO4hb/aXoiL0r5IRTN1FUnc
         2j0rfYw88yjBpXBsUrQgWIe8T3gz2J3MYPz7g8kJa/RxAUY9EMEIcHSGtLgLUDSw5Sl4
         8c1i0A/6foxCPPQupeAx8D4qb+q4lwKMAEnXcdFE2um+MCXJ4rv9VTXgQhdl/Qy8Sp7f
         dm0j5wwFq/sYhKnjktk5j204LvMn5dm5C/Uj4WbWLe7CD4wsOkLiVPyevXIwx+9VstpG
         PwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlN4jfg0gX2LZZN2w0PrP6x9vQI3f2fSsuMkV8Sa4Xg=;
        b=FBLMgKCLHQd6Uh5visesnt4cCTbY9Tupxm9YNA/D8/UKlZHUTjVmoIb4d3IhXxiuXz
         CipG0y/Qhk4t+VyWTokJwhFrg9ss5NGVUC4i+4fmasGlpAftmErYlyozoG49Sbg20w0T
         tiXCW6Zh5pa0J9DZ7SNYx2jqGYb5cjd/chzmJ8wovXSjeDWtApxNvlNh638MfsHC0Dfi
         n0YwWRVsE2UDH2/ZWUY4zqizMoqEth4VZgkKHMsTyhbxF4l+8xCdaET0a24ClR3HvkLH
         un4gxZ2jBSllp+d7KqyOVp0jI4b0MOtDepPWKS3ZRFJkjycDsRbP584eLd4NhHOyO98a
         bjxQ==
X-Gm-Message-State: AOAM53086FkDX0z7aw7Fh+SD2lsV5zQYUr+rJoCOCo1Pe/BpXSWgUUix
        sPdfvdXntAjdlm9rH7ZQVAOtPM23taaXZiiQFykmmQ==
X-Google-Smtp-Source: ABdhPJxeqlTZhXqga9k43BtCRV6P3IjRNNoQSEkCNn/i7ChYlIrPyZgPSI8OyeePFw8yqlBWHMU6Cd301mHXo+IlWb4=
X-Received: by 2002:a25:cf8f:: with SMTP id f137mr26586961ybg.338.1633470816214;
 Tue, 05 Oct 2021 14:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com> <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
 <CABCJKudBrHfwR=gQc=9=cfBjR9p5jm65ovSNwzLLEpDUdo6ZPQ@mail.gmail.com>
 <20211005065923.GH4323@worktop.programming.kicks-ass.net> <CABCJKud1Gm0ouROKLAw9t03qbs+_EASky053=SqijPJahqogng@mail.gmail.com>
 <20211005205612.GF174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005205612.GF174703@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 5 Oct 2021 14:53:25 -0700
Message-ID: <CABCJKufUZxDdQziUFG5YzUDjChvy9XOHPxBjUG4GXUw4LCGpkA@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 5, 2021 at 1:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 05, 2021 at 01:29:02PM -0700, Sami Tolvanen wrote:
> > On Mon, Oct 4, 2021 at 11:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > For x86_64 it should indeed never get called, however if you plan on
> > > supporting i386 then you need the annotation. Also, it might get called
> > > on arm64 which is about to grow basic HAVE_STATIC_CALL support.
> >
> > Good point. I read through the latest arm64 static call proposal and
> > while it can fall back to an indirect call, it doesn't look like that
> > would cause issues with CFI.
>
> Because that call is outside of compiler control?

Correct.

> Same will be true for
> any HAVE_STATIC_CALL implementation I suppose. The trampoline will be
> outside of compiler control.

True, so it shouldn't be a problem.

Sami
