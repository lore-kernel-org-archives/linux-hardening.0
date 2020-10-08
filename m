Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F249C433E7
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA76F21D7D
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ASKAd2B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbgJHRHa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgJHRHa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 13:07:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB59C061755;
        Thu,  8 Oct 2020 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFsuL5fiQpUDvhtt5fozsfGKqdT49zToyfpYwey6+xI=; b=ASKAd2B6AXXo8EQU0anUauThTY
        Xs+INzR/+2gmCusmIBzQSVkXzjRKpTmstSXY5ttvhN1QTl2AXy9LEtpPVxoi5ctQMsksLObnipIKR
        JJ9M7p5XBoKp3LJ/YzwaPHYoUUcfJbOjyIaZaM5Zy37IykTNcmhaJEtbXUiFC64OpmOLiRctr/G+S
        laVoV9oi2zAnTe0evHAULLd7iAmewSPZAtfyKWURzxixSSF8ZhVjnNmuzgdenLd7dreBwyXYeHko1
        7nxkhrlPnebM33Ltu4ijPaB6AFx/VeQMI8AKbgGFXSNKq5uzKQv11TLgovBrkdzGE2AY7JDw3ytYI
        jd6yuvwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQZO4-0007Q1-5u; Thu, 08 Oct 2020 17:07:28 +0000
Date:   Thu, 8 Oct 2020 18:07:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201008170728.GK20115@casper.infradead.org>
References: <20201008165408.38228-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008165408.38228-1-toiwoton@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 08, 2020 at 07:54:08PM +0300, Topi Miettinen wrote:
> +3   Additionally enable full randomization of memory mappings created
> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
> +    mappings is random, but the mappings are created in predictable
> +    places within the VMA and in sequential order. With 3, new VMAs
> +    are created to fully randomize the mappings. Also mremap(...,
> +    MREMAP_MAYMOVE) will move the mappings even if not necessary.
> +
> +    On 32 bit systems this may cause problems due to increased VM
> +    fragmentation if the address space gets crowded.

On all systems, it will reduce performance and increase memory usage due
to less efficient use of page tables and inability to merge adjacent VMAs
with compatible attributes.

> +	if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
> +		/*
> +		 * Caller is happy with a different address, so let's
> +		 * move even if not necessary!
> +		 */
> +		new_addr = arch_mmap_rnd();
> +
> +		ret = mremap_to(addr, old_len, new_addr, new_len,
> +				&locked, flags, &uf, &uf_unmap_early,
> +				&uf_unmap);
> +		goto out;
> +	}
> +
> +

Overly enthusiastic newline
