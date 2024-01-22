Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E639AF2
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916908; cv=none; b=NYRK5O0V03W4vOZFs7wlHYNPpQ62tG9AT0CxPvg738bQ5XYqyYqlyAQKUXBfjpsQShWC52o5Occ8eL4ZhaLSkRNZh/8T8Q6Qc6PGPRIV3MnVSPo3yxcCJPdZPW+R9nCIh9+BqE+B6Tz4tkt4mn79/hxXJ8+7VACPgwRt6yK1NXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916908; c=relaxed/simple;
	bh=nFSMEq+YJlWNxDmSP5UoykYt+A3vlhNusWRjj7vzg1U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CFqBB+wtT4dm2+jEC616PBgdkqsyAGBPvrjUbQ194quINhagmBPROGqJyn/gEzlUAiVrZqT4tRQfVYYcnLuVOi6mDVfNlhXvb/d/Pv+/9rVxZGA5Pk90buPjSH4AI4z2CFGqOqWed68VpeCj+LPXbr0ItlX6LO9fDxMIQb56s1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtXfWh4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtXfWh4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705916905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cBs2U0i3D9w9WV8+Pf0nrRzJpAUSveYB1qTpJzpZyk=;
	b=dtXfWh4ctQd09L9caAA5eSt24HkAFFa9lAXJmyyEcSc5JZ0rStm9Z/mlxL829F4zvfgtOb
	wRqrwHfp33NCODWJLBXU7KdRFMqAVTuJRfktQ2RlZlq4fT/ginvYLF2PKQR3i5tryhNie9
	abC7QoTpae5vsHQVessA5/YWs/ktdWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-5xGE6WBKMtuBIw6lc2QEbw-1; Mon, 22 Jan 2024 04:48:22 -0500
X-MC-Unique: 5xGE6WBKMtuBIw6lc2QEbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E48F88F5A6;
	Mon, 22 Jan 2024 09:48:21 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3D8111E408;
	Mon, 22 Jan 2024 09:48:19 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: mail@horotw.com,  linux-hardening@vger.kernel.org,  Jakub Wilk
 <jwilk@jwilk.net>,  Salvatore Bonaccorso <carnil@debian.org>,  Linux
 Memory Management List <linux-mm@kvack.org>,  William Kucharski
 <william.kucharski@oracle.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
	<87il3ur1ik.fsf@gentoo.org> <ZaVi4ij0jgEz+isx@casper.infradead.org>
	<07c348caaf6b4c457ab4b452f53ed048@horotw.com>
	<ZaWZqnD7XmP5HMA0@casper.infradead.org>
Date: Mon, 22 Jan 2024 10:48:17 +0100
In-Reply-To: <ZaWZqnD7XmP5HMA0@casper.infradead.org> (Matthew Wilcox's message
	of "Mon, 15 Jan 2024 20:46:34 +0000")
Message-ID: <87ede9pula.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

* Matthew Wilcox:

> I received a suggestion off-list that we only do the PMD alignment on
> 64-bit, which seems quite reasonable to me.  After all, I don't care
> about performance on 32-bit just as much as I don't care about security
> on 32-bit.

Perhaps we can we repurpose MAP_DENYWRITE to disable this?

For shared objects as loaded by a dynamic linker, the alignment is
pointless in many cases even if the original mapping is quite a bit
larger than 2 MiB because the individual LOAD segments and their
protection settings are smaller than 2 MiB, so hugepages cannot be used
in the end after all.  The dynamic linker knows the LOAD segments, so it
can drop MAP_DENYWRITE if it determines that hugepages could be
beneficial.  (Current glibc sets MAP_DENYWRITE for historic reasons.)
On the other hand, I wouldn't object to more explicit control over mmap
pointer alignment, either, for anonymous mappings as well.

There are some binutils versions that produce 2 MiB aligned file layout
on x86-64, but that change was reverted, presumably because kernel
hugepage support for non-anonymous memory wasn't available.  But there
are likely some iffy details that make these binaries unusable for
hugepages in practice, like lack of hugepage alignment at the end of
LOAD segments.  Unfortunately, BFD ld tends to produce approximate
PT_LOAD and PT_GNU_RELRO and relies on the dynamic loader to round
things up and down in somewhat questionable ways.

Thanks,
Florian

