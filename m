Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B92C027C;
	Thu, 24 Sep 2026 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294202; cv=none; b=t74qKUgWqvWNWMss0bd2uYE/qqt8RF9LowyCcBAt0thay0/QIlrKMfEopyA2xMwZnDLmdULU8Y4q0xvD6T8XpUtWSCO/kuMeccn3Wga6ng4WAdxM3HOore9KctC/BPla4NjxYs4VTvg88QcdiJj60ezTycZlkN1XkNvSKIsKo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294202; c=relaxed/simple;
	bh=tM0DuN3n8msF0/tfYTxALsC4nwPop0gAbLpk09sxOO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz5REKtYlICfXL/sATKPKIkG3z1OTBQ2AHxVm3Tp7CDSWJbO510eEcc+v0c5B3pcTHlteElGZ6E0zBIjuPd235+wX6bUQ6UNhc1gYyfmYLqFg5nImgUjuBvl0o5bXLZefD7L+FZmvMpT/0a1SyBc4HE71TBhKOB496UdTxjFXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToswNape; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToswNape"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686591F000FF;
	Thu, 24 Sep 2026 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790294201;
	bh=JSwuAGPzX8RoJMccYGVKtdfyo6odqNj35F2Uzl7Q2qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ToswNapex2IFgKhaY1s/8FdlMabI62hEDEpKUTy1dJMd0Rv5/09AWVjiYrc4Pyo/y
	 Sd8Wra9/4mCWlbBt9+69kDdw3zrDwK6FCVbaDi/BeY7rzjlVfatdKntHdqBLW+/zcg
	 7X1fcOH76ng9qOOnN9LC2FkxAc157ysF26o4JGHt5pmAObQ8QjsEeVKjmXXfIZYCPH
	 YahCxN1lXj7cZf99dwEmnaiONZlVDatYaroDN7e1ZRRAXk1OdImMOQyGxvJ+tm9b4M
	 J/v8Gsu3DSLFOr96KxPPOx5u6e9I5TS7sk/v+B9Xvb7M9iorBkU7PxtCcLJo/kBN60
	 bPjBi0UYUhwkA==
Date: Thu, 24 Sep 2026 16:56:41 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	oleg@redhat.com, luto@amacapital.net, wad@chromium.org,
	peterz@infradead.org, ada.coupriediaz@arm.com, linusw@kernel.org,
	yeoreum.yun@arm.com, kevin.brodsky@arm.com,
	anshuman.khandual@arm.com, james.morse@arm.com, thuth@redhat.com,
	vladimir.murzin@arm.com, tglx@kernel.org, broonie@kernel.org,
	liqiang01@kylinos.cn, ryan.roberts@arm.com, pengcan@kylinos.cn,
	kmehltretter@gmail.com, linux-arm-kernel@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/ptrace: Add PTRACE_SYSEMU_SINGLESTEP
 syscall-exit-stop test
Message-ID: <202609241654.F545D3A88@keescook>
References: <20260922195719.i.211-kees@kernel.org>
 <bbd65e4d-8096-4939-8308-f0f54c5cb3bc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbd65e4d-8096-4939-8308-f0f54c5cb3bc@huawei.com>

On Thu, Sep 24, 2026 at 12:11:31PM +0800, Jinjie Ruan wrote:
> 
> 
> 在 2026/9/23 3:57, Kees Cook 写道:
> > ptrace(2) states that no syscall-exit-stop occurs when a tracee is
> > continued with PTRACE_SYSEMU or PTRACE_SYSEMU_SINGLESTEP. arm64 gated
> > its syscall-exit report on
> > 
> > 	flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
> 
> Hi Kees,
> 
> The original fix description is a bit off: on arm64 there is no extra
> syscall-exit-stop; instead, there's an additional pseudo single-step
> injection.
> 
> As sashiko pointed out, as commit ac2081cdc4d9 ("arm64: ptrace:
> Consistently use pseudo-singlestep exceptions") described, for
> PTRACE_SYSEMU_SINGLESTEP, arm64 still needs the pseudo single-step
> because its hardware single-step state machine is fast-forwarded over
> the SVC instruction.

Ah! Okay. So this test should be tweaked to deal with that? Feel free to
snag/update this test for the series. We didn't have anything testing
syscall exit stops, so it seemed reasonable to get it written.

-Kees

-- 
Kees Cook
