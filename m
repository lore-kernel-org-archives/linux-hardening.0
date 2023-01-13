Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D1DC54EBD
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 00:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjAMAKO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 19:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjAMAKL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 19:10:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241D03FCBD
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 16:10:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so25302936pjk.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m558AEdE45qMXdg2bJU8lbo179NdMTzjDa4ERbyUbPw=;
        b=AL+s1vQ0wXLSI9aB6Ff4VgU5o4RTOd5NOq7D9sj7iGu5fRi5zKS1CisijMs8mYM93g
         0qH6nOlnNwsVdISBeQzY+rzr+7wiGmASj7Tm6MliZeDntl4dl4bc+Psk+EkvGktwV7qh
         fbcO0Lz/2fS5CMFnAbcI1bDNK4xXaxUjoTIPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m558AEdE45qMXdg2bJU8lbo179NdMTzjDa4ERbyUbPw=;
        b=PiCRTJ/h/9R3t17e71cJuztaScZ3QgiC5OucrjB6CtOuO3wWUkOzbUvFExHWJ+j10p
         8s9YYEKMSEiC3Sev5y7851IB0+F3HiIG839fF6b2FI1Ox4b0YCNzBfbSMnP046247e+w
         spTf8oZszWeL30mEhTJsX2l+t+cT6+T6i/UoVT40GO1pHTV4E3p0mteZM0MBI6eYaqnF
         OZbYq0/8FrjpOkdvvtzALTG/SZ6QUIxgy/N/R23e0QP6u35/8KxnrzFIuxP8UcpUmh8t
         D3Unim/YnIJmkvz4jkFBhtMoFdIPE6zs/PqiTTa+9nsnovVT3mwNLsUwg5dLCXE4IdwB
         2wdw==
X-Gm-Message-State: AFqh2kpQTqrMy+BFn2mhgk4qBVx/rACiVsNDTtOBzGknymqLm61FsLNP
        +hF3CK2ySj4mWKZBiXw+9mzzmTtI7ha3eXLs
X-Google-Smtp-Source: AMrXdXu3aZnxy50sk6TH0l8rdJE+rdJUAfSDREBIAaf/5eA4yXCik67UK4H/rNh7rP28LStzG+5LSA==
X-Received: by 2002:a17:90b:378f:b0:219:ffc6:4040 with SMTP id mz15-20020a17090b378f00b00219ffc64040mr9363188pjb.38.1673568610632;
        Thu, 12 Jan 2023 16:10:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l13-20020a654c4d000000b00496317241f9sm10651271pgr.51.2023.01.12.16.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:10:09 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:10:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, kees@kernel.org, linux@roeck-us.net,
        vbabka@suse.cz, stable-commits@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: Patch "gcc: disable -Warray-bounds for gcc-11 too" has been
 added to the 6.1-stable tree
Message-ID: <202301121559.AE5064D@keescook>
References: <167352819915167@kroah.com>
 <202301121346.D33FD799E7@keescook>
 <CAHk-=wjq1jd4ht7RvB8HYDJFAH=dRQ+43-mj3LWMJReF4yu34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjq1jd4ht7RvB8HYDJFAH=dRQ+43-mj3LWMJReF4yu34Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 05:22:53PM -0600, Linus Torvalds wrote:
> But right now it seems a matter of "just by luck, we don't hit it
> anywhere else", and I'm not interested in playing any more
> whack-a-mole with this broken compiler option.

Okay, understood.

FWIW, I've been tracking these and getting reproducers so they can
get worked on. A few got fixed for GCC 12, and but not enough to turn
-Warray-bounds on there. More were fixed in GCC 13. So far, I'm aware
of these 3 getting fixed since we started trying to enable
-Warray-bounds:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101419

I recently reported 1:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108306

And these 3 are likely related, but for options we don't yet enable,
but seem to be internal issues with the value range handling (usually
when a sanitizer of one kind or another is enabled):

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97490
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101778

The powerpc issue hasn't been reported yet. It's my intention to do so
once I can get it minimized.

-- 
Kees Cook
