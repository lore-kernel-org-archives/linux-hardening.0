Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDA22069A
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587224; cv=none; b=UEYnU1rO/kGuZ6Jhm+WD89pfuN8Ho8HzbUVSsHcWPdosHl1KaQFHQ7lmele86zCaTyzWvr4XRv4+NvWl0EiFkZ9NF9XY++rvMGtKjNB5vq4ZlM0cKJcXgMBiqa2JHniWuQ/UZG+bZMMaOn41VnP6Sf6fBj6+YDvOFRArdmud7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587224; c=relaxed/simple;
	bh=Te2kIeqdYdMn9tYf2u9iApRSgSZW5n90rzOPs8gdJpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzHDWbZc2fqKoa1kTt6YtPPpyoE/W6cninajrTXdblncmYgD0HUASgK6ap0zm1vLvjP5qALKWfHyNy44Xy9RJv0DfrOrJqOH5I2437h5Rz61S/s00JmttEy5GqkC65qvyQgX0crTqIf0LG2m7tfuTk/5klsL+/E+mD5EsZNI3Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g56LqXDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g56LqXDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740587222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppomcWQSOcgvzeEl160zR2jOyW8ovhKpqyTRKDX1OIo=;
	b=g56LqXDIbVzhrSoZwkioPy62Bj25F8KmMoSKe8aoKEhil+8VxQXTNmUDV/YI7/cinvk3V/
	6poRv1jN52EOcfbPXVyQg+mOdRkojwiOqtS4YWpORFWvlIJ3kUcy5O7XErhf9VIMqovlmz
	XCq5iAFwlCO/MSHwgLH88o2X7WC5Kjo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-LPGgYWgyOTyPOxcZJ_DLYw-1; Wed,
 26 Feb 2025 11:26:58 -0500
X-MC-Unique: LPGgYWgyOTyPOxcZJ_DLYw-1
X-Mimecast-MFC-AGG-ID: LPGgYWgyOTyPOxcZJ_DLYw_1740587214
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 436A51800998;
	Wed, 26 Feb 2025 16:26:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8BD4D3000199;
	Wed, 26 Feb 2025 16:26:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 17:26:22 +0100 (CET)
Date: Wed, 26 Feb 2025 17:26:04 +0100
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
Message-ID: <20250226162604.GA17833@redhat.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-7-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-7-jeffxu@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/24, jeffxu@chromium.org wrote:
>
> Unlike other system mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime. It could be sealed from creation.

Agreed, VM_SEALED should be always for the "[uprobes]" vma, regardless
of config options.

ACK,

but can't we do

	#ifdef CONFIG_64BIT
	/* VM is sealed, in vm_flags */
	#define VM_SEALED	_BITUL(63)
+	#else
+	#define VM_SEALED	0
	#endif

and then simply

	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,

?

But I am fine either way, feel free to ignore.

Oleg.

