Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A5FC49EA6
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Jun 2021 06:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A921A6193D
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Jun 2021 06:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFZGPM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Jun 2021 02:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFZGPM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Jun 2021 02:15:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F5C061766
        for <linux-hardening@vger.kernel.org>; Fri, 25 Jun 2021 23:12:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so9278986pjb.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Jun 2021 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3D1KelqTQqcByU+iX/g4zMb1AQ1QyzDSkN4oTccG6E=;
        b=dPYF37dHsGEYSEl9eqOPnMnSYV23hgoNW6zFFCEdWj5Q1w4OSIZ374aV2gk9AR51sH
         4QhogOUV0JirtFhghh4Sx4J7XwTYVMRFXKsFzP6gdNmxkPDTn6w8BfKYRi8dFTN6JbSf
         hBlzTMo6KZE2D3sg78jc5Rf9MdUxh59Adb2yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3D1KelqTQqcByU+iX/g4zMb1AQ1QyzDSkN4oTccG6E=;
        b=ZSPcL3NvJifwOv9SAsL8gQKFOcicbMDAsYcKOCU6v3pVh7F/mdLzFS5eseihviGifV
         FqDUCCBzIgZ8YVxVFPJ1mne918KMY5oIlI1ysJutP44SY0pU/abj3LrLi5DmYR2qtU3r
         FiGDBwQseaxXqGTV7y1EC1jhnjT/YfSnW/m5I6Zrz+yNKmgtSuEKGUNwPyZR5+7DNm3u
         RsTA802ZvTvF6RjQESWDOKLzQwC2cNdRWTiI2+eY2xIS8jw0FgNCWpIKTPTz9bUg6Q6O
         fHfFj+VNWHBtg+01uxu3kQ30MvW8y3vdizpkVtmgKeGlWQ0MR5LAm5JTvjOZ+Ap1+f/t
         NxWw==
X-Gm-Message-State: AOAM532Jbssv3ZAT8lA2nkxY/jE8NLCLApAoLt7WJ8QQCO/SsFkjY+8d
        FY8mFe1vEJRZ4AnSLmI73KdJjOxH6kmwhg==
X-Google-Smtp-Source: ABdhPJyf87SbQDubTJ9J8aMC+55dXrh4eLcutSx+3zpg0JmnRltlhc687c4pmI8apq44mFLXSlbVNQ==
X-Received: by 2002:a17:90a:194a:: with SMTP id 10mr24743998pjh.188.1624687968729;
        Fri, 25 Jun 2021 23:12:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm7895781pgj.11.2021.06.25.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:12:47 -0700 (PDT)
Date:   Fri, 25 Jun 2021 23:12:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 0/9] LKDTM: Improvements for kernelci.org
Message-ID: <202106252311.14501F2F@keescook>
References: <20210623203936.3151093-1-keescook@chromium.org>
 <030c022b-985a-16eb-b9d7-73b6fed2d5a9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030c022b-985a-16eb-b9d7-73b6fed2d5a9@collabora.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jun 25, 2021 at 07:22:01AM +0100, Guillaume Tucker wrote:
> On 23/06/2021 21:39, Kees Cook wrote:
> > This is a bunch of LKDTM clean-ups to improve and expand testing,
> > given feedback from testing at kernelci.org. Adds a few new tests as
> > well.
> > 
> > (If a pull-request is preferred, please let me know.)
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > Kees Cook (9):
> >   selftests/lkdtm: Avoid needing explicit sub-shell
> >   selftests/lkdtm: Fix expected text for CR4 pinning
> >   selftests/lkdtm: Fix expected text for free poison
> >   lkdtm/bugs: XFAIL UNALIGNED_LOAD_STORE_WRITE
> >   lkdtm/heap: Add vmalloc linear overflow test
> >   lkdtm: Enable DOUBLE_FAULT on all architectures
> >   lkdtm: Add CONFIG hints in errors where possible
> >   selftests/lkdtm: Enable various testable CONFIGs
> >   lkdtm/heap: Add init_on_alloc tests
> 
> Tested-by: "kernelci.org bot" <bot@kernelci.org>
> 
> 
> This whole series was tested on top of next-20210623, here are a
> couple of sample results from KernelCI staging:
> 
> Clang 13 on AMD x86_64:
> https://staging.kernelci.org/test/plan/id/60d4a5ce3d2bc535d924bf25/
> 
> GCC 8 on Intel x86_64:
> https://staging.kernelci.org/test/plan/id/60d570711a3d6beefe24bf26/
> 
> And this is where the series was applied:
> https://github.com/kernelci/linux/commits/a9f4387015268e426c77fd51ed846c9756938828

Fantastic! Thanks; this looks great. :)

-- 
Kees Cook
