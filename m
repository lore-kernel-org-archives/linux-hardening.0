Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_SECURITY,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB915C43461
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 00:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAB860FE5
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Apr 2021 00:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhDQADF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhDQADD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 20:03:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D003C06175F;
        Fri, 16 Apr 2021 17:02:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618617752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAJKO8dWaz92ciG9zIlL+Ikr/RFMxTd4id9MFoOL6bc=;
        b=BQXVF4t3ExWyQ3Vf3r8aYeZLNQy1SwgLH0Qp0MjoSfMVfT5+SpmyUjHZjdVpQS8uZtF5RJ
        PofMRXYf+QoSfDvGPhJl1lBkA0hJuJeh4X2lGN1kg3+0nqRzmgKfwDB0t5yJE2lpHEwx8k
        JK8XKGlUR/FwioDmCGTl1CUEsxt6q0cO91otV03ZSsL8kl24X8+cEfk+trbSRoYhCsKJPo
        VZp9sDn5I6xhCoRHsYEKDtenfpWF8F1+fFEJ7OwVIH06CF3USV1kd4j65CdKzKMfT7Nnzu
        J3H8w1vaWLadlqoHETk2/q74+1r9st7F6FuvYG91kX+xy3R5Wikgl3RQXLE91Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618617752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAJKO8dWaz92ciG9zIlL+Ikr/RFMxTd4id9MFoOL6bc=;
        b=IRiiJJW6d+3NSThZL1todwLecniMG+DONP2KvG/Z9I42DlVB97mhnAyx4zeCk7jQHWtZLK
        +Rzih2iiyKn2vQBw==
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 06/15] x86: Avoid CFI jump tables in IDT and entry points
In-Reply-To: <202104161642.B72BD68@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com> <20210416203844.3803177-7-samitolvanen@google.com> <87im4luaq7.ffs@nanos.tec.linutronix.de> <202104161642.B72BD68@keescook>
Date:   Sat, 17 Apr 2021 02:02:31 +0200
Message-ID: <87czutu6aw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 16 2021 at 16:56, Kees Cook wrote:
> On Sat, Apr 17, 2021 at 12:26:56AM +0200, Thomas Gleixner wrote:
>> Where is the analysis why excluding 
>> 
>> > +CFLAGS_REMOVE_idt.o		:= $(CC_FLAGS_CFI)
>> > +CFLAGS_REMOVE_paravirt.o	:= $(CC_FLAGS_CFI)
>> 
>> all of idt.c and paravirt.c is correct and how that is going to be
>> correct in the future?
>> 
>> These files are excluded from CFI, so I can add whatever I want to them
>> and circumvent the purpose of CFI, right?
>> 
>> Brilliant plan that. But I know, sekurity ...
>
> *sigh* we're on the same side. :P I will choose to understand your
> comments here as:
>
> "How will enforcement of CFI policy be correctly maintained here if
> the justification for disabling it for whole compilation units is not
> clearly understandable by other developers not familiar with the nuances
> of its application?"

Plus, if there is a justification for disabling it for a whole
compilation unit:

 Where is the tooling which makes sure that this compilation unit is not
 later on filled with code which should be subject to CFI?

Thanks,

        tglx


