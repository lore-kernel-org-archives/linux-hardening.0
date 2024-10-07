Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2618C02A;
	Mon,  7 Oct 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344565; cv=none; b=VwwriUxvoTSIR966da7isrSacGLB+onSKmgeYh/vhBTOXVmKcUNI97ubqGIJFpYGyfqa8Lo5qD55L8vaG0IGvTls2gz4sEmIXiQQMlFcCEGa+EUzVWpiKGZ6qEUl5KiBdFazDWHP5Cbx1e4rw6se6MrRgOatp9CUwqDtexv8dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344565; c=relaxed/simple;
	bh=gw5Yr7mT6sfHQOfQOKocssnRqHaKWutZD9XL6d5dISI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=la6JThm6esNo7PYWafNwb0Jcq8+KOL1oTWbAPncydzVPixtl+dioPB4gV9JqGe+pPJ+dd5OLFsL9T6FePqbT6T5FqqQk0x2JlwTY9FHQ9/32+aJXoNxR/h1mgzbrHn6OgBgJWSgPBxAQxNsOaXKgBjaOSLPzZg6nPgqeAlEq33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fpo+XsuO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpo+XsuO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=VrtXwXq/sxxK98DUTL4FztbDLyq5StqonQB645wrmOk=; b=fpo+XsuOLAEpysnTuaCqN/IJa/
	bYQ2qq9lXZs7FE++WBbhqUgtGf0mLRDucgA3efWom3E48j65OPNkaPQ8goVehSzMFz+CWNvBIR1Si
	SHnsAg7KLemssU1CuI52iWUVupsxUHVtDo9aT6gLAu996eySCYvL43nxJpdmFoBSfwJxwfIUjZpb2
	YmKT9DtGitnK0jzt2fVXdskNj/P4uRvrXqBD0itOf1pH0JeoHimLr5myS85Qpz+e28kayrEFGUryq
	aoQlLxX1u+VoXmwXXqRYdvgyqrFKpjVpqXOGNKiqonwWMPQKI4Ize1wp9kbmH/v4eRqDk//ENEkcS
	iJNbqMgQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxxN0-00000000y4L-1Cgw;
	Mon, 07 Oct 2024 23:42:31 +0000
Message-ID: <24700097-561f-4b81-a45c-e4f7b4b9b853@infradead.org>
Date: Mon, 7 Oct 2024 16:42:21 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, torvalds@linux-foundation.org,
 adhemerval.zanella@linaro.org, oleg@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
 ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
 mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com,
 Jason@zx2c4.com, deller@gmx.de, davem@davemloft.net, hch@lst.de,
 peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org,
 dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
 nathan_lynch@mentor.com, dsafonov@virtuozzo.com, Liam.Howlett@Oracle.com,
 mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
 enh@google.com, rientjes@google.com, groeck@chromium.org,
 lorenzo.stoakes@oracle.com
References: <20241004163155.3493183-1-jeffxu@google.com>
 <20241004163155.3493183-2-jeffxu@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241004163155.3493183-2-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jeff,

On 10/4/24 9:31 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Seal vdso, vvar, sigpage, uprobes and vsyscall.
> 

> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
>  fs/exec.c                                     | 53 +++++++++++++++++++
>  include/linux/fs.h                            |  1 +
>  mm/mmap.c                                     |  1 +
>  security/Kconfig                              | 26 +++++++++
>  6 files changed, 97 insertions(+), 2 deletions(-)
> 


> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..e289fbb5d676 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,32 @@ config PROC_MEM_NO_FORCE
>  
>  endchoice
>  
> +choice
> +	prompt "Seal system mappings"
> +	default SEAL_SYSTEM_MAPPINGS_NEVER
> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, uprobes and
> +	  vsyscall.
> +	  Note: kernel command line exec.seal_system_mappings overwrite this.

	                                                      overwrites

> +
> +config SEAL_SYSTEM_MAPPINGS_NEVER
> +	bool "Traditional behavior - not sealed"
> +	help
> +	  Do not seal system mappings.
> +	  This is default.
> +
> +config SEAL_SYSTEM_MAPPINGS_ALWAYS
> +	bool "Always seal system mappings"
> +	depends on 64BIT
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Seal system mappings such as vdso, vvar, sigpage, uprobes and
> +	  vsyscall.
> +	  Note: CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> +	  and remap will fail if the mapping is sealed, therefore
> +	  !CHECKPOINT_RESTORE is added as dependency.
> +endchoice
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS

-- 
~Randy
