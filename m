Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7851E871;
	Sat,  1 Jun 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250798; cv=none; b=lcISbNyJDTwuqHL3mL7lsDjRJA7nioP7mbgp+WF4Oz3NxoJkuOWXj97BomYEgPO35vhQUdlwNqKRAUToyP4wcSvNmYNhzO1Uhamh+4aHWzV62NaehBg7vaA3UWz4Ofd+xaGHJGmfuiYovtW7nMXhyKy2OJAr4bNKb45hIZ+wX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250798; c=relaxed/simple;
	bh=/j5ILFtMpjiIaAV7H+hfiVW/2tt6sQJV0z9kL5h7blc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU+tzlH0Aic9Ry3vA1O3vMIof87VGVHejRdDJICVtqIY+u6qkSK2pAGYOiie7jX7O47TJ7cKHQLGFSJA0TiLPajRIppakxzlmAHZ5cK+ffvvjPCe4WckZNVKsnTwz1M6vhzbbuM1OiKYCF/D5Ia+owhCDzyT8QDHWvxUTSEbiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unBUsn8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unBUsn8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E446C116B1;
	Sat,  1 Jun 2024 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717250797;
	bh=/j5ILFtMpjiIaAV7H+hfiVW/2tt6sQJV0z9kL5h7blc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unBUsn8OXnCRHHFbp1bQ5L3fAmmACope/0sfX8QPNVMYsbcSoMivByMZz7ky1L2IW
	 g3uQfvzBBoRVOqvt9t+5aCi10VUBLqUp35B9CwVmEVvp9AhfwOIDk1wRsqRb3O+jhP
	 RmnhhtpADfAAVBHmEanVQ+PrJw4mjhRUvixLFIbKgmNG9fFhNjOzfX1fCaMCc8qRL3
	 Y5AmIsWUuJSm/ogD3wc0/RGSGg06LTy+v/PPfmkme+Q0E98Cp0S/0ofIudzlGoU2Bl
	 ky1UXb5KGs4CgA9ltXovNUsf6rCapRU8Yve3PQ9+ZOm3xxIWU8iZilAQ7FWv21ETvt
	 u5CfNTB2iXIBQ==
Date: Sat, 1 Jun 2024 07:06:37 -0700
From: Kees Cook <kees@kernel.org>
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Baoquan He <bhe@redhat.com>, Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] x86/traps: Enable UBSAN traps on x86
Message-ID: <202406010700.39246BA@keescook>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>

On Sat, Jun 01, 2024 at 03:10:05AM +0000, Gatlin Newhouse wrote:
> +void handle_ubsan_failure(struct pt_regs *regs, int insn)
> +{
> +	u32 type = 0;
> +
> +	if (insn == INSN_ASOP) {
> +		type = (*(u16 *)(regs->ip + LEN_ASOP + LEN_UD1));
> +		if ((type & 0xFF) == 0x40)
> +			type = (type >> 8) & 0xFF;
> +	} else {
> +		type = (*(u16 *)(regs->ip + LEN_UD1));
> +		if ((type & 0xFF) == 0x40)
> +			type = (type >> 8) & 0xFF;
> +	}

The if/else code is repeated, but the only difference is the offset to
read from. Also, if the 0x40 is absent, we likely don't want to report
anything. So, perhaps:

	u16 offset = LEN_UD1;
	u32 type;

	if (insn == INSN_ASOP)
		offset += INSN_ASOP;
	type = *(u16 *)(regs->ip + offset);
	if ((type & 0xFF) != 0x40)
		return;

	type = (type >> 8) & 0xFF;
	pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);



-- 
Kees Cook
