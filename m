Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73475C433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Oct 2021 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523DC61019
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Oct 2021 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJHQTV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229896AbhJHQTV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Oct 2021 12:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8CaDxS3ZxSSQU+iGhFbf89kwNPmHoSD1YG/GilwFS8=;
        b=MPJCIuBfRJFxdEeSKix14lm8blSJ1fkUKXjPbImU3zJQ/LOSzh4PkcXMmTrbEfLdvKMPm5
        ZeCZQV4k76CBZG6vXAZmw+JrDj039m9TDvAlKJ9rau0rqWSeUxTlgfX933R+Qyn4wi2bsg
        c1dTUUX789bt86HuspIGIpYD5a3Ln3c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-NYDur-YBNyW_XQ2OHYCxRA-1; Fri, 08 Oct 2021 12:17:14 -0400
X-MC-Unique: NYDur-YBNyW_XQ2OHYCxRA-1
Received: by mail-qt1-f199.google.com with SMTP id t9-20020a05622a180900b002a71f83a1cdso8072494qtc.17
        for <linux-hardening@vger.kernel.org>; Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8CaDxS3ZxSSQU+iGhFbf89kwNPmHoSD1YG/GilwFS8=;
        b=tZgW9y3aRt08yqk6yvsJu4JmKrZtnadKSnONDkr0CZMZzzPVGbvflI2rA0WVWVV1TT
         KU4TZgxazOWUdgnm3MxBMAP2llJAOwMJepMwmNAm+xXfwcd/YPYfZ9l35yscR/JY/nGC
         pZLoEKI1X9B8blfJ8p705geDxwIjI441wNvVV0gMISrsJeqs5wMCpp3F+jNFAJsyZbFl
         KVv2virt5YKCPy3kFYCyIvka520mB9HGpJXPOzY3BunfrCnJsZ0dHSvjrmOjG6G+sprX
         BYBJ83D5ux02hbQ7yvhCi1BZMPz9tITwzNjW6K3G/GKCL+GinVWbvli9qCcANdgq4nn9
         WA4w==
X-Gm-Message-State: AOAM533aXIkS6aHIvgdxcRLAScU16OeG7HsHsmik5PwAkoGdm9P1610D
        Fq0YEjuPJejW1WGDWM0VsDyUNu2gyvttI6wmkMp2cgwvKe+7Wc3HTIKj+1T1uNhrU2rOyEbTAaR
        N57PZFIBNF7/dPz4N5G0jMc5gZsdY
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr9523297qvv.30.1633709834201;
        Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6ExCuEMbasm/gLwW//wQY0/4UCLYUOl4ssvLqUvFOcMjFiAJy1vmJaiafPCJcjnPk3KtghQ==
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr9523255qvv.30.1633709834017;
        Fri, 08 Oct 2021 09:17:14 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id p19sm2730266qtk.20.2021.10.08.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:17:13 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:17:07 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, keescook@chromium.org,
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
Message-ID: <20211008161707.i3cwz6qukgcf4frj@treble>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> > stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
> > told it to via skipnr, because I'd expect that
> 
> It's what most archs happen to do today and is what
> stack_trace_save_tsk() as implemented using arch_stack_walk() does.
> Which is I think the closest to canonical we have.

It *is* confusing though.  Even if 'nosched' may be the normally
desired behavior, stack_trace_save_tsk() should probably be named
stack_trace_save_tsk_nosched().

-- 
Josh

