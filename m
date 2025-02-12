Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F820C49F;
	Wed, 12 Feb 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365443; cv=none; b=TJB82xQ3rBn1t9Gb1QI5JoW0bbiNRPNvOrdBoA7MqK9m+ZiQr0c/FUkN8BTildaeN+nQiwPqKLfBXSQ8mUxW+D+Y9n2ZezmATl5zqP7TO+wVZvnFhGdIlyu2I/j1/VLyrpQJFTVpmVAvll4JdpijjZzb+BHCM1vEF/6+3oNRyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365443; c=relaxed/simple;
	bh=WPpoEVXz6qHST5bg1jg3HxWN+lQyhY1AExJV/hTo36U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffVf4E5mq0eiCseFDQai4e8qjrP64IZEms7nxcr1Yp3oXaukAgHn0/0+9BEYRjTJB8FD/l5RlldQYYQ10mA0zYjQPfGguRKdUEXwVT9tuQ+6aOAsxAG2N4eWYcN9E5V104CNZ7wI9bVIor9vLjjSmBuJOxSi72nYAqg5B1amWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyFkh7uK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqFRzqLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyFkh7uK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqFRzqLI"
Date: Wed, 12 Feb 2025 14:03:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739365440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soGwUcM7FS1/q41UUnp8a+P68mixKiDDmCjv27Yua7g=;
	b=yyFkh7uKgxkpEzxHO9IJM/Su5JamH2HM8z78zJzBJYgf0Lxpy6M6hWQ1rXpixOlD8fL2rZ
	hiysYZUa5k84oeZDgPBdlpZlO+Oj68XYfCARPvdqf5dE5wV417yuPq3udxS4nxZgyzOlsk
	+QD4vLafFb3qOWe6fGvm2qbXpquB9TJUiNsAW1ohhUxRsPts8AlEaIUb7ohKiV++04U4Zw
	/zSZ32L15VL92eJe2Vh/MWaW55AUPwUcvNLkKiXRXOA7gxreGAd3D4W1k1/bG4jeiPMymy
	tL3tsOCpnUk8JLEkY8P9tKafkORcFX1Xk0YrCP/PhtAKAtJ7Vl2RY9OeFQj9mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739365440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soGwUcM7FS1/q41UUnp8a+P68mixKiDDmCjv27Yua7g=;
	b=OqFRzqLIlg24n/tDmtYsX94R48vsZwYDpth0U9pqbAGNaSCr8vHQileOHaoaaTu6hn1vpX
	yjX+qcIgpSa3+KAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, adobriyan@gmail.com, johannes@sipsolutions.net, 
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 2/7] selftests: x86: test_mremap_vdso: skip if
 vdso is msealed
Message-ID: <20250212135000-861e6353-6e0a-43c3-9b28-649ae4dfc607@linutronix.de>
References: <20250212032155.1276806-1-jeffxu@google.com>
 <20250212032155.1276806-3-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212032155.1276806-3-jeffxu@google.com>

On Wed, Feb 12, 2025 at 03:21:50AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add code to detect if the vdso is memory sealed, skip the test
> if it is.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
> index d53959e03593..c68077c56b22 100644
> --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> @@ -14,6 +14,7 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <stdbool.h>
>  
>  #include <sys/mman.h>
>  #include <sys/auxv.h>
> @@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
>  
>  }
>  
> +#define VDSO_NAME "[vdso]"
> +#define VMFLAGS "VmFlags:"
> +#define MSEAL_FLAGS "sl"
> +#define MAX_LINE_LEN 512
> +
> +bool vdso_sealed(FILE *maps)
> +{
> +	char line[MAX_LINE_LEN];
> +	bool has_vdso = false;
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, VDSO_NAME))
> +			has_vdso = true;
> +
> +		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
> +			if (strstr(line, MSEAL_FLAGS))
> +				return true;
> +
> +			return false;

This only tests that any mapping after the vdso is sealed.
There is a real parser for /proc/self/smaps in
tools/testing/selftests/mm/vm_util.[ch], see check_vmflag_io().

> +		}
> +	}
> +
> +	return false;
> +}

<snip>
