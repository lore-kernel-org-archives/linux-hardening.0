Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D43DC433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 15 Jan 2022 03:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiAODuu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Jan 2022 22:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiAODuu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Jan 2022 22:50:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C01C061574
        for <linux-hardening@vger.kernel.org>; Fri, 14 Jan 2022 19:50:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e8so1155588plh.8
        for <linux-hardening@vger.kernel.org>; Fri, 14 Jan 2022 19:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glwqqOEdn91POaZx9czNGi+z/EIMYXyhx0ZODvWOkR0=;
        b=PXUM6ip1gn1+Z5jW8swrOLF3BV9itUCEcLYQCp2orcK9jlHRTk3DxMwbP1tpEoV8cM
         OFw2h/5ar5N+aZNXlFTMqh6v4aXrZYK2X6tWvJECiz81Gi4v9qKd/dIO6eQ0KiGWpTef
         +hkdnHieyMv2NqxMz8B9Kz3n90NaG333FbQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glwqqOEdn91POaZx9czNGi+z/EIMYXyhx0ZODvWOkR0=;
        b=dCp5DiO1OV50uP2nEcn2nejKLHkJD5hjAvy6ioKvNFvLf6lNFe6iHxyKVV4nwAhJDP
         dsJ3xPN696sTNxPsT96L0eLDdkdrgsbd/uDOdZeJEHSf81utxZWhlX6zDsSb6yJP6vuJ
         gIDKyZXSh5S9lDqihfVu7OLxUpNTILqOqZYNUAk6hCdfmJzF2aW25wWbmlv9cYVb3bH7
         BpRAe+hmv7jawIfIAgGAtmyUO/AF6HJ/XoWC2NNs3UY4+yijVA6Oy0i1yjtbwjo+jVVu
         g8pgdUholES5tg/HWdVrK2ORwurfrNXl9HX9TdoEM0DqzRaivWhfA+PNDE78/0XDT6ed
         JIbA==
X-Gm-Message-State: AOAM5312wdRsGCbzcihMn+11/ubkZ3HHlF2/fo/YAtZVA0oX9StvwAbc
        HV8B4X3F/FIStyQ/lU2C6cefsg==
X-Google-Smtp-Source: ABdhPJxT6ZBYuQcmSXlrAijE8o8SdFMgz49AbsQ0GuEiNixlYic8K09k0PM5BtkBV5vPPez4AxqUVw==
X-Received: by 2002:a17:90a:bb86:: with SMTP id v6mr23685422pjr.152.1642218648520;
        Fri, 14 Jan 2022 19:50:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm11628101pjq.7.2022.01.14.19.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 19:50:48 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:50:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <202201141935.A3F2ED1CF@keescook>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
 <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
 <20220111101425.7c59de5b@rorschach.local.home>
 <Yd/ugQ8kUmcceuex@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd/ugQ8kUmcceuex@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 13, 2022 at 10:18:57AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 11, 2022 at 10:14:25AM -0500, Steven Rostedt wrote:
> > On Tue, 11 Jan 2022 12:30:42 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > > >  	if (unlikely(!deref_curr_numa_group(p))) {
> > > > > > -		unsigned int size = sizeof(struct numa_group) +
> > > > > > -				    NR_NUMA_HINT_FAULT_STATS *
> > > > > > -				    nr_node_ids * sizeof(unsigned long);
> > > > > > +		unsigned int size = struct_size(grp, faults,
> > > > > > +						NR_NUMA_HINT_FAULT_STATS * nr_node_ids);    
> > > > > 
> > > > > Again, why?! The old code was perfectly readable, this, not so much.  
> > > > 
> > > > Because it is unsafe,  
> > > 
> > > Unsafe how? Changelog doesn't mention anything, nor do you. In fact,
> > > Changelog says there is no functional change, which makes me hate the
> > > thing for obscuring something that was simple.
> > 
> > If for some reason faults changes in size, the original code must be
> > updated whereas the new code is robust enough to not need changing.

I think this alone is reason enough. :)

> Then I would still much prefer something like:
> 
> 	unsigned int size = sizeof(*grp) +
> 			    NR_NUMA_HINT_FAULT_STATS * numa_node_ids * sizeof(gfp->faults);
> 
> Which is still far more readable than some obscure macro. But again, the

I'm not sure it's _obscure_, but it is relatively new. It's even
documented. ;)
https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

That said, the original patch is incomplete: it should be using size_t
for "size".

> It is a fairly useful and common pattern to have a small structure and
> an array in the same memory allocation.
> 
> Think hash-tables, the structure contains the size of the table and some
> other things, like for example a seed for the hash function or a lock,
> and then the table itself as an array.

Right, the use of flexible arrays is very common in the kernel. So much
so that we've spent years fixing all the ancient "fake flexible arrays"
scattered around the kernel messing up all kinds of compile-time and
run-time flaw mitigations. Flexible array manipulations are notoriously
prone to mistakes (overflows in allocation, mismatched bounds storage
sizes, array index overflows, etc). These helpers (with more to come)
help remove some of the foot-guns that C would normally impart to them.

> I can't, nor do I want to, remember all these stupid little macros. Esp.
> not for trivial things like this.

Well, the good news is that other folks will (and are) fixing them for
you. :) Even if you never make mistakes with flexible arrays, other
people do, and so we need to take on some improvements to the robustness
of the kernel source tree-wide.

-Kees

-- 
Kees Cook
