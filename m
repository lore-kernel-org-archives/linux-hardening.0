Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94991C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Feb 2022 20:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353059AbiBKUBH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:01:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245588AbiBKUBG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5453C50
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 12:01:01 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t36so7287573pfg.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QNqvweKtPqIF4attpHp1noQLaabICsimXqSeB/QPjEI=;
        b=DpIN81zjnh+AwCO+qCWcnLW920fFY9PMwlJ3PW0Ee5vWBCqso1AyT9kdGi/ouyKLeQ
         RPUIDaScKejJU5SIIErkiywv1jEBq22/gq1gLqIZhlxR9SPmoJZaGuYxRuE2mCHVsIXy
         wyVqBsoQh4qoAteYdlaENTxzZ8rO0FY7grMN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QNqvweKtPqIF4attpHp1noQLaabICsimXqSeB/QPjEI=;
        b=bGgbJqVG9hawLOO1uYEJNRlkELGNOCMPifwewL16/kyB6LDEq/rl7x3rREkZ3C0GF8
         Y8zjFc15HuwIRguBtGw8Pu6m8TG0Z3tfLDxFNMwRMoojmH0gqVmKp3jFQMMwoFKVSpnR
         c39Qb7B2UwmFCofful1br8OTHXZgMMTAtjbLOtGBsLsmPuIpM4Ky4njtJj1nXZdgY441
         i504AZDtykaqE75ynO7+2rT2hbUJLPaCpi+Dtkz+9TdpGUWKBuLI3feC0F/wGDXJUHRQ
         4Mh8yZTWfhUqQDM5Z16qhX0ZJ2tJyJkHuic2efHAMmiE8ykb0oUqU6Dwv3YMcwTiN0RV
         319w==
X-Gm-Message-State: AOAM531xJpc5+NTCEMhDLLOIrtaWFPLX0slS3Fj2Lkc+oiOGVjfn8bcJ
        g5XXR/xlMzXoneh5w9bUVEpEaGp0FMvHaQ==
X-Google-Smtp-Source: ABdhPJwLAGT61PFgZsP2SAVpzMNkZ+DM5KpdHyqc7A087qE45VeO3Biw1+4t38r3D6WqAK6kg6XHPA==
X-Received: by 2002:a63:8849:: with SMTP id l70mr2701342pgd.25.1644609661110;
        Fri, 11 Feb 2022 12:01:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm28951487pfu.210.2022.02.11.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 12:01:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <202202111159.7B2BAD2EF1@keescook>
References: <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
 <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org>
 <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org>
 <202202101827.4B16DF54@keescook>
 <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
 <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 11, 2022 at 11:46:53AM -0600, Eric W. Biederman wrote:
> Robert Święcki <robert@swiecki.net> writes:
> > When I noticed this problem, I was looking for a way to figure out
> > what syscall caused SIGSYS (via SECCOMP_RET_KILL_*), and there's no
> > easy way to do that programmatically from the perspective of a parent
> > process. There are three ways of doing this that come to mind.
> 
> Unless I am misunderstanding what you are looking for
> this information is contained within the SIGSYS siginfo.
> The field si_syscall contains the system call number and
> the field si_errno contains return code from the seccomp filter.
> 
> All of that can be read from the core dump of the process that exited.
> 
> Looking quickly I don't see a good way to pull that signal information
> out of the kernel other than with a coredump.
> 
> It might be possible to persuade PTRACE_EVENT_EXIT to give it to you,
> but I haven't looked at it enough to see if that would be a sensible
> strategy.

If there is already a ptrace on the child with PTRACE_O_TRACEEXIT, it
should be possible to use PTRACE_GETSIGINFO.

> > I think it'd be good to have some way of doing it from the perspective
> > of a parent process - it'd simplify development of sandboxing managers
> > (eg nsjail, minijail, firejail), and creation of good seccomp
> > policies.
> 
> By development do you mean debugging sandbox managers?  Or do you mean
> something that sandbox managers can use on a routine basis?

It'd really be nice to be able to get this info without the ptrace
relationship already in place... hmmm.

-- 
Kees Cook
