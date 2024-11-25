Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB56F06D;
	Mon, 25 Nov 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567218; cv=none; b=UCQ8MSrlcJSLfqALCbfeLyDIwVEJQa+jJTr2XxrwYC4tj+09IUQZlmVV4FnkJanzer/7H6om/BucyBLi+FfyDp0SO5yse6eNC/3S+/pQRswZFENFGQo004vgmk9u7n3cFpCD7zXh8n3vcPbvrqSXJJ0IJUmOqAFdIef0dAshOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567218; c=relaxed/simple;
	bh=3Mf+OvNtpOP4Yp8PFHrwPkTjxqY8Et/criB/R1N7alQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucs52rdVrvgG85s6v+xP7eGWjKFAgYiDELhH9IvaIS9mVZUy9bD1QQTsg+AxWOyJ+tRDPMFRCHPttEP9qNlQjVjTQXE1LyOI/f7+EoHCwMn43OWZtB2mchN6RUq93HrbXc9MbbB2IZhds86qODibRzcPFoeLLXHdgjvp2YWXKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XjGNUmFt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XjGNUmFt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NVsVk2Cd6ZJd8jRyfdNHFXq9NI02Yyjwk/+6q8/76/A=; b=XjGNUmFtOmnA/EI2txIfuGDPeV
	nDHfPS6SRB/QmkiwbxrqAkhKjvmXw8WUaRUB5kNIX+LUEKkim/+7Th3OagA0U8+9t3ojSc9iOZ71g
	2SDHbyXJHA9om93l4E6Q8wxjjsCSFPLwF2P5eGO07CiShs3YA0nEegqtq2XolBdMFPc9vcFcogu9C
	y/nrkG4tMttZ8V4IuPJLYXokPTQsgf620Q9e4Uaz4mfuMDT1JzTdrYDaRu60x2R2ym61KN6vw4O2U
	FVrsZcS0XnuiwZg97F1XC+enJnOtDaXMnePahJ2+KXNM+koYjXH5cCYATve9kwTpm4EZknow5k9Zl
	b3pqS5lw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFfsN-0000000CSXT-3y4q;
	Mon, 25 Nov 2024 20:40:08 +0000
Date: Mon, 25 Nov 2024 20:40:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	oleg@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <Z0Tgp4WBPvJiojqG@casper.infradead.org>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125202021.3684919-2-jeffxu@google.com>

On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> +/*
> + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> + */
> +enum seal_system_mappings_type {
> +	SEAL_SYSTEM_MAPPINGS_DISABLED,
> +	SEAL_SYSTEM_MAPPINGS_ENABLED
> +};
> +
> +static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
> +	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
> +	SEAL_SYSTEM_MAPPINGS_DISABLED;
> +
> +static const struct constant_table value_table_sys_mapping[] __initconst = {
> +	{ "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> +	{ "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> +	{ }
> +};
> +
> +static int __init early_seal_system_mappings_override(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
> +			buf, seal_system_mappings_v);
> +	return 0;
> +}
> +
> +early_param("exec.seal_system_mappings", early_seal_system_mappings_override);

Are you paid by the line?  This all seems ridiculously overcomplicated.
Look at (first example I found) kgdbwait:

static int __init opt_kgdb_wait(char *str)
{
        kgdb_break_asap = 1;

        kdb_init(KDB_INIT_EARLY);
        if (kgdb_io_module_registered &&
            IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
                kgdb_initial_breakpoint();

        return 0;
}
early_param("kgdbwait", opt_kgdb_wait);

I don't understand why you've created a new 'exec' namespace, and why
this feature fits in 'exec'.  That seems like an implementation detail.
I'd lose the "exec." prefix.
