Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825663987D;
	Thu, 20 Feb 2025 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018119; cv=none; b=YtKtNxAtWt4BQnhL+M2xUNMw7sAgpXBlSTYnKbiTVxXfxx851Kq9nMW88C5TtPNpl/IT+H2anEj1894KmoHw25R3r3PEe7NNZnsghN5ZECumt+mqxNHEtGJ2xlUNt8fqqlHxETE06jfVtZqeA0DkqyM+vTso5YLjVaBQdmTyAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018119; c=relaxed/simple;
	bh=CsKE1O38t52KiDz42xjoVchy3XbzTa/Ox6cYeUTmN2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie4hTrcO1a76m4Fxriisna8wkH9j03Z2Z1fq6T1huyu7uCE92gW6doqkfMY3InELSnCHmIoR6tpg5Q3iquvOrPXKEO7NkualsXfu27DmNIfs3Zm3nHgbRrzFH6p7/o1yAoQo9x8jGyFGVkEi1oEN18ytwdm5yJD/igkd9RPIcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPWAverB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPWAverB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03670C4CED1;
	Thu, 20 Feb 2025 02:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740018119;
	bh=CsKE1O38t52KiDz42xjoVchy3XbzTa/Ox6cYeUTmN2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPWAverBseQNUwurQ+ue9mcQ3yObYrdhiPCoGRhbnZFL/cAjTpWfe1AmIt50Pl7lZ
	 rHt4QfEOkJ41lkhLfitj8NZYkWNtH2ZXBm/blLk4moFU6g8thv/kw3CSft4749/mqU
	 N+YC6M74gTPmrQw2W5fOW1zzUUAtvLxUNDA4BH7FoycgihzdlYH9qJ2yP2PJ5Js7Lp
	 YkHapP5/qyvdD61ksSS79UvIqpWwxFWyIYXseDXmnFFGovm2HryPsVc9TA3bTshn+Q
	 b9n+jl89FoHDmeqrzJE5wqdL8RmidlxWBJV1LtmlBHx8xxFW81/Qa2KnbTTps5yGez
	 3T9I+P5eP+0CQ==
Date: Wed, 19 Feb 2025 18:21:54 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Replace deprecated strncpy() with strscpy()
Message-ID: <202502191820.DA875C6@keescook>
References: <20250213141037.50394-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213141037.50394-2-thorsten.blum@linux.dev>

On Thu, Feb 13, 2025 at 03:10:36PM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/m68k/kernel/setup_mm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 15c1a595a1de..48ce67947678 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -243,8 +243,7 @@ void __init setup_arch(char **cmdline_p)
>  	setup_initial_init_mm((void *)PAGE_OFFSET, _etext, _edata, _end);
>  
>  #if defined(CONFIG_BOOTPARAM)
> -	strncpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
> -	m68k_command_line[CL_SIZE - 1] = 0;
> +	strscpy(m68k_command_line, CONFIG_BOOTPARAM_STRING, CL_SIZE);
>  #endif /* CONFIG_BOOTPARAM */
>  	process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
>  	*cmdline_p = m68k_command_line;

m68k_command_line lives in rwdata, so it should be 0-initialized by
default, so there should be no behavioral difference here (i.e. it will
be zero-padded), and it is used as a C String, so there was unlikely to
be anything depending on the NUL-padding.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
