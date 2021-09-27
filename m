Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF0CC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 18:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE71A60F12
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 18:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhI0SJJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhI0SJI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 27 Sep 2021 14:09:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F43C061575
        for <linux-hardening@vger.kernel.org>; Mon, 27 Sep 2021 11:07:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so12341238pls.6
        for <linux-hardening@vger.kernel.org>; Mon, 27 Sep 2021 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tDOkVE0ODQlIfy+svH+8qmYmMfJw/SIE05I5QEmJTc0=;
        b=H4dtikHlIIRNu9x+nUBJ94yto7vmTPkWR8JrJ3hOvt1/U8BGZ1N+m4tQCt4tF9CT6s
         KpBUabpeYdk1Chi60PLSpsc4rxh7sfO9oGE7bCVcww60FrgVvM3lqnRYX/BB1vMyaS8P
         RH2fGw80AQ/rrLC9fW8ALjrP/aLT93HUL5bQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDOkVE0ODQlIfy+svH+8qmYmMfJw/SIE05I5QEmJTc0=;
        b=7VqozQ3zatNwhDRgOEJhkJORuY9lE5tUftkulbYe6UFPcyMYeGKMqLiBVSRrIgJaI7
         0qwGApl7291ht71JQ9bkOePf1cRlBfNZY3qN6le1vbZSKIJePqFDyWe4uicQe/Wg6jej
         It7T4gW8yNhTEh+fBMFyYf7JhTatttVbNl+9iJDW/lgZ8ozetQwk0qb7LKpRdHpOiYmC
         5ODbauLYYSnxUs0E2pa4wYkSEmVtfHSh/qgI86YaUbz6LGHWG1oSUuANmZfiVEfHl8Lv
         50PLY5CQ3BNZ9tES25yjHTFzuO9L0FY+0/3XYPjN5QnPHNN8O7WBCfasdtohYiRS1bfR
         X3Mw==
X-Gm-Message-State: AOAM530UqgFpT1SIBEPf/un8cPYxGxLGPmnKZqMH69qJOHjv/44TL3IO
        QsYP2cwW1IQjMuGX8ds9rRVkBQ==
X-Google-Smtp-Source: ABdhPJxpWsl+grzENU9fNTzNpe31Dtx/ov/zifR29rSBBH3z6+gdu1F8hPw0pBn+jIG/phol5XJ2GA==
X-Received: by 2002:a17:90a:1944:: with SMTP id 4mr497852pjh.62.1632766049496;
        Mon, 27 Sep 2021 11:07:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z62sm115624pjj.53.2021.09.27.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:07:28 -0700 (PDT)
Date:   Mon, 27 Sep 2021 11:07:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Vito Caputo <vcaputo@pengaru.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <202109271103.4E15FC0@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927090337.GB1131@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 27, 2021 at 10:03:51AM +0100, Mark Rutland wrote:
> On Fri, Sep 24, 2021 at 07:26:22AM -0700, Kees Cook wrote:
> > On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> > > On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > > > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > > > entrypoint address in the current task struct for get_wchan() to
> > > > > access, whenever userspace enters the kernel?
> > > > 
> > > > wchan is supposed to show where the kernel is at the instant the
> > > > get_wchan() happens. (i.e. recording it at syscall entry would just
> > > > always show syscall entry.)
> > > 
> > > It's supposed to show where a blocked task is blocked; the "wait
> > > channel".
> > > 
> > > I'd wanted to remove get_wchan since it requires cross-task stack
> > > walking, which is generally painful.
> > 
> > Right -- this is the "fragile" part I'm worried about.

I'd like to clarify this concern first -- is the proposed fix actually
fragile? Because I think we'd be better off just restoring behavior than
trying to invent new behavior...

i.e. Josh, Jann, do you see any issues with Qi Zheng's fix here:
https://lore.kernel.org/all/20210924062006.231699-4-keescook@chromium.org/

-Kees

-- 
Kees Cook
