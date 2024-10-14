Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387F231C9C;
	Mon, 14 Oct 2024 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728880115; cv=none; b=JwN85wbxOm5xCjLU8iEbQKeQWcVma3ehfGwE3ExnB8fRpopjtZ1TSy8dMSz0BBFcfm+lbXD7f5fcjP+nOJrocYqs8hJGb80Lng1fPYJ5V9hZn1oYaXGMjr7IkcUlL9rPSfQ6gK5f8BDcNh2grs7Um+BBbFbQYv2zlaE0YWv2amA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728880115; c=relaxed/simple;
	bh=BEBNNN3TM1sEEyjm+HhJUXIc3ue0HOu8SSTt/94QJ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT8nx4EulWq0n3ybXT8gA+OQugz4gKjGcLyXiyLfV0Wa8Stdi/mZyYx6Ji1OUAK/Lt/2G31hCL+IAEDLZlxG1LMWsJUgLSYgIyxRd0hAglRMiYZ3hzAuHc7sTLgNWA1W3ETFtD8NIRMBAS+lwXG+56MTCB/8MWUPIdSq+/m/AtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmUBOunb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmUBOunb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D82BC4CEC3;
	Mon, 14 Oct 2024 04:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728880114;
	bh=BEBNNN3TM1sEEyjm+HhJUXIc3ue0HOu8SSTt/94QJ+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmUBOunbAhoR/a1ntOamSkdFxqkaz+WMR+AXw4+BMMBd2Gxx3hFIJH+Y8TdxCUJVW
	 cb75lGpdArs/Hi8RSJXNWVMcDgTzwwuswF0aQLhf1InunVAnZVyfvcXXMCrLQCgSyg
	 gk/TQ4YqgEdAYuU9b4UriIBbeHJOEGhALXQtIondxCJxTTz900xB1SLP/alfElQ6yQ
	 8z7baYxwEssQhnlxik5hf+VFrKh3BIDmtioyOB9xlVV+9dRSnoEZ7zviwdp/la3Lf7
	 DhwuCH7SczW+wyjFJ840g9Tg3s2c1wOF4Kcf55uJ87Dm5gD4tArnJ8OeiSXawcR/qn
	 TnAdmw6h96hWg==
Date: Sun, 13 Oct 2024 21:28:33 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 6/8] crypto: x86/crc32c - Use idiomatic relative jump
 table
Message-ID: <20241014042833.GA20015@sol.localdomain>
References: <20241011170847.334429-10-ardb+git@google.com>
 <20241011170847.334429-16-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011170847.334429-16-ardb+git@google.com>

On Fri, Oct 11, 2024 at 07:08:54PM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> index bbcff1fb78cb..45b005935194 100644
> --- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> +++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> @@ -53,7 +53,7 @@
>  .endm
>  
>  .macro JMPTBL_ENTRY i
> -.quad .Lcrc_\i
> +.long .Lcrc_\i - jump_table
>  .endm
>  
>  .macro JNC_LESS_THAN j
> @@ -169,7 +169,8 @@ SYM_FUNC_START(crc_pcl)
>  
>  	## branch into array
>  	leaq	jump_table(%rip), %bufp
> -	mov	(%bufp,%rax,8), %bufp
> +	movslq	(%bufp,%rax,4), len
> +	addq	len, %bufp
>  	JMP_NOSPEC bufp

I think it would be much better to just get rid of the jump table here.

I have done this at
https://lore.kernel.org/linux-crypto/20241014042447.50197-4-ebiggers@kernel.org/

- Eric
