Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19057C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB7760E78
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 18:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJNSuu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231202AbhJNSuk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 14:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634237315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=390oXOAx8xu4/KUEBxfvh8/zjlryT8/NcisAwMW9dms=;
        b=YT0IGGUa/SpTFtGwJHq5kMZo70pkSDohvspPt2rcHKl2Rdn3lq3CEAMk+QMjHfOTI+j4jr
        z6MHOL6UROLm/CgXtUuxqcOBqCcogGOZVsOKKe2xEIFrv4B8zSQ/T6JP2ejpAKNhdVrMnm
        nn9bSO3pLOlIEVBCEeveJOiMjlpnVfc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-tgZ_kCVYOKeKh9GIvnmroA-1; Thu, 14 Oct 2021 14:48:32 -0400
X-MC-Unique: tgZ_kCVYOKeKh9GIvnmroA-1
Received: by mail-qt1-f198.google.com with SMTP id w12-20020ac80ecc000000b002a7a4cd22faso2008558qti.4
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 11:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=390oXOAx8xu4/KUEBxfvh8/zjlryT8/NcisAwMW9dms=;
        b=W6jtgWKclIB6Mh8AjDK6z/29Ho9eSaY0CLGQkESv94btda0PvpCM3gbtGFD3EqupoU
         IygTmBwwQ6fyHxf5UTasYQM9TnbYRQ2XrwYxlSygbEZxstNMi3xewZzdImAZSpzpHfWE
         4TxQkJRiLFoq563WOpAzWXJXzkXYUVsMnc/x9wQKdm9U0inOu0+dgLUsF/aWDv/8cplc
         zM7VkfT/3/k7Dzr833q/vbGDNBIbmUAJ51TzNnCgalPqiUVxuORe2pg41Hkb3TsRlzRm
         wfQrENh12dUOIko1J8nbuQLbYUhyaGh15/hBbHGNyLGm2wfp0M+eW1RbZjyTApQ4R48w
         XsNQ==
X-Gm-Message-State: AOAM533yRIaR7FKXijmpRTHQbAHZDNtj+rCEVCpq5LOMFWl2bh9lAwgf
        ZVg9CSx6veHgJriaE3N7zGrobBOXWunxQPRbEundy2/CI+NUFiG4e3ah4eNFPB6oooUIdfrUYR6
        zdzZmhUeOhH7vkVRHuGnKp5DJ9yOR
X-Received: by 2002:a37:c90:: with SMTP id 138mr6072549qkm.255.1634237311720;
        Thu, 14 Oct 2021 11:48:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytP+DvZn3EfxUM7dsxKpelaHBNmMC9oJwTycXxdHYSXFOFWt9jMdlMXSlEI0NyE7E7s7Jegg==
X-Received: by 2002:a37:c90:: with SMTP id 138mr6072528qkm.255.1634237311500;
        Thu, 14 Oct 2021 11:48:31 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id g5sm1601735qkm.112.2021.10.14.11.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:48:31 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:48:25 -0700
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
Message-ID: <20211014184825.2vre4bt3fojcfdka@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
 <20211014180307.GB39276@lakrids.cambridge.arm.com>
MIME-Version: 1.0
In-Reply-To: <20211014180307.GB39276@lakrids.cambridge.arm.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 14, 2021 at 07:03:07PM +0100, Mark Rutland wrote:
> On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 08, 2021 at 01:40:52PM +0100, Mark Rutland wrote:
> > > [Adding Josh, since there might be a concern here from a livepatch pov]
> > > 
> > 
> > > > +static unsigned long __get_wchan(struct task_struct *p)
> > > > +{
> > > > +	unsigned long entry = 0;
> > > > +
> > > > +	stack_trace_save_tsk(p, &entry, 1, 0);
> > > 
> > > This assumes stack_trace_save_tsk() will skip sched functions, but I
> > > don't think that's ever been a requirement? It's certinaly not
> > > documented anywhere that I could find, and arm64 doesn't do so today,
> > > and this patch causes wchan to just log `__switch_to` for everything.
> > 
> > Confused, arm64 has arch_stack_walk() and should thus use
> > kernel/stacktrace.c's stack_trace_consume_entry_nosched.
> 
> Looking at this arm64's *current* get_wchan() unwinds once before
> checking in_sched_functions(), so it skips __switch_to(). As of this
> patch, we check in_sched_functions() first, which stops the unwind
> immediately as __switch_to() isn't marked as __sched.
> 
> I think x86 gets away with this because switch_to() is asm, and that
> tail-calls __switch_to() when returning.
> 
> Does switch_to() and below need to be marked __sched?

Yes, I would think so, for arches where they otherwise show up on the
stacktrace.

-- 
Josh

