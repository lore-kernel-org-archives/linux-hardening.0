Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E99C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 23 May 2022 14:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiEWOTc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 May 2022 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiEWOTb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 May 2022 10:19:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89725A2CF
        for <linux-hardening@vger.kernel.org>; Mon, 23 May 2022 07:19:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b9so6404126qtx.11
        for <linux-hardening@vger.kernel.org>; Mon, 23 May 2022 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWWc2ufu33khGKEV0bBRhozmdSQdZxaeJldqWqBjNU0=;
        b=Ca4pS9a4zUlNfJS71/xyjcXZwSvHarFm9ArT3ZbYYlDSt9AQPBUQZjo1ap515khvib
         lfG8oGwjxr5aUzbs9rrcRMb4QDXQxw5TsbNIjQBNXX6PHFaVAZZJL3sUld4GscV8Ustm
         82oInsvFBsCy9EEB9w642rL77Gr+HYyy/8+6J6svU6js20GxtsJrBfZnr1B0tRCVShSp
         tc7BSlvWSzkJ8c9fCuULWwENNs6hGAMxL1eq0ns3sjaqUNp7nN4NIocOV4YiRJMJEV3e
         TYJORsIsv+C5YAoKj9CtvGjaaAnZU4V51d3eDApSMPEejh+mx+r7ChtuUUjEorPYlysD
         58Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWWc2ufu33khGKEV0bBRhozmdSQdZxaeJldqWqBjNU0=;
        b=VS0rIqZ4NwwV8UdcJUetGGjTfS+/RsvDwVXC+TZjZvLkKxo4HfjNlFvu1G1/d+FyqM
         /BGRLRYJhXlInG/4FJxOAMaOkb0weDYUenm2eRQgHXD1LRELWlF98XBrq5TauO6Jg/EY
         rIqc2icsDUrH6Z/Ja3ngcjcG0hbPHFwWsVp8h21Hy5TUG5OZBSp90GIieWX2cvmbOL2R
         H/+AYM5iSjgZJdQ3jOczvSruQ5miu1lcbWk0gbKsotyR7bpXkSh0aGKGThtru097shUt
         JmbsmDb8hISg8V5FMNWkkKxws9JKcjANyjfHup/UzrgDtrWXhMOI87f4yjkIgWsYplg/
         n8Cw==
X-Gm-Message-State: AOAM532ZtANdAGmoL/KiK9JNGwkbZUs5avrpwbnhCNtV/YGiTWLomBQB
        Hij5vDlQmnf+9fNx0aSgnBi6pg==
X-Google-Smtp-Source: ABdhPJwjIWZ/Xu8CISDgPppsp4d9DpRDuyDFiAKBdGorgak+hkFR3g6gfGmV423tCLSN+fnTZB80DQ==
X-Received: by 2002:ac8:5dcc:0:b0:2f3:d8d2:7cf with SMTP id e12-20020ac85dcc000000b002f3d8d207cfmr16552559qtx.464.1653315564452;
        Mon, 23 May 2022 07:19:24 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bc3-20020a05622a1cc300b002f39b99f6a2sm4165754qtb.60.2022.05.23.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:19:24 -0700 (PDT)
Date:   Mon, 23 May 2022 10:19:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched/psi: Bounds-check state iterator against
 NR_PSI_STATES
Message-ID: <YouX6g1T7w3FDeM8@cmpxchg.org>
References: <20220520165826.2140252-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520165826.2140252-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 20, 2022 at 09:58:26AM -0700, Kees Cook wrote:
> GCC 12 cannot tell that "t" will be bounded by NR_PSI_STATES, which could
> lead to walking off the end of the tasks array, which is NR_PSI_STATES in
> size. Explicitly bounds-check "t" as part of the loop.
> 
> In file included from ../kernel/sched/build_utility.c:97:
> ../kernel/sched/psi.c: In function 'psi_group_change':
> ../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
>   730 |                         groupc->tasks[t]++;
>       |                         ~~~~~~~~~~~~~^~~
> In file included from ../include/linux/psi.h:6,
>                  from ../kernel/sched/build_utility.c:36:
> ../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
>    84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
>       |                      ^~~~~
> ../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
>   730 |                         groupc->tasks[t]++;
>       |                         ~~~~~~~~~~~~~^~~
> ../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
>    84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
>       |                      ^~~~~
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a337f3e35997..827f16a79936 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -725,7 +725,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		}
>  	}
>  
> -	for (t = 0; set; set &= ~(1 << t), t++)
> +	for (t = 0; set && t < ARRAY_SIZE(groupc->tasks); set &= ~(1 << t), t++)
>  		if (set & (1 << t))
>  			groupc->tasks[t]++;

This is a very hot path, it runs for every nested cgroup on every task
switch, wakeup and sleep. We should avoid unnecessary instructions and
branches if we can help it at all.

Does the below patch address the warning for you? I can't test it
myself, because I'm not getting it with gcc version 12.1.0. It's also
odd that it didn't warn you about the loop over `clear' a few lines
up, which ostensibly has the same "problem".

---

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c7fe7c089718..113861343733 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -41,6 +41,7 @@ enum psi_task_count {
 #define TSK_RUNNING	(1 << NR_RUNNING)
 #define TSK_ONCPU	(1 << NR_ONCPU)
 #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
+#define TSK_MASK	((1U << NR_PSI_TASK_COUNTS) - 1)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a4fa3aadfcba..fb7fd40af337 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -804,6 +804,8 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	void *iter = NULL;
 	u64 now;
 
+	WARN_ON_ONCE((clear|set) & ~TSK_MASK);
+
 	if (!task->pid)
 		return;
 
