Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104821E096
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587701; cv=none; b=ew60BvzCYjcnUwI+nb9rd3Wc4U5QfYVbx6lpu1B0K87UD/Al3s04QWeZsK7PCUgmlSXO0yld8mkS5dUfdU8fOUnpKOPKkCE9hoh1xv5s3gpYkixsWSk6Vk3oaZg4Oe2eFc6JJkV+Y2a0hTudF+AVX+bSmUuYYdtx2p2uZ4VQGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587701; c=relaxed/simple;
	bh=+eYCtkXeUjDx5HX7zQv5kNtD7gM7axtjo4d8GobgnvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHLqz1NC0lVoCTZrVuSyJY/VjLIt/36t+WR3pPCBsnFG1eCaNPaACSU8/Tdx4erYyod4ViGDp1TdfQqsc0tCRW/FlAPE5HOW83Fd0wI5NGcwW8IkoRUbZ5znMvq2N17baycikvVsLPeTy3tmvYNJlbDEr/25SuA0W4mJPeYMmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT5RG1v9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT5RG1v9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740587698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyEeKTSwKpsNdlVwXwewsRo+Wp2oqTEyHSu9r2lJIi8=;
	b=YT5RG1v96KOd3sHJblIsYxZRQJuL6EoqVu0fQujBRHtFWEyu/F/tPhcKE9HpVPuooqf5D8
	aaik/UTEzDO79uYAZC+7cNhLlPAZaB59kr7l+MzrVqqeByAhSHh3q6PaMer5ZzDozFhghR
	9XVEwmKxZm46X79zstocjvvYCs1aumQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-K_6v7QjvOk28uSUtvhbxJw-1; Wed,
 26 Feb 2025 11:34:55 -0500
X-MC-Unique: K_6v7QjvOk28uSUtvhbxJw-1
X-Mimecast-MFC-AGG-ID: K_6v7QjvOk28uSUtvhbxJw_1740587689
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C305C193578F;
	Wed, 26 Feb 2025 16:34:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DB74919560AB;
	Wed, 26 Feb 2025 16:34:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 17:34:17 +0100 (CET)
Date: Wed, 26 Feb 2025 17:33:59 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
	ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Message-ID: <20250226163359.GB17833@redhat.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226162604.GA17833@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/26, Oleg Nesterov wrote:
>
> On 02/24, jeffxu@chromium.org wrote:
> >
> > Unlike other system mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime. It could be sealed from creation.
>
> Agreed, VM_SEALED should be always for the "[uprobes]" vma, regardless
> of config options.
>
> ACK,
>
> but can't we do
>
> 	#ifdef CONFIG_64BIT
> 	/* VM is sealed, in vm_flags */
> 	#define VM_SEALED	_BITUL(63)
> +	#else
> +	#define VM_SEALED	0
> 	#endif
>
> and then simply
>
> 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
>
> ?
>
> But I am fine either way, feel free to ignore.

Yes, but either way, why your patch adds "unsigned long vm_flags" ?
OK, perhaps it makes sense for readability, but

	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
	vm_flags |= VM_SEALED_SYSMAP;

looks a bit strange, why not

	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED_SYSMAP;

?

Oleg.

