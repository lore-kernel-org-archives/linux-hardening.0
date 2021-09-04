Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED1C433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  4 Sep 2021 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEFC60F3A
	for <linux-hardening@archiver.kernel.org>; Sat,  4 Sep 2021 17:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhIDR4W (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 4 Sep 2021 13:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237271AbhIDR4V (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 4 Sep 2021 13:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630778118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6lcQHSayde3n9IkdvfIrHZle4H+zzn24IgjkiwSRWcs=;
        b=JMDrN2o/iAyhpl3faBpQhmMs9bHmNlCbCmIXiweX9z5DcNEZWe1srgbXqtfl54Ang5xXQ0
        uwYNSXNG3nO2k3sMqxlO38EzDmlIhnGMRlrZVIkZQTxz12jr8RbIh+KNJ1AR7WlC+/avMy
        WDbFO5iHhkSYGfYntoYLjt88zkQA1g0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ArVaMMAIPsCYea0PQuv2_A-1; Sat, 04 Sep 2021 13:55:16 -0400
X-MC-Unique: ArVaMMAIPsCYea0PQuv2_A-1
Received: by mail-qv1-f69.google.com with SMTP id i8-20020a0cf388000000b00377cd31a04bso4297763qvk.17
        for <linux-hardening@vger.kernel.org>; Sat, 04 Sep 2021 10:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6lcQHSayde3n9IkdvfIrHZle4H+zzn24IgjkiwSRWcs=;
        b=NGSQT4DhJ74iTLtabiYOcGfNWcYYpQAiMW8VAQ+WF2cYwifJC5Qi1OSe1gQGUGk6Fm
         mX9+TVB1e7UdNVtO9h5jlFUWS4U7hJhBHCfgehwWcYXA1LAPLlo+V2Dqgehgh5MGcy99
         FyPXZtXO8cLJUNAywIa4v3wpouCuyIJpdMHwk6F+V9GLezG1eSCIyVWIc0/MAvI4gh8E
         YnFuxcF2X65gp2n8wa+g8Buht+0MRSikws1IWJR/ySxB/JHGtJkU2dfMfB9Vv1ohiXlp
         eABnrye72SZS/5OJXJ/5muRT/f2TVj+QOKProsm+SRctFkWdYj2Tpl4/5zeLJfAYtb6y
         2Yiw==
X-Gm-Message-State: AOAM533XQJEQbr1xnLjqnSk+AvFfiffYez+z1skxxCDUvXrudxcEvU/Y
        rd0g7ZCRdpVy04ITt4vEj+V/3Kg01CV/QnG1gUjtC85QoeqkdMo4/He6OMhqoC8uwCV1+FoPSuk
        5ToW3CGn701Ek6vMe8LOWgi8qVotz
X-Received: by 2002:a37:f515:: with SMTP id l21mr4158583qkk.234.1630778115886;
        Sat, 04 Sep 2021 10:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynF9Y6BjqxIWiaX6cDMwcVqync6czUcP+2+d9LbHh6ElU+IIqbVYZyvvi6UbQI6IemnJWkUQ==
X-Received: by 2002:a37:f515:: with SMTP id l21mr4158578qkk.234.1630778115683;
        Sat, 04 Sep 2021 10:55:15 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l7sm2148433qki.99.2021.09.04.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:55:15 -0700 (PDT)
Date:   Sat, 4 Sep 2021 10:55:11 -0700
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
Message-ID: <20210904175511.oijbn4f2tzghwk7l@treble>
References: <20210903021326.206548-1-keescook@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20210903021326.206548-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> From: Marios Pomonis <pomonis@google.com>
> 
> Fix a bug in the ORC unwinder when kretprobes has replaced a return
> address with the address of `kretprobes_trampoline'. ORC mistakenly
> assumes that the address in the stack is a return address and decrements
> it by 1 in order to find the proper depth of the next frame.
> 
> This issue was discovered while testing the FG-KASLR series[0][1] and
> running the live patching test[2] that was originally failing[3].
> 
> [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> [1] https://github.com/KSPP/linux/issues/132
> [2] https://github.com/lpechacek/qa_test_klp
> [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> 
> Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I suspect this is fixed by:

  https://lkml.kernel.org/r/162756755600.301564.4957591913842010341.stgit@devnote2


> ---
>  arch/x86/kernel/unwind_orc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index a1202536fc57..8c5038b3b707 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -7,6 +7,7 @@
>  #include <asm/unwind.h>
>  #include <asm/orc_types.h>
>  #include <asm/orc_lookup.h>
> +#include <asm/kprobes.h>
>  
>  #define orc_warn(fmt, ...) \
>  	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
> @@ -414,6 +415,15 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
>  	return false;
>  }
>  
> +static bool is_kretprobe_trampoline(unsigned long ip)
> +{
> +#ifdef	CONFIG_KRETPROBES
> +	if (ip == (unsigned long)&kretprobe_trampoline)
> +		return true;
> +#endif
> +	return false;
> +}
> +
>  bool unwind_next_frame(struct unwind_state *state)
>  {
>  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> @@ -540,7 +550,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  		state->sp = sp;
>  		state->regs = NULL;
>  		state->prev_regs = NULL;
> -		state->signal = false;
> +		state->signal = is_kretprobe_trampoline(state->ip);
>  		break;
>  
>  	case UNWIND_HINT_TYPE_REGS:
> -- 
> 2.30.2
> 

-- 
Josh

