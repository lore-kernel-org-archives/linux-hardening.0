Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56139ECAAA1
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Sep 2022 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIBUwm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Sep 2022 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIBUwk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Sep 2022 16:52:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185CFE35C
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 13:52:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 73so2952492pga.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Xrq0xaJscCe2LFXho6Z5SMg88GSPjvsfWB0TByS7koM=;
        b=dW6kpbSaQbTaWbefqRhfls6POnB8wBk8wGzkDF9+nJ5/pcLz8aoEXVHn1hfwQ8qSmI
         gTUfl8RmLPi4xMR/CEUEejkZt9/CrkSBMb1JENOoRm/X6w2XKKYXhRg/L5kU7h+bf6R/
         dMY+E+nekbCc6QVsSHSYwXdscdb6ETn1htOiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xrq0xaJscCe2LFXho6Z5SMg88GSPjvsfWB0TByS7koM=;
        b=ri5fie9VzbQiSw1S6oTL+/VG+WGK7pyJijAmDpcDAGJTdG4mhVvk7NHEorn8dN3KUC
         xuuX92hV/rz9rqpNKtXSVJdnTKknRD9OlDAKN/4un8BJYQZ2OEAYVbOQMbbRp3+6auLM
         eQF3UFagPdpu3wMGOtLVdkv9I51VEugyJNM4Vb5n9Zp1nE1mx2Zheb0Tua40lMCRLOoo
         i7pO+/12nsoEcEzinGgFZPRpUk9MpobelutRjdOjta0OB2vkybaiqSiy+ONDJuJyr8j4
         yJEUq1/g2d4U1Wtziic//c2p4APw6CG2TgfK/50xxStC6RZ8vDLPAL9pugU4LDu51cxh
         nHog==
X-Gm-Message-State: ACgBeo07V8bEXNlHJPASnEr1YszkvpOXt/z+ouA4zjjBvDBvlfBgBUCT
        i5mxdQvcOYyadBTBqRY0i1X6kg==
X-Google-Smtp-Source: AA6agR6/sc1utJRqox+EQ93nbssyjmVQ0KWuz5zOB6kpLHeqaFwQE7wdrUV35UzfGFi9zmreSk3vTw==
X-Received: by 2002:a65:4c09:0:b0:430:8422:9642 with SMTP id u9-20020a654c09000000b0043084229642mr7559187pgq.322.1662151958218;
        Fri, 02 Sep 2022 13:52:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i71-20020a639d4a000000b0041b667a1b69sm1867398pgd.36.2022.09.02.13.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:52:37 -0700 (PDT)
Date:   Fri, 2 Sep 2022 13:52:35 -0700
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
Message-ID: <202209021351.13203B669@keescook>
References: <20220901190952.2229696-1-keescook@chromium.org>
 <ba161718-bc61-57b8-dfbe-dee666fd06e8@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba161718-bc61-57b8-dfbe-dee666fd06e8@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 01, 2022 at 12:34:34PM -0700, Guenter Roeck wrote:
> On 9/1/22 12:09, Kees Cook wrote:
> > [...]
> > -If a caller is using non-NUL-terminated strings, strncpy() can
> > -still be used, but destinations should be marked with the `__nonstring
> > +If a caller is using non-NUL-terminated strings, strtomem() should be
> > +be used, and the destinations should be marked with the `__nonstring
> 
> s/be //

Thanks!

> > [...]
> > +++ b/include/linux/fortify-string.h
> > @@ -77,6 +77,36 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
> >   #define POS	__pass_object_size(1)
> >   #define POS0	__pass_object_size(0)
> > +/** strncpy - Copy a string to memory with non-guaranteed NUL padding
> 
> Does that need a newline before strncpy() ?

What do you mean here? I think this is valid kerndoc, but I'll
double-check. (And will continue in the neighboring htmldoc build thread.)

-Kees

-- 
Kees Cook
