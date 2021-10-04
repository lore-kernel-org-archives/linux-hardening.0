Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E8CC433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  4 Oct 2021 13:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E4961184
	for <linux-hardening@archiver.kernel.org>; Mon,  4 Oct 2021 13:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbhJDN6E (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhJDN55 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 4 Oct 2021 09:57:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F99C06178C;
        Mon,  4 Oct 2021 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6vUpJUB5MdZXzWaMmf7c2QvR3CqVlsdp5dr0n/HKs40=; b=e90zv0e7wf8LJPpvaSWtJTY6cO
        Ulgjoqv+E7YyYinhTnXJeK9uT2+m0JxNB+LUoDuVW98WBXfcwOY3AvaoyGuEjZcXq4hda+QGTfK7W
        i6yXATawRQn05/eYQhz58UcKA7kphdaqTG97RVD0lUgzeDZ/U05AUdTkOJb4ZPP/kZAa1+WvhY+YV
        DSJZ9LKZZYqSB93GkOf03fVE17onPldrpr6Un7QrCTYN73Aclh+NakdQH3oCG90gvI5N3VBAjz9oS
        eiMIYSJ9ALP3KfIlDDTiI1gEp7HDhD48PovWQORPlGfc1uvG1zseCZmB9cx9GPf1b7CWp/MmsfOOn
        Da2tYbmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXOMN-007qXv-3U; Mon, 04 Oct 2021 13:50:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 081AC30026F;
        Mon,  4 Oct 2021 15:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC22E2016AFC1; Mon,  4 Oct 2021 15:50:24 +0200 (CEST)
Date:   Mon, 4 Oct 2021 15:50:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
Message-ID: <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930180531.1190642-5-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:20AM -0700, Sami Tolvanen wrote:
> This change introduces the DEFINE_CFI_IMMEDIATE_RETURN_STUB macro,
> which defines a stub function that immediately returns and when
> defined in the core kernel, always passes indirect call checking
> with CONFIG_CFI_CLANG. Note that this macro should only be used when
> a stub cannot be called using the correct function type.

> diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> index 879744aaa6e0..19f74af8eac2 100644
> --- a/include/linux/cfi.h
> +++ b/include/linux/cfi.h
> @@ -20,6 +20,17 @@ extern void __cfi_check(uint64_t id, void *ptr, void *diag);
>  #define __CFI_ADDRESSABLE(fn, __attr) \
>  	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
>  
> +/*
> + * Defines a stub function that returns immediately, and when defined and
> + * referenced in the core kernel, always passes CFI checking. This should
> + * be used only for stubs that cannot be called using the correct function
> + * pointer type, which should be rare.
> + */
> +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> +	void fn(void) { return; } \
> +	const void *__cfi_excl_ ## fn __visible \
> +		__section(".cfi_excluded_stubs") = (void *)&fn
> +
>  #ifdef CONFIG_CFI_CLANG_SHADOW
>  
>  extern void cfi_module_add(struct module *mod, unsigned long base_addr);
> @@ -35,6 +46,8 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
>  #else /* !CONFIG_CFI_CLANG */
>  
>  #define __CFI_ADDRESSABLE(fn, __attr)
> +#define DEFINE_CFI_IMMEDIATE_RETURN_STUB(fn) \
> +	void fn(void) { return; }
>  
>  #endif /* CONFIG_CFI_CLANG */
>  

Why DEFINE_CFI_IMMEDIATE_RETURN_STUB() vs __no_cfi attribute that we can
stick on the relvant functions?

Because I've got at least one more variant for you :-) See
kernel/static_call.c:__static_call_return0
