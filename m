Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EA2C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Apr 2022 17:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiDNRYr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbiDNRYq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Apr 2022 13:24:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF382BC869
        for <linux-hardening@vger.kernel.org>; Thu, 14 Apr 2022 10:22:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c12so5198120plr.6
        for <linux-hardening@vger.kernel.org>; Thu, 14 Apr 2022 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74YOS5V1qHXZZ1fLoG5JxUvAs7/uENmkI5e8dEDxses=;
        b=iP28I5g0myp4w/7aNYzjc3WyyPOxckjdXhNgkDQjobWLTAXQkU73Qgd0OL6OYIcFiZ
         7TuqFSQhN5HPnyy4iqyfBSWtpSwySLdgUqwmpPNPnSN+nbp/stQkNNRigCCyyPHN/Amv
         CP92wNGgq5xuHIV5YjMikUjlIFzM0CXlpzBGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74YOS5V1qHXZZ1fLoG5JxUvAs7/uENmkI5e8dEDxses=;
        b=R2iYOc+uGtob90VNBwq/G5SLwkIR0WoROo0oHy8v1e16lzENN7B1hENVhxRVkRzYjc
         Yhw4luM7Wn/piUgUiNYxCFIeAUZ7V0ogr/NIXk+M8YwgAVTl8HbqOgVQisyeMpegXZT3
         EWFKMm6cyRWjgreEn+xIZLyLb7QlEdVPB/jRxNJDq0Z8K7V/oI0NaUvzUWIwTtQpxUtf
         EKstHviZfS1BOGEnAPmd7unIi5YUwToAlb4T1ytGLzAXwfIaWDhvtHoO917piUUHazk/
         saUm8bPHSArTbfhZmUmJ4JLKO9L2EzRRy4htd9qPDCeNh4iI99dRiwppB6pjxX+iIzoh
         MsPg==
X-Gm-Message-State: AOAM532MF5qC8WXnDTwiFZWLIKN9kUFKdo7Ha/zBKxgk/EoEEue0MsaW
        tKYTmS2REfK7TJz7DbdP21T0a9JgK1Z6UQ==
X-Google-Smtp-Source: ABdhPJxAprf/p03cPbZ5hRrExWbkfNTc3juXB5tKGk3RtI0L1iw6o5BW7MusfTN8dyZm5rA7k+YW7A==
X-Received: by 2002:a17:902:e808:b0:156:cbfd:4235 with SMTP id u8-20020a170902e80800b00156cbfd4235mr48710529plg.24.1649956940429;
        Thu, 14 Apr 2022 10:22:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b00505dfd42f2fsm503493pfo.22.2022.04.14.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:22:19 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:22:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Message-ID: <202204141019.CD9152A7@keescook>
References: <20220413213917.711770-1-keescook@chromium.org>
 <f7a5642f-bfcb-865d-7039-d0b9d62a3360@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a5642f-bfcb-865d-7039-d0b9d62a3360@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 14, 2022 at 03:19:02AM -0700, Dan Li wrote:
> Hi, Kees,
> Thanks for the rewrite. I tested this patch, and it works fine for
> me except for a few minor comments below :)
> 
> On 4/13/22 14:39, Kees Cook wrote:
> > +/* The ultimate ROP gadget. */
> > +static noinline __no_ret_protection
> > +void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
> > +{
> > +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> > +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> > +
> > +	/* Make sure we've found the right place on the stack before writing it. */
> > +	if(*ret_addr == expected)
> > +		*ret_addr = (addr);
> > +	else
> > +		/* Check architecture, stack layout, or compiler behavior... */
> > +		pr_warn("Eek: return address mismatch! %px != %px\n",
> > +			*ret_addr, addr);
> > +}
> > +
> > +static noinline
> > +void set_return_addr(unsigned long *expected, unsigned long *addr)
> > +{
> > +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> > +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> > +
> > +	/* Make sure we've found the right place on the stack before writing it. */
> > +	if(*ret_addr == expected)
> > +		*ret_addr = (addr);
> 
> When PAC is enabled, I get a mismatch as follows:
> 
> /kselftest_install/lkdtm # ./CFI_BACKWARD.sh
> [  182.120133] lkdtm: Performing direct entry CFI_BACKWARD
> [  182.120665] lkdtm: Attempting unchecked stack return address redirection ...
> [  182.122543] lkdtm: ok: redirected stack return address.
> [  182.123521] lkdtm: Attempting checked stack return address redirection ...
> [  182.123964] lkdtm: Eek: return address mismatch! bfff800008fa8014 != ffff800008fa8030
> [  182.124502] lkdtm: ok: control flow unchanged.
> CFI_BACKWARD: saw 'call trace:|ok: control flow unchanged': ok
> 
> We may need to ignore the pac high bits of return address according
> to TCR.T1SZ (or simply remove the high 16 bits before comparing).

Oh! Hah, yes, I totally forgot that. Thanks for testing -- getting PAC
emulation working in QEMU has eluded me. I think untagged_addr() will
work yes? i.e.:

	if((untagged_addr(*ret_addr) == expected)

> 
> > +	else
> > +		/* Check architecture, stack layout, or compiler behavior... */
> > +		pr_warn("Eek: return address mismatch! %px != %px\n",
> > +			*ret_addr, addr);
> 
> According to the context, it might be "expected" here?
> 
> 		pr_warn("Eek: return address mismatch! %px != %px\n",
> 			*ret_addr, expected);
> 
> I simply ignored the upper 16 bits, and tested it separately
> in gcc/llvm 12 with SCS/PAC and all the four cases worked fine for me.

Great! Do you have the PAC "Oops" text handy so I can include it in the
commit log as an example of what should be expected?

Thanks!

-- 
Kees Cook
