Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D8DC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05A760EE5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 16:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbhJFQdT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhJFQdS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 12:33:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4696AC061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 09:31:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 133so2982246pgb.1
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U0uxG4pMOch24ZlbEABqSLA4Fhkobjai2fJURMCBQv4=;
        b=UtdOozShF5eo/cpHCJ0nwvV2GQrmGg7CASezsc4WZns/HMXW61f9+EsSvrcE/QuYF0
         jGw5G12klu/kcU6idZBs2s5sK7ghVL/tdhT5PXHRB/HOI7bvyjbMdjKtSNZKDeyoFHzX
         WNdcO12frSLNB8IrKXqX/shHYETRsmTZtye1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0uxG4pMOch24ZlbEABqSLA4Fhkobjai2fJURMCBQv4=;
        b=1CojbY4loI13tPXr2nsnJVX2T5AzN3E8Dt73fWj41jYfsK3OJz1Sq+/H0KMOja4sDF
         hLAXMHbfsI7QMJ8uQPajtNp2df+a/FHAfSUVimCDpYItdKZX32Q6wAHq2YfH+NTzjOrw
         imNrFe2I8bJG7kiOaW9320nfes8fotBjNC9L6Zh7u+ZjYA2NwTfDV2DaDM8fWMaU/cFe
         ks4mIfT3llzURUZk6DIW4QntA8EsUzTvGiWBBQbbgTaBTjTCEO8ewDrJC4a1EFbxv6Xd
         XCqXRrazOSR8JttGet7y7eI1T54qTo+7MAPuHNO9mWGwyQngdzmEkdb9qPPxcvG8ijll
         1+Mw==
X-Gm-Message-State: AOAM533BEmTqAAxHH7Outw9bZ4AAekOJXAGdNRU5ufD9fti0dp/XTSbt
        lQvLTtajVqHKcUr99wMF74XqHw==
X-Google-Smtp-Source: ABdhPJxx7lESrAGU0V8YXUtT8hY0WSqmJKVUANvMfs2Q+AHx2usiTkv/JR30ymuVK3+glSmvmTQwQQ==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr21116226pgj.47.1633537885790;
        Wed, 06 Oct 2021 09:31:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm24516266pfc.111.2021.10.06.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:31:25 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:31:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202110060930.84D8EC6@keescook>
References: <20210924025450.4138503-1-keescook@chromium.org>
 <202110052146.D639C70@keescook>
 <YV1r57V3baZIs8dl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV1r57V3baZIs8dl@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 06, 2021 at 11:27:03AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 05, 2021 at 09:48:51PM -0700, Kees Cook wrote:
> > On Thu, Sep 23, 2021 at 07:54:50PM -0700, Kees Cook wrote:
> > > With struct sched_entity before the other sched entities, its alignment
> > > won't induce a struct hole. This saves 64 bytes in defconfig task_struct:
> > 
> > Friendly ping. Can someone snag this for -tip please?
> 
> Hurpmf... if only we had like perf driven pahole output :/

Normally I wouldn't even make suggestions in task_struct given the high
variability due to CONFIG options, but this case was pretty universal.

> Picked it up, we'll see what if anything hurts.

Thanks! *fingers crossed*

-- 
Kees Cook
