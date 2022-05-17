Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C5CC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 06:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiEQGm5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiEQGm4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 02:42:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB793FBEA;
        Mon, 16 May 2022 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=An34si7RN3x5AYHyo9ivNO4juXia4lwKqloOqJ0YQa0=; b=jKxTL6a94SajWnF7xG/o6Lgfqm
        kl1vlPQz0hoaJ4EvVsBXD01Y9dJq8H/QK6h3UQfid7vyzt1aQYnd6CJO5UWu5NmV4kC4VckJOXs/e
        mOtUQ/1gnmTR8uldKw0hZk4IfcSehAB9pS5Z8M9xqDWFm3jXwU4i76Ba9e/3qggGgcz8cx5Bw6btI
        d015QjnDEbJ99qCo50TRnoD2WhCg2jQz7HvDkeeB6/jdJM4rzdZn2rY29VVQGDaIfd9Ru4ggwyBCL
        jgy2rH8UrDwlag9Y3FKYEk90QQLee0cAGvoh4YNqlhDbapCwvfgtJ0uiZDBmdqAIYAwtcOuK5lLbd
        WWNZMdzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqqup-0019ZV-0W; Tue, 17 May 2022 06:42:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E72D3000DD;
        Tue, 17 May 2022 08:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEE062023D64A; Tue, 17 May 2022 08:42:39 +0200 (CEST)
Date:   Tue, 17 May 2022 08:42:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Message-ID: <YoND3ws5RUO4T+5g@hirez.programming.kicks-ass.net>
References: <20220517030024.3388355-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517030024.3388355-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 08:00:23PM -0700, Kees Cook wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d58c0389eb23..f2bcc7f15381 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5665,7 +5665,8 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
>  	 * We can terminate the balance pass as soon as we know there is
>  	 * a runnable task of @class priority or higher.
>  	 */
> -	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +	for_class_range(class, prev->sched_class,
> +			sched_class_higher(&idle_sched_class)) {
>  		if (class->balance(rq, prev, rf))
>  			break;
>  	}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8dccb34eb190..c757bd26b01a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2193,11 +2193,16 @@ const struct sched_class name##_sched_class \
>  extern struct sched_class __begin_sched_classes[];
>  extern struct sched_class __end_sched_classes[];
>  
> -#define sched_class_highest (__end_sched_classes - 1)
> -#define sched_class_lowest  (__begin_sched_classes - 1)
> +#define sched_class_higher(class) ((class) + 1)
>  
> +#define sched_class_highest (&__begin_sched_classes[__end_sched_classes     \
> +						    - __begin_sched_classes \
> +						    - 1])
> +#define sched_class_lowest  (&__begin_sched_classes[0])
> +
> +/* For each class, inclusive from _from down to _to. */
>  #define for_class_range(class, _from, _to) \
> -	for (class = (_from); class != (_to); class--)
> +	for (class = (_from); class >= (_to); class--)
>  
>  #define for_each_class(class) \
>  	for_class_range(class, sched_class_highest, sched_class_lowest)


Urgh, and we're back to unreadable garbage just because GCC is insane :/
