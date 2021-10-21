Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB51C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9CE6128E
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 20:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhJUUMl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhJUUMh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 16:12:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38AC061348
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y4so1229767plb.0
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s1+yeGZaBzg+DezicZ/S6RHWxeVrK0TuafKlv+G0xjQ=;
        b=EVANbVhuKeeWYQIcn7fQOXbd1T2PwQDfbVieAkktbi+BjSgOHLLzFKAPgw4SV4AHbN
         mFbenZ0P/2cuckeJEs+U5N7XMQ6Th8ZYlWsvNijcJ6uthuX2rDJOE5u5YKi8XJW7IOV/
         6eQFtmVgdxEToNtR0hrlXfpEANf+fgtYlACP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s1+yeGZaBzg+DezicZ/S6RHWxeVrK0TuafKlv+G0xjQ=;
        b=euQv0bZOstGN6A27lPn9MKqSiZCUh2ebq1c/DO0skQFWRtfCb749gIudc7PuftJsRp
         ittRPIquI+/pd3Z7iEZHDH2mDtRR76LvmUfPXJBYFcDmKAYMT4TwcMnh6Y+I/VCtfPJ3
         crkfbW0FuSusQJIbXspQoW0iCH+PUfSEhN6D0XVMYO0lhcU6p1aP+EYAEzFdeY5TJcB7
         PBZ6M30E9aciezVi+9YQ5/zc+noZGZeq5NJPI88bMme81K6dk3QhPLyMnINMGT+z1psd
         gvQJxgeVu6Zkjo6pln6pVAwLX/8NOjgGvW6HuRz678/HmE//GQIPqNt91Rn7UJLhuvWA
         UePw==
X-Gm-Message-State: AOAM530ANPPSZ1deE4gFqP2NcdbQCsJgRuk0e6Aj3AEBQO5AMngpTnPf
        VS7FNssYSZjCeyd1oeyVjSaqMw==
X-Google-Smtp-Source: ABdhPJxCvQAVXdM2Ce6Kgyx1ISIlaRS4sllWhsl1Vw4PA9wUov2YtR7y2YSEZwksZFFzJsN0YeLcrg==
X-Received: by 2002:a17:903:1c6:b0:13f:2b8:afe8 with SMTP id e6-20020a17090301c600b0013f02b8afe8mr7205298plh.81.1634847020362;
        Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b130sm7124117pfb.9.2021.10.21.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:10:20 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:10:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <202110211309.A4DFAE27@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <202110211008.CC8B26A@keescook>
 <20211021193033.GW174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021193033.GW174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 09:30:33PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 21, 2021 at 10:09:33AM -0700, Kees Cook wrote:
> 
> > > Hi Peter,
> > > 
> > > Can you add this to the wchan series, please? This should help wchan from
> > > regressing in the future, and allow us to notice if the depth accidentally
> > > changes, like Mark saw.
> > > ---
> > 
> > I'd like to make sure we have a regression test for this. Will you add
> > this to the wchan series please?
> 
> I have it there, but it's in the part that didn't make it in yet. I'm
> currently in the progress of reworking that.
> 
> Do you want it it ahead of all that?

Nah, that's fine. I'm not in any rush; I just wanted to make sure it
didn't get lost. I didn't realize it was already there (I had only seen
the -tip emails). Sorry for the noise; thanks!

-Kees

-- 
Kees Cook
