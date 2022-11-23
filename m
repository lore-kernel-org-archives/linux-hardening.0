Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F0C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Nov 2022 05:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiKWFP4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Nov 2022 00:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiKWFPz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Nov 2022 00:15:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39ABECCD0
        for <linux-hardening@vger.kernel.org>; Tue, 22 Nov 2022 21:15:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v3so15877488pgh.4
        for <linux-hardening@vger.kernel.org>; Tue, 22 Nov 2022 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpV9LZG6lum2+mJs6hiaJhY/GA7UnSa+zZbSm43A0ug=;
        b=cDeVvprPd40bk4/tjBwKAlkCE7CYWPe+LHBDXgCiAgsBMQBPE6TpXcNgWUk3jEhejY
         JGf+qknBzyWA481RCia2iuQpJZtg0muVzCUri5xXZk1KHO/zAwZy0qft9gdlIZMQLONN
         br2iEl5Zwjuz3zGFjCIRK0CksLz8BBUUnyhqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpV9LZG6lum2+mJs6hiaJhY/GA7UnSa+zZbSm43A0ug=;
        b=n7RacXLjJZ+NJC0bovbTwDJVYCjzre2psQG36XBxfMsF9DNJi5QSiAZdvYdBQd9RZN
         uPug6qD+Z0HVczrxWFesLPrPVoLPQKt6yK3x8W1A0BS/R9koLJT28oPHV/WRUD2C00lJ
         zmu7xuWSCym+4wvNJeyd4gIRcfuU6KirGvPUIsnEsTNvsIvJyTEvjT2P3w0mxbp75F5k
         hITU+UpbaE5IFEa++ZsaRHM0mk9WeJ6rtNPmQwbhvir9sDtHuelyZRBoSjPnNDi6ywjE
         1fUoZ1aBQN8AvRRYR8x4DHoQgHlC8YhAsu448qhFA28VoTW44a6Z1Sj3xhVUmcOdouey
         ixaA==
X-Gm-Message-State: ANoB5pkzYX6LbnqhuB2Pn4wtf2YKL8Ajm6T7k9VSsj2tyV3ATInahpoL
        uFjoMtB+JLl22K5W7Xls9290fw==
X-Google-Smtp-Source: AA0mqf5hwNBtV6faGgkTJ4/wTG7/m9Pmba4L3GkFgHEdHUI22Lo6Bdo1kYX8qMnu6KN0VLwUccrhnw==
X-Received: by 2002:a63:5153:0:b0:41a:4bd4:f43f with SMTP id r19-20020a635153000000b0041a4bd4f43fmr7621643pgl.460.1669180554101;
        Tue, 22 Nov 2022 21:15:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a1a0b00b00218cd71781csm451793pjk.51.2022.11.22.21.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 21:15:52 -0800 (PST)
Date:   Tue, 22 Nov 2022 21:15:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-hardening@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Message-ID: <202211222113.10003CF8FD@keescook>
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
 <0da67f73-dd73-7e6d-74c2-14aec5d79902@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da67f73-dd73-7e6d-74c2-14aec5d79902@gotplt.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 22, 2022 at 05:20:37AM -0500, Siddhesh Poyarekar wrote:
> On 2022-09-20 15:22, Kees Cook wrote:
> > Since the commits starting with c37495d6254c ("slab: add __alloc_size
> > attributes for better bounds checking"), the compilers have runtime
> > allocation size hints available in some places. This was immediately
> > available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
> > updating to explicitly make use the hints via the associated
> > __builtin_dynamic_object_size() helper. Detect and use the builtin when
> > it is available, increasing the accuracy of the mitigation. When runtime
> > sizes are not available, __builtin_dynamic_object_size() falls back to
> > __builtin_object_size(), leaving the existing bounds checking unchanged.
> > 
> > Additionally update the VMALLOC_LINEAR_OVERFLOW LKDTM test to make the
> > hint invisible, otherwise the architectural defense is not exercised
> > (the buffer overflow is detected in the memset() rather than when it
> > crosses the edge of the allocation).
> > 
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Tom Rix <trix@redhat.com>
> > Cc: linux-hardening@vger.kernel.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/misc/lkdtm/heap.c           | 1 +
> >   include/linux/compiler_attributes.h | 5 +++++
> >   include/linux/fortify-string.h      | 7 +++++++
> >   3 files changed, 13 insertions(+)
> 
> Hi Kees,
> 
> Circling back on this, I noticed that all but this patch got pulled into
> Linus' tree.  Is there a reason why this has been held back?

Hi!

Yeah, it depended on a bunch of various clean-ups, which have finally
managed to land. It's late enough in the devel cycle that I suspect I
will hold this one back until after the merge window and then make sure
it has plenty of time to bake in -next. If the rest of the patches
continue to behave, I may change my mind... :)

-Kees

-- 
Kees Cook
