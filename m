Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522399;
	b=IefcD7cxrmhVD0bYe+gK9+PoWnm2mzvfoVD0EYvVVuu1rIbk7Kp6knnuNhHBxeqzqwo6
	 72HQEbjDcfQxK/DoPiWXwXuuAYmWv8ueRJwu5emi+FjMQ4wQbui+sNLAHi5ckezqnFdoa
	 oTz8KwPsEpZQCG0PETHkK2iDt8B8/1nA5HSWbHiwDjkNX5UgcMia/5Bd+PcYYkSj2EK4H
	 5i5ExF+Xvqf9N2KggsQSYvp0jy1eQ0qtN/+U5ennIrkmR6GmyJZ2d356iC0oSKfOGL4oN
	 2y4riTG3OmyRs+7V8Ydow/N3ZDzO9wn3mu9eoUU33n1i+FBu8DGwpnkPX0yFhZ+Gu+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522399;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yzusoICsZjm08Apg9oZ/jq4BkURI6t1XbBRqUFt4Xm8=;
	b=UJhjl5w23wpwlA1HU3Nb8VUttfjJe9SdnA2T1sDub1kkA/QOlrson+s5cdkrzvfbve+l
	 RC6IEyR67ex3rN+tksKzcDOidnGpYiGulVBRh6cOm7y5oG4yUWxpSen6qEEFoNk7eFrqI
	 tOLLkoNE+jY9cotgvebwvKCDoX94EQCSaQlgOCtmDuH1wuPnI21Ka5wEShtPNUnofGETI
	 aiu9qyqbnsRBeggu4L9qruSDiSbMm+cmSEkn5xtr3FzIhf4m5XeEzj53+rawYpO8VWfc8
	 Bvp/sA3KBfxxFpYA0SCg8YxMI8cvZ1pJeswA8tFJw2Si/4aup49nDle1YnezcMZtfDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=E8isgUyy;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6DC606A32A;
	Tue, 24 Nov 2026 12:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B6DC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=E8isgUyy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC79339;
	Tue, 24 Nov 2026 04:13:15 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597E03F632;
	Tue, 24 Nov 2026 04:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795522398; bh=Bz7umvMoPtgIHCEppXFYHWZcFXpcpdG83AT8i+31kpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8isgUyyGUY/+jfI1aGuIyNhFLJGeRCpBVaEgIMVIro0/iHezUX1AfBowPvgiJpz9
	 Q8XwXcio+kDZ94maesvIvnFfWJA7eScolfnnIInPInsPyt/5BWuw2z90s3sSPKC6Id
	 p+Nv12OtfBR8jj+sVkwkHKNPO7e+P618mjt8jURM=
Date: Tue, 24 Nov 2026 12:13:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Thorsten Blum <blum@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: patching: Annotate text_addrs, new_insns
 with __counted_by_ptr()
Message-ID: <awV_Wn0PivLnU2wp@arm.com>
References: <20261111164515.77988-2-blum@kernel.org>
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
In-Reply-To: <20261111164515.77988-2-blum@kernel.org>

On Wed, Nov 11, 2026 at 05:45:14PM +0100, Thorsten Blum wrote:
> Add __counted_by_ptr() to aarch64_insn_patch::text_addrs and
> aarch64_insn_patch::new_insns to enable access bounds checking via
> CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
[...]
>  struct aarch64_insn_patch {
> -	void		**text_addrs;
> -	u32		*new_insns;
> +	void		**text_addrs __counted_by_ptr(insn_cnt);
> +	u32		*new_insns __counted_by_ptr(insn_cnt);

I'm not sure it buys us anything. The only accesses to these arrays are
in aarch64_insn_patch_text_cb() in a loop already bounded by
pp->insn_cnt. UBSAN just repeats the loop condition. There's no
mem*/str* use of these pointers either, so FORTIFY_SOURCE doesn't
matter.

The annotation can't catch a wrong count from the caller since insn_cnt
is taken directly from the cnt argument of aarch64_insn_patch_text().

So, I don't think this patch is needed.

-- 
Catalin
