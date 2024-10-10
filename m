Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B91DF971;
	Thu, 10 Oct 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591127; cv=none; b=CgnfSW1SBrilZRFh7sTBIdqW9iKGtbXio+RFDnjX8OPELsSyH9N0O9Zt8/Nc73JjGrlmQG+qTPQmqT08HwSbPfCj+EP7FpUWK+YxL/CCWeBQc9ddvAGc9edrjRAOC86V7Up4UE83jO6NKkk1G51guo4w4k+SYuxuNECPQHKpT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591127; c=relaxed/simple;
	bh=JCIc/THGumTBm6gTrXTiZZykyIoKUMdP02DbZlEOyqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYWv7cQ0AOItfVenIqVg1aPiYp49noyjnukRdXQogBjukuA09ArzXEisEQM5PhhsJSPf3K/AG+VIq6VaDHLZm+KrlAbnW6pKbvf+UoZopKoe4eBWg0K+r/wb7ywunD3m/UN4Ivk3PKerRziS9cIajkgK1pkSfNKw1dcDZJBFq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCAAp+zv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCAAp+zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19591C4CECD;
	Thu, 10 Oct 2024 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728591126;
	bh=JCIc/THGumTBm6gTrXTiZZykyIoKUMdP02DbZlEOyqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCAAp+zv0FqZTtF3O++uZAxRsxIICg4grphlzdMZEA1hnpUCELd72WuLLZwyuqMU6
	 WHet7FL96t55tJVuQLDKffCJXRCh19jgQ6QYwLN8wpHZsZJFu7OXSGcVQJZTaIJEr9
	 s50KfW/+gwGzp3zgn+S/i3Tz13ebgRudoUPZocX8UIsb+kGqciMcMvmSqz5sZqNEs+
	 31OnIyZv9d3JIoAkCVRev1HwU91Au2lYNg5QuGrgJQfsiy3hV6dBrjtz91LenbPh55
	 Elww/B1TpnTZkCEM7DfSUCDfPqBTo+f8+Dg74OxBW9f6RakYEbwdYKPO3xXI0hFuab
	 HkBZczOhZxdeA==
Date: Thu, 10 Oct 2024 13:12:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/5] objtool: Add support for annotated jump tables
Message-ID: <20241010201201.y2lrqqhcygun66pz@treble>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010122801.1321976-10-ardb+git@google.com>

On Thu, Oct 10, 2024 at 02:28:05PM +0200, Ard Biesheuvel wrote:
> @@ -1394,8 +1396,12 @@ static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *i
>  	if (!file)
>  		return NULL;
>  
> -	reloc = find_reloc_by_dest_range(file->elf, insn->sec,
> -					 insn->offset, insn->len);
> +	do {
> +		/* Skip any R_*_NONE relocations */
> +		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
> +						 offset++, len--);
> +	} while (len && reloc && reloc_type(reloc) == 0);

s/0/R_NONE/

-- 
Josh
