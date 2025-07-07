Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E960C442C;
	Mon,  7 Jul 2025 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864769; cv=none; b=S9KPs51+H3+viNtQUvf3a87CD5d6l4toNL0UCQmwCgY0NBhXt8t6/9k8BcGKpMOzsd01gnTw0/JadmDhOEKi0SPjUTxk2WJDzgCYR0S9df6kQQ5jyWtmZp4u8hLlEIHEVG9a0gghfw48/fcg5QPQMGo+M1xuBGUkfjod3/jkSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864769; c=relaxed/simple;
	bh=OwXC6dVgryGV0YpSY2pOkIgNqEFTgCQQLN+wgWUl9KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQYuNqOG5QRlc8Qv6fwA52RA9i5B8vy2/QyAPFnlMyCXpybbJYjPxT7ebqXhSlfxL4Fl8U4HDOsiMP6I2wx0duzfqdOcWDoo7ddMyFhpOkKpoWHUk/EQ0rwhjff9U3IllItkDEJsQ8Z2Y7Pxy9ectA88jPXZHFkhELDzGlI1XVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3aDEKSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3aDEKSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9048C4CEE3;
	Mon,  7 Jul 2025 05:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751864768;
	bh=OwXC6dVgryGV0YpSY2pOkIgNqEFTgCQQLN+wgWUl9KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3aDEKSRz6T0v/Liop11NaaYtH19j9lG1lEET9wYKkFKmlqyixeOdEqAKZ88uk61j
	 xJzQxWM0wxKsj6AbNgpBwQJwjLjQOjMF3ScAjlKBrxIkNO0VCk5fYSSPl33ki1FryK
	 WkkcfewV7Fh4uCEN1aDvuOl1E2OzeZ2c25+SoBk8F+Yc7M49dx/UcJ9xTnAOwydldj
	 GuFo1v7ZtMgSuRJ4TicIrAQT/PTXZz8uhkvnRjaEdgLPGXFNyMl/tWoeevxYVvvc3H
	 r9Bzgbll3tnDudxyVURI0TJd6qiObtbG9Ti4fa+m+qE2WGD9X0a3CO7uNVQNefst/p
	 U3ucOziEhayUA==
Date: Mon, 7 Jul 2025 07:06:06 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v3 0/7] Add and use seprintf() instead of less ergonomic APIs
Message-ID: <cover.1751862634.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751747518.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

Hi,

In this v3:

-  I've added Fixes: tags for all commits that introduced issues being
   fixed in this patch set.  I've also added the people who signed or
   reviewed those patches to CC.

-  I've fixed a typo in a comment.

-  I've also added a STPRINTF() macro and used it to remove explicit
   uses of sizeof().

