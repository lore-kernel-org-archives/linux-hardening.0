Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D668C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Feb 2022 19:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353042AbiBKT6S (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:58:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353028AbiBKT6S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Feb 2022 14:58:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88982B8F
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 11:58:16 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y5so18101428pfe.4
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SPfAVMPxFXWP9yaWNQ8kQASSQMlDzKBO7XOnuPeP+c8=;
        b=lly4ZI04Jy6RBjOUgr4jYMTzZ2uCUnQ3vwJQpca1ZJyg5XJGU1J1k7CqP3pi6dHa5I
         Ps0uTkqHLTqZnb19yEQekzG4SeA3fPgRU76s2ZHiGEivW5YlFNnIYXPeYtG/jiP9RSzi
         s+QkHFWRhfnxbdBWMua2H6Vv7DXTB1q6VZsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SPfAVMPxFXWP9yaWNQ8kQASSQMlDzKBO7XOnuPeP+c8=;
        b=PyAlc5gdhb9hi0bPKCa6qYgzrznjPtL6MigjprQxNyCuhEiodkUEkGU8e+wQsrB9Ia
         jp2FFfHOnILe0NdfjC1QEqji1pjKAah6+qgqk72bUEd7DO7am2jo7a37CLTBAt0Su+0G
         /QPfYgu9LONd9//673j38fWBnBuASRYOVjvcn75VHLPM7PQQDQlJHLi+4nghXOwQcu7U
         LEHBr1HPRGCaKO2PlBFhOwb5iwilzV58ja9Nwdiuo4K79cICb9ZEO0uXC2aojTkTiTz/
         D5e7Sq3Bs2kv3yHbMFc+saugt3zdi8uXVjtov+ONiAom2aaVVC8rFcQgPDNa++nmoRwR
         MlUw==
X-Gm-Message-State: AOAM532GB8B7CJTuT5kMNjmKyjc45ztLt1EfoeQXRVQppqjt/JsqjYXZ
        7FETmhvmf+C+iLcO7TB+D+NSMw==
X-Google-Smtp-Source: ABdhPJwX9z2DpIPF4RWD0zONi5vPZR2mOetW5ivl8slwqZNE7FCT+K4F8UNla32gNrSjYLc5v5mpew==
X-Received: by 2002:a05:6a00:b84:: with SMTP id g4mr3220812pfj.10.1644609496082;
        Fri, 11 Feb 2022 11:58:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm27369792pfu.9.2022.02.11.11.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:58:15 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:58:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <AB117FDA-5D7C-4AA6-ACBF-400568CC6196@chromium.org>
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
 <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org>
 <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org>
 <202202101827.4B16DF54@keescook>
 <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
X-K9mail-Identity: !l=0&o=0&qs=PREFIX&f=TEXT&s=--%20%0D%0AKees%20Cook&m=
 %23%3AOGM4OWE1MTEtMTdkZS00ODEzLTlhNDQtMGY1OTRhYjk5NDcx%3AMg%3D%3D%3AODc
 5NTg%3D%3AANSWERED&p=0&q=SHOW
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On February 11, 2022 4:54:26 AM PST, "Robert Święcki" <robert@swiecki.net> wrote:
>> It's mainly about the exit stuff having never been run before on these
>> kinds of process states, so things don't make sense. For example, on the
>> SIGSYS death, the registers have been rewound for the coredump, so when
>> the exit trace runs on x86 it sees the syscall return value as equal to
>> the syscall number (since %rax is used for the syscall number on entry
>> and for the syscall result on exit). So when a tracer watches a seccomp
>> fatal SIGSYS, it sees the syscall exit before it sees the child exit
>> (and therefore the signal). For example, x86_64 write (syscall number
>> 1), will return as if it had written 1 byte. :P
>>
>> So, it's not harmful, but it's confusing and weird. :)
>>
>> > I am trying to figure out if there is a case to be made that it was a
>> > bug that these events were missing.
>>
>> I don't think so -- the syscall did not finish, so there isn't a valid
>> return code. The process exited before it completed.
>
>A tangential point: please ignore for the purpose of fixing the
>problem at hand. I'm mostly making it, in case it can be taken into
>account in case some bigger changes to this code path are to be made -
>given that it touches the problem of signal delivery.
>
>When I noticed this problem, I was looking for a way to figure out
>what syscall caused SIGSYS (via SECCOMP_RET_KILL_*), and there's no
>easy way to do that programmatically from the perspective of a parent
>process. There are three ways of doing this that come to mind.

I had hoped that the parent could read the SIGSYS siginfo_t from the
child, but I haven't found any way to do this. :( :(

I don't seem to be able to use:

- PTRACE_ATTACH to use PTRACE_PEEKSIGINFO on a dead process.
- signalfd (nothing is in the fd after the exit).

Hmpf.

-- 
Kees Cook

