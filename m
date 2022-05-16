Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B27AC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 16:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbiEPQ3B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiEPQ3B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 12:29:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555CD3B019
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:29:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p139so7012716ybc.11
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bOl+fIEQwkyHpsAzPSpEA4t7EJjG4W9SophqswqviQ=;
        b=bdD+55o79GwcDBvWafpfYRSlZ2cIsVtsEzWN8lNQZowpdfgforgqMt8qYsM397aVOm
         YiVGsBjyCQ4/nzJb8pjgE6jjFdcKLpF5wOOcJodQ1RZ4iNIvX0CENTxmrtn9+/UciHyW
         EKnHHqZErG9LECr8b32WdjMLnN2pXB4+B7zMmAvfkaPu7l6jzIfy0MhMILwvn73/9VQ/
         MkHv6wCf5C5mFtWTtxiMgZBPV2qCW1bp6lyYTE56bmlfFrfQylzrQZmpH8+PR5FUV1/R
         OxVBsmGQ396NviKrlt0o6WZ5PsTDAzdbxxcSej5Osw7CXNEecq4EKHR7E8NkFpIkBOAc
         v+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bOl+fIEQwkyHpsAzPSpEA4t7EJjG4W9SophqswqviQ=;
        b=a4kKfbeSY2nkiqPvQM09W4pNllJVaWjwZtKPE/gHb9TqLpfoqtQeSCFI3bNWaYAtNb
         VGg+mrJlmUqTMtZnM0ipA7xZYj76uxpbpOVBphSTF3V5kHJAVEYMoE3R+3I7F41IX5r6
         McONFAW3UraFf3+soGw/DVvEZU2/fRQIDsC+3hJtngbZAlgmZo97T7F27rKwjYS9UAHh
         ca0Od7hErovIeNJna5h0W9mG8vDdNlV869hALHy7ouoGQ2zsgK0uR/pwez3EvmSr4Qkj
         BkD8Rd/qpqT9e85/t829q8LmTWkbCRqqbHhHlfyR47ioL+fdoPhSGrCcqGf37e3Edqxw
         PWGg==
X-Gm-Message-State: AOAM530ReYRjyDI8QCtL/Qx/qi4iX26sgefw/KB2mtzb3687KjepD2Df
        UlxLtXoD8UPxhvmH5F8tph1ihkDQGbmIwa++CGuysw==
X-Google-Smtp-Source: ABdhPJwCEGLuNBoujfx+BIv6GEik4LbJeGm6Fda7U5MlIv3LPv1HXUgO10cPIMseX62+HYUEsnBRjf+KqqvWact8dkE=
X-Received: by 2002:a05:6902:90b:b0:64b:233d:8e03 with SMTP id
 bu11-20020a056902090b00b0064b233d8e03mr18071522ybb.428.1652718539243; Mon, 16
 May 2022 09:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-12-samitolvanen@google.com> <202205141453.44171359E3@keescook>
In-Reply-To: <202205141453.44171359E3@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:28:23 -0700
Message-ID: <CABCJKudJZUsRjwAEzWszOGY6G5igwWVpEy1OsAWrhyKr3csUSA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/21] arm64: Drop unneeded __nocfi attributes
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, May 14, 2022 at 2:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:49PM -0700, Sami Tolvanen wrote:
> > With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
> > with address space confusion in functions that switch to linear
> > mapping. Now that the indirectly called assembly functions have
> > type annotations, drop the __nocfi attributes.
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> It looks like there are still other cases that continue to require
> __nocfi, yes? It looks like after this series, it's still BPF?

Yes, BPF is the only remaining user of __nocfi after this series.

Sami
