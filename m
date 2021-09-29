Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57640C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3739B61390
	for <linux-hardening@archiver.kernel.org>; Wed, 29 Sep 2021 18:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbhI2S4j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346351AbhI2S4i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 29 Sep 2021 14:56:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18FC061765
        for <linux-hardening@vger.kernel.org>; Wed, 29 Sep 2021 11:54:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so2756721pjb.4
        for <linux-hardening@vger.kernel.org>; Wed, 29 Sep 2021 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8+uJcBBc/PF7ems2z5fw4m588jWE79HAklefzm/UZpA=;
        b=jUKnSXoA0hVODkS6t3osdG2XYk+v1gSULRVbnIZ9NcZh4ZpOliivKVPuRpp/UlzKhh
         AbAGzhdYgAFxFcXd7rtQC4jDpvDc26ThZ27hDgqIxJg/E3s6vOblrrvcj45Gi0/6cPpw
         q2WLquH9eoGvFWwMXjEu5YoLIYzPRTV+vvS4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+uJcBBc/PF7ems2z5fw4m588jWE79HAklefzm/UZpA=;
        b=Cmd10RClwJD4ARVrEwzd3w0NJTPjIJTxgUy+vCYGkbQOFnaoUkXVfEG2jN/FxLLH7H
         VtzSDpUp03+ITjphZ7OdN4pB2WVbQudDA+8YB/SFtdBYC6HgdFDT/tYWaKNGRu/k6POY
         fv0DnHUAvzm1RwioWCwumItNx+AFxVUyYVipcun2w+MWMY6VMHiV5m+IaTdAp3k1Y5/g
         NPw3HBfnkSF96opALwoiZHnXCvGGrWhjwEVNwOZBQitF43CynfSPSJVWznsnDbwj8bzk
         m32skJlZEwp8T2DdGHGROfmjPSXwI4M7uNitStV1BR4/nxsqG9VcSl8AwMzu3KEwQAqJ
         vYlA==
X-Gm-Message-State: AOAM532cJvFg/F57IFS1qwWDGH1qAckGM8PXE5U+sIKoLkXqjp/+Nccs
        a00+8W9zWi/yGzpB4bO3xJ2MK85d30vI7w==
X-Google-Smtp-Source: ABdhPJzMCh/F5SF+Yhv5xgUAe1RpRTKX6R9v+nOxJt1NfhIE0v6dfSR2DW4sq15+zE5QfL0u0Kpdvg==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr8095556pje.124.1632941697076;
        Wed, 29 Sep 2021 11:54:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c206sm480031pfc.220.2021.09.29.11.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:54:56 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:54:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109291152.681444A135@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927205056.jjdlkof5w6fs5wzw@treble>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 27, 2021 at 01:50:56PM -0700, Josh Poimboeuf wrote:
> On Mon, Sep 27, 2021 at 11:07:27AM -0700, Kees Cook wrote:
> > On Mon, Sep 27, 2021 at 10:03:51AM +0100, Mark Rutland wrote:
> > > On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> > > > On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > > > > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > > > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > > > > entrypoint address in the current task struct for get_wchan() to
> > > > > > > access, whenever userspace enters the kernel?
> > > > > > 
> > > > > > wchan is supposed to show where the kernel is at the instant the
> > > > > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > > > > always show syscall entry.)
> > > > > 
> > > > > It's supposed to show where a blocked task is blocked; the "wait
> > > > > channel".
> > > > > 
> > > > > I'd wanted to remove get_wchan since it requires cross-task stack
> > > > > walking, which is generally painful.
> > > > 
> > > > Right -- this is the "fragile" part I'm worried about.
> > 
> > I'd like to clarify this concern first -- is the proposed fix actually
> > fragile? Because I think we'd be better off just restoring behavior than
> > trying to invent new behavior...
> > 
> > i.e. Josh, Jann, do you see any issues with Qi Zheng's fix here:
> > https://lore.kernel.org/all/20210924062006.231699-4-keescook@chromium.org/
> 
> Even with that patch, it doesn't lock the task's runqueue before reading
> the stack, so there's still the possibility of the task running on
> another CPU and the unwinder going off the rails a bit, which might be
> used by an attacker in creative ways similar to the /proc/<pid>/stack
> vulnerability Jann mentioned earlier.

Since I think we're considering get_wchan() to be slow-path, can we just
lock the runqueue and use arch_stack_walk_reliable()?

-- 
Kees Cook
