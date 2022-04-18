Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12647C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Apr 2022 21:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiDRVx6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Apr 2022 17:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiDRVx5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Apr 2022 17:53:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A4101D8
        for <linux-hardening@vger.kernel.org>; Mon, 18 Apr 2022 14:51:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k14so21270010pga.0
        for <linux-hardening@vger.kernel.org>; Mon, 18 Apr 2022 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=McML/7aq2qYQeHtr+zF/mEmdaC5pb8ihc8HBw6Ng3QE=;
        b=Xynf82T+YJ3L9WP7bS10BageZ9YV+V1bwOGz/uSRoxx9QL0km13oL6wprefg95OK6/
         XiBa4U49OwIQ2CowIh/bUSmR5pHsIdN4GoSTAeAPT6z5ACOT2wveezuYjmKuGzUEhgWo
         Y9GdnShjwgAxhuf2vba32qgkr9asYPszd/h2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=McML/7aq2qYQeHtr+zF/mEmdaC5pb8ihc8HBw6Ng3QE=;
        b=BdC8rcRqT2ydk4CAJE72685xy6H9VXoFP0YRo4sIKw434KKDCLSkeIE+YHjYGQAZjD
         2aS0M/rir6A9PLjDUzMNKNPo8NI92P1n8DNMRiCdqottGVDpt8kFjNp/0cOalKye9y5Q
         YuxmRZb/3G1m8oilYB7cprB59VeFR/e8ZHtaQTQKfUKyuQdh+T5PYd6lnqgGrZlGdYMJ
         eXYd4mJ5Gbnk5J2ez/Hl3WPoBgDK+mI9a4uGPjJxf9Cw96W1IXCYIcINNUZsTkTmHqwY
         J7uGoIhoaQxIWWOL0RHwxnDajg7AGLfanjHnuktrvjRJWhbDJ/M3bJcIHXu1xu5AzohS
         yEvA==
X-Gm-Message-State: AOAM533GE1UPClPU4LhBGezWweUGbDjcNv3Y5m9noNLOXo3FPzE5M4nh
        wzmpR0E0V1NAySdAEx8V9JQaWw==
X-Google-Smtp-Source: ABdhPJyoRoXMQ/9/BWXQveo5IafXB1/Wwz08+r4TNPjC4GYcIGRdF2i5UDHcNh6YZ4z0qrqlXYQQRA==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr14453638pfb.84.1650318675949;
        Mon, 18 Apr 2022 14:51:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a7acd00b001d2cd88956esm203296pjl.24.2022.04.18.14.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:51:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 14:51:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm: Add CFI_BACKWARD to test ROP mitigations
Message-ID: <202204181451.AC3DB70EE@keescook>
References: <20220416001103.1524653-1-keescook@chromium.org>
 <e1563d18-36d7-08b2-762c-def7021d1382@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1563d18-36d7-08b2-762c-def7021d1382@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Apr 17, 2022 at 02:15:43AM -0700, Dan Li wrote:
