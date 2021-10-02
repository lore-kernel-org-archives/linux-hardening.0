Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE1C433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 21:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE9B61AEF
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhJBVon (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhJBVon (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 17:44:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0363C0613EF
        for <linux-hardening@vger.kernel.org>; Sat,  2 Oct 2021 14:42:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id np13so2642299pjb.4
        for <linux-hardening@vger.kernel.org>; Sat, 02 Oct 2021 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0FFjP0oMZpxRexvNkXdCYUTlS/H85H78Cl8QLMYAVqY=;
        b=lu/QAwQBpT03rq/VQqSlSsmAXa6QbEPOPpK95EFgVMjGjF7JAjrI9RiL1pn6ZotiKB
         g8/UamqqsiA5JdRLDR8CJ2qO1NoES6urk1/CRCn+M6s0ohwG4KegN2MXXtF2rSUgiiJo
         neebnm2figgIUrMXjkXgAD6IquiNvy+HfLBjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0FFjP0oMZpxRexvNkXdCYUTlS/H85H78Cl8QLMYAVqY=;
        b=wViku5+EFv3KsLb6ZDRL5pFQ2UHKHbZsr62ikhvpwakQQdmVkgQr7K0q/otjkAJ0KD
         ZXLXb8La4S4Jt+ceU+UZhSNIaQG4Pz2m1YcWhEG3ZjSKDoMAa3YoUgTkNsOp+d0OvyxW
         oBKmGkiKksRqmH25SENqLDC95aKpPY9qez5WjRfhQNnVde69VfT9VGpvJvVCc4aoefLT
         zOatFP47fe/QXACXCxDzoJe4rH5cBt04x+Oyp24I/RsBThot73uTEfgfrP020tlXerFS
         doYy9p/YuUx8bCEM1P8rDUlZbzf0OqBzgYrF8RQFBZzaO1OBuYQq9c9A6L9qvFHEtXGO
         KePA==
X-Gm-Message-State: AOAM532CPgoEvfDNdInDR7+jGwDsS8f+apfsnMijPqzDCDe3uRwtzPip
        PMLSySZN/xiQ5bKPkDYMdtQSlA==
X-Google-Smtp-Source: ABdhPJwHouZwwcQTL+3/hhpEg8o6JRvZfZmd3ySpA8bXdqKGb9wtZn+VEUaXyTMCYiTTh0fev9osyw==
X-Received: by 2002:a17:90a:588f:: with SMTP id j15mr28057348pji.177.1633210976114;
        Sat, 02 Oct 2021 14:42:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8sm10821655pjt.39.2021.10.02.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:42:55 -0700 (PDT)
Date:   Sat, 2 Oct 2021 14:42:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
Message-ID: <202110021441.C70D775A61@keescook>
References: <20210930235754.2635912-1-keescook@chromium.org>
 <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
 <YVf80rXg8Yd19Hmw@kroah.com>
 <9f262a81acffffb6e267d5832b29d8596d8046e2.camel@perches.com>
 <CANiq72m7gRxNmHUJb9jJ+JMiYHyMuNf6Yc1+7N87yz_RLc3atA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m7gRxNmHUJb9jJ+JMiYHyMuNf6Yc1+7N87yz_RLc3atA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 02, 2021 at 06:27:02PM +0200, Miguel Ojeda wrote:
> On Sat, Oct 2, 2021 at 5:22 PM Joe Perches <joe@perches.com> wrote:
> >
> > If automated scripts exist to change all the code to that new
> > 'one true way', it wouldn't be applied.
> 
> I think nobody is saying we should reformat all code at once, just
> that agreeing on a given style allows us to eventually automate it (it
> also makes humans more likely to be consistent).

I just want to know what style to use to not have it NAKed by Linus. ;)

But yeah, it might be nice to do style checking against the kernel some
day. We have a lot of weird stuff in here, though! *slaps roof of kernel*

-- 
Kees Cook
