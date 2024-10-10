Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC691C9B6D;
	Thu, 10 Oct 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566789; cv=none; b=KVXB2lma3DqSB9zUuWewm4ye9kpVwhL8X3gfqSSHcvTpj9UlgL4Dq6+2lScds5zdBKllnijd9cpRukFUbLImmEdFs6B55FeY9iuQFirFGOCbnrkN78bzK+XMkWVYpOgbkNpPeavalaOWSvhxExek2Yl2LF+z0QruATEc4OjUtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566789; c=relaxed/simple;
	bh=llPFfHa+YAlLecNr8hO6F+hVZetBYEaDSKxeKNHar78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paseTP1pbZo9weAIcNNxTJn6PtZupHEapAY0RJYXgLqYQgzqFEjNalMTTwxqIUQDnoKt7DQ4WpIWL11kJPk0ipA/QxtTe7KGx86PFAVvICNP23oMCj3zek+NB8D9C7P7sqAgQDVYbZjGkq+LRemu8Rbh/3k68OFHOc2YqbvH7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jhXn5Pgu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhXn5Pgu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AzHzS3nahWM1GRwGfK8kFMoHkVw2QFsfTemuA7o0jJQ=; b=jhXn5PguJPzif8eONzfX9KJrKX
	aluBMJn0Ze+XWmCrCQ5cNuGLWIokKbciWVO9RMvqNU4S1HCRC55LLrGMneBRmEPdNQ5R4XwrfARp9
	cGbqfM7x2uZfE+8n/F0916KRe6VuFxOg2G/kp6lbCgGFXujNmkHriJaMu02LA8Oe+XpRmMSR9HaRc
	Xh5hU0c3viOwxGMMsSc7I0NxYU+FZCA74UcE3PcWEcxAH765lctZiyLOFWMD820QJFbfs5Ok4jnjI
	JyPbsF8IhiZjlkSv+Y5dRcwr80qNx1sVNHSvk8bUp3ruR/TdTi9VF6VwRRM9fa5e8xqSeR0PcIv1z
	kfbaCL2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sytBP-00000007gRY-0T8J;
	Thu, 10 Oct 2024 13:26:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A7B83002F0; Thu, 10 Oct 2024 15:26:23 +0200 (CEST)
Date: Thu, 10 Oct 2024 15:26:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/5] objtool: Deal with relative jump tables correctly
Message-ID: <20241010132623.GI17263@noisy.programming.kicks-ass.net>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010122801.1321976-8-ardb+git@google.com>

On Thu, Oct 10, 2024 at 02:28:03PM +0200, Ard Biesheuvel wrote:
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 3cb3e9b5ad0b..7f7981a93535 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2101,6 +2101,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  {
>  	struct symbol *pfunc = insn_func(insn)->pfunc;
>  	struct reloc *table = insn_jump_table(insn);
> +	unsigned int rtype = reloc_type(table);
> +	bool pcrel = rtype == R_X86_64_PC32;

R_DATA32 or R_TEXT32 please, the budding cross arch stuff has their own
names for all that.