Now, only 5 calls to snprintf(3) remain under mm/:

	$ grep -rnI nprint mm/
	mm/hugetlb_cgroup.c:674:		snprintf(buf, size, "%luGB", hsize / SZ_1G);
	mm/hugetlb_cgroup.c:676:		snprintf(buf, size, "%luMB", hsize / SZ_1M);
	mm/hugetlb_cgroup.c:678:		snprintf(buf, size, "%luKB", hsize / SZ_1K);
	mm/kfence/report.c:75:		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
	mm/kmsan/report.c:42:		len = scnprintf(buf, sizeof(buf), "%ps",

The first three are fine.  The remaining two, I'd like someone to check
if they should be replaced by one of these wrappers.  I had doubts about
it, and would need someone understanding that code to check them.
Mainly, do we really want to ignore truncation?

The questions from v1 still are in the air.

I've written an analysis of snprintf(3), why it's dangerous, and how
these APIs address that, and will present it as a proposal for
standardization of these APIs in ISO C2y.  I'll send that as a reply to
this message in a moment, as I believe it will be interesting for
linux-hardening@.


Have a lovely night!
Alex

Alejandro Colomar (7):
  vsprintf: Add [v]seprintf(), [v]stprintf()
  stacktrace, stackdepot: Add seprintf()-like variants of functions
  mm: Use seprintf() instead of less ergonomic APIs
  array_size.h: Add ENDOF()
  mm: Fix benign off-by-one bugs
  sprintf: Add [V]STPRINTF()
  mm: Use [V]STPRINTF() to avoid specifying the array size

 include/linux/array_size.h |   6 ++
 include/linux/sprintf.h    |   8 +++
 include/linux/stackdepot.h |  13 +++++
 include/linux/stacktrace.h |   3 +
 kernel/stacktrace.c        |  28 ++++++++++
 lib/stackdepot.c           |  12 ++++
 lib/vsprintf.c             | 109 +++++++++++++++++++++++++++++++++++++
 mm/backing-dev.c           |   2 +-
 mm/cma.c                   |   4 +-
 mm/cma_debug.c             |   2 +-
 mm/hugetlb.c               |   3 +-
 mm/hugetlb_cgroup.c        |   2 +-
 mm/hugetlb_cma.c           |   2 +-
 mm/kasan/report.c          |   3 +-
 mm/kfence/kfence_test.c    |  28 +++++-----
 mm/kmsan/kmsan_test.c      |   6 +-
 mm/memblock.c              |   4 +-
 mm/mempolicy.c             |  18 +++---
 mm/page_owner.c            |  32 ++++++-----
 mm/percpu.c                |   2 +-
 mm/shrinker_debug.c        |   2 +-
 mm/slub.c                  |   5 +-
 mm/zswap.c                 |   2 +-
 23 files changed, 238 insertions(+), 58 deletions(-)

Range-diff against v2:
1:  64334f0b94d6 = 1:  64334f0b94d6 vsprintf: Add [v]seprintf(), [v]stprintf()
2:  9c140de9842d = 2:  9c140de9842d stacktrace, stackdepot: Add seprintf()-like variants of functions
3:  e3271b5f2ad9 ! 3:  033bf00f1fcf mm: Use seprintf() instead of less ergonomic APIs
    @@ Commit message
                 Again, the 'p += snprintf()' anti-pattern.  This is UB, and by
                 using seprintf() we've fixed the bug.
     
    +    Fixes: f99e12b21b84 (2021-07-30; "kfence: add function to mask address bits")
    +    [alx: that commit introduced dead code]
    +    Fixes: af649773fb25 (2024-07-17; "mm/numa_balancing: teach mpol_to_str about the balancing mode")
    +    [alx: that commit added p+=snprintf() calls, which are UB]
    +    Fixes: 2291990ab36b (2008-04-28; "mempolicy: clean-up mpol-to-str() mempolicy formatting")
    +    [alx: that commit changed p+=sprintf() into p+=snprintf(), which is still UB]
    +    Fixes: 948927ee9e4f (2013-11-13; "mm, mempolicy: make mpol_to_str robust and always succeed")
    +    [alx: that commit changes old code into p+=snprintf(), which is still UB]
    +    [alx: that commit also produced dead code by leaving the last 'p+=...']
    +    Fixes: d65360f22406 (2022-09-26; "mm/slub: clean up create_unique_id()")
    +    [alx: that commit changed p+=sprintf() into p+=snprintf(), which is still UB]
         Cc: Kees Cook <kees@kernel.org>
         Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
    +    Cc: Sven Schnelle <svens@linux.ibm.com>
    +    Cc: Marco Elver <elver@google.com>
    +    Cc: Heiko Carstens <hca@linux.ibm.com>
    +    Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
    +    Cc: "Huang, Ying" <ying.huang@intel.com>
    +    Cc: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>
    +    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    +    Cc: David Rientjes <rientjes@google.com>
    +    Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    +    Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
    +    Cc: Chao Yu <chao.yu@oppo.com>
    +    Cc: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
     
      ## mm/kfence/kfence_test.c ##
4:  5331d286ceca ! 4:  d8bd0e1d308b array_size.h: Add ENDOF()
    @@ include/linux/array_size.h
      #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      
     +/**
    -+ * ENDOF - get a pointer to one past the last element in array @arr
    -+ * @arr: array
    ++ * ENDOF - get a pointer to one past the last element in array @a
    ++ * @a: array
     + */
     +#define ENDOF(a)  (a + ARRAY_SIZE(a))
     +
5:  08cfdd2bf779 ! 5:  740755c1a888 mm: Fix benign off-by-one bugs
    @@ Commit message
         'end' --that is, at most the terminating null byte will be written at
         'end-1'--.
     
    +    Fixes: bc8fbc5f305a (2021-02-26; "kfence: add test suite")
    +    Fixes: 8ed691b02ade (2022-10-03; "kmsan: add tests for KMSAN")
         Cc: Kees Cook <kees@kernel.org>
         Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
    +    Cc: Alexander Potapenko <glider@google.com>
    +    Cc: Marco Elver <elver@google.com>
    +    Cc: Dmitry Vyukov <dvyukov@google.com>
    +    Cc: Alexander Potapenko <glider@google.com>
    +    Cc: Jann Horn <jannh@google.com>
    +    Cc: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: Linus Torvalds <torvalds@linux-foundation.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
     
      ## mm/kfence/kfence_test.c ##
-:  ------------ > 6:  44d05559398c sprintf: Add [V]STPRINTF()
-:  ------------ > 7:  d0e95db3c80a mm: Use [V]STPRINTF() to avoid specifying the array size
-- 
2.50.0

