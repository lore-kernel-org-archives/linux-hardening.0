Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3184A40;
	Sat, 20 Jul 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721493739; cv=none; b=sf6Zqos/mT+tDEmpq7Z8IUewgKLT6tcN71PsLeFEZQzaF62nxNkbJX/DyexPNPfwrwofjU7knvlcsoovkG0WTj0jSPyYjCmBLrP+XqE52P0L5bMMl3UoGNPDUuVzpHAofB/0pf50VfmEZWrjUasvnrPG9/52rbK6AazNNKRAWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721493739; c=relaxed/simple;
	bh=IK1dKsFhTRKXjQWoSAzLI6OMePp8YPLTXexi7s1Fgxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn6qGuQ9bRqeuyqxrtNmoPGKhmMJgfYFDEneJr0q/BF64K5IJw0mf/NrHhkhIpoGojj3TS1vXuP4QtgaBWYm6tiV28m8ERPePXgetwvB4DPL+VWwhMgUJjw8d6S8kKR6n45UdB2tln1V/OcujdrObv+ULvUms2GKeOKOHaRNGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5yVXHZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5yVXHZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F1BC2BD10;
	Sat, 20 Jul 2024 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721493739;
	bh=IK1dKsFhTRKXjQWoSAzLI6OMePp8YPLTXexi7s1Fgxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5yVXHZSmQNfq3QQF4eBe7LITL60eLZFX+p/wzTsSjB6NDMxGMi6VbOtFzUVBASS2
	 xLHiSjlfIczgqxwaZ3/x1p6y+AgERdpEr8/KOLdXiqws7yx65WKQP9d7D24qnbM+8c
	 n1RZNxn9MX5NG8471N3S/8I1fSlXUIKUQnMtVUeTFkwdHfRvwU99nA6m9hMz+cbDdE
	 2N4dDAfMhfPC+eSoz07mxEKcPBnMl0tTKAaiE7R513Xu/7bf05NngiCGUHhDjGBTrN
	 /EBEPhCQau4EFOdqQv6JrIe6HW18cbc/d4yJfvcTyXjRbl91P3oEZuqmvHqE5F+Unr
	 Ssb4yoXDilX8g==
Date: Sat, 20 Jul 2024 09:42:18 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, gustavoars@kernel.org,
	arnd@arndb.de, maobibo@loongson.cn, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] loongarch: Support RANDOMIZE_KSTACK_OFFSET
Message-ID: <202407200940.ABE5F65@keescook>
References: <20240719031427.119274-1-ruanjinjie@huawei.com>
 <202407190858.3097E9AF98@keescook>
 <a654c7e2-929c-cbeb-cfd5-b8bbb00845d2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a654c7e2-929c-cbeb-cfd5-b8bbb00845d2@huawei.com>

On Sat, Jul 20, 2024 at 10:52:06AM +0800, Jinjie Ruan wrote:
> 
> 
> On 2024/7/20 0:01, Kees Cook wrote:
> > On Fri, Jul 19, 2024 at 11:14:27AM +0800, Jinjie Ruan wrote:
> >> Add support of kernel stack offset randomization while handling syscall,
> >> the offset is defaultly limited by KSTACK_OFFSET_MAX().
> >>
> >> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> >> slowing down the entry path, use __no_stack_protector attribute to
> >> disable stack protector for do_syscall() at function level.
> >>
> >> With this patch, the REPORT_STACK test show that:
> >> 	`loongarch64 bits of stack entropy: 7`
> > 
> > I suspect this will report the correct "6" after now that this commit
> > has landed:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=872bb37f6829d4f7f3ed5afe2786add3d4384b4b
> 
> Hi, Kees
> 
> I noticed your patch, and I reconfirm that I have updated to the latest
> mainline and that your patch is in the code.
> 
> However，the following REPORT_STACK test of your below script has the
> same result (run multiple times).
> 
> And riscv64, arm64, x86 also has the 7 bit  of stack entropy.

Okay, thanks for checking! I may go take a closer look if I have time.
It'd only be a problem if the distribution isn't sufficiently even.

-Kees

-- 
Kees Cook
