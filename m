Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42172C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1434460F11
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 13:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhIXN4L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:56:11 -0400
Received: from foss.arm.com ([217.140.110.172]:50004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhIXN4K (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 09:56:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F197D6E;
        Fri, 24 Sep 2021 06:54:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.20.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8D43F719;
        Fri, 24 Sep 2021 06:54:30 -0700 (PDT)
Date:   Fri, 24 Sep 2021 14:54:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
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
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
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
Message-ID: <20210924135424.GA33573@C02TD0UTHF1T.local>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109231814.FD09DBAD3@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > Instead of unwinding stacks maybe the kernel should be sticking an
> > entrypoint address in the current task struct for get_wchan() to
> > access, whenever userspace enters the kernel?
> 
> wchan is supposed to show where the kernel is at the instant the
> get_wchan() happens. (i.e. recording it at syscall entry would just
> always show syscall entry.)

It's supposed to show where a blocked task is blocked; the "wait
channel".

I'd wanted to remove get_wchan since it requires cross-task stack
walking, which is generally painful. 

We could instead have the scheduler entrypoints snapshot their caller
into a field in task_struct. If there are sufficiently few callers, that
could be an inline wrapper that passes a __func__ string. Otherwise, we
still need to symbolize.

Thanks,
Mark.
