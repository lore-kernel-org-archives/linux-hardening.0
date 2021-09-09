Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD6BC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 22:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9669861104
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Sep 2021 22:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbhIIWwf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhIIWwf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Sep 2021 18:52:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A622EC061574
        for <linux-hardening@vger.kernel.org>; Thu,  9 Sep 2021 15:51:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bb10so2084827plb.2
        for <linux-hardening@vger.kernel.org>; Thu, 09 Sep 2021 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjfjoKfAyLUu17TUBmafdcx7ZjtKrPqEZ88OWOwwmOo=;
        b=FJ0sSwN5MzU3wz/mLMk/pJRqghJOwHE3n+7an1s3JLsGOce0TKvMypw99AWhb4jWnp
         O1pV5QBv2tuwzyMGfUK8NliQB6n13EeftXaAv7iDEhnapgYg/jallCkSqYJsW0zCsc+U
         ZGlmKtK3LUcyf6suaU0970vHr4G5pthcmO9cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjfjoKfAyLUu17TUBmafdcx7ZjtKrPqEZ88OWOwwmOo=;
        b=KnReDNGvIcyaeFtYDHg2Ek6iROMQfxwGEEP/hIzoJsAFvjOfyN6LNlIDQwoIh1BO8q
         /y45vdDxof10FEU6UvUg7xeNK5D/OJN29uaBG/JlB/2ExXvnXff1G5iEqJVrnzSVZOiP
         kkVdt9uS2kL5mo57QyO1U2XI3ay0xm+FO5CzsqOb3xuJjtoOZKTt4XUJ9T7gIbB2Urxc
         MbYC5XWLszcvju4zZnK1ucpyV0T1dYmaStifivRzcfir+cGj59tMTkeCJeC7wWc0m4b7
         WPMuJ0uHxpbmn/OZLYXxn7Wpvgt7U0Kow7Gcl793CQ1vvjv3QLfTxqNBDOHyHLiG5U6i
         BiIA==
X-Gm-Message-State: AOAM533QjWn0GftGGe63UD1aywXgur9YaIfpJNocLlsca6/d3pR4KoVj
        2rMGw/6Dzu7oUkNJu2R57MuUjA==
X-Google-Smtp-Source: ABdhPJxhhcd9zPLQvqtYq5i5kvuPYbI/YKkJ2K+K0w85jnCSHF1Rt/+xWEKm6txjrbKn/Xe6VSgyjQ==
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr5938225pjb.125.1631227885202;
        Thu, 09 Sep 2021 15:51:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm3481935pgk.57.2021.09.09.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:51:24 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:51:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-ID: <202109091549.FF8E0C61E2@keescook>
References: <20210909161409.2250920-1-keescook@chromium.org>
 <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 09, 2021 at 01:27:52PM -0700, Andrew Morton wrote:
> On Thu,  9 Sep 2021 09:14:09 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > GCC 9.3 (but not later) incorrectly evaluates the arguments to
> > check_copy_size(), getting seemingly confused by the size being returned
> > from array_size(). Instead, perform the calculation once, which both
> > makes the code more readable and avoids the bug in GCC.
> > 
> >    In file included from arch/x86/include/asm/preempt.h:7,
> >                     from include/linux/preempt.h:78,
> >                     from include/linux/spinlock.h:55,
> >                     from include/linux/mm_types.h:9,
> >                     from include/linux/buildid.h:5,
> >                     from include/linux/module.h:14,
> >                     from drivers/rapidio/devices/rio_mport_cdev.c:13:
> >    In function 'check_copy_size',
> >        inlined from 'copy_from_user' at include/linux/uaccess.h:191:6,
> >        inlined from 'rio_mport_transfer_ioctl' at drivers/rapidio/devices/rio_mport_cdev.c:983:6:
> >    include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> >      213 |    __bad_copy_to();
> >          |    ^~~~~~~~~~~~~~~
> > 
> > But the allocation size and the copy size are identical:
> > 
> > 	transfer = vmalloc(array_size(sizeof(*transfer), transaction.count));
> > 	if (!transfer)
> > 		return -ENOMEM;
> > 
> > 	if (unlikely(copy_from_user(transfer,
> > 				    (void __user *)(uintptr_t)transaction.block,
> > 				    array_size(sizeof(*transfer), transaction.count)))) {
> 
> That's an "error", not a warning.  Or is this thanks to the new -Werror?

This is a "regular" error (__bad_copy_to() uses __compiletime_error()).

> Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> older kernels will be a common thing down the ages.
> 
> If it's really an "error" on non-Werror kernels then definitely cc:stable.

I would expect that as only being needed if __alloc_size was backported
to -stable, which seems unlikely.

-- 
Kees Cook
