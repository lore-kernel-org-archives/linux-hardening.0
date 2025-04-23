Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AB264602
	for <linux-hardening@vger.kernel.org>; Wed, 23 Apr 2025 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390978; cv=none; b=ASvqMAX6jTMdk+9Yti+JEp/UT0cGnulYOqU38kVZoYuEiHvQBDgXuMCFbmZIgfV7l7VS3bzQ17APtCaR16oXI9g8dG8jAIOLc0xmnvaxqCO/HqCW39O+/DYiYa3+q1HtT/Oj6BIyvyYYs9/dWAyv/nkmW2k/VRyCBIPgIwIcayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390978; c=relaxed/simple;
	bh=WVnWFHU0v9SFvJB4fB2rFyZJpCs60+/tHwhoxmErUr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ7SgQT3OzYTEMFxzdJ4SmD8pqz0YXgsJUwHszQgG4fBJde2ZX+a6h0ETz7XEdLFMcbdzO57Onz3AAU5SqM1IIdcc5s+vYVr1/BW0rPX3psyEIaKzqMCsyP9GZndu6rRgSsj6M/oE1VxXH8sjdG/ORBC4WGHi5+P7T003Cr+bYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anv9Vn7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anv9Vn7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFA8C4CEE2;
	Wed, 23 Apr 2025 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745390978;
	bh=WVnWFHU0v9SFvJB4fB2rFyZJpCs60+/tHwhoxmErUr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anv9Vn7+WBHYrcPwYnyJChBmjvxsuI0XF4x0WtkcBxzscCa8Sv4GO3HREQBydKedG
	 8BAaYm+2yarcj1RD3pQl8s69IvGW4+fwpsxiVh67ZrwpIIRa9tvoajFURkdCwsH+F5
	 XYtaYavQ1vyE7hKTMGndGtl3LTt5/tp4klsySperDxujkLnygpjhnweuropqCjye6+
	 pLV3/aUVU+4yUv2tzMOdLFN56vshLllGBe/b4ZEk4UsmQUDcJzlQ1QN8N08aRGWWcu
	 Es6c99zYbScvXnGSF/PlRsKW89MSOqm3Qcu9J/jQ9p78LpFQTE+14T3jcYA6b+zDP7
	 A9joeOqcV3lEw==
Date: Tue, 22 Apr 2025 23:49:34 -0700
From: Kees Cook <kees@kernel.org>
To: Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x195/0x220
 at running fortify_kunit (v6.15-rc1, x86_64)
Message-ID: <202504222221.6EA181A7A@keescook>
References: <20250408192503.6149a816@outsider.home>
 <20250421120408.04d7abdf@outsider.home>
 <202504220910.BAD42F0DC@keescook>
 <20250423004422.3c4ef599@yea>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423004422.3c4ef599@yea>

On Wed, Apr 23, 2025 at 12:44:22AM +0200, Erhard Furtner wrote:
> On Tue, 22 Apr 2025 09:50:24 -0700 Kees Cook <kees@kernel.org> wrote:
> > On Mon, Apr 21, 2025 at 12:04:08PM +0200, Erhard Furtner wrote:
> > > fortify_test_alloc_size_kvmalloc_const test failure still in v6.15-rc3, also with a 'GCC14 -O2'-built kernel:
> > > [...]
> > > BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x2a2/0x370
> > > [...]
> > >     not ok 7 fortify_test_alloc_size_kvmalloc_const
> > > [...]  
> > > > I gave v6.15-rc1 a test ride on my Ryzen 5950 system with some debugging options turned on, getting a KASAN vmalloc-out-of-bounds hit at running fortify_kunit test:  
> > 
> > I'm not able to reproduce this yet. What does your .config look like?
> > [...]
> > What other debugging do you have enabled?
> 
> Hi!
> 
> Sorry, I forgot to attach my v6.15-rc3 kernel .config. It's basically the same as the -rc1 one from my first report (https://lore.kernel.org/all/20250408192503.6149a816@outsider.home/), but with GCC 14 and -O2 instead of Clang 19 and -Os.

