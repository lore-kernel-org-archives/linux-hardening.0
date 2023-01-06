Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFCAC54EBD
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjAFTLV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjAFTLU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 14:11:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2B68799
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 11:11:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id dw9so969675pjb.5
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 11:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8D3UMgiXLWkn97zxdcVsZ26wy/4Qk/KB4lcp4wb6CBg=;
        b=A4AqfUS5XUfLmvuEwP4oYqK2ebk4628oLq8T74ED9gI/jsApNxIUxodGWGQb0A3cXM
         eRO1DyGJJK2WjsworIDKJ7ufOGIEkbe6lybdBjsrvWkehXq870VUkEVa00BSjANutHiW
         oTJs0pI9PQf+0H6roXuPbQzeUkKXk4cteN3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D3UMgiXLWkn97zxdcVsZ26wy/4Qk/KB4lcp4wb6CBg=;
        b=C6NA6INpsMRgqI/GGequr+IFXEa8k1++vYx7yKh6WOawKjTACxZK4E80DeZILNVglJ
         biaDSIlJXFeukTG0vHPVL675iUfzGzikW/XGvXhYzjtjZJ1cnBbNSuTpMevWjzQ35zdD
         RJGWQjSraQUdoMxezcwueQ1VJF2voUa9SIUmw6o+XQKQHeBvWzBkEY2+f+Iw69aJixFh
         IJRO7zCDqj7FYHnbNFqgRC6kMB3y0kSB0e5f3rCUSOowf6svS4f//lqJtfdo1+tdlvQU
         Y41yEPjwDwVYpAQkGpbs03S9TBEfM6ORn3IbzAFoE05WDJw1RQJoDNHAeorEH0nEcpQv
         hD6A==
X-Gm-Message-State: AFqh2kr8jmavub7mQc3q4SQiJ1lwwQTtjii0NllIupMXux2ZDn8MNtcc
        s2CY+z7bJKPKE1kKsGf97Fc6Hg==
X-Google-Smtp-Source: AMrXdXvYyR1F/thrOSPadqoE90Q0LDkthAlS9+yTY4mnVKRYpyTjuE3IUhd/bTftBN8cldUyhmW4Dw==
X-Received: by 2002:a05:6a21:7893:b0:af:1a39:553d with SMTP id bf19-20020a056a21789300b000af1a39553dmr86781422pzc.14.1673032279194;
        Fri, 06 Jan 2023 11:11:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b0055f209690c0sm688639pfb.50.2023.01.06.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:11:18 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:11:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
Message-ID: <202301061107.C56365E@keescook>
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
 <Y7hDGoCbWG2ZYdlV@alley>
 <20230106121457.05edbbdf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106121457.05edbbdf@gandalf.local.home>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 06, 2023 at 12:14:57PM -0500, Steven Rostedt wrote:
> On Fri, 6 Jan 2023 16:49:46 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > > Index: linux/lib/vsprintf.c
> > > ===================================================================
> > > --- linux.orig/lib/vsprintf.c
> > > +++ linux/lib/vsprintf.c
> > > @@ -2738,6 +2738,15 @@ int vsnprintf(char *buf, size_t size, co
> > >  	if (WARN_ON_ONCE(size > INT_MAX))
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * C99 allows @buf to be NULL when @size is 0. We treat such NULL as if
> > > +	 * @buf pointed to 0-sized buffer, so we can both avoid a NULL pointer
> > > +	 * dereference and still return # of characters that would be written
> > > +	 * if @buf pointed to a valid buffer...
> > > +	 */
> > > +	if (!buf)
> > > +		size = 0;  
> > 
> > It makes sense except that it would hide bugs. It should print a
> > warning, for example:
> 
> I agree. This is a bug, and should not be quietly ignored.

Yup.

> 
> > 
> > 	char *err_msg;
> > 
> > 	err_msg = check_pointer_msg(buf);
> > 	if (err_msg) {
> > 		WARN_ONCE(1, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n");
> > 		size = 0;
> > 	}
> 
> 	if (WARN_ONCE(err_msg, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n"))
> 		size = 0;

Also good. Please CC me for an Ack when this is a full patch. :)

-Kees

-- 
Kees Cook
