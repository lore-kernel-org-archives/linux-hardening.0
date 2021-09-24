Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E1BC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E83461164
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 14:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhIXO16 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhIXO15 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 10:27:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FCAC061571
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 07:26:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so9757987pjn.1
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGzzGbeOeLEORaxwOD7BLDmEH+a0amSJ/nYoDh8OWO0=;
        b=FGOqdb8Wc6HM1sjK/2fbXMNHDvLwKPUuowC529hVtm8I6s3/4QxQ1YBVBPiENwD5cf
         MLK8nggL/D+kCwp/GZZaFYbBbBGuqWUwxJeHpm+2nwMZzck6aP11onhvZEBmpcVEVK8c
         YOS4HwQtsAu3rZGTzfjU2+fJz4DuOZxiWFrE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGzzGbeOeLEORaxwOD7BLDmEH+a0amSJ/nYoDh8OWO0=;
        b=FtcQvg2nADH0At8OMIlKkq4YpS/7Rbpvh/vzXuEhE5ddBYxyWzwEjkGpax24rbiTEt
         Q8QKgyatyZMfHnwgbHCe59D7RnpR8b3Pv0y7xQM7N6JzJ+Sbsy4VAqbpm+KuQKEBL9ef
         m63rEK8r8JwclS1JhMZL0G+PRjiD+3kkjihJ/FYOh2tF0RyXqIdsfn+vfdaYD+OnChMN
         4XGxs5MquNNbNBJUWSruZYQRbwkEuaIz/cCYlkKIECnp0Eoz9yzBT+7xUYDJx+BYx72E
         //Q5ZjHkR8E8ftriLYzsDTXLzBOnzTfMdTVoDq0DIsk2VU26SNyqvv7jvnYAziL61ysV
         +PUg==
X-Gm-Message-State: AOAM5313myoe7IjkkZIRiuVRsNW3frcBg1TaJKS8/OsxAA6wMcEUcl9O
        RUrmeDtuHBwIWz9mQNF887i83Q==
X-Google-Smtp-Source: ABdhPJz07BWVVjhirIskBAi83rmTvlhUeoG7P547BlYgytzb5ayVQrWhQOHZumT2qg1rFa/0cZwbEw==
X-Received: by 2002:a17:902:c948:b0:13a:345c:917c with SMTP id i8-20020a170902c94800b0013a345c917cmr9245252pla.61.1632493584372;
        Fri, 24 Sep 2021 07:26:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm8893038pfh.213.2021.09.24.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:26:23 -0700 (PDT)
Date:   Fri, 24 Sep 2021 07:26:22 -0700
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109240716.A0792BE46@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924135424.GA33573@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 24, 2021 at 02:54:24PM +0100, Mark Rutland wrote:
> On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> > On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > > Instead of unwinding stacks maybe the kernel should be sticking an
> > > entrypoint address in the current task struct for get_wchan() to
> > > access, whenever userspace enters the kernel?
> > 
> > wchan is supposed to show where the kernel is at the instant the
> > get_wchan() happens. (i.e. recording it at syscall entry would just
> > always show syscall entry.)
> 
> It's supposed to show where a blocked task is blocked; the "wait
> channel".
> 
> I'd wanted to remove get_wchan since it requires cross-task stack
> walking, which is generally painful.

Right -- this is the "fragile" part I'm worried about.

> We could instead have the scheduler entrypoints snapshot their caller
> into a field in task_struct. If there are sufficiently few callers, that
> could be an inline wrapper that passes a __func__ string. Otherwise, we
> still need to symbolize.

Hmm. Does PREEMPT break this?

Can we actually use __builtin_return_address(0) in __schedule?

-- 
Kees Cook
