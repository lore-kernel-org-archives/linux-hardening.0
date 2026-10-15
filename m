Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D53E3141;
	Thu, 15 Oct 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082120; cv=none; b=QSIQn5vUJCHXvbRZEWYdXHWbcmZmjGX7gDmzC6cwS3QQhresoEgbE8TqxWetGsnUZkeAwP/axxJLXceUWNMHFIYUVRnMsEi0FfHlB7eXtZG4MmJ7GyiHkFsqYlQInDy3icNI+z8qs8b3hnDA+fYnN7pus1BCtsA2HNJxf4TJGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082120; c=relaxed/simple;
	bh=lsiH1+9I7R8Zogecgsc8mrMTXuCaEqcuQrsVaEDtkC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrE0QI8DVwJn1JbBLO7Q/Ww5TjGrZ2unk4b8xQ4nNBOGhkiQqxI+obwRcgku0acX+OKW1M8me0bR6u7KUxQBXTeEyhu9k9Kzkm/4dvScHrHEHTLgOs8hg6O1cX1pJ9yPS4Ltl+gOb/Nov7KWqgEJB1WZGxDM8fNvLKAl16VP17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a2AsLQvb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a2AsLQvb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A7414BF;
	Thu, 15 Oct 2026 09:35:02 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9223F871;
	Thu, 15 Oct 2026 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792082105; bh=lsiH1+9I7R8Zogecgsc8mrMTXuCaEqcuQrsVaEDtkC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2AsLQvbUtafLx5JEFU7If/jPUmnKDzQLNnyAKcPeXuraMiO1yHOL9cr1qGxmcFDg
	 /ZtQ63wu2mEK+d3MgSz1GePJ/sF0hbTvf5y80ElN7tv5niqN5SSKYm3Huz/QQ9fjE3
	 8WSg6sfzddBzCnipx04jTzq4ZNdtfgDF7erhtQtM=
Date: Thu, 15 Oct 2026 17:35:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Iurii Trukhin <yuri@trukhin.com>
Cc: Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit
 and 52-bit VA
Message-ID: <atEAtHiHh0eeVPn3@arm.com>
References: <CAOx7e9K5sgNcWNj4CemyZd0Ar1ZjR4o44B4nryohq-Ue6TNdKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOx7e9K5sgNcWNj4CemyZd0Ar1ZjR4o44B4nryohq-Ue6TNdKA@mail.gmail.com>

On Wed, Oct 14, 2026 at 10:23:35PM -0700, Iurii Trukhin wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cab741a695f5..7bca47269dd5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -313,6 +313,14 @@ config ARCH_MMAP_RND_BITS_MAX
>  	default 16 if ARM64_16K_PAGES
>  	default 18
> 
> +# default to 1 TiB (5 bits below ARCH_MMAP_RND_BITS_MAX) on 48-bit and
> +# 52-bit VA; smaller VA sizes fall back to ARCH_MMAP_RND_BITS_MIN in
> +# arch/Kconfig
> +config ARCH_MMAP_RND_BITS
> +	default 24 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
> +	default 26 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
> +	default 28 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)

This looks fine but I was wondering what ARCH_MMAP_RND_BITS_DEFAULT (and
the compat equivalent) is for. It turns out that an int always evaluates
to 'n', so not taken into account. It might be worth removing them
altogether as a separate patch. No-one seems to be using them.

-- 
Catalin
