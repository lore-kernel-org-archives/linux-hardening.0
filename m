Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F5C433DB
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Feb 2021 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED11364E83
	for <linux-hardening@archiver.kernel.org>; Tue, 23 Feb 2021 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhBWRmX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBWRmW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 Feb 2021 12:42:22 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92FC061574;
        Tue, 23 Feb 2021 09:41:42 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x20so6431830oie.11;
        Tue, 23 Feb 2021 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YxD9KhbFWZ0ReTeZQ3zFVGWOKjEpx/0x9a2PlciRz5o=;
        b=kyp4wA+XZihBEjP4VsacPfwzw0MYmW6SW4misZ+l6tkrwQNcvoWCkX+ptMc/Q8WxRQ
         HQ7C+8oMDy5HefMFAZVvHvChQ1e3sHe12dCz13UFINSswuEh5Wp88mYahvvTcfjwdHmn
         w5tJ9WcmA8R/W3IQxTHMqkZEbgBTBUEG8ZeiqQlu+eIgY1DcerTaSCkOfkHq7Ali7SPX
         euhBLs9zmoNvfH8i2dZgyT9IZd9mJPIu6CbypMMIlNMCAi5Qn4JoPnXRjZSFETDNCUz9
         LEC3yXx9EKDnuIGxo31cK5AkizG+4aCV6mjtTdEVQcNKAjm2opThAYIZ/QNILqiY7LD/
         VGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxD9KhbFWZ0ReTeZQ3zFVGWOKjEpx/0x9a2PlciRz5o=;
        b=gR88li7nUl0xbc7/kSlIWynAFWTNAWD9goWCFWoGsqRurs0cTWD3Ax8l2T7qMWRo02
         QsL7tBfjG4IOsxPX4ViUSvnB/i7TpHbEOKOwCNjRCGp8L5lwiznrj8gNgeDJdgPx6IKM
         7j7KJonP/jc+RwJP5MCBI8NoBVYoMB70Vdac+X4RxYvRXjCEOwhwySHlF81yq+6WoZa8
         oGU+YiVbh7weDN1dmFUGSPaMHi6TMXYMh3yRYcqGIE2/76I9fwNw1p5zLsUkFhJXrukT
         XKS5kTy3G8SqUAZwW8tohzq3QVBmfTo4ECFPs52eXtH8fsM65mR+z3PIyfodMsNYTwcu
         Ercg==
X-Gm-Message-State: AOAM532Txd8L92kVCnkcs8UjSlWz+XNkyr/6PW+iNFXn4gxOKwjW6tbF
        XzlqYprOBbF8VNU7Lt+GKnM=
X-Google-Smtp-Source: ABdhPJze2XXrVBEl5kgKSFDlzRfpcsX8lqfe7L0EpIDkKkAm7i5B0eCkJMqrfIuKwGK0JDUbHxrhUA==
X-Received: by 2002:aca:b655:: with SMTP id g82mr19419603oif.91.1614102102260;
        Tue, 23 Feb 2021 09:41:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y143sm2119028oie.50.2021.02.23.09.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Feb 2021 09:41:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Feb 2021 09:41:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
Message-ID: <20210223174140.GA159796@roeck-us.net>
References: <20210221225650.33134-1-linux@roeck-us.net>
 <YDOeI5+1H3T1ocmQ@osiris>
 <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
 <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
 <8d3de6fc-0991-9cef-d5fd-032fdbe2e85e@roeck-us.net>
 <YDTs4vfjezu3j7rX@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDTs4vfjezu3j7rX@osiris>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 23, 2021 at 12:54:10PM +0100, Heiko Carstens wrote:
> On Mon, Feb 22, 2021 at 08:03:31AM -0800, Guenter Roeck wrote:
> > > Maybe, we can add something like CONFIG_SUPPRESS_NOISY_TESTS,
> > > which is set to y by all{yes,mod}config.
> > > 
> > > This is self-documenting, so we do not need the '# too noisy' comment.
> > > 
> > > 
> > > 
> > > config SUPPRESS_NOISY_TESTS
> > >        bool "suppress noisy test"
> > > 
> > > 
> > > config GCC_PLUGIN_CYC_COMPLEXITY
> > >         bool "Compute the cyclomatic complexity of a function" if EXPERT
> > >         depends on !SUPPRESS_NOISY_TESTS
> > > 
> > 
> > Good idea. Downside would be that it won't solve the real problem
> > for s390 (which is lack of allmodconfig/allyesconfig compile test
> > coverage because COMPILE_TEST isn't set anymore), but that is a
> > different problem anyway, and my original patch doesn't solve
> > that either.
> 
> I tried to explain why we don't want to set COMPILE_TEST for s390
> anymore. It overrides architecture dependencies in Kconfig, and lots
> of drivers do not set dependencies for HAS_IOMEM, HAS_DMA, and friends
> correctly.
> This generates constantly fallout which is irrelevant for s390 and
> also for other architectures. It generates just work with close to
> zero benefit. For drivers which matter for s390 we still see those
> errors.
> 
> > On the other side, if that flag would be set explicitly by
> > all{yes,mod}config, it would really beg for being misused. We
> > might then as well add a new flag that is explicitly associated
> > with all{yes,mod}config, but not with randconfig.
> 
> I think that makes most sense, probably also have a flag that is set
> for randconfig.

Not sure what value such an option would have, and how it would be used.
I would argue that randconfig should not set COMPILE_TEST to start with,
since its purpose should be to test random valid configurations and not
to compile test arbitrary (and in that case random) code. But that is
a different question, and just my personal opinion.

Overall, the question is what kind of additional option you would find
useful for s390. You make it clear that you don't want COMPILE_TEST.
At the same time, you still want all{mod,yes}config, but presumably
excluding options currently restricted by !COMPILE_TEST (such as
DEBUG_INFO, BPF_PRELOAD, UBSAN_TRAP, GCC_PLUGIN_CYC_COMPLEXITY,
and a few others). SUPPRESS_NOISY_TESTS would not cover that, but
neither would RANDCONFIG (or whatever it would be called).

Guenter
