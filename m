Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237DC433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 20:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiBBUwD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346946AbiBBUwC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 15:52:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF3C061714
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 12:52:02 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d1so279368plh.10
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPEMedQu4jTNYHJmp71olOjxDB0xRf7+fA/WfqhgIVA=;
        b=EAlOPLnqtqVr6UWoSRQCQiil8xtekqy0ucrjftpEPAugnwRJaCgExC22zDJ3dLa32p
         IEtN7Zr25QITv0r/g5zMyAkjB0tErkFPXm8iUVah6oF4t6y9SojxveFQX8MkNVFtbGkl
         Y02gvbpZvq4nfuJCQ6hoiWRRvdk4dxnYiQ4EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPEMedQu4jTNYHJmp71olOjxDB0xRf7+fA/WfqhgIVA=;
        b=so45JcjL5tMhl043hQilgsKGc5UEb3Hql9G8DvMPjDb5q6/9N93f5A6JklcfMN6wP+
         wV0BUD/8OFUTnkbM0a5UPw34NqFo3zr4phKZNOhru8Lv4kxlXGH01caVUQW0fcaR3rnt
         NKIY573ZfSVrV2zZ9Zt2aAHKKXLVmgwKrWPvT2oi9CWtCLTMQnI17skwEhImks2zM69E
         k8CSGLxrG9v3dOll1WWkBHOHkRPV7nu+RghTyMeJZmYiSAHxsa+3u8eAw3OX8QqIodjZ
         17mazGt7bIkduASEa4wkdWlm8Bv+nXWmnt6CNsC3TMNwtTR3EJteeOYcvwSeJMDaflNi
         c5hQ==
X-Gm-Message-State: AOAM530rCdCKshlRh36vD4R92jHN+qLSxbz0pTpSgPDoAhGF9q/VyWlP
        DXEcZQQY9IrXFzNgfkgNTOLOuw==
X-Google-Smtp-Source: ABdhPJxdd9YfV7EbD3xvSuaZUXxBX9DB7g4c3W3Ag1C9zKX/pGzoQSAo0PKxahuKofQSPv3t073cQw==
X-Received: by 2002:a17:902:d64a:: with SMTP id y10mr18742283plh.66.1643835121970;
        Wed, 02 Feb 2022 12:52:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f16sm28486385pfa.147.2022.02.02.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:52:01 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:52:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202021237.487D3DE73@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160149.GA2322037@roeck-us.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 02, 2022 at 08:01:49AM -0800, Guenter Roeck wrote:
> On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:
> > Add a simple test for strlen() functionality, including using it as a
> > constant expression.
> > 
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > I'll be taking this as part of my Clang FORTIFY_SOURCE series.
> > ---
> >  lib/test_string.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/lib/test_string.c b/lib/test_string.c
> > index 9dfd6f52de92..59994f552c48 100644
> > --- a/lib/test_string.c
> > +++ b/lib/test_string.c
> > @@ -179,6 +179,38 @@ static __init int strnchr_selftest(void)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Unlike many other string functions, strlen() can be used in
> > + * static initializers when string lengths are known at compile
> > + * time. (i.e. Under these conditions, strlen() is a constant
> > + * expression.) Make sure it can be used this way.
> > + */
> > +static const int strlen_ce = strlen("tada, a constant expression");
> > +
> 
> This results in:
> 
> lib/test_string.c:188:30: error: initializer element is not constant
>   188 | static const int strlen_ce = strlen("tada, a constant expression");
> 
> for several of my tests. I don't think you can mandate that a compiler
> implements this.

Which tests?

This property of strlen() is already required by our builds (this is how
I tripped over it). For example:

drivers/firmware/xilinx/zynqmp-debug.c:

#define PM_API(id)               {id, #id, strlen(#id)}
static struct pm_api_info pm_api_list[] = {
        PM_API(PM_GET_API_VERSION),
        PM_API(PM_QUERY_DATA),
};



> 
> Guenter
> 
> > +static __init int strlen_selftest(void)
> > +{
> > +	/* String length ruler:         123456789012345 */
> > +	static const char normal[]   = "I am normal";
> > +	static const char *ptr       = "where do I go?";
> > +	static const char trailing[] = "hidden NULLs\0\0\0";
> > +	static const char leading[]  = "\0\0hidden text";
> > +
> > +	if (strlen(normal) != 11)
> > +		return 0x100001;
> > +	if (strlen(ptr++) != 14)
> > +		return 0x100002;
> > +	if (strlen(ptr++) != 13)
> > +		return 0x100003;
> > +	if (strlen(trailing) != 12)
> > +		return 0x100004;
> > +	if (strlen(leading) != 0)
> > +		return 0x100005;
> > +	if (strlen_ce != 27)
> > +		return 0x100006;
> > +
> > +	return 0;
> > +}
> > +
> >  static __exit void string_selftest_remove(void)
> >  {
> >  }
> > @@ -212,6 +244,11 @@ static __init int string_selftest_init(void)
> >  	if (subtest)
> >  		goto fail;
> >  
> > +	test = 5;
> > +	subtest = strlen_selftest();
> > +	if (subtest)
> > +		goto fail;
> > +
> >  	pr_info("String selftests succeeded\n");
> >  	return 0;
> >  fail:
> > -- 
> > 2.30.2
> > 

-- 
Kees Cook
