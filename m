Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D4C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Oct 2022 20:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiJZUdv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiJZUdu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Oct 2022 16:33:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFBE7E315
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 13:33:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e129so16078951pgc.9
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0kxEl2S2a68MlFLjbJ42CBU2Unm12GzaCEH0lHQWuY=;
        b=obeJhxI+ENacAUlLPp+v61BhonjTS9sjU5Bul5it9+TdjHX1b4Op8qbkgN5uiAd9Gn
         Rd++IsKXJUdHvO+QOHUTGWHEmxI4CX4zFjED0OsH9PsV0jOV3C/F27o4oDQHKnHqCHbR
         ik1V1MssxtQ/uj/MararQ0+xsoC+XV6V9lfSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0kxEl2S2a68MlFLjbJ42CBU2Unm12GzaCEH0lHQWuY=;
        b=m5d3V1JN2ntgaqcAfn2+vEj5ylvB3mxp2LkuG9y4NJse7fuToZjI2YEw+W/nkWmQVL
         2nzdLCM4NXjTrzVq/G5NEo211yJMHVa6Ju3fmyYZWDpFygMoBC3Ari6WLY5lraQskfLJ
         hyywtDgvxodcQUtwRyfb2yBh7X32B1pmv3OLa2HiPGRLkw7bmYl26XFif0lQ5iKQ8o42
         Q4rdBglRrpKXMs6O0bgtRHdAHgqCoEYt5opwfnAKzC/NQLtNsTlC2zKXlEzBuA+mY7GH
         cvAgjQvqzaJbaIqpCJoSUA7p24NsFJvGQbirGTLQe3r8AISULnhJwupGtq+4bN4/Tftc
         mYrA==
X-Gm-Message-State: ACrzQf3MBLzeQM9EcoztimkGhz6KHUmLRF/9jpmIvv+3EtXpp9CGridh
        BUOiQOh52eJGrwUd2HiVrZ6yBQ==
X-Google-Smtp-Source: AMsMyM4LL5FU6eakv/Sxfgq+61DepYp6/wpZrXWfv9mn6/p1V/LnMHUZp0tBb0NQskKtGvdKrQEfXA==
X-Received: by 2002:a05:6a00:2307:b0:565:9079:b165 with SMTP id h7-20020a056a00230700b005659079b165mr46196368pfh.53.1666816429195;
        Wed, 26 Oct 2022 13:33:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s27-20020aa78bdb000000b0056bc30e618dsm3377335pfd.38.2022.10.26.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:33:48 -0700 (PDT)
Date:   Wed, 26 Oct 2022 13:33:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Keith Packard <keithp@keithp.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Zorro Lang <zlang@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce flexible array struct helpers
Message-ID: <202210260904.41D0BE00A@keescook>
References: <20221024171848.never.522-kees@kernel.org>
 <20221024172058.534477-1-keescook@chromium.org>
 <87k04pf4tk.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k04pf4tk.fsf@keithp.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 24, 2022 at 11:35:03AM -0700, Keith Packard wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > + * struct flex_array_struct_example {
> > + *	...			 // arbitrary members
> > + *	bounded_flex_array(
> > + *		u16, part_count, // count of elements stored in "parts" below.
> > + *		u32, parts	 // flexible array with elements of type u32.
> > + *	);
> > + * );
> 
> > + * struct flex_array_struct_example {
> > + *	...		// position-sensitive members
> > + *	// count of elements stored in "parts" below.
> > + *	DECLARE_FAS_COUNT(u16, part_count);
> > + *	..		// position-sensitive members
> > + *	// flexible array with elements of type u32.
> > + *	DECLARE_FAS_ARRAY(u32, parts);
> > + * };
> 
> I'm sure there's a good reason, but these two macros appear to be doing
> similar things and yet have very different naming conventions. Maybe:
> 
>         FAS_DECLARE_COUNT(type, name)
>         FAS_DECLARE_ARRAY(type, name)
>         FAS_DECLARE(size_type, size_name, array_type, array_name)

Well, the custom has been for individual things, call it "DECLARE_*",
and for groups, we went with lower-case macros (e.g. struct_group()).

> 
> > +/* For use with flexible array structure helpers, in <linux/flex_array.h> */
> > +#define __DECLARE_FAS_COUNT(TYPE, NAME)					\
> > +	union {								\
> > +		TYPE __flex_array_elements_count;			\
> > +		TYPE NAME;						\
> > +	}
> 
> How often could that second "public" member be 'const'? That would catch
> places which accidentally assign to this field.
> 
> For code which does want to write to this field, is it mostly trimming
> data from the end, or does it actually smash in arbitrary values? For
> the former case, would it be helpful to have a test to make sure the
> assigned size isn't larger than the real size (yeah, that would probably
> take an extra field holding the real size), or larger than the current size?

I don't think this'll work within arbitrary struct declarations, but it
would be nice. :)

-- 
Kees Cook
