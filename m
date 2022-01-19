Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F96C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jan 2022 19:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiASTBi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiASTBi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jan 2022 14:01:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA0C061574
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 11:01:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so7107008pjj.4
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nnXdclxtwo8kug9xsiXZGzqrqIG9VlNEk6H+ZSlfrgY=;
        b=fbVCXUVMVjmFbOu3aJkxKVjM4o3W1lCX4t8iTfXH7YIe1N+9muwxo/g+Shdy/L//Oi
         UYcIQw1Fzh5GREOPexJ5m1I5TveOkc0Tc8n73RW15SzUkuTdvznNTRwnUa8rCA4B2aHU
         97gX7VTGEl3/znrbrWOSaisKMURWT86qs/SB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nnXdclxtwo8kug9xsiXZGzqrqIG9VlNEk6H+ZSlfrgY=;
        b=gTqAhxVfywK48D5n0cpaBcwlBSsJDLrtK2Lhv5Vp/vGLgMCQ4hMArxWJ/uQavGr4Sq
         plA7EJYiZPm/wrydfguD4sgh7eZxY0MXkrBNHyesiLUsbH9ioJTBOdWLd9tD3mEU+G54
         Gbp8d5Ed8BsMKeS77w4mfX+3Tf5EKaBykV7mvYEJvtxhJsJV3tJUu+StiA1loO6OEzRC
         6OWiZwymATMdFLuJZALXzlUzGGC5NvtHZEqR8lfF+FLb5OF4xNSzLaUWFvA8oZNPCp6n
         1rGPMsc4Ie+FMaLrLShLf3pjgQI5mz8+TwoUBZy8S/37orRPk9PNzpL4iVLmwdl8eYPx
         fEwA==
X-Gm-Message-State: AOAM530aWYdtaz1Kg67ofCwYpD1gFOyE+Xt+HvWWXihcb95OsKsI2bAu
        yjGU97yTmv0GBD93XRL1GhdzLA==
X-Google-Smtp-Source: ABdhPJyOcsSg3W+RSjgAWuAteuR2ceGEMAm2W1rpFakq7uK5lf6Ou6wXyI5YbzdeSRcSjhVi7c9pww==
X-Received: by 2002:a17:902:70c3:b0:149:a78f:54ea with SMTP id l3-20020a17090270c300b00149a78f54eamr33517021plt.114.1642618897432;
        Wed, 19 Jan 2022 11:01:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10sm418292pgr.5.2022.01.19.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 11:01:37 -0800 (PST)
Date:   Wed, 19 Jan 2022 11:01:36 -0800
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
Message-ID: <202201191057.FAEAF1F94@keescook>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
 <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
 <20220111101425.7c59de5b@rorschach.local.home>
 <Yd/ugQ8kUmcceuex@hirez.programming.kicks-ass.net>
 <202201141935.A3F2ED1CF@keescook>
 <YeaBCYiTM/mxtBDU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeaBCYiTM/mxtBDU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 18, 2022 at 09:57:45AM +0100, Peter Zijlstra wrote:
> On Fri, Jan 14, 2022 at 07:50:47PM -0800, Kees Cook wrote:
> > On Thu, Jan 13, 2022 at 10:18:57AM +0100, Peter Zijlstra wrote:
> 
> > > Then I would still much prefer something like:
> > > 
> > > 	unsigned int size = sizeof(*grp) +
> > > 			    NR_NUMA_HINT_FAULT_STATS * numa_node_ids * sizeof(gfp->faults);
> > > 
> > > Which is still far more readable than some obscure macro. But again, the
> > 
> > I'm not sure it's _obscure_, but it is relatively new. It's even
> > documented. ;)
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> I'm one of those people who doesn't read documentation, I read code.
> 
> I also flat out refuse to read any documentation that isn't plain text.

Sure, which is why it's in the tree:
Documentation/process/deprecated.rst

> 
> > > I can't, nor do I want to, remember all these stupid little macros. Esp.
> > > not for trivial things like this.
> > 
> > Well, the good news is that other folks will (and are) fixing them for
> > you. :) Even if you never make mistakes with flexible arrays, other
> > people do, and so we need to take on some improvements to the robustness
> > of the kernel source tree-wide.
> 
> But nobody helps me read the code when I trip over crap like this :/ Why
> do we have to have endless silly helpers for things that can be
> trivially expressed in regular C? I appreciate things like
> container_of() because if you write that out it's a mess, but this, very
> much not so.
> 
> 	struct_size(grp, faults, NR_NUMA_HINT_FAULTS_STATS * numa_node_ids);
> 
> vs
> 
> 	sizeof(*gfp) + sizeof(grp->faults) * NR_NUMA_HINT_FAULT_STATS * nr_node_ids;
> 
> The latter wins hands down, instantly obvious what it does while with
> the former I'd have to look up the macro.

One of the drivers is general robustness. The open-coded version can
have bugs slowly drift in, especially with the sizeof() ends up naming
a structs like:

 	sizeof(struct object) + sizeof(struct element) * NR_NUMA_HINT_FAULT_STATS * nr_node_ids;

One of the points of struct_size() is to include the semantic sanity
checking that the compiler can do (i.e. making sure "faults" is a member
of "grp", correctly sizing them both, avoiding overflows, etc, etc).

I know what you mean about not liking looking up new macros, but given
C's fragility in these areas, it's been important for us to swap stuff
out shift the burdens to the compiler as much as possible.

-Kees

-- 
Kees Cook
