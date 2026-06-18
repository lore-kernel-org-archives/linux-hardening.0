Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B128D8DA;
	Thu, 18 Jun 2026 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801653; cv=none; b=DcDFFk4+QiU8bg0FZz7ilPrJQBB9MpuYmLVwB4jDSCXz/m/ocMfgoo/N/49o5htECgBKYwKWmVFuZZq0tEWYcmCx5onlsFlVwytwcLgF/d5R/ANaOAtKNWly5EPpOQAyjTEUH4ejndjj2pf7UVBnnSxMKpT1FuoRYW7jkrOth/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801653; c=relaxed/simple;
	bh=f921/Yupm9I7VYe6MpH7HOkwP0ic1/72UUx/dXvrHHE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LykA2CzityUPI/f12XGJntcrQoF7XJ21nlEbKdPwG0hCyanKdmodT/RH47bhtHvxtyjWAgxXLPZWyrnmAUJBh9ioZiR4dHuetBMnKthIpFfy/PYm3PjPPku7TBgvahG6GZ1+dPyid/kl3bnO5m++bXXn45J1A9d3dy4J3QKVHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q828+UYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q828+UYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B6F1F000E9;
	Thu, 18 Jun 2026 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801652;
	bh=f921/Yupm9I7VYe6MpH7HOkwP0ic1/72UUx/dXvrHHE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=Q828+UYYr24vWrvjy2oG7aXakUIBAlvCiJALDDs/wf4+XQ1nAFhnbqHq7Y+YEOV/y
	 rPjawwyDW2dFHRuDin9ItMYjhXDRgP6b2PXXMVlegk5qKdA+ThZnSfJXe0XGtomzis
	 QxTpWfJAEAgPXJRcqskz5F1PAgg9p9FNw9/S+GVhTJw66LPuSOzDXP0Waw3ZkJ+VwF
	 25u738kQo+006SrwPB6b78V8VWApIa5qz3SS6ScULFEvt+chW15eVTQ1a4mvVfKq9V
	 lTlNlS3UCKjbmZsDcnt31ijzACAyRkbhmc2KUuyeBgEdqoTi9F9aJcVNA4DM46MWkc
	 0SmcqIDOClPFA==
Date: Thu, 18 Jun 2026 09:54:11 -0700
From: Kees Cook <kees@kernel.org>
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <pjw@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
 Evan Green <evan@rivosinc.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: Add kCFI type prefix to unaligned copy routines
User-Agent: K-9 Mail for Android
In-Reply-To: <877bnwtb0n.fsf@yellow.woof>
References: <20260618081252.work.711-kees@kernel.org> <877bnwtb0n.fsf@yellow.woof>
Message-ID: <9E1CFDD7-018E-4945-B261-0D46B355A369@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 18, 2026 3:10:00 AM PDT, Nam Cao <namcao@linutronix=2Ede> wrote:
>Kees Cook <kees@kernel=2Eorg> writes:
>> __riscv_copy_words_unaligned() and __riscv_copy_bytes_unaligned() are
>> called indirectly through function pointers from measure_cycles() (via
>> compare_unaligned_access()) during the boot-time unaligned-access
>> probe=2E Under kCFI, an indirect call checks the type id stored in the
>> word immediately preceding the callee against the type id of the
>> function-pointer type at the call site=2E These two routines are define=
d
>> with SYM_FUNC_START(), which emits no __cfi_ prefix, so the check reads
>> the alignment padding ahead of the function (zero) instead of a type id
>> and traps:
>
>This has already been fixed by commit f2abc305aa93f ("riscv: Define
>__riscv_copy_{,vec_}{words,bytes}_unaligned() using SYM_TYPED_FUNC_START"=
)

Ah-ha! Great=2E I need to update my tree, it seems=2E :)

-Kees

--=20
Kees Cook
