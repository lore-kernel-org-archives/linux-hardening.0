Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CD61FDF;
	Tue, 14 Jan 2025 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736828400; cv=none; b=WMWynDxUKTbrU7UNysZfUSHBfT0rqeoOVik/+u2Tva40MXKO4hi+FRQ3m3bJgSOcdLpTJdMtqtAn6zj7tIWVGk7cpKHWfKwlTdjoMQMQlKnZjjmNYOlwPd/4t/Y0Er5T+zE8602OezotQyVxcNgRoFYWAtEs1I/bAPz024xInx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736828400; c=relaxed/simple;
	bh=pWLWMTrlZH+0KOSlXSHCz6ZxRuHRaO3BiP/QX/Q5KH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7/WMAijTlZ5QsXDcVLRlZRY8Ek32d+KhyoE2rXMl51MAVu0MVJA5T941eZQokdVtmefdmwMIG6BKngiODuUPY9SYRdOhAzMJXhfoDhtQI43q0UPbreS4E5/D1scCQE+F+mjU35mc5qTrWiZy4qh/MdDRQkE33ilPmbnAgK5CTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wDnfiLbW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wDnfiLbW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pWLWMTrlZH+0KOSlXSHCz6ZxRuHRaO3BiP/QX/Q5KH4=; b=wDnfiLbW6kFNyGYXh0NdoXIKPZ
	05SXkshAR6yehMa57NOQXwTkwpXJAQ3ZdN/wkuZ0VLUCAt0Nuy08ejN8BWPrIXenOWCzTjmm8oZvS
	5mGZQ7VtK0Z+vsU5Q+bY7gAxFC8WdmgPpSjzg+oIVI5oLVnmFDpbK1uDJV2LmCjlSGD/iAZnBU0y8
	OGZYedXBuTUMquxWz4jiAPXtjctsu/qPmrjIFVzf2r04uEemfk+yIkQ3Bbqp+6XYWN0mcQ+s+XBPK
	q8Q0LRBIQDpvgoGtzX/+n4x9UoFVF71/2oL3g26OhtY+GMMAkb/PtTxeHUjNUjWScslmvCIsUkmIs
	20f7JmKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXYP7-00000009KiM-3hHY;
	Tue, 14 Jan 2025 04:19:49 +0000
Date: Tue, 14 Jan 2025 04:19:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	oleg@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <Z4Xl5XZizH2fwP9e@casper.infradead.org>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook>
 <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>

On Mon, Jan 13, 2025 at 01:26:59PM -0800, Jeff Xu wrote:
> This patch is intended for ChromeOS and Android and is
> feature-complete from their perspective.

"I have everything I need from the Google point of view, so I will push
this feature into upstream".

No, thanks.
