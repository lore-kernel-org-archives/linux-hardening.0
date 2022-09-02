Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDCEECAAA1
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Sep 2022 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiIBWhX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Sep 2022 18:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIBWhW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Sep 2022 18:37:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F58DDB66
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 15:37:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v5so3178643plo.9
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YqEz9P92aVLz6CF4nfeMLpOackJa8aB4SG7L2waxiMw=;
        b=FblueC6TXkIC7NBlNdmRb+Ofk7EbQBKfMaTrcJSDD7XULj/GwBk7l4/Pua32HMnoGv
         dn9Sn+IEk1rfOK18rBZfUv4ail6cRSttSdJTwWeSk/pbz3MKG6Qzr//kn2qBK5QQcetQ
         1lAesOHCqGfX0Sa3esNv2zqKS5eEHmDjYv8mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YqEz9P92aVLz6CF4nfeMLpOackJa8aB4SG7L2waxiMw=;
        b=su+792nqnVXunDyJiMq1S73DeTt/QhTJIFh5S5ZnJWq66FCvBJl3Kxfc+TyopV/2Gp
         cEEjRbixlJ/RQXLXPpH+1dFA1JUrcP/iiG2RvyiinVNRlvDXaNsw5qBuugEDTRfmrsVp
         8cXQ+ylJs6LANQ3E1om8/1JSDBDfmfwhuX5yAFzWG3SF6LJURxm7D87/9SJMWs/XZZn9
         wW/9b8c1PhGkPrhS8ekSG97GgFVEJvs7NBF5J6PSpuwNVv4vN6SwVXc2gPGbd2IcLMfW
         jZjC7orCiH/yx2tMMX4Wv7KzA5Ua4QkswDkEkYyyMewpR7SGwi/ybb2J/v0wAd8Zx1TG
         x/NA==
X-Gm-Message-State: ACgBeo2oHhAOBYQGeQgVrcbXj1M4ux9id8eGpKGYSV3w7jg6wlLPh0Wq
        JP1tg3I8FIKz3a9HJOb/Yska2Q==
X-Google-Smtp-Source: AA6agR4OJ9UB5g9ECsccg1QUQU2XbCgs307mTgPiaKySm0fOScuCGMvlBb1AUyWMFbO8KN/EPiH7Qw==
X-Received: by 2002:a17:90a:13c8:b0:200:17ca:f183 with SMTP id s8-20020a17090a13c800b0020017caf183mr200505pjf.104.1662158241226;
        Fri, 02 Sep 2022 15:37:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b00172b87d97cbsm747066plg.67.2022.09.02.15.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:37:20 -0700 (PDT)
Date:   Fri, 2 Sep 2022 15:37:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Message-ID: <202209021537.43D3FDD@keescook>
References: <20220901190952.2229696-1-keescook@chromium.org>
 <ba161718-bc61-57b8-dfbe-dee666fd06e8@roeck-us.net>
 <202209021351.13203B669@keescook>
 <20220902214704.GA4094673@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902214704.GA4094673@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 02, 2022 at 02:47:04PM -0700, Guenter Roeck wrote:
> On Fri, Sep 02, 2022 at 01:52:35PM -0700, Kees Cook wrote:
> > On Thu, Sep 01, 2022 at 12:34:34PM -0700, Guenter Roeck wrote:
> > > On 9/1/22 12:09, Kees Cook wrote:
> > > > [...]
> > > > -If a caller is using non-NUL-terminated strings, strncpy() can
> > > > -still be used, but destinations should be marked with the `__nonstring
> > > > +If a caller is using non-NUL-terminated strings, strtomem() should be
> > > > +be used, and the destinations should be marked with the `__nonstring
> > > 
> > > s/be //
> > 
> > Thanks!
> > 
> > > > [...]
> > > > +++ b/include/linux/fortify-string.h
> > > > @@ -77,6 +77,36 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
> > > >   #define POS	__pass_object_size(1)
> > > >   #define POS0	__pass_object_size(0)
> > > > +/** strncpy - Copy a string to memory with non-guaranteed NUL padding
> > > 
> > > Does that need a newline before strncpy() ?
> > 
> > What do you mean here? I think this is valid kerndoc, but I'll
> > double-check. (And will continue in the neighboring htmldoc build thread.)
> > 
> 
> Just asking. "/** strncpy - Copy a string ..." seemed unusual without
> newline between "/**" and the function name.

Oops, yes. Thank you again!

-- 
Kees Cook
