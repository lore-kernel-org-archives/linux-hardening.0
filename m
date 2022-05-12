Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C309C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 12 May 2022 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiELS4V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 May 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbiELS4U (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 May 2022 14:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183D25287;
        Thu, 12 May 2022 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ULz2Dtv91P8WzuGAfLOyWOh95kZjdcqEsbvgbLOmN1w=; b=Ls7vKsBsyoP7dte09NuSnJXEGQ
        3N7Ifi2ptlJofBErJnBdC57q9X+WUnPHKtMX8/Zu7BbB2Q/H75uqPe+jmyrwBhqJ6d7bZ3Vk5e63x
        pna0ifgkrBD0BoyH0RHCTjgUkUTHFuAZi5zAU53ywQjm2JgTeu+8WCjRrEtOvBoM1A2UHz3PzztRp
        RQz8Xtb1TOFHDR8bYPQvcC+iVdT9WdIaQJffrmPfPxXY6F9Mb+uoHvgDAyHuhsUlT5ZN6TvUndAAT
        ohYkDVGbe+JfbaBERW3vk412l1Pr+YkZGN/rwgVe1wYRYh3yRFD7zV4dsRnMkSbFdrJ5Pb/aUwfiE
        rHwcMqDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npDyv-006exT-4U; Thu, 12 May 2022 18:56:13 +0000
Date:   Thu, 12 May 2022 19:56:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH] lkdtm/usercopy: Add tests for other memory types
Message-ID: <Yn1YTZkWVWfXk5Q8@casper.infradead.org>
References: <20220512183613.1069697-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512183613.1069697-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 12, 2022 at 11:36:13AM -0700, Kees Cook wrote:
> +static void lkdtm_USERCOPY_FOLIO(void)
> +{
> +	struct folio *folio;
> +	void *addr;
> +
> +	/*
> +	 * FIXME: Folio checking currently misses 0-order allocations, so
> +	 * allocate and bump forward to the last page.
> +	 */
> +	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
> +	if (!folio) {
> +		pr_err("folio_alloc() failed!?\n");
> +		return;
> +	}
> +	addr = page_address(&folio->page);

Ideally, code shouldn't be using &folio->page.  If it is, we have a
gap in the folio API.  Fortunately, we have folio_address().

> +	if (addr) {
> +		do_usercopy_page_span("folio", addr + PAGE_SIZE);
> +	}
> +	folio_put(folio);
> +}

Other than that, this looks sane to me.
