Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35821C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Feb 2022 00:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352492AbiBDA2D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351278AbiBDA2D (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 19:28:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E01C061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 16:28:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y17so3695044plg.7
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 16:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vhgypBVUxatDQA2t/PEFyJq1Dz/oV4D6TAQvVZv0u8=;
        b=W0bGQxU2pU33Ei4vTMwb4LxDzrWE0EXjvMUkCBocmmMUvkaM2UsgQk5t3PALzqMv7A
         lwPd32y7m9eeQCbpVad3GG1/067X3mSlbKgu/pUqoqJwnR6nFSBetJG6JYl6+G+RMZX1
         qQ5u/9a9tlXqQzT9hGubw9MgAX/XtNzYaS4xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vhgypBVUxatDQA2t/PEFyJq1Dz/oV4D6TAQvVZv0u8=;
        b=8LdtCBXB8b3gvhGFgtaIruOxB9kk1Q1xFt89ddPJupF1b1Jr+czO0LK7sXmMRV7ayC
         +bft5BUvhXPPrLK0jiJEhA7u86rYYmOSbRbWUwiFF/XYNVdoYbdphefgMAjsPa+Ldpn0
         L1aCSklLlw11iGIF6eBvBH+I9XM0tQsrkEWs0tul57Czj8k6wV3GRdE+0H1l/+eAMP8V
         IUk9ZFCMC2CQtyA/AOAX8k4rSWHfJposn8XT/kSntDwvnaBJ/ADr7H/zflsau0w0JLch
         GsBX51AIpO33eQLC5s4wbW3d+bais71lshTnDa+BxPI9mOmPvt+kjgb4lSq27fU//Ily
         Ev3w==
X-Gm-Message-State: AOAM531fl3D5mCMXXlerNTwCNoo1ZALRWNClsH8D7ijllmwrXl/4uLvw
        TsFJRYK86V0Oj2ukeMjl2rmmNGAR0FFDEA==
X-Google-Smtp-Source: ABdhPJzclz2hHFHcinwuT36MxYy5C66IRul1bzvGhtdzdI25zojLs1J2oEC8VA4G/XwZL8ZwyaFSNQ==
X-Received: by 2002:a17:903:183:: with SMTP id z3mr380439plg.127.1643934482295;
        Thu, 03 Feb 2022 16:28:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm162686pfu.194.2022.02.03.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:28:01 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:28:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
Message-ID: <202202031627.0EEB393@keescook>
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-5-keescook@chromium.org>
 <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 03, 2022 at 02:13:33PM -0800, Nick Desaulniers wrote:
> On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index c45159dbdaa1..5482536d3197 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -2,7 +2,9 @@
> >  #ifndef _LINUX_FORTIFY_STRING_H_
> >  #define _LINUX_FORTIFY_STRING_H_
> >
> > -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> > +#include <linux/const.h>
> > +
> > +#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline)) __overloadable
> 
> Sorry, I just noticed this line (already) uses a mix of open coding
> __attribute__ and not. Would you mind also please changing the open
> coded gnu_inline to simply __gnu_inline to make the entire line
> consistent?

Ah yeah, thanks. Fixed.

-- 
Kees Cook
