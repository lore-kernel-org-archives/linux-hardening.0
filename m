Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1ADC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60713611C7
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 18:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhJNSnw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhJNSnl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 14:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AafzswapDPTkg7dAS5SeXPSsZy6CJIYT17ewfhavBbM=;
        b=cEnTh4YLIHUMXZ/jjvr+bGGnTZ6k3i9mn92HSWnu2zsmlgvf/gWVLAZfwtuaS/JVU4iW0o
        Vsn1QDKoxjx6HPse3DDhTa2D5ZgyxVYaSxFPQ+z67zIJrOgwDzCQ+gb1QZgRRuSN2p6oex
        t4Bmz4oI8hdGg16fHTyBwPMJExBkLws=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-003XwtN5P9uB4b0mEQvVeQ-1; Thu, 14 Oct 2021 14:41:32 -0400
X-MC-Unique: 003XwtN5P9uB4b0mEQvVeQ-1
Received: by mail-qv1-f72.google.com with SMTP id 4-20020a05621420a400b003831d93e2b5so6333443qvd.12
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 11:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AafzswapDPTkg7dAS5SeXPSsZy6CJIYT17ewfhavBbM=;
        b=cQGmmPwP/CMNi/v6bWY6UuM830cvLSM9ki/XVpskkvPo/GBISYFu6ObXwiZMc19oZF
         huSlvMHiKCbWLUMKIIiTraGE6puQxvwg7wgT9H/C4iZFrTjckojqRKZ2yHLtLF9hiTxM
         D4t9LhJpd32SV48p9zCdO+tUH6lU/EbIbKxmdOa9rm/z8SplCRs9wfMN9al1h20hWIKn
         010wpGKE6xvSz1GeAG38VEm3XKhAHLOgQA989L1fnCJGGBmWwfuF1CGA/B1xV7g7+xCa
         9Yw2hRhXP5h1P29kISUkVJ38nlsBcw5ZeIyyOlJansgyMAPXwx7iIugK8HEs7urx4CjE
         QbkA==
X-Gm-Message-State: AOAM532/xduBt0jff3rZUA01umCXLETNmRm+7/v8G6JP9Qd70LS+jPfh
        2oUsG2YjgDCTk0b6EUFq490ULkKDut9v8EgvnItrgVUFAijf09ZII/IfsnZ/+WTMUikM6zXjcg2
        NX1WthUvQaeUusnWqavz6tZZrsmkf
X-Received: by 2002:a05:622a:148d:: with SMTP id t13mr1305799qtx.393.1634236891940;
        Thu, 14 Oct 2021 11:41:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygjoXS46jv87A7o06lSdoC2FnrbnpPOHamvT2pDm+KpgKrYNPS45xs+2q6vSVC0kHBygMcKw==
X-Received: by 2002:a05:622a:148d:: with SMTP id t13mr1305732qtx.393.1634236891674;
        Thu, 14 Oct 2021 11:41:31 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id h14sm1823421qkn.4.2021.10.14.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:41:31 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:41:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        jannh@google.com, linux-kernel@vger.kernel.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, vgupta@kernel.org,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, jonas@southpole.se, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, hca@linux.ibm.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <20211014184125.4qu7lih6uwvx35qs@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
 <20211008161707.i3cwz6qukgcf4frj@treble>
 <20211014180738.GC39276@lakrids.cambridge.arm.com>
MIME-Version: 1.0
In-Reply-To: <20211014180738.GC39276@lakrids.cambridge.arm.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 14, 2021 at 07:07:38PM +0100, Mark Rutland wrote:
> On Fri, Oct 08, 2021 at 09:17:07AM -0700, Josh Poimboeuf wrote:
> > On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > > > stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> > > > told it to via skipnr, because I'd expect that
> > > 
> > > It's what most archs happen to do today and is what
> > > stack_trace_save_tsk() as implemented using arch_stack_walk() does.
> > > Which is I think the closest to canonical we have.
> 
> Ah; and arch_stack_walk() itself shouldn't skip anything, which gives
> the consistent low-level semantic I wanted.
> 
> > It *is* confusing though.  Even if 'nosched' may be the normally
> > desired behavior, stack_trace_save_tsk() should probably be named
> > stack_trace_save_tsk_nosched().
> 
> I agree that'd be less confusing!
> 
> Josh, am I right in my understanding that the reliable stacktrace
> functions *shouldn't* skip sched functions, or should those similarly
> gain a _nosched suffix?

Correct, the reliable variants need to see the entire call stack and
therefore they shouldn't skip sched functions.

-- 
Josh

