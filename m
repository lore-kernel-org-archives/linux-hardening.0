Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF1191487;
	Wed, 26 Jun 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428873; cv=none; b=C3gzVXfNicde7iwAKGXF75+v9zuUhLk6McdstnO0FHT0/Iz0yAOTrGVu/NQrPH4UfXAQHpwT+N37NRSBvl/Va470F1Jqsnlc4i/hdZnb1m6W6fLkeg2mlrW+2rb6DriMky9pYTgbePY6h5lxmxKOGxFr6MmetPzNUp3Fd6rybo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428873; c=relaxed/simple;
	bh=bqHWQz8E3Am6DleAIbssY3jjO1zvMlgjemHa+tlFa40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jcx/Kzd85DbbpatJsSXFqm4S7LeT+QPXcw9gnkqvEMBLmtTtMx6EzNO/s5loMU75PUIgq4xfEZD05wcY+2rgWrny56V4pl0cq71S6F1TQLTv8nAXjq1EgsCb4BOVYHuEBVSBVZqei31pBqvd8zGRJ7TXN05Eih6efeivlpsrTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHTqRn4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHTqRn4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AA9C32782;
	Wed, 26 Jun 2024 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719428872;
	bh=bqHWQz8E3Am6DleAIbssY3jjO1zvMlgjemHa+tlFa40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHTqRn4fj5bfkzftnY3K2lkiVZvCbc/pMPXzZUhMWJewG4saqpOaQkwADy3Pgl7bm
	 2aKJhpT2rvftGdmlaKXYv4BF+9mVXpfU3ePYZk3jDTm0Ud1xd+QNzV7ZP4GivGXjb+
	 /5AUXPEmZN5k2y/Lw6im71Hsb9w0dRtZDDBDJ7ZAoO89bkmKtwLOOfbg1I8BZhOpnX
	 8BtRrDKtL1H/aN40lAhldYuqhGzn/6NyRA7zvjg6MhLNtTTAUrNCduoduoeGBnkGcT
	 p3xztrjfDKHn1BiSabX9WDOoBzyW56bmR9rFhITZNnQSQR4J3/D0jR6JtoRqoCQTQo
	 a8KFQfP/U2U6Q==
Date: Wed, 26 Jun 2024 12:07:52 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] x86/traps: Enable UBSAN traps on x86
Message-ID: <202406261205.E2435C68@keescook>
References: <20240625032509.4155839-1-gatlin.newhouse@gmail.com>
 <20240625093719.GW31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625093719.GW31592@noisy.programming.kicks-ass.net>

On Tue, Jun 25, 2024 at 11:37:19AM +0200, Peter Zijlstra wrote:
> Also, wouldn't it be saner to write this something like:
> 
> __always_inline int decode_bug(unsigned long addr, u32 *imm)
> {
> 	u8 v;
> 
> 	if (addr < TASK_SIZE)
> 		return BUG_NONE;
> 
> 	v = *(u8 *)(addr++);
> 	if (v == 0x67)
> 		v = *(u8 *)(addr++);
> 	if (v != 0x0f)
> 		return BUG_NONE;
> 	v = *(u8 *)(addr++);
> 	if (v == 0x0b)
> 		return BUG_UD2;
> 	if (v != 0xb9)
> 		return BUG_NONE;
> 
> 	if (X86_MODRM_RM(v) == 4)
> 		addr++; /* consume SiB */
> 
> 	*imm = 0;
> 	if (X86_MODRM_MOD(v) == 1)
> 		*imm = *(u8 *)addr;
> 	if (X86_MORRM_MOD(v) == 2)
> 		*imm = *(u32 *)addr;
> 
> 	// WARN on MOD(v)==3 ??
> 
> 	return BUG_UD1;
> }

Thanks for the example! (I think it should use macros instead of
open-coded "0x67", "0x0f", etc, but yeah.)

> Why does the thing emit the asop prefix at all through? afaict it
> doesn't affect the immediate you want to get at. And if it does this
> prefix, should we worry about other prefixes? Ideally we'd not accept
> any prefixes.

AFAICT it's because it's a small immediate? For an x86_64 build, this is
how Clang is generating the UD1.

-Kees

-- 
Kees Cook
