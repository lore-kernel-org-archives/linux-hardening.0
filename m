Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900B1D514E;
	Tue, 11 Mar 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697966; cv=none; b=D+hPLYWotHHYG4Z3wdsyfzzQuJsVAZ5jTkEEdC1Sp5/EHI8WhkMptYgTVbrAdA9/QKPAAeiI4OrlBSwpHeUECdj0M0d0+7qhS+vPQbzPzcsj2GorDMkrC9CvzE4wetDnbka/eNxZ6l/XZN4S5EFkUnA93YwZHVVmyYS2+lBueuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697966; c=relaxed/simple;
	bh=fV4YvRwTGnc6zvGfftcOS3tN8NU/LkwhUCtrwIVOqCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heWZETezmkWz0NakDqh8n6nOGvMVhKXhy2sYIGxHHLJVbAxehn67fqESgCNQjjJ7s4z9prohNJmq/UIxKlWf56lDXxmL9cuQ0iKIyR+ZZb/IaMfXmMaEaic6+LeJYTxwdZVtuoA6c8Fo/ScBXDuWbpD+UAv6tevGNm1G+d2Pdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3I4jb67p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+kLjVgNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3I4jb67p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+kLjVgNe"
Date: Tue, 11 Mar 2025 13:59:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741697963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqrVsWAlbMJNJgk2uSMgNDQZC0XfWOKSi6T6DcyzAp0=;
	b=3I4jb67p12pbZXlW5wsZxfRszIQiN+eZiTk7Ww8zV2EbdB7itO8rJQHn0bSmkEGbZeO3vJ
	XmXEWhHwGPXxbq8bEUA+I3seKxHDOp/3ypelg92IX8oAvPwQg9s8v39T5/Qr0A83QQXgPp
	GOqqXKiAVOL5bbbRPwXiwgKxVWxJU1/xUxzOmH8dCOelp5nZLnLP1zNHVJtm/tY4JsnLF/
	L7Ia7LoayWT93P0QoScJ06lheO6/dod2SSYpZ1T6f9mchiPWIDtmKy2dPt4YUmHoQdtpov
	TzcbDOrl3Il6FC4504Z7IOQEizEM/PcvFf8iqgyvFpvls4BXcVyiRrfW+Xou5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741697963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqrVsWAlbMJNJgk2uSMgNDQZC0XfWOKSi6T6DcyzAp0=;
	b=+kLjVgNeFywidxNYfTtOLCrRLemJQEw0Fklqsgsyv7GQc3P+pSJj14uutJRtGCGWnB4TeB
	qL64bP9jmsO8UMBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/2] mseal sysmap: generic vdso vvar mapping
Message-ID: <20250311135542-574f3a8a-525f-4e84-9f04-c9d1ded0deef@linutronix.de>
References: <20250311123326.2686682-1-hca@linux.ibm.com>
 <20250311123326.2686682-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311123326.2686682-2-hca@linux.ibm.com>

Hi Heiko,

On Tue, Mar 11, 2025 at 01:33:25PM +0100, Heiko Carstens wrote:
> With the introduction of the generic vdso data storage the VM_SEALED_SYSMAP
> vm flag must be moved from the architecture specific
> _install_special_mapping() call [1] [2] which maps the vvar mapping to
> generic code.

I think this change should be part of the merge commit between the
trees carrying the generic vdso data storage and mseal for system mappings.

https://lore.kernel.org/lkml/20250307151426.5f3c0c39@canb.auug.org.au/
https://lore.kernel.org/lkml/20250311150847.5a63db36@canb.auug.org.au/


> [1] https://lkml.kernel.org/r/20250305021711.3867874-4-jeffxu@google.com
> [2] https://lkml.kernel.org/r/20250305021711.3867874-5-jeffxu@google.com
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  lib/vdso/datastore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
> index e227fbbcb796..b7c7386c98a9 100644
> --- a/lib/vdso/datastore.c
> +++ b/lib/vdso/datastore.c
> @@ -99,7 +99,8 @@ const struct vm_special_mapping vdso_vvar_mapping = {
>  struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr)
>  {
>  	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
> -					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
> +					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP |
> +					VM_PFNMAP | VM_SEALED_SYSMAP,
>  					&vdso_vvar_mapping);
>  }
>  
> -- 
> 2.45.2
> 
