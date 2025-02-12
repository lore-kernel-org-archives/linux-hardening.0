Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF09219ED;
	Wed, 12 Feb 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369353; cv=none; b=QNSoBcaOHWEiG/Bk/vqcgjATCkZxPUAHl20x3BbDPTh24qmIbixRf9VgaQfAY9EBijDKXkvNoKe4SSMLORUXQOkJGB8bd1SF32aAnPwgE/QnMoj6bhfzv9L12bX+r+r2kIp6bqL0tfg730+jNg64l5siQKl4+Pl+RtKxfb0yloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369353; c=relaxed/simple;
	bh=Elf/FaTDK9fVRFnIY3VNHEhn1eL3NZf69mLnjaztmRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8ReXykzIjxaUhyNGwcD3jj+w3ittrVt47yipBvF9QkM/YlLep4fMFMXeJYHYK5H2Cu40YYAQ2E29edBRHqXwuXWRZsRNR8kVQ9ePIQ4HXqgJrSVQK11hRfIa81s0TS/+8eov4BmVTOQ9AUF51YeeixZN571q5Zv6Kk/iPXNb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UliI5jNo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UliI5jNo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Elf/FaTDK9fVRFnIY3VNHEhn1eL3NZf69mLnjaztmRU=;
	t=1739369351; x=1740578951; b=UliI5jNoVYFHhCXfjiO9AmxmC9CrjGR9PRKwx5E07lBs2Ge
	Ve0YrTSGxl6USPkgKpVNltFr2s6VFh2Vao/Z6xHfusKKS1+8Tosq7z+qD3emuhXWQPslEbBVYNyjf
	9lEhsHkUpbtsE/7r9nXNJrq0aXRJ5AXRDfxESyPeUH0bwliuRjUeX+NGq/cfOEHZPOZeA0U0+JSYQ
	ACVGcOOwO4Rk8hUXBSnmtx9GxIDTS3iEO1cA5pXSKmMBEOclYT5Wl7r7VCRzdiSmV9ZbYl+7N8R3b
	v5MYHlfDV0jlxioaJZP6wru4o90w8bdhs91QJZCrwmrciQtmKhkhwBYThNPd431A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tiDQ5-0000000CFTu-2Jhk;
	Wed, 12 Feb 2025 15:08:54 +0100
Message-ID: <c597fdcd4356636fc3163a46da32fc5d6c17aed9.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pedro Falcato
	 <pedro.falcato@gmail.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
 rdunlap@infradead.org, 	davem@davemloft.net, peterx@redhat.com,
 f.fainelli@gmail.com, gerg@kernel.org, 	dave.hansen@linux.intel.com,
 mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 	42.hyeyoo@gmail.com,
 peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Date: Wed, 12 Feb 2025 15:08:51 +0100
In-Reply-To: <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
References: <20250212032155.1276806-1-jeffxu@google.com>
	 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
	 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
	 <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-02-12 at 14:01 +0000, Lorenzo Stoakes wrote:
> Thanks, yeah that's a good point, it would have to be implemented as a
> personality or something similar otherwise you're essentially relying on
> 'unsealing' which can't be permitted.
>=20
> I'm not sure how useful that'd be for the likes of rr though. But I suppo=
se
> if it makes everything exec'd by a child inherit it then maybe that works
> for a debugging session etc.?

For whatever that's worth, ARCH=3Dum should not need 'unsealing' or 'not
sealing' it for *itself*, but rather only for the *children* it starts,
which are for the userspace processes inside of it. Which I suppose
could actually start without a VDSO in the first place, but I don't
think that's possible now?

Which I'll note should not have access to the host, so in a way this
outer security feature (sealing) breaks the inner ARCH=3Dum security, I
think.

johannes
