Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186743B47E1;
	Wed,  1 Jul 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890643; cv=none; b=soggguQkD0sA1cZarChDAKtWpdSNM4BSixyrcbZASn5H03xyRdmbBgc2DxGnTn2s1u9WeOLIqm7TMn9hrMiUSqATBFvmrbLrXvj/iX0Wztw91ABVBk5OYozzRjOgnjl0/EoJ+AsU6JsFcsmYCMDlGkfejfz3veTx/LGDd9UcfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890643; c=relaxed/simple;
	bh=kqYb9VVI1TivkTAjIcqh9CCLkV/zmToRsDzBMn2R1DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFAMUhkZIAV9UoBE3M7M3ZOmwF8MBT0ZhejTPPYAl+GEkVO2ULjIU5ib+sFHeq1zdzBBmR5T/hPBILkB0MR8hP/7uNRoPPIavVcLNFlYVZY64LAC/yK0A2m6KRrlCwJowK4HfjfkmJbwrqsCloIOUvmByUZW7FDsshUa9MJEZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HkTCwjNX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HkTCwjNX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7uGyyPWBXX00bU/7EmAFPO8s9JNCVqICKT+bwYXLH24=; b=HkTCwjNX0nqdvnjTsta0tpZbhn
	o/sI+ePPaKOAxFSjmVtH13KzE9hzZXYWGbVjqAOk7S+zC97NPPTZVA0YuWi0pKg30UeplvI4JoC5d
	hnZfTN9uCmGGZRoP7cXQQIEhuiv2RGzy0G2DMBQ3WqgpdMwzZ+7WUCZ46tswVonzkO3lekIjMK1g4
	cuiG1UMZdohAA8zjRZ11IQTkK9zfdrO2899CmacO7mPXrVD7Q2Ce/Gyewmu6Uasq7s0Vydo8fNwFS
	iiGquqSc+afv7/SZKLIIwflig0CBhtocjoxErs1rUSfLqRjrSAB7isBfVmWkPLv/S3ni+Wq7kFffo
	r1wG0X1A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wepIX-00000002T2n-0B8e;
	Wed, 01 Jul 2026 07:23:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 42397300402; Wed, 01 Jul 2026 09:23:51 +0200 (CEST)
Date: Wed, 1 Jul 2026 09:23:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Xiang Mei <xmei5@asu.edu>,
	Kees Cook <kees@kernel.org>,
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
Message-ID: <20260701072351.GM48970@noisy.programming.kicks-ass.net>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com>
 <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
 <akPYNv37BCJXUg8-@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPYNv37BCJXUg8-@pedro-suse.lan>

On Tue, Jun 30, 2026 at 03:58:41PM +0100, Pedro Falcato wrote:
> On Tue, Jun 30, 2026 at 07:01:48AM -0700, Dave Hansen wrote:
> > On 6/29/26 18:22, Xiang Mei wrote:
> > >> Please don't even try to send a v3 without addressing this.
> > > This is a demo exploiting CVE-2026-31419 with this technique:
> > > https://github.com/google/security-research/pull/397
> > 
> > Thanks for sharing that. That's really good info.
> > 
> > But what I want to hear a bit more about is why this new guard region is
> > a good, generic mitigation. Does it help mitigate a whole class of
> > vulnerabilities?
> 
> I guess, to add to the questions (to Xiang and/or x86 people):
> 1) Aren't initiatives like kCFI/CET/shadow stack supposed to mitigate these
> issues? Is this mitigation supposed to be applied in spite of these features?
> 2) Aren't you screwed by the time the attacker gets kernel remote code
> execution anyway?

Right; so CFI is supposed to eliminate the forward control flow
hijacking primitives, and shadow-stack will hobble the backward ones.

The whole ENTER thing is really only relevant provided you have a
control flow hijack of some sort. Once you do, it makes it easier to
build out a ROP chain.
