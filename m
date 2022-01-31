Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB233C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 21:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379738AbiAaVOU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380007AbiAaVNx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 16:13:53 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F1C061401
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 13:13:31 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z131so13371970pgz.12
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GS7ARrVx7mqa1AsFf3AdkLtLmRc92cKknoJbQi/nsN8=;
        b=VpMxW+eMio0Wu66eA+trKZ060aIZM8z7jb6VDn7qKwkY/PhFOYC8LO+1DYq2da/FxI
         JAotv9ZcWLXu2zJrGrqOb3fuimLZxVDvBCd1imtyfHmpGXv3gRKgTceDM1NACLwsxF0a
         fXSM/pmmRC0yZGBYF92QdQD7GqZ4bK4Fiezbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GS7ARrVx7mqa1AsFf3AdkLtLmRc92cKknoJbQi/nsN8=;
        b=Qlhudqt2v0toSF8mzoJPqoNKFFgc/aaUG8QL5Zk6o9OHfbHlZT0PICx5dTCQxuRp17
         5kT53NnEHj/KzKj4R3V4Q5gB1kOxW9/OukLoyAWVnjMldL2+uf1ldG2n/E8WGnHnZFW5
         RzyhLK/xpSXqocwbK5SiVwQSfiVy5ep4EY5QVJhOQnu15iWnonUZB5aZbMJquaqdZcoG
         B7nSFbvQlaKMOHk3KBcsmO0jL+It6ZmY0dnLd3z9zZqoU8/bsh/e83vmtEak9eDXsy3/
         tbM0lRx2NOsiLv5sRVGPBkemfkzU/ZzvKpVbFFHlVJwQRw38uEwNOm/0lcWN58pdJ1qh
         2B2w==
X-Gm-Message-State: AOAM530EU0Ofa0a7y771D1JkWT6X1qOXanc5CS7Aaq4VGW1OJqRXZbT0
        0HMOQc/H+PptSFPIkOLj0593uQ==
X-Google-Smtp-Source: ABdhPJzxIEXhImcS+G4fX4a7La7yj1Sol7mkyBq+x+m4eA/grNnHBkUexrk8Gwx7zzkYa0bvDq2Fcw==
X-Received: by 2002:a63:69c8:: with SMTP id e191mr1911222pgc.412.1643663610998;
        Mon, 31 Jan 2022 13:13:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y42sm17430367pfw.157.2022.01.31.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:13:30 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:13:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4] fortify: Work around Clang inlining bugs
Message-ID: <202201311309.AFF4A0C@keescook>
References: <20220130182204.420775-1-keescook@chromium.org>
 <CAKwvOdmrzO9U9Cu5zB07t1C+Xh-kAzk_F-MisAxsrArhJVhSNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmrzO9U9Cu5zB07t1C+Xh-kAzk_F-MisAxsrArhJVhSNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 31, 2022 at 11:04:36AM -0800, Nick Desaulniers wrote:
> On Sun, Jan 30, 2022 at 10:22 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > To enable FORTIFY_SOURCE support for Clang, the kernel must work around
> > a pair of bugs, related to Clang's inlining:
> >
> > 1) Change all the fortified string APIs into macros with different
> > inline names to bypass Clang's broken inline-of-a-builtin detection:
> > https://bugs.llvm.org/show_bug.cgi?id=50322
> >
> > 2) Lift all misbehaving __builtin_object_size() calls into the macros
> > to bypass Clang's broken __builtin_object_size() arguments-of-an-inline
> > visibility:
> > https://github.com/ClangBuiltLinux/linux/issues/1401
> 
> ^ mentions a difference in compilers for mode 1. I wonder if this
> patch could "hoist" the BOS calls into the macro ONLY for mode 1 and
> not mode 0 usage? i.e. the str* functions, not the mem* functions.

Everything (with a couple exceptions) is using mode 1 after the earlier
patches in the series. e.g.:

+#define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s, \
+		__builtin_object_size(p, 0), __builtin_object_size(q, 0), \
+		__builtin_object_size(p, 1), __builtin_object_size(q, 1), \
+		memcpy)

> It's too late to fix these in clang-13.  If we get a fix in clang-14
> or later, what does that look like for this header?  Is there a way we

If the bos mode 1 got fixed for Clang 14, this patch would likely be
dropped and the Clang + FORTIFY version check would be moved to Clang
14.

> can provide a different header than include/linux/fortify-string.h
> just for clang-13 (or whatever versions until the above are fixed)?

So much of it would be identical. This macro-ification is least
invasive, and it's pretty invasive.

> I don't see this series getting backported to stable, where older
> versions of clang may still be in use.

Right.

> I'm tempted to say "let's get get these 2 fixed in clang-14" but we'll
> probably have to trade something off the existing TODO list.

Agreed.

-- 
Kees Cook
