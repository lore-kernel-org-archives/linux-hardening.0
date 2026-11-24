Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542240;
	b=jAFPONI5XWBzQv85vZSnBDFW+6amtUPiR4/YitjOapdLBdkwZAEJ5SKNmQO6FNL5tLga
	 rARu4qXVuaChBVLCh1o3Og7N27VXILMcgU4nXUH9u5MmbBLwKVt7XPlPMEa2wb+9lJm11
	 mLmWJj+AfdDa4WYm+4HdAsUoMo1zQiaef4gdDi3dbyCgI4w0aPjESmaQMuyMcJi8wC3vl
	 PT5xHnFbk6ZwIR3mpMw6gkcPOU5GEDB4AB928e0P+iq/J4OdJQen3XXmfXfXq+6uvjsp+
	 hieMrYXGxb36E3Dtkt5EYf8oyPFKWO77IL8lvf/0YCFVt4MbQ0c6WMGVmcF882oKd5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mEF01XSutK6OiYIL5GsOD9Pg+N69x5w2z8F66Ac8pew=;
	b=lG0mvsdE4BtU9Zh/ZKP5jKwam6x2dMTrfr/d8lzC4z1/ZAS+XPKOvQ8f5EiBK33mD8l6
	 MYmfMNwd7AD5KRS4V6pTmBjEmdQBmHrXMDdqDm90E2u+WCkDaUSSnJYWz+PaOOjuraNU8
	 9kev/Nbj7Ge88E28AuHz2aPGQ6a0HlHsS7LKEm+1SS1buE0KQsDnz2leZM6oDO7UnT2tq
	 7BQskhkkR1l5h2wJ2giwbTuLYIy3RgVH6GAP8O8uvEEhcJcnsdT7BvWMfOx8s4Ba1s6ar
	 ZRBysEi2XZmHX3lLvUYBBuSDoWXYTu4TtmdwEeyG5+b5heCamcs13SrjhmEUBzG265g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8Sg+5Q4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E503606A323;
	Tue, 24 Nov 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8Sg+5Q4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB5F1F000C0;
	Tue, 24 Nov 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542240;
	bh=mEF01XSutK6OiYIL5GsOD9Pg+N69x5w2z8F66Ac8pew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8Sg+5Q4w0OgIkgoYP1iLUxnrkOSOp3EiF1ix0p4gWRW8d8IsoyyNw5Ny600vVwov
	 WmmQCLuRIvQHRMh2ihos5HyJ6WWlgQdutDRmZtgQ1GwrHbiSIguI2KOd4x5wbcoSk9
	 j1T4muALCA3oxAYZVwPb2/Ga/37lz2PdoeOR36sdL0BIqUucAsOFmii6Ppcjuub7PG
	 khasVElNqnAIcoKwkHsNMcMohBqp5agj8aDngpSXHvcJ1Li5FAdNDv5Q5jHVNR89yl
	 AsKgYB9VeNZ5tYw4opqq5zVLU24zCEHkSTg/6VC2BiZZSCgk9w6DsyvmS5DB0rASk/
	 DnHRcal1dhHQQ==
Date: Tue, 24 Nov 2026 18:43:54 +0100
From: Thorsten Blum <blum@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: patching: Annotate text_addrs, new_insns
 with __counted_by_ptr()
Message-ID: <awXM2h0A4UsEQ3go@kernel.org>
References: <20261111164515.77988-2-blum@kernel.org>
 <awV_Wn0PivLnU2wp@arm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awV_Wn0PivLnU2wp@arm.com>

On Tue, Nov 24, 2026 at 12:13:14PM +0000, Catalin Marinas wrote:
> On Wed, Nov 11, 2026 at 05:45:14PM +0100, Thorsten Blum wrote:
> > Add __counted_by_ptr() to aarch64_insn_patch::text_addrs and
> > aarch64_insn_patch::new_insns to enable access bounds checking via
> > CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
> [...]
> >  struct aarch64_insn_patch {
> > -	void		**text_addrs;
> > -	u32		*new_insns;
> > +	void		**text_addrs __counted_by_ptr(insn_cnt);
> > +	u32		*new_insns __counted_by_ptr(insn_cnt);
> 
> I'm not sure it buys us anything. The only accesses to these arrays are
> in aarch64_insn_patch_text_cb() in a loop already bounded by
> pp->insn_cnt. UBSAN just repeats the loop condition. There's no
> mem*/str* use of these pointers either, so FORTIFY_SOURCE doesn't
> matter.
> 
> The annotation can't catch a wrong count from the caller since insn_cnt
> is taken directly from the cnt argument of aarch64_insn_patch_text().
> 
> So, I don't think this patch is needed.

Fair points. It was meant as a hardening change to prevent future errors
and document the relationship, but since nothing is gained today, I'm
happy to drop it.

Thanks,
Thorsten
