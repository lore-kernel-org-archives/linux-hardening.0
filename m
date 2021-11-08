Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132ABC433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 12:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E384D61288
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 12:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhKHMtE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbhKHMs4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 07:48:56 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C49C061746;
        Mon,  8 Nov 2021 04:46:07 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id u74so6173510oie.8;
        Mon, 08 Nov 2021 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wWmw8CpxE1JULoanBDa3pQJV3DV8dTWi3lLJNpSsNQ=;
        b=PnJ7OgB6sNR3or1vk7NLNefICfETsuDLpf+pH9Bi1Ht2Z5iU8FwP6ysJ6gNbGgmTE7
         sCJoObGIW5fXpfvP9meRhQpHdnIIzrgV2a58md1HUIWClESVzVcGcdHbAIaqx19XcHZ+
         GXlyOHV7xU/1PdtNpNEx+97YZqlVB8YwHZtiUWkLt4Wx5lsrhXXhopIXyhPa+nvWJeCy
         bTd9RX2RXaA94/jyAHIL5vXN0a9/XKcaATdyNlgVXly9Gmn0QeVPwMEORAjheGaNTCjE
         wL+gm8rH3Jv80YvwStzb3+HFkc9Dn0SCs29p8Chy5QzrwcURdwrcnZbVD9Hvr+hLH3Hc
         nKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wWmw8CpxE1JULoanBDa3pQJV3DV8dTWi3lLJNpSsNQ=;
        b=INNuoLsUmDlfyP0o4yqikj3IdbTj5i6YchNQFb9vfRkkGht2kceH+YsvEO4ql8lIAb
         1rRqZ6FRIV2b2eA2/vZWIEvh7KpFhvGClRz6G1omL4OxmTWpaIRlhPzSB+KbIuvDh3bC
         ui/1hg9TwnbmuOpJZRg5v+MiInjIkLXmaMS5ED6LJL+dV1doiguz97Q77PHMfEGDGhxb
         wR5QS3KWSQ5w4uD4IeAQ+fKRRQt2pDruJJcd/nB/MT2wwFs6bm+XE6PtLWefRdb/GICL
         Ks0r0XTxLEnCYMxXA2r3I8Ra70jiO+74Lcl3Twf59iEQgVP9+p/NQLiEbBI8LVMw1kxo
         ogQA==
X-Gm-Message-State: AOAM533EYrY0kkM43shHfuj+M8IVYjYL6gLyY9CN0XPfnfLn+nxHHE9R
        dDOnwtwvieuR1FYyAPO6BACpPzGjzH9zuvD0wMwOTpBCCWY=
X-Google-Smtp-Source: ABdhPJxJVo7LXK53XAwiGmKN8b7EH0BBprAFgrS8TGAuyuQNwTnPP16t1xNfPRYMbnYJlEbmWAToIkdBcuzt+YZMjHU=
X-Received: by 2002:a54:4499:: with SMTP id v25mr36945378oiv.71.1636375566432;
 Mon, 08 Nov 2021 04:46:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <YYkWb4GQAAtZJNsT@kroah.com>
In-Reply-To: <YYkWb4GQAAtZJNsT@kroah.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 18:15:54 +0530
Message-ID: <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andy@kernel.org, Kees Cook <keescook@chromium.org>,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Greg,

Thanks for your time.

>
> Wait, why?  We have recently added new string copy functions to resolve
> the type of issues you have pointed out.  The kernel is not yet
> converted to use them, so why add yet-another-function that also is not
> used?

Greg, would request your couple of minutes more, in suggesting a
concrete way forward, by working through an example as below.


In the file fs/kernfs/dir.c, there is a statement

        return strlcpy(buf, kn->parent ? kn->name : "/", buflen);

Here, there is no information of how long kn->name might be, so there
is a definite chance of overflow happening. Thus, accordingly, strlcpy
is used, to bound copying of upto buflen bytes. Of course, buf
(destination-buffer) is safe from any overflow now.

However, iffff strlen(kn->name) is greater than (buflen - 1), then
strlcpy would return a different value than the number of bytes
actually copied. Since there is no check, this (wrong) return value
will be propagated to the clients down the stack.


Now, in the current situation, following is the remedy :

########################################
        int ret = strlcpy(buf, kn->parent ? kn->name : "/", buflen);
        if(ret >= buflen)
            ret = buflen - 1;

        return ret;
########################################

Lines changed : 4



On the other hand, with the proposed new function strlscpy, the fix
would simply be :

########################################
       return strlscpy(buf, kn->parent ? kn->name : "/", buflen);
########################################

Lines changed : 1


Personally, as a "generic third-party", I would prefer investing my
time which makes lives of everyone - present and future - easier, so
the RFC for the new method is a step in that direction. This new
method would reduce effort from 4-lines-change to 1-line-change.



>
> I think you should work with the functions we have _first_ and help
> convert the kernel to use them, before adding another one please.
>

I tried looking a similar function in lib/string.c, but could not find any.
If there indeed is already a function that behaves like the new
intended method, kindly point me to it, case would be closed
immediately :D


Once again, many thanks for your time.


Thanks and Regards,
Ajay
