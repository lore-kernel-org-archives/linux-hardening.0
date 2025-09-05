Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEA20F09C
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062276; cv=none; b=Pwte0f6xAqtM/BYm5isAfoTrrF8hzKszCwKXi753BViU6XInW0d1Q6eOOemkU26Mzdfa3eOOSSn3nGJjQbNUC9rUBeod9J5dNd8E8cZABwimzmDKoYoGaUYyHv3fN+qv+xbFqGqR+1mQKhUmr6uGSYhFMVF0PgA5O4T/vxwLE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062276; c=relaxed/simple;
	bh=CkXSIdCWLMa6Ik48EgNr5STuK2qNsWR1cncQZ+uot0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu7BKKBbFQf/kDcXbRy05PQUNF1rvWg7SPsMHc0CMFDhSmLIenbNg4UNBjuKrLbnRHt4Nu3ymN4i1vXeJIb9a+QywDtxStfP9slMknvGzKMcVy9F4vKlcoX0kyqcPaNFCr3r00GZgZQbriGaVsBkhOhMWPjagHQTPdlXmogBiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oVSUIkhB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oVSUIkhB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VZueJysqCpIwSTudgJc0eT3MsvOMYf19shcDrN9D6eo=; b=oVSUIkhBl0Bpe/O9fo/+VCuMuF
	XE/auyLSCdRSK1ppdDuvIX+nuoj9FFlD5zKbPkqm/OfRdEzmnuPmntY7A8bkppofs8sQdvo/GB6HH
	539BOuzAcTtPeWs5pTuwEOm/R9RgVX3lxko1uvI9xlRqT7Qu/Y4jF0MpRB82Fwn5kBhSVMgZNfzm7
	b054TBVSKaUFjdRbb+1JowPHcezin6kWotFJsRxCZXySxDGdrHL92sBxaVgKo8GO6ZnKibnQSH62z
	MF/59ofhDPkCMWiuX/s+0OL6lQvkBLn+GSWfpT78yRH70rYiWnHaM8db66FfpQlBtgnwP2zRAzoGN
	jcpnjN0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuS9v-00000004UvO-3BtL;
	Fri, 05 Sep 2025 08:51:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46F0330034B; Fri, 05 Sep 2025 10:51:03 +0200 (CEST)
Date: Fri, 5 Sep 2025 10:51:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20250905085103.GT3245006@noisy.programming.kicks-ass.net>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905002418.464643-2-kees@kernel.org>

On Thu, Sep 04, 2025 at 05:24:10PM -0700, Kees Cook wrote:
> +- The check-call instruction sequence must be treated a single unit: it
> +  cannot be rearranged or split or optimized. The pattern is that
> +  indirect calls, "call *$target", get converted into:
> +
> +    mov $target_expression, %target ; only present if the expression was
> +                                    ; not already %target register
> +    load -$offset(%target), %tmp    ; load the typeid hash at target
> +    cmp $hash, %tmp                 ; compare expected typeid with loaded
> +    je .Lcheck_passed               ; jump to the indirect call
> +  .Lkcfi_trap$N:                    ; label of trap insn
> +    trap                            ; trap on failure, but arranged so
> +                                    ; "permissive mode" falls through
> +  .Lkcfi_call$N:                    ; label of call insn
> +    call *%target                   ; actual indirect call
> +
> +  This pattern of call immediately after trap provides for the
> +  "permissive" checking mode automatically: the trap gets handled,
> +  a warning emitted, and then execution continues after the trap to
> +  the call.

I know it is far too late to do anything here. But I've recently dug
through a bunch of optimization manual and the like and that Jcc is
about as bad as it gets :/

The old optimization manual states that forward jumps are assumed
not-taken; while backward jumps are assumed taken.

The new wisdom is that any Jcc must be assumed not-taken; that is, the
fallthrough case has the best throughput.

Here we have a forward branch which is assumed taken :-(


