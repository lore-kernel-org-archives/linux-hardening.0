Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3452C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 20 May 2022 17:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbiETRJi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 May 2022 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350328AbiETRJe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 May 2022 13:09:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F41862B9
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 10:09:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t26so15230994ybt.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QU49IpXWY3ILYjrG9pprYmKd2girarG6kbSVlkmZXq4=;
        b=RFVe4hjab8BtmvgSDTDCxD8vofyFqNalvXRBQZgx9gZ4x0DAquq0obhlAEFHddTmeW
         Loz1ZuchS0quSsRLELcG8rhU8pxiZJxYaO165uilvHF+A02AKKBm4UZs1j/+3risPDCw
         AuXygWBks+teEdgM/k5tlJsk4Ri/AzDhCkFN4xOJIUXax7f+otVYztbsGlIEoQ0bHDSr
         fzTB0DZN/sTP9AaKfRqBx7fTJfU8EK1BQ8upFpH+yLeNa/kK0VIdE5tgoCkicTGFnVA0
         LGObsSEUesvNzfC3iZrUfd1CzOmDJh8+Rq+YxtpUs5go5GbpW23fIo/yOU9DrdSO6YFQ
         UKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QU49IpXWY3ILYjrG9pprYmKd2girarG6kbSVlkmZXq4=;
        b=yx/ZYBVv2vBUd1S807FWSCUSgNZpLRKhrkKn6koMzybzMKnAOHbTiMSrAwVVqkkXLh
         +5NFbWEGbytnLSQwiYxEEU667TEiB4R0gCA1fJaTrAyxu5JYc/IemwnAqeNgmLVa+leP
         xWuDSPIHuQXG/oOlCOtUuc3txGtqEWf7InZglwSn3b37urVxmUPnXWaMIUuNVT0vLKC+
         9dDUK6XzX3BZW3SFtvDVrNG0U+jpVt3HjB4tvqTlNj0Alwhg9d2r9i9c87553XsAXsFi
         M/BgXao1bdf4sMeuxtzW4ofGXAZBxY3KyHSGUiduHe6PeGjNN8v9C+nyupyByfGi4tbQ
         P+ww==
X-Gm-Message-State: AOAM5306uVhy+AKSJGpSgicRR0vCHxQTRiG12QKFt+lvg6QMl3PEI5Dr
        Bx/ldJxCfgk1yjySXJzv7aL1evIaLhjXok3XoDB1Vg==
X-Google-Smtp-Source: ABdhPJxEo6gFNLNscO7/ZgLV0QwPqEiaGItXCsWeFOnHsvuK0OOHvvT7zEaAuGJHZkw4CGOdImbbhBWl0Vj1Ie7MLSo=
X-Received: by 2002:a05:6902:13c2:b0:641:b6d:a151 with SMTP id
 y2-20020a05690213c200b006410b6da151mr10461624ybu.348.1653066571425; Fri, 20
 May 2022 10:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220520165826.2140252-1-keescook@chromium.org>
In-Reply-To: <20220520165826.2140252-1-keescook@chromium.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 May 2022 10:09:20 -0700
Message-ID: <CAJuCfpGqY4sidGe3XSTjJ-tt+5wsm0JTpmUa-hc8WgT9aRXXSQ@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: Bounds-check state iterator against NR_PSI_STATES
To:     Kees Cook <keescook@chromium.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 20, 2022 at 9:58 AM Kees Cook <keescook@chromium.org> wrote:
>
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

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a337f3e35997..827f16a79936 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -725,7 +725,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>                 }
>         }
>
> -       for (t = 0; set; set &= ~(1 << t), t++)
> +       for (t = 0; set && t < ARRAY_SIZE(groupc->tasks); set &= ~(1 << t), t++)
>                 if (set & (1 << t))
>                         groupc->tasks[t]++;
>
> --
> 2.32.0
>
