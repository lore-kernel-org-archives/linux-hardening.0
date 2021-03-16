Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C29C433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Mar 2021 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8B96505E
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Mar 2021 19:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhCPTTE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhCPTSg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Mar 2021 15:18:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4153C061756
        for <linux-hardening@vger.kernel.org>; Tue, 16 Mar 2021 12:18:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t37so12456667pga.11
        for <linux-hardening@vger.kernel.org>; Tue, 16 Mar 2021 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kTFGaP3zw/Fu1Vu34NQdT6odvbGU01/j1hv611s2WEk=;
        b=g+XpbAbEV6nyFc0yI+iTSaDBcvjMUj6QK0H/YiwhY2fWmatsW6E/QWhrvhEbSt0qRI
         itfH+R+CErgok+kinhtw3NZbGKSpsjcaTAgf/tbECUhXtfZ62kPYd5tiy6vangOzXJSY
         kYYcfjoKK9Tw9V/fKsSE5iwsER9ubGUm/XI/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kTFGaP3zw/Fu1Vu34NQdT6odvbGU01/j1hv611s2WEk=;
        b=EDegmuZ/nrCaPD3ZrwzomntOh2PKMliSGA6uN3Crfywi4//RovUZzGCr3DsbbTIWcQ
         oSaC3T4kjYxUMLEdIsSUUhk16YshFK6wkB9LmKb3b/idi2jLoIpH5i6CjSexTH2MwH1L
         N83nWWnpthHJXw5n45zXMyPaEAzGirtijcJ0SjQdzRg6AVuuoCh8QVhjhB0MCwBLmzdw
         Wa4hfpY9CnTiTTHsRFDbwR7CftO4dJRe0T3I2d3Ty1bdTvKSb9J9LMz14cSjP1g3GV1/
         PW5V7o08/IEZvvI30rom0UGmQdpyfD/qo1/VvKJ0TIN6cQK4B3JKswEHxPXhh6dRKLo8
         0n6w==
X-Gm-Message-State: AOAM531p3U1aDuiRYk211aDs2mryWhHonKpHnjGaK26p5PslYR3AORN4
        sqpI4DJLZ6hEtI/Lg5h9Z0N4yQ==
X-Google-Smtp-Source: ABdhPJwBczIEvob3FcudNUCo9qdlk3+Pv2lnIocMJV9rVeke6Yi6PDvwSg2ZOmChbIrhU5ZiKAaruA==
X-Received: by 2002:a65:6107:: with SMTP id z7mr1040368pgu.435.1615922315588;
        Tue, 16 Mar 2021 12:18:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm18421088pfk.92.2021.03.16.12.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:18:34 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:18:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103161208.22FC78C8C@keescook>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
 <202103151336.78360DB34D@keescook>
 <YFBdQmT64c+2uBRI@kroah.com>
 <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Mar 16, 2021 at 12:43:12PM +0000, Al Viro wrote:
> On Tue, Mar 16, 2021 at 08:24:50AM +0100, Greg Kroah-Hartman wrote:
> 
> > > Completely agreed. seq_get_buf() should be totally ripped out.
> > > Unfortunately, this is going to be a long road because of sysfs's ATTR
> > > stuff, there are something like 5000 callers, and the entire API was
> > > designed to avoid refactoring all those callers from
> > > sysfs_kf_seq_show().
> > 
> > What is wrong with the sysfs ATTR stuff?  That should make it so that we
> > do not have to change any caller for any specific change like this, why
> > can't sysfs or kernfs handle it automatically?
> 
> Hard to tell, since that would require _finding_ the sodding ->show()
> instances first.  Good luck with that, seeing that most of those appear
> to come from templates-done-with-cpp...

I *think* I can get coccinelle to find them all, but my brute-force
approach was to just do a debug build changing the ATTR macro to be
typed, and changing the name of "show" and "store" in kobj_attribute
(to make the compiler find them all).

> AFAICS, Kees wants to protect against ->show() instances stomping beyond
> the page size.  What I don't get is what do you get from using seq_file
> if you insist on doing raw access to the buffer rather than using
> seq_printf() and friends.  What's the point?

To me, it looks like the kernfs/sysfs API happened around the time
"container_of" was gaining ground. It's trying to do the same thing
the "modern" callbacks do with finding a pointer from another, but it
did so by making sure everything had a 0 offset and an identical
beginning structure layout _but changed prototypes_.

It's the changed prototypes that freaks out CFI.

My current plan consists of these steps:

- add two new callbacks to the kobj_attribute struct (and its clones):
  "seq_show" and "seq_store", which will pass in the seq_file.
- convert all callbacks to kobject/kboj_attribute and use container_of()
  to find their respective pointers.
- remove "show" and "store"
- remove external use of seq_get_buf().

The first two steps require thousands of lines of code changed, so
I'm going to try to minimize it by trying to do as many conversions as
possible to the appropriate helpers first. e.g. DEVICE_ATTR_INT exists,
but there are only 2 users, yet there appears to be something like 500
DEVICE_ATTR callers that have an open-coded '%d':

$ git grep -B10 '\bDEVICE_ATTR' | grep '%d' | wc -l
530

-- 
Kees Cook
