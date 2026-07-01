Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEF28C2BF;
	Wed,  1 Jul 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890400; cv=none; b=AzoUxd7jfPSuYQReii/mV2G8flH6kyS7s1wo7K4bVXOxhvyt/2W5+6Y45vGJNjv70RaE4USz2KDiSmXfUGZguaSQZ2K3wDeMgGwzcm3OQAAM+Z3hLI6+6qUtUJ6zllmpLIBcWS0eNny5wPBnP7acbvGJzXufQ4sOxYUOB6RYs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890400; c=relaxed/simple;
	bh=LrE6XR517o2GlhoFL4JciqRTKMYI75vLmG+CDzgDXcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgkEa6BHIH3vH3MF7O6/f8ImEsuZO+rQz79esovbCcPZB9x9Lz+qxyihGda0We10XDKEU2lDxguu6cJx4BRQRQ9uMjvf77ox5w3uFVl/WF/9aSHaH0Hwv1yhEYWvb+def2D+wRkOLZ7pudRo0J1v3A8t1lEQw+NIvUkDsSq/wN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uler7TU1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uler7TU1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oU4WzgOEp9MzpTOCoPD9OUsBrXWafEC3mjtn0apNXKM=; b=uler7TU1Gk9SDIwdFJcsM8Dq2t
	QtyDMju9rs26AfVwFAI5kufCwCm8B03v4tb0uaRemIIHO1lIFqbDZFZJmHMy6YbGu4hOiZK9WVzTf
	kCxAYt/FVHbq3V1GiJR5VW3Ey8/WgrYRzGpZuBA6nWteQ/bswc/y6bm1bol5NIp8iIpMjI26XfAVY
	pz4pDIl7QNZvkwM2sMRBXJoXq55CmzsefUa08ShHXmbMwzKoItZ57WcrZWrqYWRT+lFHMXy3mplrE
	lQwGt1A1X8Oamv6jQhpA4vy86N/0P9HjTteDYVS387w9jV3A0CaqgBqnOv+98KPp+eyjiAoyXESmx
	6ZPcZ64g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepEX-00000006DAR-3izs;
	Wed, 01 Jul 2026 07:19:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5555430035C; Wed, 01 Jul 2026 09:19:45 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:19:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Xiang Mei <xmei5@asu.edu>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hardening@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <20260701071945.GL48970@noisy.programming.kicks-ass.net>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com>
 <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>

On Tue, Jun 30, 2026 at 07:01:48AM -0700, Dave Hansen wrote:
> On 6/29/26 18:22, Xiang Mei wrote:
> >> Please don't even try to send a v3 without addressing this.
> > This is a demo exploiting CVE-2026-31419 with this technique:
> > https://github.com/google/security-research/pull/397
> 
> Thanks for sharing that. That's really good info.
> 
> But what I want to hear a bit more about is why this new guard region is
> a good, generic mitigation. Does it help mitigate a whole class of
> vulnerabilities?
> 
> I think you're making the claim that this ENTER technique takes what
> would normally just be a DoS and makes it fully exploitable. Does this
> happen for a lot of DoS bugs? Or is CVE-2026-31419 very unusual and this
> stack guard gunk won't ever be useful again?

AFAICT all it really does it make it easier to set up a ROP chain. I
don't think ROP is unfeasible without it.
