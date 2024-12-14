Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC57653;
	Sat, 14 Dec 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167544; cv=none; b=cJZ7kP1/1/hmK45cQHFc9GMDECMkaP/A7q64rnmbROZuLfgox9MDrrnaXZfRF74vv4mR1eIi9MLuDxWsGDNTi7CnLB6q5SKFh3xKLy2HGliG8XyH+am9NsS/51mxexbCc5QVGyk0/c2UkbkmxkobUO9oqfxAv6IEjypBgQyWMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167544; c=relaxed/simple;
	bh=vakxJDBESZJU69hvEmHaZbNiXoRGI/zkqMQV/o04X9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVe46P0ttNxKtDo2x0idW9grZ/MV7IztaEN2cssJqLy59a5OPR3C5kh6qJaqUUd78w2nTem6nufP0lkBjzhHlUfcCFB2c+bPvKRPwSkzSgxIGo5LISmy7bLxtpkKgIFUHeuwSUJ7FDdoP5G75oXqapcpAQKeeEkVvrOxiOLv5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BfNre14Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BfNre14Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81B8C4CED1;
	Sat, 14 Dec 2024 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734167543;
	bh=vakxJDBESZJU69hvEmHaZbNiXoRGI/zkqMQV/o04X9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfNre14QDyWDsHUNnIp1SHG4ZL8SaX+OlRBtconsafmSusJMiCKa9jCrEsfG+h/Ns
	 6XT/2hpZ5FiPDvFgoDb/8g/N0ygQ+iBqiKtDWQ+JvOqjp0cUoJsCDIp+QgO1cBrRXR
	 FLDuC0pni+j/uPQxAT9P4vRQKSkt++9dDiEvYKuU=
Date: Sat, 14 Dec 2024 10:12:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>, Qing Zhao <qing.zhao@oracle.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fortify: Hide run-time copy size from value range
 tracking
Message-ID: <2024121450-scrawny-payphone-71b5@gregkh>
References: <20241214013600.it.020-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241214013600.it.020-kees@kernel.org>

On Fri, Dec 13, 2024 at 05:36:10PM -0800, Kees Cook wrote:
> GCC performs value range tracking for variables as a way to provide better
> diagnostics. One place this is regularly seen is with warnings associated
> with bounds-checking, e.g. -Wstringop-overflow, -Wstringop-overread,
> -Warray-bounds, etc. In order to keep the signal-to-noise ratio high,
> warnings aren't emitted when a value range spans the entire value range
> representable by a given variable. For example:
> 
> 	unsigned int len;
> 	char dst[8];
> 	...
> 	memcpy(dst, src, len);
> 
> If len's value is unknown, it has the full "unsigned int" range of [0,
> UINT_MAX], and bounds checks against memcpy() will be ignored. However,
> when a code path has been able to narrow the range:
> 
> 	if (len > 16)
> 		return;
> 	memcpy(dst, src, len);
> 
> Then a range will be updated for the execution path. Above, len is now
> [0, 16], so we might see a -Wstringop-overflow warning like:
> 
> 	error: '__builtin_memcpy' writing between 9 and 16 bytes from to region of size 8 [-Werror=stringop-overflow]
> 
> When building with CONFIG_FORTIFY_SOURCE, the run-time bounds checking
> can appear to narrow value ranges for lengths for memcpy(), depending on
> how the compile constructs the execution paths during optimization
> passes, due to the checks on the size. For example:
> 
> 	if (p_size_field != SIZE_MAX &&
> 	    p_size != p_size_field && p_size_field < size)
> 
> As intentionally designed, these checks only affect the kernel warnings
> emitted at run-time and do not block the potentially overflowing memcpy(),
> so GCC thinks it needs to produce a warning about the resulting value
> range that might be reaching the memcpy().
> 
> We have seen this manifest a few times now, with the most recent being
> with cpumasks:
> 
> In function ‘bitmap_copy’,
>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
> kernel/padata.c: In function ‘__padata_set_cpumasks’:
> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>   713 |                                  cpumask_var_t pcpumask,
>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
> 
> This warning is _not_ emitted when CONFIG_FORTIFY_SOURCE is disabled,
> and with the recent -fdiagnostics-details we can confirm the origin of
> the warning is due to the FORTIFY range checking:
> 
> ../include/linux/bitmap.h:259:17: note: in expansion of macro 'memcpy'
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
>   '__padata_set_cpumasks': events 1-2
> ../include/linux/fortify-string.h:613:36:
>   612 |         if (p_size_field != SIZE_MAX &&
>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   613 |             p_size != p_size_field && p_size_field < size)
>       |             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>       |                                    |
>       |                                    (1) when the condition is evaluated to false
>       |                                    (2) when the condition is evaluated to true
>   '__padata_set_cpumasks': event 3
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
>       |                                 |
>       |                                 (3) out of array bounds here
> 
> Note that this warning started appearing since bitmap functions were
> recently marked __always_inline in commit ed8cd2b3bd9f ("bitmap: Switch
> from inline to __always_inline"), which allowed GCC to gain visibility
> into the variables as they passed through the FORTIFY implementation.
> 
> In order to silence this false positive but keep deterministic
> compile-time warnings intact, hide the length variable from GCC with
> OPTIMIZE_HIDE_VAR() before calling the builtin memcpy.
> 
> Additionally add a comment about why all the macro args have copies with
> const storage.
> 
> Reported-by: "Thomas Weißschuh" <linux@weissschuh.net>
> Closes: https://lore.kernel.org/all/db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de/
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20241112124127.1666300-1-nilay@linux.ibm.com/
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Fixed the build issues I have here, so:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

