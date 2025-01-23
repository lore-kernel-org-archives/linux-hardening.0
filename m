Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D083C463;
	Thu, 23 Jan 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671925; cv=none; b=VfaeOgy9MuNBKLPL7+X+5oSJra/U6GPg89TLzY1G0j9OaUEjq7+wR91VB4ESp9uJN2h5HmyNlgiJKkz5+HcoEdz5rW6KjByMS4lnvE4NHW2r3kr1Ga7wOoS/sXlwDBMgxx9G0bTDQS4pfKN281lhxrBTpIutxinrHh7U2N4m+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671925; c=relaxed/simple;
	bh=yh6b+cZcjYDmNt1Vb4HM/fy8U2yY81X6obnraoK1JNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvVLtgWklkbhDgklhPperFdmbJ8oYsB6rVmBjv5fCDMEcId1zh8RDnK5oQ6KjV6hv53eO+xYswHDwnXhEI5FnIahbX/w5pBij/X1/9WZh63GbstoPdcidNpwafhp3Zd7dT2BH4dtEG4rkOV2v2kglShtyEUqnnoOZpEQ/CIwprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qTYMtfcV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qTYMtfcV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0fGNZae0SEsdeWC7CbCUBx4kB8+o1y3cPswn80K5x64=; b=qTYMtfcV02PO6gNh0YR8vHugQY
	ekoQSqltH1di7AEklFlxmJQjAGXVtV08P3t+PlJu1Ro7ABZi4FLCHvRwqNMsupDfE1zwB+Vzhmkra
	9GiKQjsoMjGQKYmyY7GsN0jYEpX0ysGO96Jz/mhjWeB0PpgZlvmD+5BmSrKZGhp4lxvgkbE+vAJFi
	4248oBMvtEoHYytq9W243xI5dlZ65epReXaY/wxUi3JeBs0z/cdZQlQ98Z1ysNm5cLqxNpX5SOuTe
	wxifipKy2cBs5yAlVxSD29Eq+uIGMZwrnL8LLMHliQurDhRRMWqraojLXzSyEzsdTUfn+NylBaKkc
	RJa477eg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5qL-0000000BIin-0Vwz;
	Thu, 23 Jan 2025 22:38:33 +0000
Date: Thu, 23 Jan 2025 22:38:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: enh <enh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org,
	jannh@google.com, torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Christopher Ferris <cferris@google.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <Z5LE6BkIQjgyVfvb@casper.infradead.org>
References: <2e5de601da34342d8eb0d8319dcf81ff213c7ef0.camel@sipsolutions.net>
 <CAKbZUD1btTbeEht6W5MmhgtEJk3dg55cBpBtoDL0ieaL=23qeQ@mail.gmail.com>
 <CABi2SkWoNTd5sRJ7-7arPfutYZx6xi9iac0mXZyfzuVXuh1atA@mail.gmail.com>
 <CAJgzZop04=7+13jjV_zDfJF4dyJ7tp-86G8_mRe=C=sBEp+z3Q@mail.gmail.com>
 <ocstrhpyoyxzurvvxbrbnlzfqzo6hiqt7dxj7vu45ipj4min6z@ffnpao72slda>
 <CAJgzZopv+jKmDncYDJEQTymqQ1oRpy8HNpOsmcoM7Chb=uBJzg@mail.gmail.com>
 <l7pexkoo7t7p5u6gobgc46lxvpgpe2lywaqwa4b6vjddt3ccnq@mh6x72cxfhyv>
 <CAJgzZopiyhq9Wpu+gxUssoNhQT7tNjiey0JGsKPJAXjraEBRiw@mail.gmail.com>
 <881c3558-1101-496e-9ef4-5bef13f3f233@suse.cz>
 <CAJgzZoq29GzVsqAMrGiKoUpXFPVjPRQRO87SiagaQCVXfH90Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJgzZoq29GzVsqAMrGiKoUpXFPVjPRQRO87SiagaQCVXfH90Lw@mail.gmail.com>

On Thu, Jan 23, 2025 at 04:50:46PM -0500, enh wrote:
> yeah, at this point i should (a) drag in +cferris who may have actual
> experience of this and (b) admit that iirc i've never personally seen
> _evidence_ of this, just claims. most famously in the chrome source...
> if you `grep -r /proc/.*/maps` you'll find lots of examples, but
> something like https://chromium.googlesource.com/chromium/src/+/main/base/debug/proc_maps_linux.h#61
> is quite representative of the "folklore" in this area.

That folklore is 100% based on a true story!  I'm not sure that all of
the details are precisely correct, but it's true enough that I wouldn't
quibble with it.

In fact, we want to make it worse.  Because the mmap_lock is such a
huge point of contention, we want to read /proc/PID/maps protected
only by RCU.  That will relax the guarantees to:

a. If a VMA existed and was not modified during the duration of the
   read, it will definitely be returned.
b. If a VMA was added during the call, it might be returned.
c. If a VMA was removed during the call, it might be returned.
d. If an address was covered by a VMA before the call and that
   VMA was modified during the call, you might get the prior or
   posterior state of the VMA.  And you might get both!

What might be confusing:

e. If VMA A is added, then VMA B is added, your call might show you VMA
   B and not VMA A.
f. Similarly for deleted.
g. If you have, say, a VMA from (4000-9000) and you mprotect the region
   (5000-6000), you might see:
	4000-9000 oldA
   or
	4000-5000 newA
	4000-9000 oldA
   or
	4000-5000 newA
	5000-6000 newB
	4000-9000 oldA
   or
	4000-5000 newA
	5000-6000 newB
	6000-9000 newC

(it's possible other combinations might be visible; i'm not working on
the details of this right now)

We shouldn't be able to _skip_  a VMA.  That seems far worse than
returning duplicates; if your maps parser sees duplicates it can either
try to figure it out itself, or retry the whole read.
