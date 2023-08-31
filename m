Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318CDCA0FE1
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjHaWjN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHaWjN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 18:39:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B655E5F
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 15:39:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26d5970cd28so1014670a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693521549; x=1694126349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5C93ShUAQJdbWhmcDSSeEctnZZ6hfSTIk6ij7roG6Q=;
        b=gR9uDJlWulrGWSA4N/IG7mGXiariXReXigoBerUuzMkSkP1AvtfOM9axjiZRhYTwBg
         eqgD1OXmIHZwx2KRPbRMl65+xA6ZiGDnOWcXHfRbMya40G4gqeC6AhWGTec39Xm9g1VV
         OAzv5AMprU/NeOzBBXolIOofv4OwWyOYhTN6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693521549; x=1694126349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5C93ShUAQJdbWhmcDSSeEctnZZ6hfSTIk6ij7roG6Q=;
        b=FcH0HRPR11jnyh4Yq8X5O7EWMz5A5hyssTjNOGnjV8wmsWVfBhHzF1JsxhR/WZDsO8
         2N7FmO5C7tYxT8TgAzOSBRRE8umBcWqgkxidk8lTjd17CV8NX2p7cnB0WbWzRsoSE+ZO
         YcLshWMnXupsBS/aL+JSilC9aVVDARSuGuStpD8CpWxtzHGFv8Zh4IND8W64cBoJc9bI
         VLPJ1V1+u48ipeHQ3sRszi3egFFW/dXDA95TTEnQ5uiDBUUJzh6lFYPZjhrIdMhsLNEL
         7DlkwPY2U2GLFy/5YYkkKJpK38d14DgHTfxYSxUYs1JisIks2LGqg564bzERvnob0tNj
         5J6Q==
X-Gm-Message-State: AOJu0YwbEx49j4iIQ3rGSC+J+Sbey4DHV/dCMI/mIZ0IYA7j9OqfE6a3
        7A4dmI0QLEEbKTnM4o8lFV+WyQ==
X-Google-Smtp-Source: AGHT+IEjV9HAbVVTP4HHayfcKDshqiKuBeHQR01S10RLV6D50ErdDs12lZF/jBw3I3fgHz1G8q+k9w==
X-Received: by 2002:a17:90a:3003:b0:259:466:940f with SMTP id g3-20020a17090a300300b002590466940fmr659783pjb.22.1693521549595;
        Thu, 31 Aug 2023 15:39:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a65c300b00263b4b1255esm3331953pjs.51.2023.08.31.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 15:39:09 -0700 (PDT)
Date:   Thu, 31 Aug 2023 15:39:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] pstore: Base compression input buffer size on
 estimated compressed size
Message-ID: <202308311538.2BD3826FD@keescook>
References: <20230831210125.gonna.173-kees@kernel.org>
 <CAMj1kXE2kz1raOSy+ethim7YyFvKs+_uP2xhvndXDAbLdJDLdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE2kz1raOSy+ethim7YyFvKs+_uP2xhvndXDAbLdJDLdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 31, 2023 at 11:34:17PM +0200, Ard Biesheuvel wrote:
> On Thu, 31 Aug 2023 at 23:01, Kees Cook <keescook@chromium.org> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
> > removed some clunky per-algorithm worst case size estimation routines on
> > the basis that we can always store pstore records uncompressed, and
> > these worst case estimations are about how much the size might
> > inadvertently *increase* due to encapsulation overhead when the input
> > cannot be compressed at all. So if compression results in a size
> > increase, we just store the original data instead.
> >
> > However, it seems that the original code was misinterpreting these
> > calculations as an estimation of how much uncompressed data might fit
> > into a compressed buffer of a given size, and it was using the results
> > to consume the input data in larger chunks than the pstore record size,
> > relying on the compression to ensure that what ultimately gets stored
> > fits into the available space.
> >
> > One result of this, as observed and reported by Linus, is that upgrading
> > to a newer kernel that includes the given commit may result in pstore
> > decompression errors reported in the kernel log. This is due to the fact
> > that the existing records may unexpectedly decompress to a size that is
> > larger than the pstore record size.
> >
> > Another potential problem caused by this change is that we may
> > underutilize the fixed sized records on pstore backends such as ramoops.
> > And on pstore backends with variable sized records such as EFI, we will
> > end up creating many more entries than before to store the same amount
> > of compressed data.
> >
> > So let's fix both issues, by bringing back the typical case estimation of
> > how much ASCII text captured from the dmesg log might fit into a pstore
> > record of a given size after compression. The original implementation
> > used the computation given below for zlib:
> >
> >   switch (size) {
> >   /* buffer range for efivars */
> >   case 1000 ... 2000:
> >         cmpr = 56;
> >         break;
> >   case 2001 ... 3000:
> >         cmpr = 54;
> >         break;
> >   case 3001 ... 3999:
> >         cmpr = 52;
> >         break;
> >   /* buffer range for nvram, erst */
> >   case 4000 ... 10000:
> >         cmpr = 45;
> >         break;
> >   default:
> >         cmpr = 60;
> >         break;
> >   }
> >
> >   return (size * 100) / cmpr;
> >
> > We will use the previous worst-case of 60% for compression. For
> > decompression go extra large (3x) so we make sure there's enough space
> > for anything.
> >
> > While at it, rate limit the error message so we don't flood the log
> > unnecessarily on systems that have accumulated a lot of pstore history.
> >
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Link: https://lore.kernel.org/r/20230830212238.135900-1-ardb@kernel.org
> > Co-developed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2:
> >  - reduce compression buffer size to 1.67x from 2x
> >  - raise decompression buffer size to 3x
> 
> LGTM
> 
> Thanks for picking this up.

You bet! :) I've pushed it out, and if the bots don't yell at me I'll
send a PR to Linus tomorrow.

-- 
Kees Cook
