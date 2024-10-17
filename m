Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD921D097C
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154314; cv=none; b=I5WKjvXiGL3S8WoQWyCK4xiOgk9dZtK/sWbldpZQ9Qt/c7mVh39A+2zFoWmpDTZ0C8hGT1DNUbqiPN8KBhvUCZ2EL35SvslIF7NY/TY7pofuwUjpYQ6wRi6df95fWauvRuciwCP7IqMBJzovobj//YsZ9qeS9j0KDSGOqFzSSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154314; c=relaxed/simple;
	bh=jeCvakJBxAuk8Hj3ZGxIj/OhcAZQwfqjr/2zRzHPp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXcIBT4hauRhG/utYP6QhgNOmFsPl0ACQcVaL4M8AhJrbhfVzocqol+I9yKULbT0pVwjmHa2Ijsz4KfwINlQ2RlDzPYFEB1KBPfqPke6CUM5+BSkbCpM2Sadw8hrTrh0+LHFgcXv2zrx/wiyXOFX28vJk9s+jBW5T5+sVREup6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ+05pSS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ+05pSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729154311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXbmRI+FXFGUGtJncLieyIIoT0CwT8u+yPXsRgVVfmc=;
	b=iQ+05pSSfkksZ0dh4KtqvN7xBgMRQyYlXE3vULPOyRCai/YeWyKBBZvI4FK9pp8Lz/09BC
	sAe6YvGdI6gXHJNjaYZtY6s7z+2LgRfBgRMj5I8Ey2MohUY6nwA8XOsJXdBft7bmnuGSoU
	aRs6BwuB0WzK0K0sD7B6Y1tavjzUslc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-qRqxaJYdPs-4g8GzylWjxQ-1; Thu,
 17 Oct 2024 04:38:28 -0400
X-MC-Unique: qRqxaJYdPs-4g8GzylWjxQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00DBC19560AD;
	Thu, 17 Oct 2024 08:38:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6F9901956056;
	Thu, 17 Oct 2024 08:38:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 17 Oct 2024 10:38:07 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:37:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
	keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
Message-ID: <20241017083752.GA15167@redhat.com>
References: <20241014215022.68530-1-jeffxu@google.com>
 <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
 <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/16, Jeff Xu wrote:
>
> On Wed, Oct 16, 2024 at 6:10 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > > +     exec.seal_system_mappings = [KNL]
> > > +                     Format: { never | always }
> > > +                     Seal system mappings: vdso, vvar, sigpage, uprobes,
> > > +                     vsyscall.
> > > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS_*
> > > +                     - 'never':  never seal system mappings.
> >
> > Not true, uprobes are sealed when 'never' is selected.
> >
> Thanks. I forgot to uprobes from the description in Kconfig and
> kernel-parameters.txt, will update.

Jeff, I am sorry for confusion.

No need to make uprobes "special" and complicate the logic/documentation.

I just meant that, unlike vdso, it is always safe/good to mseal the "[uprobes]"
vma, regardless of config/boot options.

Please do what you think is right, I am fine either way.

Oleg.

