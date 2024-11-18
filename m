Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45A13CFA5;
	Mon, 18 Nov 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731905208; cv=none; b=nIxLtMg9rvySCrzcMWrqqz3dR2VfOuJLBYa9XaF6Srk6U79LeWB4HHcOWxvpVG74ooCU3UDSes8IKSKKkp318pQ+U2VVgaW+MQE1PPweXTT9MxBOJj4Fboe7UUGNlyrhC+Xjx6cGeuQcmSJdm94xGEiNm/0kNahoCDDiVpCjFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731905208; c=relaxed/simple;
	bh=ryCbzJ37q2DIZgbhl/DsiG7UZIoX0K5gGnhDZmLkehM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp2COc6wpbjTMlOH6qyML9R05CrEQE8HcUy2bh0a1rHVfFSjnVIJdiWk15eYMfbTBKpsBnwGKxvEXNHEQ2A8k4rq7noA7dosrTPvkmpuLMnufNdd3KDsRNmoK8fMCyZfhfnruDuLG0HKfZcMeOtcgmp7TPsJ31W72NS19TotkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3cmpTsc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3cmpTsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295AFC4CECF;
	Mon, 18 Nov 2024 04:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731905208;
	bh=ryCbzJ37q2DIZgbhl/DsiG7UZIoX0K5gGnhDZmLkehM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3cmpTscNQjtEzC/wf2JuyG/FwK+poTxqSwC191jC/kKjC7CtMxRmaLictQk7Dcc7
	 5bSWxPyzfelNA+hMNCZSOEkCR3bAsQkAVLluIb2pJJAIZ22aUkDLL9gHbicOqlejrU
	 Xw3x4GTSz8fWJrQiFZzWd5crCRyibBefOwXA0Yk/N/lHw7emztZ00HUNpP8/W+ghdb
	 TqxvnGj13pkVSAGDA7fLvXZhu5InmlQcGzePjc5ZfisfFqDN5GSZhfNZd2f3cima2s
	 oZbJ9YCtCACWIf2GQSN61UngO4dv9LeWDTwq4Je7A0n9GqzYYMs9WzWk4lFb6GUMBH
	 wxcvut4PqexFg==
Date: Sun, 17 Nov 2024 20:46:45 -0800
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: Handle compound pages better in __dump_page()
Message-ID: <202411172043.C19A3963@keescook>
References: <20241117055243.work.907-kees@kernel.org>
 <Zzq-TJlSKXoo80Fo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzq-TJlSKXoo80Fo@casper.infradead.org>

On Mon, Nov 18, 2024 at 04:10:52AM +0000, Matthew Wilcox wrote:
> folio_test_large() does not touch page[1].  Look:

It does, though. :( It's via the PageTail(), which calls page_is_fake_head():

In function 'page_fixed_fake_head',      
    inlined from 'page_is_fake_head' at ../include/linux/page-flags.h:237:9,
    inlined from 'PageTail' at ../include/linux/page-flags.h:281:47,
    inlined from 'const_folio_flags' at ../include/linux/page-flags.h:309:2,
    inlined from 'folio_test_head' at ../include/linux/page-flags.h:824:9,
    inlined from 'folio_test_large' at ../include/linux/page-flags.h:845:9,
    inlined from '__dump_page' at ../mm/debug.c:138:8:   
../include/asm-generic/rwonce.h:44:26: error: array subscript 9 is outside array bounds of 'struct p
age[1]' [-Werror=array-bounds=]               
   44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
      |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
   50 |         __READ_ONCE(x);                                                 \
      |         ^~~~~~~~~~~
../include/linux/page-flags.h:221:38: note: in expansion of macro 'READ_ONCE'
  221 |                 unsigned long head = READ_ONCE(page[1].compound_head);
      |                                      ^~~~~~~~~
../mm/debug.c: In function '__dump_page':
../mm/debug.c:126:21: note: at offset 72 into object 'precise' of size 64
  126 |         struct page precise;
      |                     ^~~~~~~

> > Instead, explicitly make precise 2 pages. Just open-coding page_folio()
> > isn't sufficient to avoid the warning[1].
> 
> Why not?  What goes wrong?  I'm trying to get gcc-15 installed here now

With your original patch applied, I get the above warning.

-- 
Kees Cook
