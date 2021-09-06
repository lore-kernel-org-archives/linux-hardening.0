Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CAC433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2573861004
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Sep 2021 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhIFRUU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhIFRUS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Sep 2021 13:20:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604AC061757
        for <linux-hardening@vger.kernel.org>; Mon,  6 Sep 2021 10:19:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f65so2496984pfb.10
        for <linux-hardening@vger.kernel.org>; Mon, 06 Sep 2021 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0w5VvMqvVfXA2u97tXNbjwUCVgURBwlqEz+ps2g78yU=;
        b=i+gmhVx9C6mf17aSAk5OQCGeo7nx9y7t1WQxvx78PMr2GOEUBoRG792pvZdPHPxGfR
         Y5C8ydKE4AiyPQ3fw9PHfdijisiHdLJxIVab71COe6/2o3opCzeObHVfIchUMoyz4X1T
         ml0Fs874tXkPBMzuWApZHVS69gYQArVNQr2vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0w5VvMqvVfXA2u97tXNbjwUCVgURBwlqEz+ps2g78yU=;
        b=fGk4MAyqy/0Z0V34JHDb08UTal4uZEJXy/ADsc4HYV/jmDo9UdphDsgi/DWgN0pjX4
         oMqk8SgtG1nrWR2ZxLUN0KHqEsezz63xhU08Ohyr8tjBzKoNBqnDUPkrsJC0SGZ/xSV7
         +x62UNoutFDBaTMqaoCAB01xM7LZyisKDBM3NSjLLzulywrhlo1yPQT5D2vENNCm0PWx
         IL+xgf2xFWMpkJVsbkSL8h/NuhPCJbiuLOf2fJ7UqMvlfT72e/23SqfQHcQCY9DiJ04z
         j+Sqwxm8TrSkOO4w7WtBY9PLwHLVhUoucR5k1oOSW6CPJcjQLdgNCKGUPEGOTS7uXbUg
         /8Lw==
X-Gm-Message-State: AOAM533cfG2tf7dR2aYqlS6DiwcyhpJVZM8tjfZ4Z/0Fp9q3iCr6OzI7
        7YsTty+zMwvxkk+UBkWsHHRXQw==
X-Google-Smtp-Source: ABdhPJyFnrCQ63UYWsWdIVntYuP7YvJFdaF08GSZvaAN1C8w70OlxJOprKmL15JsdS3e07d3SHvEFg==
X-Received: by 2002:a05:6a00:2352:b0:40b:2031:4827 with SMTP id j18-20020a056a00235200b0040b20314827mr17280299pfj.6.1630948752993;
        Mon, 06 Sep 2021 10:19:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d200sm8208350pfd.127.2021.09.06.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 10:19:12 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:19:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
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
Message-ID: <202109061013.E4730B3B42@keescook>
References: <202109022012.756B6B5B79@keescook>
 <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org>
 <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
 <202109051123.11E4E31@keescook>
 <20210906114350.GB4309@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906114350.GB4309@sirena.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 06, 2021 at 12:43:50PM +0100, Mark Brown wrote:
> If you're looking for coverage on this stuff it's also good to check
> with clang as well, it's sufficiently different that it often triggers
> extra stuff [...]

Yup, I tested across multiple GCC and Clang versions, which is
why the failures came as such a surprise. And specifically, these
overflow changes have been designed with Clang in mind (as well as GCC
obviously). (i.e. see the patch[0] in this series, and the last patch[1]
in the coming series.)

-Kees

[0] https://lore.kernel.org/lkml/20210822075122.864511-17-keescook@chromium.org/
[1] https://lore.kernel.org/lkml/20210818060533.3569517-64-keescook@chromium.org/

-- 
Kees Cook