> 
> 
> On 4/15/22 17:11, Kees Cook wrote:
> > In order to test various backward-edge control flow integrity methods,
> > add a test that manipulates the return address on the stack. Currently
> > only arm64 Pointer Authentication and Shadow Call Stack is supported.
> > 
> >   $ echo CFI_BACKWARD | cat >/sys/kernel/debug/provoke-crash/DIRECT
> > 
> > Under SCS, successful test of the mitigation is reported as:
> > 
> >   lkdtm: Performing direct entry CFI_BACKWARD
> >   lkdtm: Attempting unchecked stack return address redirection ...
> >   lkdtm: ok: redirected stack return address.
> >   lkdtm: Attempting checked stack return address redirection ...
> >   lkdtm: ok: control flow unchanged.
> > 
> > Under PAC, successful test of the mitigation is reported by the PAC
> > exception handler:
> > 
> >   lkdtm: Performing direct entry CFI_BACKWARD
> >   lkdtm: Attempting unchecked stack return address redirection ...
> >   lkdtm: ok: redirected stack return address.
> >   lkdtm: Attempting checked stack return address redirection ...
> >   Unable to handle kernel paging request at virtual address bfffffc0088d0514
> >   Mem abort info:
> >     ESR = 0x86000004
> >     EC = 0x21: IABT (current EL), IL = 32 bits
> >     SET = 0, FnV = 0
> >     EA = 0, S1PTW = 0
> >     FSC = 0x04: level 0 translation fault
> >   [bfffffc0088d0514] address between user and kernel address ranges
> >   ...
> > 
> > If the CONFIGs are missing (or the mitigation isn't working), failure
> > is reported as:
> > 
> >   lkdtm: Performing direct entry CFI_BACKWARD
> >   lkdtm: Attempting unchecked stack return address redirection ...
> >   lkdtm: ok: redirected stack return address.
> >   lkdtm: Attempting checked stack return address redirection ...
> >   lkdtm: FAIL: stack return address was redirected!
> >   lkdtm: This is probably expected, since this kernel was built *without* CONFIG_ARM64_PTR_AUTH_KERNEL=y nor CONFIG_SHADOW_CALL_STACK=y
> > 
> > Co-developed-by: Dan Li <ashimida@linux.alibaba.com>
> > Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1: https://lore.kernel.org/lkml/20220413213917.711770-1-keescook@chromium.org
> > v2:
> >   - add PAGE_OFFSET setting for PAC bits (Dan Li)
> > ---
> >   drivers/misc/lkdtm/cfi.c                | 134 ++++++++++++++++++++++++
> >   tools/testing/selftests/lkdtm/tests.txt |   1 +
> >   2 files changed, 135 insertions(+)
> > 
> > diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> > index e88f778be0d5..804965a480b7 100644
> > --- a/drivers/misc/lkdtm/cfi.c
> > +++ b/drivers/misc/lkdtm/cfi.c
> > @@ -3,6 +3,7 @@
> >    * This is for all the tests relating directly to Control Flow Integrity.
> >    */
> >   #include "lkdtm.h"
> > +#include <asm/page.h>
> >   static int called_count;
> > @@ -42,8 +43,141 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
> >   	pr_expected_config(CONFIG_CFI_CLANG);
> >   }
> > +/*
> > + * This can stay local to LKDTM, as there should not be a production reason
> > + * to disable PAC && SCS.
> > + */
> > +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> > +# ifdef CONFIG_ARM64_BTI_KERNEL
> > +#  define __no_pac             "branch-protection=bti"
> > +# else
> > +#  define __no_pac             "branch-protection=none"
> > +# endif
> > +# define __no_ret_protection   __noscs __attribute__((__target__(__no_pac)))
> > +#else
> > +# define __no_ret_protection   __noscs
> > +#endif
> > +
> > +#define no_pac_addr(addr)      \
> > +	((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> > +
> > +/* The ultimate ROP gadget. */
> > +static noinline __no_ret_protection
> > +void set_return_addr_unchecked(unsigned long *expected, unsigned long *addr)
> > +{
> > +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> > +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> > +
> > +	/* Make sure we've found the right place on the stack before writing it. */
> > +	if (no_pac_addr(*ret_addr) == expected)
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
> > +	if (no_pac_addr(*ret_addr) == expected)
> > +		*ret_addr = (addr);
> > +	else
> > +		/* Check architecture, stack layout, or compiler behavior... */
> > +		pr_warn("Eek: return address mismatch! %px != %px\n",
> > +			*ret_addr, addr);
> > +}
> > +
> > +static volatile int force_check;
> > +
> > +static void lkdtm_CFI_BACKWARD(void)
> > +{
> > +	/* Use calculated gotos to keep labels addressable. */
> > +	void *labels[] = {0, &&normal, &&redirected, &&check_normal, &&check_redirected};
> > +
> > +	pr_info("Attempting unchecked stack return address redirection ...\n");
> > +
> > +	/* Always false */
> > +	if (force_check) {
> > +		/*
> > +		 * Prepare to call with NULLs to avoid parameters being treated as
> > +		 * constants in -02.
> > +		 */
> > +		set_return_addr_unchecked(NULL, NULL);
> > +		set_return_addr(NULL, NULL);
> > +		if (force_check)
> > +			goto *labels[1];
> > +		if (force_check)
> > +			goto *labels[2];
> > +		if (force_check)
> > +			goto *labels[3];
> > +		if (force_check)
> > +			goto *labels[4];
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Use fallthrough switch case to keep basic block ordering between
> > +	 * set_return_addr*() and the label after it.
> > +	 */
> > +	switch (force_check) {
> > +	case 0:
> > +		set_return_addr_unchecked(&&normal, &&redirected);
> > +		fallthrough;
> > +	case 1:
> > +normal:
> > +		/* Always true */
> > +		if (!force_check) {
> > +			pr_err("FAIL: stack return address manipulation failed!\n");
> > +			/* If we can't redirect "normally", we can't test mitigations. */
> > +			return;
> > +		}
> > +		break;
> > +	default:
> > +redirected:
> > +		pr_info("ok: redirected stack return address.\n");
> > +		break;
> > +	}
> > +
> > +	pr_info("Attempting checked stack return address redirection ...\n");
> > +
> > +	switch (force_check) {
> > +	case 0:
> > +		set_return_addr(&&check_normal, &&check_redirected);
> > +		fallthrough;
> > +	case 1:
> > +check_normal:
> > +		/* Always true */
> > +		if (!force_check) {
> > +			pr_info("ok: control flow unchanged.\n");
> > +			return;
> > +		}
> > +
> > +check_redirected:
> > +		pr_err("FAIL: stack return address was redirected!\n");
> > +		break;
> > +	}
> > +
> > +	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL)) {
> > +		pr_expected_config(CONFIG_ARM64_PTR_AUTH_KERNEL);
> > +		return;
> > +	}
> > +	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
> > +		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
> > +		return;
> > +	}
> > +	pr_warn("This is probably expected, since this %s was built *without* %s=y nor %s=y\n",
> > +		lkdtm_kernel_info,
> > +		"CONFIG_ARM64_PTR_AUTH_KERNEL", "CONFIG_SHADOW_CALL_STACK");
> > +}
> > +
> >   static struct crashtype crashtypes[] = {
> >   	CRASHTYPE(CFI_FORWARD_PROTO),
> > +	CRASHTYPE(CFI_BACKWARD),
> >   };
> >   struct crashtype_category cfi_crashtypes = {
> > diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> > index 243c781f0780..9dace01dbf15 100644
> > --- a/tools/testing/selftests/lkdtm/tests.txt
> > +++ b/tools/testing/selftests/lkdtm/tests.txt
> > @@ -74,6 +74,7 @@ USERCOPY_STACK_BEYOND
> >   USERCOPY_KERNEL
> >   STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
> >   CFI_FORWARD_PROTO
> > +CFI_BACKWARD call trace:|ok: control flow unchanged
> >   FORTIFIED_STRSCPY
> >   FORTIFIED_OBJECT
> >   FORTIFIED_SUBOBJECT
> 
> 
> Compiling with gcc/llvm 12 on aarch64 platform with scs/pac enabled
> respectively, all four cases work fine for me :)

Great! Thanks for confirming it. :)

-- 
Kees Cook
