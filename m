Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F97C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 04:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63E760C4A
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 04:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhJNEyn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 00:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNEyl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 00:54:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA457C061746
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 21so3279337plo.13
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJDlq0YOd3FIp9yltFh10NZ+GTEdKsRbgNrMT/fMhy8=;
        b=l7CblFVsCZ9q2NJP3e6RC8afxRYWYpADQJqPj/4vdlDauWotjdin6xfqggpL2Ard9Z
         Gw9G1Gf0s6Coi79Pqbh6QyIJX6A+DTtF0+VszjbTrDFLSzQrep9oJjDiXz4XiEsjEk/D
         IwMKa1N11jJ36T6XQl7xIrSisVsiFt9cK91mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJDlq0YOd3FIp9yltFh10NZ+GTEdKsRbgNrMT/fMhy8=;
        b=Bi/tgoqLGIFiT+y/Puo0/vM3o/se7mmpcrjud3IqrjA+nygZMPgqkCKkUwgnDFfZx8
         y/woxef8JbVQ/tvf8jKrgm35PDN+1ajH6KyaLd/8xAZekhOfrx1x/XpdxGQ3NWKJtcFr
         mLRfto51g2FtSPI8u5VLETA246D1kMVAWccVNDLHDLvG9MqANbHkvkxtBBhZbga0aCHq
         cOruPiJIJv3+YsUmrUReq+YIP/cXT46tmYbUN9SoCkIgEGWRR8MzAgohE2DiNCHFou3L
         lvYdEBX/3l96Kv85Ju0Ii8R+dY7Mr6YpTH1oIh/bT3Eu8KGIGqZtfA8paMsVxvASt8QN
         FMKA==
X-Gm-Message-State: AOAM530hYB5rEKcyP3AkDPXZzPRKhHxtxabfEf5THjd08d7wLfgTrJS2
        uSt07IG1MSbfJrsPa96FEh+o2Q==
X-Google-Smtp-Source: ABdhPJwwQZfVLF1jPk/lor0aB50rGf7fWVKbiUn2BwtlZa1P/VwX+4e2ZVASHShBHv5BWJhIvXW9lg==
X-Received: by 2002:a17:90a:c594:: with SMTP id l20mr17666973pjt.223.1634187157408;
        Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm1066229pgv.82.2021.10.13.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 21:52:37 -0700 (PDT)
Date:   Wed, 13 Oct 2021 21:52:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Marios Pomonis <pomonis@google.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-ID: <202110132151.F78F49AD8@keescook>
References: <20210903021326.206548-1-keescook@chromium.org>
 <202110111403.3C59BF77@keescook>
 <20211014014101.6du6jj2o7g4ficu5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014014101.6du6jj2o7g4ficu5@treble>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 06:41:01PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> > On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > > From: Marios Pomonis <pomonis@google.com>
> > > 
> > > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > > assumes that the address in the stack is a return address and decrements
> > > it by 1 in order to find the proper depth of the next frame.
> > > 
> > > This issue was discovered while testing the FG-KASLR series[0][1] and
> > > running the live patching test[2] that was originally failing[3].
> > > 
> > > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > > [1] https://github.com/KSPP/linux/issues/132
> > > [2] https://github.com/lpechacek/qa_test_klp
> > > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > > 
> > > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Ping again; Josh can you take this please?
> 
> I'm confused how this still fixes anything after Masami's patch set,
> which is now in linux-next.
> 
> After those patches, for a CALL-type ORC entry, the unwinder sets
> state->ip to the address returned by unwind_recover_ret_addr().  In the
> case of a kretprobe, that means that state->ip will no longer point to
> kretprobes_trampoline() -- making the above patch description incorrect.
> 
> Instead, state->ip will then contain the original call return address
> which was replaced by kretpobes.  So it looks to the unwinder like a
> normal call return address, and 'state->signal' should remain false.
> 
> Am I missing something?

I'll let Marios answer in more detail, but my understanding is that
Masami's patch set didn't solve the FGKASLR-vs-kretprobes issue[1].
I don't understand _why_ yet, though.

-Kees

[1] https://lore.kernel.org/all/CAKXAmdgS3SL_qyjzjY32_DXe3WVTN+O=wYwJ9vkUXKhjmt87fA@mail.gmail.com/

-- 
Kees Cook
