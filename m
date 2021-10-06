Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24916C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 04:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F038461151
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 04:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJFEup (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 00:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJFEup (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 00:50:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BF7C061749
        for <linux-hardening@vger.kernel.org>; Tue,  5 Oct 2021 21:48:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a11so919808plm.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDyvtoXyS9XOzQribqOAnTKH2S+at0kdnEMr//U405I=;
        b=TgxxRM6YtMr4p5YoTP63dgV2zsximbwhtsDSBh6hwvicGgpPhOjpSS67Xj44GdloA/
         zZDACb649zWYgKpW5X9anrT8+tVV7e6PKhrgRtF9211mbuBYjQ/MWSNBKIp+4MUHjEOS
         dRmT69Fcf4exFTJgGbXEwnMLKnSrijFU7YAqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDyvtoXyS9XOzQribqOAnTKH2S+at0kdnEMr//U405I=;
        b=u2X1PzqgvSZHR4V3C/8RagbjmqodSjyrtHtlsiZ0Mb8F2hD5N8j0w7OCIUgf7Vl2Uk
         R7QXX3NDOd0ScoXrQAK2zcRKtkMeCrR6lxaRQSft8euvFKUf5FqQYtjt0VKJlFF809xQ
         uonxiUY45pdzWjQrHvvJOTEd48EFtom2MjjiSEyBeA2Hya7imyLoD1EKTgwE+EBneZ4b
         qyqfREaL2+4X7kcPmVtAN7bb5i1MIWhBWGjNrWyNH3pQRHdHRuLPJZv+H98iKsj7Cx7j
         jFLBGsiGZyCx2gkcEhETW4nevc7Zmo0rIKDTUUe3UuhjOnhoQIG+6U3Hf0n+rMsUAckD
         Vrjg==
X-Gm-Message-State: AOAM533yW3EXzUhNRAFFnESBca0bTCgBW5/eOQtcuBCMIgKuUuED6O34
        LRbcg6Pje0txTdBXv4cWaN+NVQ==
X-Google-Smtp-Source: ABdhPJyOoWn4V1je6f55k+dfT7SOKRZchETiJDZNzJJIUl1rA79ODgBUGWF3tYnZaFXu244+asOpDQ==
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr8659945pjb.173.1633495733239;
        Tue, 05 Oct 2021 21:48:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17sm3513395pjh.17.2021.10.05.21.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:48:52 -0700 (PDT)
Date:   Tue, 5 Oct 2021 21:48:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched: task_struct: Fill unconditional hole induced by
 sched_entity
Message-ID: <202110052146.D639C70@keescook>
References: <20210924025450.4138503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924025450.4138503-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 23, 2021 at 07:54:50PM -0700, Kees Cook wrote:
> With struct sched_entity before the other sched entities, its alignment
> won't induce a struct hole. This saves 64 bytes in defconfig task_struct:

Friendly ping. Can someone snag this for -tip please?

Thanks!

-Kees

> 
> Before:
> 	...
>         unsigned int               rt_priority;          /*   120     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         const struct sched_class  * sched_class;         /*   128     8 */
> 
>         /* XXX 56 bytes hole, try to pack */
> 
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         struct sched_entity        se __attribute__((__aligned__(64))); /*   192   448 */
>         /* --- cacheline 10 boundary (640 bytes) --- */
>         struct sched_rt_entity     rt;                   /*   640    48 */
>         struct sched_dl_entity     dl __attribute__((__aligned__(8))); /*   688   224 */
>         /* --- cacheline 14 boundary (896 bytes) was 16 bytes ago --- */
> 
> After:
> 	...
>         unsigned int               rt_priority;          /*   120     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct sched_entity        se __attribute__((__aligned__(64))); /*   128   448 */
>         /* --- cacheline 9 boundary (576 bytes) --- */
>         struct sched_rt_entity     rt;                   /*   576    48 */
>         struct sched_dl_entity     dl __attribute__((__aligned__(8))); /*   624   224 */
>         /* --- cacheline 13 boundary (832 bytes) was 16 bytes ago --- */
> 
> Summary diff:
> -	/* size: 7040, cachelines: 110, members: 188 */
> +	/* size: 6976, cachelines: 109, members: 188 */
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 39039ce8ac4c..27ed1d40028f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -775,10 +775,10 @@ struct task_struct {
>  	int				normal_prio;
>  	unsigned int			rt_priority;
>  
> -	const struct sched_class	*sched_class;
>  	struct sched_entity		se;
>  	struct sched_rt_entity		rt;
>  	struct sched_dl_entity		dl;
> +	const struct sched_class	*sched_class;
>  
>  #ifdef CONFIG_SCHED_CORE
>  	struct rb_node			core_node;
> -- 
> 2.30.2
> 

-- 
Kees Cook
