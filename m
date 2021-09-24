Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF8C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 02:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C79D61039
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 02:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbhIXCOl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243883AbhIXCOk (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 22:14:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5AA860F6D;
        Fri, 24 Sep 2021 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632449587;
        bh=B/XHIWMq1gag7dtKsGrmlye8E+xPHZm+e2yAyVV3M6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=imhuc81evtsk2EniQ+zv0t/OEdOmAFrh2AYCPNxmBftH60pEeUTReAi1sUAV08c1G
         mm7QmfIVliTxodfM5ADhZ7o/6tDNUEjh1Z14XR3sRvqXcI3q6xL1XZzPB1lt3OgmGI
         R5gv0i/Fgqw/WIeAQ4t0Bof0tHhUTAdYAw2oQk2Q=
Date:   Thu, 23 Sep 2021 19:13:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?ISO-8859-1?Q?Wei=DF?= 
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
Message-Id: <20210923191306.664d39866761778a4a6ea56c@linux-foundation.org>
In-Reply-To: <20210923233105.4045080-1-keescook@chromium.org>
References: <20210923233105.4045080-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 23 Sep 2021 16:31:05 -0700 Kees Cook <keescook@chromium.org> wrote:

> The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> years now[1].

[1] is hard to decrypt.  I think it would be better if this changelog
were to describe the problem directly, completely and succinctly?

> As this remains a potential leak of either kernel
> addresses (when symbolization fails) or limited observation of kernel
> function progress, just remove the contents for good.
> 
> Unconditionally set the contents to "0" and also mark the wchan
> field in /proc/$pid/stat with 0.
> 
> This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> again, since this was broken for 4 years, was this profiling logic
> actually doing anything useful?

Agree that returning a hard-wired "0\n" is the way to go.
