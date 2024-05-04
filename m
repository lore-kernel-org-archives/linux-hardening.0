Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990257580E;
	Sat,  4 May 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714861444; cv=none; b=MMMDzV9TI5XCQp1YW22Hwfa1KjzPB8ICh+9z2ExAG7XNIsXFrbS+8NfGnrPHnQDGMNO2X1RMpxS4xeui7L3HKskFaAZFzOYabx7cjIRG7qI+QYz0XOu1zGsJ9XIYnoLoiZK2MAcukK3i90pGUbNRwkbpt1UMFYAzTvh/HHei5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714861444; c=relaxed/simple;
	bh=HinZjebuSrqPkb/wLqws6KDk1bX5GIUlA5DoM/oka8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNstS6TNMX6M0YGXPFmyL/aRDqQCCa3bsYhheblYeAmAPLU5Y28nXdkXyxkjepvqnHLMKiwaWYqMvnA+pTtIoKorMKP2HCJ2TsfD/ZVR9AbLtqVo8u1x757zNBICEUmZ7HqUF1gIIAEPHscG7inOI4+6EwP7Se3ljFaQNduuAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLliaO20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLliaO20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74E8C072AA;
	Sat,  4 May 2024 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714861444;
	bh=HinZjebuSrqPkb/wLqws6KDk1bX5GIUlA5DoM/oka8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLliaO20JYD0uoAJk8EEs5xuplcthyQh82T21DlxKq8XQ+WQnbn6N6LOJxD6fhsIj
	 k9ymM9wjLcQ7vPGjSINPHe3iJFlDtuEAD/XGSKubCcgyWaK2iZofhTECx/ZlPpBU5Z
	 qqOtEYC7wkvkjPxNPyzeisc6+EjlcYOvcDAcOkEnvZO4qDL6LnqbehSGr+4I5U1IAG
	 43wOri2Z/IPIIeoeoVCu7O++4lLuBRNS+sbdiNBb2jgzH7oHpl6vQ9HuUtnIN4VYTe
	 gLlQs8GwnBtjoUjRJqTzWaE+YhnbRXAdv1iZYvN6iDNsneI2vAPXHE5fRXRJ6DLhdS
	 dRayEajZaAxGw==
Date: Sat, 4 May 2024 15:24:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Youling Tang <tangyouling@loongson.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] objtool: Provide origin hint for
 elf_init_reloc_text_sym() errors
Message-ID: <20240504222402.p24zt6dc2zkyxqti@treble>
References: <20240430235106.work.680-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430235106.work.680-kees@kernel.org>

On Tue, Apr 30, 2024 at 04:51:07PM -0700, Kees Cook wrote:
> @@ -891,8 +892,8 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
>  	int addend = insn_off;
>  
>  	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
> -		WARN("bad call to %s() for data symbol %s",
> -		     __func__, sym->name);
> +		WARN("bad call to %s() for %s symbol %s",
> +		     __func__, origin, sym->name);
>  		return NULL;

Thanks for the patch.

That warning was already phrased pretty awkwardly which was probably
part of the confusion.  It could be rephrased to make it a little
clearer:

Something like:

  .cfi_sites: unexpected reference to non-executable symbol 'execute_location'

And ".cfi_sites" is already in 'sec->name', so you wouldn't need to add
the new 'origin' arg.

-- 
Josh
