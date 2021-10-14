Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B8C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 01:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F9A611C1
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 01:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJNBnR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 21:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhJNBnQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 21:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634175672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIkaijae5P+JkUkpof6h1wsF8G71ZnOerZjw8vEk7g0=;
        b=ENCeYPOHpuQiNSB0ZWWVfY6NHz+Cf7eJcB2kbJHUA5PDSw5JiEugiKLFBgf8VbQIRods2O
        YM/lXcB7AGyqaWOsQZ7yg77WcXYnoSfOIkc67emhI7JNKY+0g8jRarcZYIPizxLJPp1W28
        BenTr7As6p/lVny7W3lhKSdYkfDSkPQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-20PzB19-PHyGJHjE9bbPAw-1; Wed, 13 Oct 2021 21:41:06 -0400
X-MC-Unique: 20PzB19-PHyGJHjE9bbPAw-1
Received: by mail-qt1-f197.google.com with SMTP id x28-20020ac8701c000000b0029f4b940566so3422170qtm.19
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 18:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIkaijae5P+JkUkpof6h1wsF8G71ZnOerZjw8vEk7g0=;
        b=RdUE8jiQpxv29NS+V5KXGypkfSyBA9nC/BQGpcF6ZCxuUjsRhhJwXAuYcrq/QJnPus
         UK/mkuKLzsTfM0KBKN6iN++7AtnEtfO7YOWVEtWrIHYBQXKH3An7XmT1nm/Nf2afJ3/1
         Q0eON4qhIBUnNgB7bOSQ7zBtfM+pz6qJ9P2CaFGjur4wvwcmhJlmtYW8A02L3cBt/pAp
         mY+pG/a6MQjjG27BjkZuGX24726IWnoK2olW6g+pTedAGXI9gbIMfMqyi47iogHhQp1N
         CyVuC2Eija/pEGPiJf1f6kBK++87F1F5VSqoNZBefQlW4rm1YSr6AyYiD2Mupyi2QcFJ
         OP8A==
X-Gm-Message-State: AOAM533VQ4Hwv1TKF8mSXJdmHim4HFglBqNq+QrgfQusndmYzcv2hkcj
        fQsFaI78RwDuDkXS4keA8XJBEf2KzWYOuisjTSwoEG8WHGGWkcHEZsemK3nF+J2E3NPD0Z6Lmt8
        CCrDYOmP1wAqMZizPte72Bnt1vwHt
X-Received: by 2002:a37:43c2:: with SMTP id q185mr2321553qka.512.1634175665561;
        Wed, 13 Oct 2021 18:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXcY5HYwk05IO41TYoOci3q1aRvUhi28MMJm1T3T4rnl+CWgD8I1JKfzSN2+wmwif2o6R0Og==
X-Received: by 2002:a37:43c2:: with SMTP id q185mr2321538qka.512.1634175665333;
        Wed, 13 Oct 2021 18:41:05 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c26sm819731qtm.21.2021.10.13.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 18:41:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:41:01 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20211014014101.6du6jj2o7g4ficu5@treble>
References: <20210903021326.206548-1-keescook@chromium.org>
 <202110111403.3C59BF77@keescook>
MIME-Version: 1.0
In-Reply-To: <202110111403.3C59BF77@keescook>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > From: Marios Pomonis <pomonis@google.com>
> > 
> > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > assumes that the address in the stack is a return address and decrements
> > it by 1 in order to find the proper depth of the next frame.
> > 
> > This issue was discovered while testing the FG-KASLR series[0][1] and
> > running the live patching test[2] that was originally failing[3].
> > 
> > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > [1] https://github.com/KSPP/linux/issues/132
> > [2] https://github.com/lpechacek/qa_test_klp
> > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > 
> > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Ping again; Josh can you take this please?

I'm confused how this still fixes anything after Masami's patch set,
which is now in linux-next.

After those patches, for a CALL-type ORC entry, the unwinder sets
state->ip to the address returned by unwind_recover_ret_addr().  In the
case of a kretprobe, that means that state->ip will no longer point to
kretprobes_trampoline() -- making the above patch description incorrect.

Instead, state->ip will then contain the original call return address
which was replaced by kretpobes.  So it looks to the unwinder like a
normal call return address, and 'state->signal' should remain false.

Am I missing something?

-- 
Josh

