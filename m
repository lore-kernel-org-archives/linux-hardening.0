Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE58130AC8
	for <linux-hardening@vger.kernel.org>; Sat,  5 Oct 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158928; cv=none; b=ubin+bwuJ/wed5JsXVxSSFEMh5IkE5R3jglYvTXQ6YltfDnGfUr1LJI1143M48CmvDKEaUlpATnCkwftFai2MfQSwCO45wzcNTjP0XoSrnZC38h65npU8cnwV6k//T05D9cOgrmBQkLNJuls0N5GrnifeAHiv5JiVyG8L/qb1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158928; c=relaxed/simple;
	bh=GKC1EfUZQmjyXGUyqT6jtO2jC/3S4Vunq2GX6DbgcIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBUhYaFVuN/zI+J6GT9VOZz2GbRsBt8iHxhpjJd9muYtCeoia3vBMDBTFxhP0DXEzsm+/iNuG10x7SNs1COMbAggd7/eXRdQsgQXosuQilWs55mz1pFPrUfg/a0v0WbOxKmTdJCBm80LdfeoLkPCppCAwh//Yzdsg+ybVobjvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVP7Pf0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVP7Pf0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728158924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7L6m21ApIWYig/q11IA1MKr17jgGleFK15eNAui5Awg=;
	b=CVP7Pf0Axfy0EGdnriVbbwyZmSkUANrpTFkpKXoLwXrhT2EKHuDpfTzB9cbxwKID4QwkFx
	8zteuUY9MLeHATqEIz1R3OBoKXz8WDpWpr4Wg7NYI+TlC3WNofmjuBuvWIUdnVfLHrORUd
	mVlKu0iy02ksmS8JTwQMo+/j58rl1nk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-BJ0u1fDhNl-ZhALUG3veJg-1; Sat,
 05 Oct 2024 16:08:41 -0400
X-MC-Unique: BJ0u1fDhNl-ZhALUG3veJg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A705E1955EE9;
	Sat,  5 Oct 2024 20:08:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 295393000198;
	Sat,  5 Oct 2024 20:08:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  5 Oct 2024 22:08:20 +0200 (CEST)
Date: Sat, 5 Oct 2024 22:08:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org,
	mike.kravetz@oracle.com, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com,
	Liam.Howlett@Oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com,
	peterz@infradead.org, ardb@google.com, enh@google.com,
	rientjes@google.com, groeck@chromium.org,
	lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
Message-ID: <20241005200741.GA24353@redhat.com>
References: <20241004163155.3493183-1-jeffxu@google.com>
 <20241004163155.3493183-2-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004163155.3493183-2-jeffxu@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/04, jeffxu@chromium.org wrote:
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the mapping of vdso, vvar, and sigpage during restore
> operations. Consequently, this feature cannot be universally enabled
> across all systems.

Can't review.

But as for uprobes, I'd prefer a simpler patch which doesn't need the new
CONFIG_ and/or kernel boot options, something like the patch below.

And I don't really like the fact that this patch changes the behaviour
of the "generic" _install_special_mapping() helper, but I won't argue.

Oleg.


--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -430,6 +430,8 @@ extern unsigned int kobjsize(const void *objp);
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
+#else
+#define VM_SEALED	0
 #endif
 
 /* Bits set in the VMA until the stack is in its final location */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 40ecab0971ff..388373c11593 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1510,7 +1510,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);

