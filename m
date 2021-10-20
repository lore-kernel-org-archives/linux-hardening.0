Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A56C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B06135E
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhJTTRZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhJTTRY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 15:17:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1307C061755
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 12:15:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t184so10394814pgd.8
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i22CGOfMdCgEzNofkN2ujFXF/VRH37ibkrOAmDeTGJk=;
        b=JpcmTmu47LLgTalrcwHRfbvnurUdEUIPsEFm+gDXyWzHYc7ndXQEKbhgm4vo91rqt1
         TMNIN7Qa9dCpB6e3ViS2EZ+qPxoTjr6dHBkYXKic25otGOFt5rTop+eIp8mnFDNRwpGt
         aje3upgjKjBAz6T1loijjMNJQqfNOXXET2wlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i22CGOfMdCgEzNofkN2ujFXF/VRH37ibkrOAmDeTGJk=;
        b=oBRvsDI3AmQckaujWlWnRgFDZOPib3IOWe3JrKfhwe06RSCWjMhNB+HFvbECMfxsUB
         Q5XAjUlE4pzKzTPShn/iDbB0YKeHxVq/NIfMzCQ0do6AKUHSRqwa8TUles5BCbA5GcuP
         BvFAx3+N8JCV36/gDcNDTaqrLCP1gy1RM2cNcFuLd4eReC3hLufAgNtKBsvB1zg3AyiF
         aYKvFY56EagN1FU3N5RPc60zC8vsL2dGgRllj6RRlA+dNcpcZbmUZlCdoHVyCI0OajWB
         KP1DW6jvuaVXd4SGhSxCIJdcl8/CuTxwAEqjk8oNSxpHekwcnWbiXWPMRTc/oQ6FH4dy
         TQ9g==
X-Gm-Message-State: AOAM533fBdc/9V9GWd+rIfD1Wioww0C8EJp48b3Ua7Su0lPbAUnQbOG1
        7dY5niVZnaCPnG9j8fRLat1/vg==
X-Google-Smtp-Source: ABdhPJwlN6e6EukdLBE/1sEfEDDBaNtAFd50dDayRvjCFtYq+pdfXTDmzg6uAqxABX6av/5tLtlX3w==
X-Received: by 2002:aa7:94a8:0:b0:44c:f3e0:81fb with SMTP id a8-20020aa794a8000000b0044cf3e081fbmr797733pfl.6.1634757309155;
        Wed, 20 Oct 2021 12:15:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12sm3981100pfh.52.2021.10.20.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:15:08 -0700 (PDT)
Date:   Wed, 20 Oct 2021 12:15:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        llvm@lists.linux.dev, Dan Li <ashimida@linux.alibaba.com>,
        ardb@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gcc-plugins: Explicitly document purpose and
 deprecation schedule
Message-ID: <202110201212.43DC4A24@keescook>
References: <20211020173554.38122-1-keescook@chromium.org>
 <20211020173554.38122-2-keescook@chromium.org>
 <YXBVx+0YjoMtQ27T@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXBVx+0YjoMtQ27T@archlinux-ax161>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 20, 2021 at 10:45:43AM -0700, Nathan Chancellor wrote:
> On Wed, Oct 20, 2021 at 10:35:53AM -0700, Kees Cook wrote:
> > GCC plugins should only exist when some compiler feature needs to be
> > proven but does not exist in either GCC nor Clang. For example, if a
> > desired feature is already in Clang, it should be added to GCC upstream.
> > Document this explicitly.
> > 
> > Additionally, mark the plugins with matching upstream GCC features as
> > removable past their respective GCC versions.
> > 
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Seems reasonable to me.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

> 
> One comment below.
> 
> > ---
> >  Documentation/kbuild/gcc-plugins.rst | 26 ++++++++++++++++++++++++++
> >  scripts/gcc-plugins/Kconfig          |  4 ++--
> >  security/Kconfig.hardening           |  9 ++++++---
> >  3 files changed, 34 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/kbuild/gcc-plugins.rst b/Documentation/kbuild/gcc-plugins.rst
> > index 3349966f213d..4b28c7a4032f 100644
> > --- a/Documentation/kbuild/gcc-plugins.rst
> > +++ b/Documentation/kbuild/gcc-plugins.rst
> > @@ -32,6 +32,32 @@ This infrastructure was ported from grsecurity [6]_ and PaX [7]_.
> >  .. [7] https://pax.grsecurity.net/
> >  
> >  
> > +Purpose
> > +=======
> > +
> > +GCC plugins are designed to provide a place to experiment with potential
> > +compiler features that are neither in GCC nor Clang upstream. Once
> > +their utility is proven, the goal is to upstream the feature into GCC
> > +(and Clang), and then to finally remove them from the kernel once the
> > +feature is available in all supported versions of GCC.
> > +
> > +Specifically, new plugins should implement only features that have no
> > +upstream compiler support (in either GCC or Clang).
> > +
> > +When a feature exists in Clang but not GCC, effort should be made to
> > +bring the feature to upstream GCC (rather than just as a kernel-specific
> > +GCC plugin), so the entire ecosystem can benefit from it.
> > +
> > +Similarly, even if a feature provided by a GCC plugin does *not* exist
> > +in Clang, but the feature is proven to be useful, effort should be spent
> > +to upstream the feature to GCC (and Clang).
> > +
> > +After a feature is available in upstream GCC, the plugin will be made
> > +unbuildable for the corresponding GCC version (and later). Once all
> > +kernel-supported versions of GCC provide the feature, the plugin will
> > +be removed from the kernel.
> > +
> > +
> >  Files
> >  =====
> >  
> > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > index ab9eb4cbe33a..3f5d3580ec06 100644
> > --- a/scripts/gcc-plugins/Kconfig
> > +++ b/scripts/gcc-plugins/Kconfig
> > @@ -37,6 +37,8 @@ config GCC_PLUGIN_CYC_COMPLEXITY
> >  
> >  config GCC_PLUGIN_SANCOV
> >  	bool
> > +	# Plugin can be removed once the kernel only supports GCC 6.1.0+
> > +	depends on !CC_HAS_SANCOV_TRACE_PC
> 
> This symbol is not user selectable and the one place that does select it
> only does so when !CC_HAS_SANCOV_TRACE_PC so this seems pointless to me.
> 
> Keep the comment, ditch the depends?

I had a similar thought, and in the end, I decided I wanted to always
enforce the GCC feature check through a depends, with a comment about
the expected version. I want to make sure we don't use plugins if an
upstream feature is already available. It happens that SANCOV was
effectively the first to do this, but it did so on the other side and I
wanted it repeated here so it was "self contained".

-Kees

-- 
Kees Cook
