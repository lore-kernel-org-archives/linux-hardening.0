Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C827BC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 09:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E91B6117A
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 09:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhJFJbk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhJFJbk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 05:31:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57039C061749;
        Wed,  6 Oct 2021 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xZm5kVAF4GxyNSQZ7ZpOau+eXzycMw18CKyxakwvLK0=; b=MsowkM4j330OoqazuiCLUkS12v
        0l/QXqv2Jr5/OD4UfzpYfX6FTQRL8FJrnx7EpfUdSugz9De2lf+7UvElkBwHUZQWrWk9DycjEUW/y
        RKdtSqaF6cCjVGVZ2uZAzdZ7wYtI6RbSkvUustWEpDVM+Fos8p7zvb0GXtjpFDsZZNhHeCUNRWzn8
        9FJmxWlgOWhxmfHwP5w0EPP+Yenfi5f1jm4ZAzEzDY8TqQAt9mHYslHO/8dM1gZjNoZ/8be2N88va
        cbSJnpfpManE8le/U3T7Nn4htugwSbVSg+ZAbfD6Hc6dFSHOnMLFN4sClBAbndu2DcxhhAfo3oLVV
        cFvMbnkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY3Ca-000jrQ-LV; Wed, 06 Oct 2021 09:27:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C79730019C;
        Wed,  6 Oct 2021 11:27:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E47CE2136BA84; Wed,  6 Oct 2021 11:27:03 +0200 (CEST)
Date:   Wed, 6 Oct 2021 11:27:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched: task_struct: Fill unconditional hole induced by
 sched_entity
Message-ID: <YV1r57V3baZIs8dl@hirez.programming.kicks-ass.net>
References: <20210924025450.4138503-1-keescook@chromium.org>
 <202110052146.D639C70@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110052146.D639C70@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 05, 2021 at 09:48:51PM -0700, Kees Cook wrote:
> On Thu, Sep 23, 2021 at 07:54:50PM -0700, Kees Cook wrote:
> > With struct sched_entity before the other sched entities, its alignment
> > won't induce a struct hole. This saves 64 bytes in defconfig task_struct:
> 
> Friendly ping. Can someone snag this for -tip please?

Hurpmf... if only we had like perf driven pahole output :/

Picked it up, we'll see what if anything hurts.
