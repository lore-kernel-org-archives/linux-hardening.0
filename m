Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1008FC433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E830C61AD1
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 20:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJAUJW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJAUJV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Oct 2021 16:09:21 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1123C061775
        for <linux-hardening@vger.kernel.org>; Fri,  1 Oct 2021 13:07:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 71so22944961ybe.6
        for <linux-hardening@vger.kernel.org>; Fri, 01 Oct 2021 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBLk927GvcqTts5ZXZsY0rNBa9CfWPtALtUWhvHfD0k=;
        b=jzDkGY/oX2BBlbsmSp5ApGvUVFq1EwemTnlAP/JY1bhAKaYvEKP92awpcx+vVt69v2
         Y0DySpaUPc8oEE1NYy5inzTKlur3eiTGIb8ToCdVedhHm9BX9Y3zzAsPPeRttaPBffLd
         Qrd5bgUhkmVOfgL+m7ksNSUdp96fSPRgrOotVPJBbnBO7fTgnADEOzcCVDWTy/dl2kLY
         7KtLtNzV6m2ae9NVXUDI33AH/tCIfDiL/Fg6jIbZaxzBT43CoxIN+738DFfkd0PrwNhk
         J4X1Zv4vZMYZnt0FFmeRWuwmfPm0+y06SbPc1joBKUPxYWGlD5o4JPwqqiuNOqOCRJfA
         FtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBLk927GvcqTts5ZXZsY0rNBa9CfWPtALtUWhvHfD0k=;
        b=tYqGHJl6HFppFjH2zvRxLoxczXPmXistkuy3QJ+I11luG0SGZliMhvU3aB8j0H/wgD
         EbUHpfsOE1Teu+3T+bEsk5IUeDAeP+RnuK9OD5Yil1C23ij7ExGW+9wNdymp+msrsN9M
         BMfuu7kepNwMK7MX1J3eoFTCSmQGubDgs96SsoXHOy/rB6xR5ae+lyebP8ZjvXDDpK8+
         s2RjSoUN3pbmA/0fEeGgv/oorNNc/lLOn0uYjkBsuQ0wgoPIF9iV+I6Ii0OK7m2KL5de
         QOmHirjph04o0EfslF3CXzThBmt0sENsM3U2PUvko/tNCPbVNeKV9QFYFZ1c/8bj95VP
         el/Q==
X-Gm-Message-State: AOAM531tDmrS+vleFraBjHhfD+rDGtpq62gxiN7EzYuXyOL2JA1m8Jpp
        8QfriETB/hpkIJWekCObHhXYdW5QD9hfb3iTDhdLjQ==
X-Google-Smtp-Source: ABdhPJyK8IpoknA+mSXQjbTAdDI7HXLYzQ/Vxv87fIjV5+NKCMojAZ1h7strK2gksLcLdbV5IDywivxRQ3NyA/yW9NA=
X-Received: by 2002:a25:e6d0:: with SMTP id d199mr8201002ybh.527.1633118855954;
 Fri, 01 Oct 2021 13:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com> <CAKwvOdnN-5PBnegEpb4eq3uPWezmAO6Zrvy3O7zyCNEBFvYt4A@mail.gmail.com>
In-Reply-To: <CAKwvOdnN-5PBnegEpb4eq3uPWezmAO6Zrvy3O7zyCNEBFvYt4A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Oct 2021 13:07:24 -0700
Message-ID: <CABCJKucX-FWcsaCt2TCY+2Y+GrKb5EKFFFsGWN8mbgZTTy8nNg@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:50 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> > which defines a stub function that immediately returns and when
> > defined in the core kernel, always passes indirect call checking
> > with CONFIG_CFI_CLANG. Note that this macro should only be used when
> > a stub cannot be called using the correct function type.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Seems like the only use is in patch 5/15. Probably could be squashed...

I would prefer to keep these separate, but if everyone thinks that's
unnecessary, I'm happy to combine them.

Sami
