Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F328443D;
	Fri, 19 Jul 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404885; cv=none; b=TGSAQUj/sP978Uf7XkV13MgxpkPU/kpsJnP5Irc3T2G3iwXt6lCPmg0M4l9SJ5mgZAbl14PjWe58PVvksVk5MD4bppquIor2W2CX3L4UkWDW8Es/ya2Y5GTcvhhXjaRZepijKuINjECN1y/VgeXnqTqEGSVLbDZ+PJ7Z69386D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404885; c=relaxed/simple;
	bh=p94O4KFwhP6QRgPpW/E+AEjxs45NbRS4KUZpfxl0EpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwzIddx445KCB3Kv7/dLHLdA2Nk6fidS7a6DoLtBPwSISfekVe5NE+NmBfBmzo9Q3FyqGl8D7YPt1U64wg1yx48TZsewXSxbNQlUW5N4xH9mqY9AyrRg3NSzcg8ER5eXm1SAnlk0dlgaBLb9BiecrShCyUETRuHqNCLK2cuW3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfYqpGRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfYqpGRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DA9C32782;
	Fri, 19 Jul 2024 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721404884;
	bh=p94O4KFwhP6QRgPpW/E+AEjxs45NbRS4KUZpfxl0EpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfYqpGRVvdRSqdfowho0xqO+1L3x2Xj/AEV9Twi30Em3fHz8gr1bmmIKxmCAnE//B
	 GRWB5IgPGV+v0HmgizldGBkAmc9J7AD+x9f2TJu/U/eFy2EYpNJf4Bkttpu8CLPV93
	 Cke7sMkN5Q0PTe3jpvJlHmL3x3lSU3PPovF7NN6Q20leaGdTMiNYrXJ1o1Nn8Y7h8n
	 +YzRnyAnqxrwCL0zn8ogAqaYSNgvtb6Or2MkMzppzuJAUAknuh77bITL5Qor000K38
	 ZnR0+PZZcQ6yB8mQoTH356KAu1Kme91edCQCWu5QB3D1iTmHM7NHRig/gF97ZwirmW
	 RIyw36h6jMR0g==
Date: Fri, 19 Jul 2024 09:01:23 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, gustavoars@kernel.org,
	arnd@arndb.de, maobibo@loongson.cn, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] loongarch: Support RANDOMIZE_KSTACK_OFFSET
Message-ID: <202407190858.3097E9AF98@keescook>
References: <20240719031427.119274-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719031427.119274-1-ruanjinjie@huawei.com>

On Fri, Jul 19, 2024 at 11:14:27AM +0800, Jinjie Ruan wrote:
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX().
> 
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_syscall() at function level.
> 
> With this patch, the REPORT_STACK test show that:
> 	`loongarch64 bits of stack entropy: 7`

I suspect this will report the correct "6" after now that this commit
has landed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=872bb37f6829d4f7f3ed5afe2786add3d4384b4b

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Huacai Chen <chenhuacai@kernel.org>

Thanks for adding this and getting it tested!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
