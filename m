Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3BE552;
	Mon,  7 Jul 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916931; cv=none; b=TVfwDVHt7RWUzvQy2pnErcFKR+yWk1xDGs9bHNMzGWEBfUjkucrmaqt4khA6YFogguSxM0Jv3axJFA8+uGUfeqgAtXyVHSUCP3C+LnLg4sPIUf2RmAhA9PFfG9JG1IBwEBg0KVQtMgfEjycMx+TOL71uaft3V4RIf3OBAXvSMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916931; c=relaxed/simple;
	bh=iEtHlsuxuwWzMeLakJ3mML6qWWC1Cfs4iU2Z2Bk2gDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGui09olTrSyswrqmSlAkWaE1d05MMkFKsEux/oMxxePBTnO++/fVyVf0jDV6i0OoYarkyjYJM/1AsIsVGjrgteqirIgxYRGyP3awgHa9Yk1dlFU/XAKVhBqUPr8/vNydo3M9pNqRGoAlpq8xj88JpGdIAZgYXk2BsHzCt0AJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s9bgsMm2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s9bgsMm2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Otyv2zO0XZSVF++N+FU4mfn8HTxzVXBK2tNM9StJTvY=; b=s9bgsMm2ZdrH/uwx/fP7d9V9tf
	ZqWlzpTjOPc91xoC9nz1S76EB3FchcYgPZJ3m+gqRE0QGw/CrMNIJ0JbindtCEZnVamIcvBlBad3E
	vw2A6j41W6AvOyjowmkLR1D1tJERGvzeINaQSS/6u/QTtHmJC3V4spItqTC3yuBPtj/gbPwnrmhqF
	NLwiom++yVac/334sWunDrk9fy15gDtTEmLHCHhSyx9yl+uQ1NabDgthLAeDfLZP6YNUIreS8VDon
	rjamX4TVhF1IPHQHAdXrJbcCXFHQZ30d5BZUEEPayjesgaaiOlOtVj+KUfzi38dLJA20XB9+VJs2N
	gS9qoY5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYrcX-00000003G1r-2czU;
	Mon, 07 Jul 2025 19:35:21 +0000
Date: Mon, 7 Jul 2025 20:35:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	Sven Schnelle <svens@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Lee Schermerhorn <lee.schermerhorn@hp.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <20250707193521.GI1880847@ZenIV>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 12:17:11PM -0700, Linus Torvalds wrote:

> and we do have something like that in 'struct seq_buf'.  I'm not
> convinced that's the optimal interface, but I think it's *better*.
> Because it does both encapsulate a proper "this is my buffer" type,
> and has a proper "this is a buffer operation" function name.
> 
> So I'd *much* rather people would try to convert their uses to things
> like that, than add random letter combinations.

Lifting struct membuf out of include/linux/regset.h, perhaps, and
adding printf to the family?