Thanks! I was able to reproduce this by not using UML and forcing on
CONFIG_FORTIFY_SOURCE=y:
(Bug #1: CONFIG_FORTIFY_SOURCE should be enabled by KUnit for x86_64)

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_KASAN=y \
	--kconfig_add CONFIG_KASAN_VMALLOC=y \
	--kconfig_add CONFIG_FORTIFY_SOURCE=y \
	fortify
...
[22:52:53] BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x1a4/0x200
[22:52:53] Read of size 6291456 at addr ffffc90000200000 by task kunit_try_catch/41


As it turns out, I had to go back to v6.11 before this passed again.
Doing a git bisect lands me on commit 590b9d576cae ("mm: kvmalloc: align
kvrealloc() with krealloc()"), which certainly sounds like something
that might break the fortify_test_alloc_size_kvmalloc_const test. :)

$ ./scripts/faddr2line .kunit/vmlinux vrealloc_noprof+0x1a4/0x200
vrealloc_noprof+0x1a4/0x200:
vrealloc_noprof at mm/vmalloc.c:4106

4104:        if (p) {
4105:                memcpy(n, p, old_size);
4106:                vfree(p);
4107:        }

This seems to think it's the vfree(), but I think this is off by a line
and it's probably the memcpy()...
(Bug #2: KASAN is reporting the wrong crash location)

Looking at the commit, though, I think it is just exposing the use of
vrealloc(), which was introduced in commit 3ddc2fefe6f3 ("mm: vmalloc:
implement vrealloc()").

The KUnit test is attempting to allocate these # of pages:

        TEST_alloc(check_const, 1, 1); \
        TEST_alloc(check_const, 128, 128); \
        TEST_alloc(check_const, 1023, 1023); \
        TEST_alloc(check_const, 1025, 1025); \
        TEST_alloc(check_const, 4096, 4096); \
        TEST_alloc(check_const, 4097, 4097); \

The realloc test doubles it for the realloc:

        checker(((expected_pages) * PAGE_SIZE) * 2, \
                kvrealloc(orig, ((alloc_pages) * PAGE_SIZE) * 2, gfp), \
                kvfree(p)); \

So I'm not sure where the 6291456 bytes from KASAN is coming from --
that's not one of the potential sizes.

I bet this is KASAN precision vs get_vm_area_size(). i.e. KASAN marks
the exact number of bytes requested ("size"):

        area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);

but the allocation in __get_vm_area_node() is going to round up:

        size = ALIGN(size, 1ul << shift);

Instrumenting the test for some more details, and I can confirm:

[23:27:36]     # fortify_test_alloc_size_kvmalloc_const: Allocated kmem for 0 bytes
[23:27:36]     # fortify_test_alloc_size_kvmalloc_const: Allocated kmem for 4096 bytes
[23:27:36]     # fortify_test_alloc_size_kvmalloc_const: Allocated kmem for 524288 bytes
[23:27:36]     # fortify_test_alloc_size_kvmalloc_const: Allocated kmem for 4190208 bytes
[23:27:36]     # fortify_test_alloc_size_kvmalloc_const: Allocated vma for 4198400 bytes, got 6291456 byte area (2093056 unused)
[23:27:36]
==================================================================
[23:27:36] BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x1a4/0x200
[23:27:36] Read of size 6291456 at addr ffffc90000200000 by task kunit_try_catch/41

Ta-da.
(Bug #3: vrealloc attempts to memcpy the entire area, even though only
the originally requested size has been unpoisoned by KASAN)

I'm not sure what to do here, as KASAN is technically correct. Can we
store the _requested_ allocation size somewhere in struct vm_struct ?
This likely totally insufficient hack solves the crash, for example:

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e3..f77ab424b4f5 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -53,6 +53,7 @@ struct vm_struct {
 	struct vm_struct	*next;
 	void			*addr;
 	unsigned long		size;
+	unsigned long		requested_size;
 	unsigned long		flags;
 	struct page		**pages;
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3ed720a787ec..e4ee0967e106 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3859,6 +3859,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
 	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
+	area->requested_size = size;
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -4081,6 +4082,7 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		}
 
 		old_size = get_vm_area_size(vm);
+		old_size = vm->requested_size;
 	}
 
 	/*

-Kees

-- 
Kees Cook
