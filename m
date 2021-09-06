Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ACC433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3FC6103B
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 17:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhIFROJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbhIFROF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Sep 2021 13:14:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A37FC0613C1
        for <linux-hardening@vger.kernel.org>; Mon,  6 Sep 2021 10:13:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so7357406pgl.10
        for <linux-hardening@vger.kernel.org>; Mon, 06 Sep 2021 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6NacCBKP1frBhmpqgKkyBTREBZY+hKJD0S9nQbqPwa8=;
        b=WTVPuCHHyicu0+YRTXvNjGuJGvP/yWLoNGUygGsaS/hAOd5NZtdha4u4GUm9BTE2St
         2mwYQ1nPSmq/BqNkeBKRCYeKkxqJRbE29sYhNzqWxRnnDe9u+f421xNYyE7alEVm/8/I
         ZzxCjX0HpUe0NGt3OBy7lDDdBH5JJnNXmdCZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NacCBKP1frBhmpqgKkyBTREBZY+hKJD0S9nQbqPwa8=;
        b=Bd1lkvCvI8YeSILNIZuAdlSwRtA0mqBaI8uPcCtA7jyHu8gjd//YEW4PYipIx0HGoO
         k/QAJA70eXP9o+HEQWcrvThzt4b2G1gCzw1SsZjjtfLXxIyOBzWlnjTUE+t4zIlcn1fy
         OY9TFkf5E+AFcKSuWAXG2wVXQHwbyT0UtlOsPpIWEPp1PoaKha48LtNCZ63z0J1S3WG2
         MMmp4LNpSTDKgbPJ0hUzyjMK4a69wR0Tc3/bZ147PoFH3+aBCCbtd/db0/XrRz+Hwmph
         3/P/D5GDHTy2HfRGT4O2QCpnjRMqs7TU6eRDYjjwt3teSgAjliHNbKu+C1m6LBH/ATxr
         YEAg==
X-Gm-Message-State: AOAM533liqCzwxC8Kyuti9lpra7ITZA+ptdl5xgRkwtuwo5bMNM7KvPY
        s7BptrV0tXHgglwRX5snAFVEjg==
X-Google-Smtp-Source: ABdhPJxZPrDJihM1ow1QccxmKJO1KNet51HC2onoK3El64aMy3Uv7Uj0m3HXCTsjG+Ygs6jtFEhlOA==
X-Received: by 2002:a63:3c4d:: with SMTP id i13mr13298336pgn.54.1630948380070;
        Mon, 06 Sep 2021 10:13:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm52296pjg.34.2021.09.06.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 10:12:59 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:12:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
Message-ID: <202109061009.3C4B6114C3@keescook>
References: <202109022012.756B6B5B79@keescook>
 <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org>
 <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
 <20210906152731.43a9c67e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906152731.43a9c67e@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 06, 2021 at 03:27:31PM +1000, Stephen Rothwell wrote:
> Hi Linus,
> 
> On Sun, 5 Sep 2021 10:36:22 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Sep 5, 2021 at 12:38 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Yeech. Yeah, no, that was not expected at all. I even did test merge builds against your latest tree before sending the Pull Request. This has been in -next for weeks, too.  
> > 
> > Sadly, I don't think linux-next checks for warnings.
> 
> Yes, I do.  And report them.  I did not get these warnings for some
> reason.  One of my builds is an X86_64 allmodconfig, currently using
> 
> x86_64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110

FWIW, the difference turned out to be LANG=C.UTF-8 in Fedora (vs LANG=C or
LANG=en_US.UTF-8), and the warning analysis being done in the self-tests
I added got unlucky when I tried to avoid setting "LANG". (i.e. I didn't
want to depend on matching English output, and used the trailing "'" in
the function name matcher -- which is a "`" under C.UTF-8.)

This has been fixed now -- I just got fantastically unlucky, it seems,
as literally only Linus appears to have been building with LANG=C.UTF-8.
(None of the other build bots warned about this for the weeks it's been
in -next). :(

-- 
Kees Cook
