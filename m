Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6121C19E
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592957; cv=none; b=B/QmjH6hmflwOOdBVfqTMjnjKEqDT8Mtg2CLJcwFmkI4/GFmNTLeukPMHHNw6eYJ1PW+QklY64/nvvELzhbfckfSBCqcAJ8rfQkacAtwyC3KwvjO91DgdWNHPCFsjVPROR9+Hs2p9wfxU5iL8q2sLxfttGeNat0gMIZexVJH0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592957; c=relaxed/simple;
	bh=jhy078aGvkWLefBnyO8DaaSrFOwLxl0Z20hUjLmS2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svXkK5iakbawmrdE/7kV0+gN3HTT70ShxvAMQr9DH+PkSS3JonUDSYHMXhmcsF5uwgVI2EjhIzWyE7gsCjaVnucRSeexkRUQK3qxf6MZ1YHBF2qe/PAsF/Ie/YUxbVwwJJAB4BTFSgq4+HqCBovzbQGzH7Zan4QMxwvNr1KVMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsHIEJ2R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsHIEJ2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740592955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=saipoHpMrYA1d7u1DAL6sNSJSJ6bf1mRMJvo8EMj3Vo=;
	b=AsHIEJ2R8tRLa7ShRTq+6fNPXpdUBKV+Hj97igZPBYyob1Xa0c/N5Aomdre93zvvA/rqOd
	5iDb5dCDDaCyrWN14e/SLP2V9Mq8SEDr8FxU3Zq79gyNpx8GjQTOzrcYzxT5P7swdeETLo
	FOWjywEeMjvEkdWH1PL5yvD9pw7zvs0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-1NuXJJeyNLC8G461PmoNOA-1; Wed,
 26 Feb 2025 13:02:29 -0500
X-MC-Unique: 1NuXJJeyNLC8G461PmoNOA-1
X-Mimecast-MFC-AGG-ID: 1NuXJJeyNLC8G461PmoNOA_1740592945
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF24418EB2D3;
	Wed, 26 Feb 2025 18:02:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 77D981955BD4;
	Wed, 26 Feb 2025 18:02:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 19:01:52 +0100 (CET)
Date: Wed, 26 Feb 2025 19:01:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
	avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
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
Message-ID: <20250226180135.GI8995@redhat.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
 <20250226162604.GA17833@redhat.com>
 <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c489fea2-644c-411d-a03b-15e448b2778c@lucifer.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/26, Lorenzo Stoakes wrote:
>
> On Wed, Feb 26, 2025 at 05:26:04PM +0100, Oleg Nesterov wrote:
> > On 02/24, jeffxu@chromium.org wrote:
> > >
> > > Unlike other system mappings, the uprobe mapping is not
> > > established during program startup. However, its lifetime is the same
> > > as the process's lifetime. It could be sealed from creation.
> >
> > Agreed, VM_SEALED should be always for the "[uprobes]" vma, regardless
> > of config options.
>
> If you think this ought to be the case generally, then perhaps we should
> drop this patch from the commit and just do this separately as a
> permanent-on thing, if you are sure this is fine + want it?

See below...

> An aside - we _definitely_ cannot allow this -system mapping stuff- to be
> enabled without a config option,

This is clear.

But as for uprobes in particular I do think that VM_SEALED is always fine.

Do we really want it? I dunno. If a task unmaps its "[uprobes]" vma it
will crash when it hits the uprobes bp next time. Unless the probed insn
can be emulated and it is not ret-probe. Do we really care? Again, I don't
know.

Should this change come as a separate patch? I don't understand why it should
but I am fine either way.

In short. please do what you think is right,  VM_SEALED can't hurt uprobes ;)

> > 	#ifdef CONFIG_64BIT
> > 	/* VM is sealed, in vm_flags */
> > 	#define VM_SEALED	_BITUL(63)
> > +	#else
> > +	#define VM_SEALED	0
> > 	#endif
>
> This has been raised a few times. Jeff objects to this

OK,

> > and then simply
> >
> > 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> > -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> > +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
> >
> > ?
>
> Nah you'd have to do:
>
>
> > 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO
> #ifdef CONFIG_64BIT
> 				VM_SEALED
> #endif
> 				,

Why??? With the proposed change above VM_SEALED == 0 if !CONFIG_64BIT.

Oleg.

