Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EC4C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 03:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348569AbiBCDPz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 22:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbiBCDPz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 22:15:55 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32FC06173B
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 19:15:55 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v74so1073012pfc.1
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 19:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hBU4JFbPBzxehHqfaF4K5jjXVFa9V7j6ayn4pyPjLaM=;
        b=kqJ580ShflAK7PUZHi/P2jKpyhV4HdvOAkzRMDOXphgVHJDXjkbbfkesDFRNxf0+qJ
         tJ1MxkONvRpYPTFo3q2EezC9wXVqZ0szg12Y9gzBHLK9ON4Gr6Avap52/jirLO0zgDkp
         7G5Likj54d31ySNRMCJLMPvTdkvi06Kl5pdtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBU4JFbPBzxehHqfaF4K5jjXVFa9V7j6ayn4pyPjLaM=;
        b=G4akzigcWBXCXeV18PC4pFJVvNwIFCrK1cxyLXNAM9jQIfwfzq2dIC/tH8537xiw/g
         n3jkXMi+1EX/Fm4dV0el0txAwmdwAZVXZeuxdAvnlM63u+sM42Mfdpv60fAnW4zZ9Zit
         6GdIUJfZrktS/F8gu1C4Aoygz4dC1gVLrqiOioo+fRnl5WEO0+XIPDX4mZz46bHU3MOP
         Y40xWNDtwTB0CZJ0nsJMoq4eC+UoadT+lPR3g50cF5QckYtxdUckhoFmm2GmZTi7qa7l
         iBtpxhgtdXP65TnI4HsRkEqksYZX90iRBY2NBrHXKgYBDuVMDw/cJ4CSWJLCLqNs6Q5G
         5d+A==
X-Gm-Message-State: AOAM532cvGQRX0j3sHwd6HMtKqwiHivd76uBTkm0VU+d5UGYBiIbcGZW
        dWxO8CLhZlqMdO3ORYCq0a+vog==
X-Google-Smtp-Source: ABdhPJz/3irb1Mvta4DMVHkwV3P0zPfm1aoio/loPBUWG0M3eXDB+5Sxu3J3QxmOSYOFPFttFvqOKg==
X-Received: by 2002:a63:5f44:: with SMTP id t65mr26353024pgb.587.1643858154753;
        Wed, 02 Feb 2022 19:15:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a38sm26562425pfx.46.2022.02.02.19.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 19:15:54 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:15:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
Message-ID: <202202021909.F46DE164@keescook>
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-5-keescook@chromium.org>
 <CAKwvOdm1O+cKn5C86C2cB7hUCupv+Mf0w1d1pcaUNniYvc5jEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm1O+cKn5C86C2cB7hUCupv+Mf0w1d1pcaUNniYvc5jEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 02, 2022 at 01:22:09PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -179,7 +179,7 @@ config FORTIFY_SOURCE
> >         depends on ARCH_HAS_FORTIFY_SOURCE
> >         # https://bugs.llvm.org/show_bug.cgi?id=50322
> >         # https://bugs.llvm.org/show_bug.cgi?id=41459
> > -       depends on !CC_IS_CLANG
> > +       depends on !CC_IS_CLANG || CLANG_VERSION >= 130000
> 
> Are these comments still relevant, and is the clang version still correct?

Oh, good call. I thought the version was still correct (more below),
but yes, the comments need adjusting.

> In https://lore.kernel.org/llvm/CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com/
> Miguel notes that diagnose_as only exists in clang-14+.  If this
> series relies on diagnose_as, then should this version check be for
> clang-14+ rather than clang-13+?

It doesn't rely on it; this is just taking advantage of an improvement.

> https://bugs.llvm.org/show_bug.cgi?id=50322 is still open, but doesn't
> signify why there's a version check. It makes sense if there's no
> version check, but I'm not sure it's still relevant to this Kconfig
> option after your series.

With __overloadable, this probably ended up going away.

> https://bugs.llvm.org/show_bug.cgi?id=41459 was fixed in clang-13, but
> it was also backported to the clang 12.0.1 release.  Is it still
> relevant if we're gated on diagnose_as from clang-14?

Ah-ha! I missed that this got backported. Looks like 12.0.1 and later
have this fixed. That's excellent!

> Perhaps a single comment, about the diagnose_as attribute or a link to
> https://reviews.llvm.org/rGbc5f2d12cadce765620efc56a1ca815221db47af or
> whatever, and updating the version check to be against clang-14 would
> be more precise?

Yup, I will rework this after double-checking 12.0.1 builds.

Thanks!

-- 
Kees Cook
