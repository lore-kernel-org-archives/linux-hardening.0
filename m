Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DC1E04AE;
	Mon, 21 Oct 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500608; cv=none; b=lIZKS86PMqwIzgjz+YwKOD6GPWzJ0Sj3FGkKZ18cfDSPT3iRrotj4Ad5MpYMy5CjL/DDtPs+Y1Qg7gnuByppQOAG7DMWOp8evBPA3qI//OepZZzR97wkT6HhiA7/0eQQkU0iOU3I+ZrlmM3uN+DD6TZbAdICPVHzWXBeSeZ5pMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500608; c=relaxed/simple;
	bh=O2hUSO9XJcSqU7n57bCbyj4P8NhmLYjDvJ/Qgc8/bXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezPAbjWDKbdwucE7Al4l2MFs7HU1+ga+U6pBptmHytSXD+CBYtMLG5zz+GiJV/nzCh3rZnZgcUx/0Ds9PxVpgxftKrD8NdsuDT4J+aqsE8+0GB2vwrf6Sxe/KXOzV0unCRKVPV39WaScQFxT+SNS9T3Px5KUxKny4IdYtGp05n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D9SCqohr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D9SCqohr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=zV4wxDX1Qa7PkB/5K30LtQhBxEEMmOdT6d6M993cF98=; b=D9SCqohrM5rvLbyAuE3c7kihE2
	mVUxeaNJrRiFNdeLgmhmfgXuHcHcaRadELoxOfp92LmnCgQzNL5lG0Py6QoYKzFa+cG+Bwvfy0UHs
	gW5sdGSUK47ukg5fLtHNUfzxPLGvp/qHw5YNgya8aalPjB9nOqjWrRl0p004ExnVVNWQzIHlwqISG
	b2ExLBZC+rMYGLVvfhnPlDi9cKs2BJOc03RYFhjjPauj0lFOxH5enpb7pLnWjGxaEstJzj+j6924S
	oFS8K3/JtfjtpeJgUWSGIKgoeLEStBUrHgr9Czec+PpHLI/zKoBwCPgzhO4uOuUnAURESa0RcKZsV
	3LdRtC3A==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2o6v-0000000G5GM-1T3t;
	Mon, 21 Oct 2024 08:49:58 +0000
Message-ID: <85eefbd5-bc90-4cb8-807f-6d1ee195e7f4@infradead.org>
Date: Mon, 21 Oct 2024 17:49:49 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] powerpc/ps3: replace open-coded sysfs_emit function
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
References: <ZxMV3YvSulJFZ8rk@mail.google.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <ZxMV3YvSulJFZ8rk@mail.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paulo,

On 10/19/24 11:13, Paulo Miguel Almeida wrote:
> sysfs_emit() helper function should be used when formatting the value
> to be returned to user space.
> 
> This patch replaces open-coded sysfs_emit() in sysfs .show() callbacks
> 
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/system-bus.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
> index b9a7d9bae687..afbaabf182d0 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -453,10 +453,9 @@ static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
>  	char *buf)
>  {
>  	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
> -	int len = snprintf(buf, PAGE_SIZE, "ps3:%d:%d\n", dev->match_id,
> -			   dev->match_sub_id);
>  
> -	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
> +	return sysfs_emit(buf, "ps3:%d:%d\n", dev->match_id,
> +			  dev->match_sub_id);
>  }
>  static DEVICE_ATTR_RO(modalias);

I tested this on PS3 and it seems to work OK.
Thanks for your contribution.

Acked-by: Geoff Levand <geoff@infradead.org>


