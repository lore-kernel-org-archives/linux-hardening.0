Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40DC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 03:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiEQDdb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 23:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiEQDd3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 23:33:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D823D1FB
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 20:33:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y41so15739983pfw.12
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 20:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6lMCmhAYh+FvKYdNdXdz6Z38uBA0dGxW92CXeTkkVHI=;
        b=n8WjxB3Nj3gvAFxKXFL3OrDnlrBoacgytSGaFjMBE9s/LFRzUKHHXob4w0r2AQ5IKo
         tYNienYmpEVD+bM3YbFEIiV4sn8Fq5tT0DySB7eaGNheP3Py6K6yd2pAok543L01wiLt
         LywDoZZuJfuDt8WNiy39SM1tTXRASndm+9/Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6lMCmhAYh+FvKYdNdXdz6Z38uBA0dGxW92CXeTkkVHI=;
        b=q0PTIwFs3sIK5JqlonRqYXNyWEMYRmsVgGu2SLrmjohp97q5iSIYK9jjjkYY2z9Bmw
         SF5EHf0NC6oNGzUrlSO4MZ289J77K/L9Jqjacuk09LamVMwmz50JzDveo7z5nV+Q8ryR
         qb7fAWx6JfKLG1206plAIGdqKoehgwJJdJEy6a1eSrscV1Em+61MoMbBuH39+HmTi9Ie
         zT8C+vWd30daOi1yBjZlf91OaRQmkOlDGrAqJqqTxGjY+4hl506WpAMq3q5yKZiKMboO
         pkXVajJY8in8TWl96kVxeS0cja9C0SzO3PNyyduR5L+8VVcBh9eFWroQhNRDRxIEwmb9
         1PgQ==
X-Gm-Message-State: AOAM5318xwBX3yZZZHlNvS4Djlz7vcybKRvC/udgrcSaizdiYoNvEAyR
        CYM83uTgDnnnRA4h3KZwLa56Sw==
X-Google-Smtp-Source: ABdhPJwiDhEUG94kRJnu4hhVriBlgTIp0ehSqJnWQZzKxaKBO/5HlPva5aRc7j6KHroEmoc3T9Io9w==
X-Received: by 2002:a63:8ac1:0:b0:3db:515d:76d2 with SMTP id y184-20020a638ac1000000b003db515d76d2mr18315027pgd.152.1652758406602;
        Mon, 16 May 2022 20:33:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902714800b0015e8d4eb281sm5995338plm.203.2022.05.16.20.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:33:26 -0700 (PDT)
Date:   Mon, 16 May 2022 20:33:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202205162032.5161269A45@keescook>
References: <20220517030024.3388355-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517030024.3388355-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 08:00:23PM -0700, Kees Cook wrote:
> GCC 12 is very sensitive about array checking, and views all negative
> array accesses as unsafe (a not unreasonable position). Redefine
> sched_class_highest in terms of its location from __begin_sched_classes,
> and redefine sched_class_lowest to the actual lowest sched class instead
> of one lower. This also means the for_class_range() must be redefined to
> be inclusive, which means its 1 caller must be adjusted to have its
> "lowest" argument bumped up one position. Silences this warning:
> 
> In file included from kernel/sched/core.c:81:
> kernel/sched/core.c: In function ‘set_rq_online.part.0’:
> kernel/sched/sched.h:2197:52: error: array subscript -1 is outside array bounds of ‘struct sched_class[44343134792571037]’
>  [-Werror=array-bounds]
>  2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
>       |                                                    ^
> kernel/sched/sched.h:2200:41: note: in definition of macro ‘for_class_range’
>  2200 |         for (class = (_from); class != (_to); class--)
>       |                                         ^~~
> kernel/sched/sched.h:2203:53: note: in expansion of macro ‘sched_class_lowest’
>  2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
>       |                                            ^~~~~~~~~~~~~~~~~~
> kernel/sched/core.c:9115:17: note: in expansion of macro ‘for_each_class’
>  9115 |                 for_each_class(class) {
>       |                 ^~~~~~~~~~~~~~
> kernel/sched/sched.h:2193:27: note: at offset -208 into object ‘__begin_sched_classes’ of size [0, 9223372036854775807]
>  2193 | extern struct sched_class __begin_sched_classes[];
>       |                           ^~~~~~~~~~~~~~~~~~~~~
> 
> The introduce and use of sched_class_higher() could just be a bare "+ 1",
> but this code's backwards walking and non-inclusive for loop was weird
> enough, it seemed back to explicitly describe the manipulation
> happening.

I just need to start today over. This should read:

 The introduction and use of sched_class_higher() could just be a bare
 "+ 1", but this code's backwards-walking and non-inclusive for loop was
 weird enough, it seemed best to explicitly describe the manipulation
 happening.

-- 
Kees Cook
