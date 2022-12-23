Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB20C3DA79
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Dec 2022 18:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiLWSH3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Dec 2022 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiLWSH2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Dec 2022 13:07:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C526329
        for <linux-hardening@vger.kernel.org>; Fri, 23 Dec 2022 10:07:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so5598690pjh.5
        for <linux-hardening@vger.kernel.org>; Fri, 23 Dec 2022 10:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNX34iDEDxhm/E73u2ryfjAMjkVi+n5xnZV2QkAaR8Y=;
        b=B2pQNduQHUwfqdHCdaOSiaNR7q68ettEq3dUpGBPNb0sTtZvKsYwmkKSzUB5qdw/lV
         vsRPFX4RsX8ALAsgJhE8acYKHoqJvOAuPlel3zp14FztNUmVMbfVgmkeFlc40Tw/JGR6
         W0UTXJ/2e9iivuwCSOdbxkpg9lITujhaGfv1Pk4lBIZRivylOuRxESQtdO8HpCTG+2Rd
         NxQSrit5JJ9rudyvZY5phz4kGh5CiMNDSvvZytbN61wCApficmhdGFoaiqQWGiBuH+oy
         zC6JSqk8dF4YljZcV3RJppACZ6ZUPatI/IOSUsjJC/3ZZpOmX0t9irb6JyUF7+k50nJQ
         B0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNX34iDEDxhm/E73u2ryfjAMjkVi+n5xnZV2QkAaR8Y=;
        b=WwEchRdYgvR2F/U9KSZXLte0SjhApJwtBpe51kLMg/e2gDblgs2+jvKLxNyZ1XeED4
         9aEPJEiJGQMl0+wsgB2KeBCuCO92A4VHtm1iszmINj+3q8jJcgkFma6WaXJ3Hyj4Qvmq
         A+9YNtTomXDQCHhFH4YfGMjI5ZoF6u8xQv6uiU2bBmfAiNPIh+S5S8WbXcIbrPWibXg7
         AzQiZK14quO3ZadpKhYQAgjrumH+m6TuxpGVb/4uYBX6UvdtwHmViVtxRp/Da8OpDH/H
         vfNkNy2vHyHwi4eqV9Cx74t88IgX94A+TuuRM0i/zj8FABC74TSO6E7Sqkw/irxyHydJ
         NBWg==
X-Gm-Message-State: AFqh2kpPCQn3RvNdJYSxIGnm4P4BSlg6R75JVkbEgXUHz8pqCSojj6lL
        ZXpRzS9wt+d6c6PKGkdLgci4IOE/YpdD4hAkvaCyXQ==
X-Google-Smtp-Source: AMrXdXskn96xRY553YKd1nrPaJh3C6uD/jtUl/8ZfvlJSCTFs8haNJjns05KLdYBkqDSQobKq75Nsy9TPJmWu3O4YIk=
X-Received: by 2002:a17:902:b690:b0:174:7d26:812f with SMTP id
 c16-20020a170902b69000b001747d26812fmr658130pls.63.1671818846456; Fri, 23 Dec
 2022 10:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <20221207154939.2532830-4-jeffxu@google.com>
 <202212080821.5AE7EE99@keescook> <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n> <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
 <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
 <202212161233.85C9783FB@keescook> <CALmYWFuENPRvCAOF6of=Ufct5jjAbJ=iDyH7eODhdbm24uAK3Q@mail.gmail.com>
 <20221216140641.bf6e47b7c4f5a53f34c8cf9a@linux-foundation.org>
 <CALmYWFuqAruM=Brh_54hWL+HiKD+RABK4y+hzd4phOzOZ_0=CA@mail.gmail.com> <f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org>
In-Reply-To: <f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 23 Dec 2022 10:06:49 -0800
Message-ID: <CALmYWFs3Qm_89e8cCcVu0otrZpMVe3rWxqANAQwQDJgaK3S+oA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Xu <peterx@redhat.com>, jeffxu@chromium.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 20, 2022 at 8:55 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 12/16/22 16:40, Jeff Xu wrote:
> > On Fri, Dec 16, 2022 at 2:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >> On Fri, 16 Dec 2022 13:46:58 -0800 Jeff Xu <jeffxu@google.com> wrote:
> >>
> >>> On Fri, Dec 16, 2022 at 12:35 PM Kees Cook <keescook@chromium.org> wrote:
> >>>>
> >>>> On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
> >>>>> Once per boot seems too little, it would be nice if we can list all processes.
> >>>>> I agree ratelimited might be too much.
> >>>>> There is a feature gap here for logging.
> >>>>>
> >>>>> Kees, what do you think ?
> >>>>
> >>>> I agree once per boot is kind of frustrating "I fixed the one warning,
> >>>> oh, now it's coming from a different process". But ratelimit is, in
> >>>> retrospect, still too often.
> >>>>
> >>>> Let's go with per boot -- this should be noisy "enough" to get the
> >>>> changes in API into the callers without being too much of a hassle.
> >>>>
> >>> Agreed.  Let's go with per boot.
> >>>
> >>> Hi Andrew, what is your preference ? I can send a patch  or you
> >>> directly fix it in mm-unstable ?
> >>
> >> Like this?
> >>
> > Yes. Thanks!
> >
>
> Sorry jumping into this discussion a bit late. Is it possible to provide
> a way to enable full logging as a debug option to tag more processes?
>
Codewise it is possible, maybe by adding a sysctl or CONFIG_, but I am not sure
the best practice to do this with the kernel?

Kees/Andrew, do you have suggestions ?

Thanks
Jeff


> thanks,
> -- Shuah
>
