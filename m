Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBC14287;
	Wed,  4 Dec 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335908; cv=none; b=Tq2hOj93DKcQLutPtjfuUHZBZ+3wRR/dKYlmv1nFlVUi3+xd5aZlAb9jPXjyzXrbzMoqes//xv6YmlvVUiVSQ1Hnk4zQcQqpKW6w1zAW4E8d6hBeRpwu8tl29HDJO5hKwVDNRs2WS2X8D1HQ3suTUS7LYCX4+hMfOIbWRABP22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335908; c=relaxed/simple;
	bh=5D8amqqJUerY4ZMk6VjsbNllGV+NRnW6CTtDP5Db6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSRwyHgPrnEiMI+mF5nBhoZU0usHyYgKVG7ofi/9hMeOpibH2qgHBqfm+ZseA1IvhekH38Kp+354N9ZMD3BHnlEN4Y+9Aq6f6pt9vcxJjhm+qpm9Bs9YYBhTc33hG580dp4cCnHQPNbUgeKLKInkCuAnJv8W2qj3IqnczkOuD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=BGxwdNEj; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="BGxwdNEj"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4CDF381214;
	Wed,  4 Dec 2024 19:04:34 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1733335474; bh=FX4DK5jBUd2vsaiQ4y/5x3FiboD8Gzi0pXUSJlB7xas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BGxwdNEjRV32pwxOQ6LQrWVllld+YXD27kz0U8f1G5wM7UIHEVKV4NXmFqQHURsmj
	 DXeLScPzBbZl3lhtAyLkbREUl+b19LwFIyVPXIPsyjSlCLSD2BAbw/DoRNPW5PcSH0
	 /oaL4nPsXLl5jR84DYXJ0fhruQ4lJAR7gmiC/RYHdmvDUcFgcC4HfvcqA6Nr17jOPK
	 SmzcMvLm1Po+JAvhuTplzcxtJzT/zOzeRDbpjVEHRXJzUOipicUU8mi0OicMoippuc
	 PX+AqHNQkDDXtNS0aQHLVJmrdAsu63QRHJuNxOR8MYAsalvpqou7OxSkQ9D9XTuaKH
	 o/kKyk0HksBRA==
Date: Wed, 4 Dec 2024 19:04:29 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
 sroettger@google.com, adhemerval.zanella@linaro.org, ojeda@kernel.org,
 adobriyan@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 jorgelo@chromium.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/1] binfmt_elf: mseal address zero
Message-ID: <20241204190429.0a18dd22@mordecai.tesarici.cz>
In-Reply-To: <20240806214931.2198172-2-jeffxu@google.com>
References: <20240806214931.2198172-1-jeffxu@google.com>
	<20240806214931.2198172-2-jeffxu@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 21:49:27 +0000
jeffxu@chromium.org wrote:

> From: Jeff Xu <jeffxu@chromium.org>
> 
> Some legacy SVr4 apps might depend on page on address zero
> to be readable, however I can't find a reason that the page
> ever becomes writeable, so seal it.
> 
> If there is a compain, we can make this configurable.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  fs/binfmt_elf.c    |  5 +++++
>  include/linux/mm.h | 10 ++++++++++
>  mm/mseal.c         |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 19fa49cd9907..f839fa228509 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1314,6 +1314,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		   emulate the SVr4 behavior. Sigh. */
>  		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
>  				MAP_FIXED | MAP_PRIVATE, 0);
> +
> +		retval = do_mseal(0, PAGE_SIZE, 0);
> +		if (retval)
> +			pr_warn("pid=%d, couldn't seal address 0, ret=%d.\n",
> +					task_pid_nr(current), retval);
>  	}
>  
>  	regs = current_pt_regs();
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c4b238a20b76..a178c15812eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4201,4 +4201,14 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
>  
>  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
>  
> +#ifdef CONFIG_64BIT

Strictly speaking, this should be

#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)

But since we do not support any 64-bit architecture without MMU, I'm
just making this marginal note, so it can be found in ML archives if
needed.

Petr T
