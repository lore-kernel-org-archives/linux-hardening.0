Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC0C433B4
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Apr 2021 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63F1610C9
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Apr 2021 21:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhDBVXy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbhDBVXx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Apr 2021 17:23:53 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1106C06178C
        for <linux-hardening@vger.kernel.org>; Fri,  2 Apr 2021 14:23:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3094227pjv.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Apr 2021 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=08HQieGvJ5s4z39bQ9/VIsRPK3KWDyfUJY19CVcTpoA=;
        b=ZZHUC404vOs5t/NKB0to6ybKeOuaagPe7GwEPz8E4aRbI9bzhmQ5eh2W3fmlGIAQ5G
         Zt/fFdSLqRat7R08DbmWJyelbPm9NoUFsXTYln4CMBO6HfJXssG1Hr1HTZiCoU7Zt5xd
         iPVcqhkNAIOTylk143rBaRMhzzLH4EjarZKoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=08HQieGvJ5s4z39bQ9/VIsRPK3KWDyfUJY19CVcTpoA=;
        b=fNONntVvnFg/jI2wOdCYd8fO+4AwG1TAfDJaPhZyamGvh3ArqMFvfwY72JsB5dnWGy
         EW1dPsS4MO9DTQehagPBFKbR4CU89ylRy1NLRgCVn4eAnfj4SiNRYeBpwBNWmyLK/AM9
         WV7F6vQ+XkrHUwJb0tI8zdi8kDk3+E2Vs8pheQ7QC7s5ZAalD0jlpgnwUA8HlVXNrGpv
         fEnmLg8NVmcv7DblWAc+0K2tMPz6bqQVJRjlUbrBfRFtgO4dGG3o88LHIrcldQJF/6Wh
         x9TH7J1xkD0SymE0EIsWD45B7FO3utevQ2/RL3iAhF7+Pk7PuZaY0ato3BF9xTwFZ/wy
         ReVw==
X-Gm-Message-State: AOAM530nS6KGAZFY11n8/ZP0o9T2gJlUSxZKycUmFDt3XbLzz/A7BbQY
        N951gOEm1mHteh+ees5Nr/yv8w==
X-Google-Smtp-Source: ABdhPJzh1TjlfwSjwK/4Uhusa5K7hvHNWHdJg95xMTE30zaT3vWl2AH09tOC2m+ie/IgJcGERoPLbw==
X-Received: by 2002:a17:90a:420d:: with SMTP id o13mr15596212pjg.61.1617398631259;
        Fri, 02 Apr 2021 14:23:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3sm8999011pfg.176.2021.04.02.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 14:23:50 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:23:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 3/3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <202104021421.97A06AE@keescook>
References: <20210401221320.2717732-1-keescook@chromium.org>
 <20210401221320.2717732-4-keescook@chromium.org>
 <20210402063221.GA5260@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402063221.GA5260@lst.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 02, 2021 at 08:32:21AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 01, 2021 at 03:13:20PM -0700, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile
> > (seq_get_buf() should not be used outside of seq_file), as seen with
> > some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that will
> > catch and stop linear overflows. This seems justified given that sysfs's
> > use of seq_file almost always already uses PAGE_SIZE allocations, has
> > normally short-lived allocations, and is not normally on a performance
> > critical path.
> 
> This looks completely weird to me.  In the end sysfs uses nothing
> of the seq_file infrastructure, so why do we even pretend to use it?
> Just switch sysfs_file_kfops_ro and sysfs_file_kfops_rw from using
> ->seq_show to ->read and do the vmalloc there instead of pretending
> this is a seq_file.

As far as I can tell it's a result of kernfs using seq_file, but sysfs
never converted all its callbacks to use seq_file.

> > Once seq_get_buf() has been removed (and all sysfs callbacks using
> > seq_file directly), this change can also be removed.
> 
> And with sysfs out of the way I think kiling off the other few users
> should be pretty easy as well.

Let me look at switching to "read" ... it is a twisty maze. :)

-- 
Kees Cook
