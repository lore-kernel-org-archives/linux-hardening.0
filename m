Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5407CC54EAA
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjA0TYB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjA0TYA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 14:24:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7087E6F5
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 11:23:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jm10so5973602plb.13
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2ttKujJthD1r1Z4ZbanCKPljAQjrJZL0v7kGBHOnxQ=;
        b=LIT8FrflzvmNjKlokavj8t9qklGf2z+fC5ZXmVTg/V1WPzhjXoIxMLl3TGOd9P1czB
         0P6t8CHdT3hPjs2p2eC2FRuQZZNuA72Uo5CW4xKyEWE3u69ZSA9phUlewzcVNiluTUFv
         N1GZJ1p9tvn3GosvLI7w5vR5yA3G9r1uI5w7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2ttKujJthD1r1Z4ZbanCKPljAQjrJZL0v7kGBHOnxQ=;
        b=O2OYj4Cn6IdbwfnpvrEhfj4PW/JwBtW6K9lb19JSOPE1zQ80/ZjG7nwRadPlMrJ/e3
         40MY6GnzLVDp1TsR/CrgrSJghCxrz9dZm1g5gS0X1htcBt5if+vYCgVDOpiCrxitkkBt
         sWsC9FJcTzfzDEQr14bmu+MQmnNARlTxzmiaHhmZQOZ8VAGP27dVevQISddcnEMHIqQx
         XuZWsr+0NeeRmY8PHYqnOXewdH60Q/hH76zEmHtQhOE3tsOCL9oos13jYt9wc326F6dn
         oipsi54YFGCPIO4bTzJ8ghKe31AyELIwTfGdsVG/aE39XhNxzFh5A8vs4eP7LqI7uVfc
         wkPw==
X-Gm-Message-State: AO0yUKVFlm8d6bU/2CdrBqi2yb5/Rxe7bOtMf3zhL42hqqfnIKNQQJO7
        PHThNt5ck98WcQLJIr33mcLrzg==
X-Google-Smtp-Source: AK7set9Y1R4fNYl5iiJNjPVCiIEga/WC7wAX+mM99tGpF1Yw6uDJ7Etw+186f9uQO1JeU43343EDGA==
X-Received: by 2002:a17:90b:1c0d:b0:22c:10e2:9e3f with SMTP id oc13-20020a17090b1c0d00b0022c10e29e3fmr10343020pjb.0.1674847438428;
        Fri, 27 Jan 2023 11:23:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a708800b00213202d77d9sm3034456pjk.43.2023.01.27.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:23:58 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:23:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Leonardo Bras <leobras.c@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] powerpc/rtas: Replace one-element arrays with flexible
 arrays
Message-ID: <202301271120.B83DA0B3@keescook>
References: <20230127085023.271674-1-ajd@linux.ibm.com>
 <87357wp1h7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87357wp1h7.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 07:10:28AM -0600, Nathan Lynch wrote:
> Andrew Donnellan <ajd@linux.ibm.com> writes:
> > Using a one-element array as a fake flexible array is deprecated.
> >
> > Replace the one-element flexible arrays in rtas-types.h with C99 standard
> > flexible array members instead.
> >
> > This helps us move towards enabling -fstrict-flex-arrays=3 in future.
> >
> > Found using scripts/coccinelle/misc/flexible_array.cocci.
> >
> > Cc: Nathan Lynch <nathanl@linux.ibm.com>
> > Cc: Leonardo Bras <leobras.c@gmail.com>
> > Cc: linux-hardening@vger.kernel.org
> > Link: https://github.com/KSPP/linux/issues/21
> > Link: https://github.com/KSPP/linux/issues/79
> > Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/rtas-types.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/asm/rtas-types.h
> > index 8df6235d64d1..40ec03a05c0b 100644
> > --- a/arch/powerpc/include/asm/rtas-types.h
> > +++ b/arch/powerpc/include/asm/rtas-types.h
> > @@ -44,7 +44,7 @@ struct rtas_error_log {
> >  	 */
> >  	u8		byte3;			/* General event or error*/
> >  	__be32		extended_log_length;	/* length in bytes */
> > -	unsigned char	buffer[1];		/* Start of extended log */
> > +	unsigned char	buffer[];		/* Start of extended log */
> >  						/* Variable length.      */
> >  };
> >  
> > @@ -85,7 +85,7 @@ struct rtas_ext_event_log_v6 {
> >  					/* that defines the format for	*/
> >  					/* the vendor specific log type	*/
> >  	/* Byte 16-end of log */
> > -	u8 vendor_log[1];		/* Start of vendor specific log	*/
> > +	u8 vendor_log[];		/* Start of vendor specific log	*/
> >  					/* Variable length.		*/
> >  };
> 
> I see at least one place that consults the size of one of these structs,
> in get_pseries_errorlog():
> 
> 	/* Check that we understand the format */
> 	if (ext_log_length < sizeof(struct rtas_ext_event_log_v6) || ...
> 
> Don't all such sites need to be audited/adjusted for changes like this?

Yeah, I'd expect a binary comparison[1] before/after to catch things like
this. E.g. the following C files mention those structs:

arch/powerpc/platforms/pseries/io_event_irq.c
arch/powerpc/platforms/pseries/ras.c
arch/powerpc/kernel/rtasd.c
arch/powerpc/kernel/rtas.c

-Kees

[1] https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

-- 
Kees Cook
