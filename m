Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C3C5519F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B8D248EA
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Nov 2020 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/6W5cUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgKRRki (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRRkh (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Nov 2020 12:40:37 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1928D248EA;
        Wed, 18 Nov 2020 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605721237;
        bh=G4O3rFMGBtI5wnGlUM1LIeXIwsb0R29nb/PRSJCv87g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/6W5cUi9VeQFZ4HpUzsOtMlqtvhJjUI7gb6V2ITxtCe4Od1T8YmAcojdO9Fo9gg3
         72iEUXEZorUW+uQaRR+1kZy/Rlro695YSo1lWuVAJchv6mUTkhMiwykGciTJWhY0FQ
         zk3BdqFYlvS4J3z+A4dkpqk386+hAzpcM/anJxqw=
Date:   Wed, 18 Nov 2020 19:40:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Matthew Wilcox <willy@infradead.org>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201118174030.GB8537@kernel.org>
References: <20201026160518.9212-1-toiwoton@gmail.com>
 <20201117165455.GN29991@casper.infradead.org>
 <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19373af5-2272-7615-27a7-6734c584f8bd@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

(added one of the AnC paper authors)

On Tue, Nov 17, 2020 at 10:21:30PM +0200, Topi Miettinen wrote:
> On 17.11.2020 18.54, Matthew Wilcox wrote:
> > On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
> > > Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> > > enables full randomization of memory mappings created with mmap(NULL,
> > > ...). With 2, the base of the VMA used for such mappings is random,
> > > but the mappings are created in predictable places within the VMA and
> > > in sequential order. With 3, new VMAs are created to fully randomize
> > > the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> > > even if not necessary.
> > 
> > Is this worth it?
> > 
> > https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
> 
> Thanks, very interesting. The paper presents an attack (AnC) which can break
> ASLR even from JavaScript in browsers. In the process it compares the memory
> allocators of Firefox and Chrome. Firefox relies on Linux mmap() to
> randomize the memory location, but Chrome internally chooses the randomized
> address. The paper doesn't present exact numbers to break ASLR for Chrome
> case, but it seems to require more effort. Chrome also aggressively
> randomizes the memory on each allocation, which seems to enable further
> possibilities for AnC to probe the MMU tables.
> 
> Disregarding the difference in aggressiveness of memory allocators, I think
> with sysctl.kernel.randomize_va_space=3, the effort for breaking ASLR with
> Firefox should be increased closer to Chrome case since mmap() will use the
> address space more randomly.
> 
> I have used this setting now for a month without any visible performance
> issues, so I think the extra bits (for some additional effort to attackers)
> are definitely worth the low cost.
> 
> Furthermore, the paper does not describe in detail how the attack would
> continue after breaking ASLR. Perhaps there are assumptions which are not
> valid when the different memory areas are no longer sequential. For example,
> if ASLR is initially broken wrt. the JIT buffer but continuing the attack
> would require other locations to be determined (like stack, data segment for
> main exe or libc etc), further efforts may be needed to resolve these
> locations. With randomize_va_space=2, resolving any address (JIT buffer) can
> reveal the addresses of many other memory areas but this is not the case
> with 3.
> 
> -Topi

-- 
Sincerely yours,
Mike.
