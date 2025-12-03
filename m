Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C62EA154;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804637; cv=none; b=qfLZEURwxSScTcliI+JoC3FQFCqIZfjjGT1sqfa//C98XsEoqtB1De7sBV+B6sRuWMWJyYX7svAuLUYpv1BozClU1WApBtQ2sG98bSIV6NTIFaH5N3Q299Pa/JHahpaLfwz+DqUEcbI/SO0M1aV3vGBMu8ttV2ioLKC1ysMcNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804637; c=relaxed/simple;
	bh=HNYogr7zzJHRiNSelDmcEoExR/fm7KJufnOedN0KEbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orrK3kJdbtE3mU814pKxB6suirVlAz+18c34s4FZ43O+MNi+X/qyN6YFzXy2xt8MHT26xUH/fJU/1K+lVRcNCvzboYfIE5i3DEMg7BoO72dlsa/PToMYPvgYmQV3pWHP4e4UZnXPu+YNJW5AYyG4Bx85B+kXh3laQW+h4EDeupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgfupv1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgfupv1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057EDC116B1;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764804637;
	bh=HNYogr7zzJHRiNSelDmcEoExR/fm7KJufnOedN0KEbY=;
	h=From:To:Cc:Subject:Date:From;
	b=lgfupv1TvQXvNqeGjsEp7Tb7NgOU0e+DsX6CLfuR9wVEbBaot1A4klXIvr5ctcExL
	 T3s+zZcGsR+OygeA2G0H0Jcb5gyzD3sc+kYsRU1v0RDskISoueDITyehiu+9jMs9Lc
	 HiGtzFqNOmXcKDRk5jVNUJJ0DF32fEJufg7vi4ZDsW5c/kmj4bqCS7dmON/Z/MJqSS
	 46Mg4VjxhHc2XaO4nxnFte22hvLB8hcds5Xqp7zmHecQdT3IsC8/RKCP2veY2R2o88
	 1Hyxj+kY/enbNebz4HmPBHZUCSySE1fjG4JT4z9zFlfHEzdt6m7SNSDqJw4APd0V2G
	 sHr32uf/ljdRQ==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>,
	Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v6 0/5] asdf
Date: Wed,  3 Dec 2025 15:30:30 -0800
Message-Id: <20251203233029.it.641-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3399; i=kees@kernel.org; h=from:subject:message-id; bh=HNYogr7zzJHRiNSelDmcEoExR/fm7KJufnOedN0KEbY=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkGJyT5pu5Ks/h+QOPslH9hf+v13ieZh7re8V1xsexwQ VbmjgPeHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPRucXwPy5dv3HRNqWknabV F04JHmOrszu2vkQlesHtjGXfzG1+LGRkeFW1IKtFP/nHGbssV6lXa3wjfdaunP6ktsrIQt3Efh4 zLwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Here's an update for the kmalloc_obj() API proposal based on Linus's
feedback. I normally wouldn't send this during the merge window,
but I wanted to have it updated for discussion at LPC[1] (and here in
email). Please see patches 1 and 4 for the bulk of the details. This is
obviously not v6.19 material! :)

Replacing[2] all existing simple code patterns found via Coccinelle
shows what could be replaced immediately (also saving roughly 1000 lines):

 7971 files changed, 19880 insertions(+), 20752 deletions(-)

This would take us from 24515 size-based k*alloc assignments to 7682:

$ git grep ' = kv\?[mzcv]alloc\(\|_array\)(' | wc -l
24515
$ git reset --hard HEAD^
HEAD is now at 8bccc91e6cdf treewide: kmalloc_obj conversion
$ git grep ' = kv\?[mzcv]alloc\(\|_array\)(' | wc -l
7682

This treewide change could be done at the end of the merge window just
before -rc1 is released (as is common for treewide changes). Handling
this API change in backports to -stable should be possible without much
hassle by backporting the __flex_counter() patch and this patch, while
taking conversions as-needed.

The impact on my bootable testing image size (with the treewide patch
applied) is tiny. With both GCC 13 (no __counted_by support) and GCC 15
(with __counted_by) the images are actually very slightly smaller:

$ size -G gcc-boot/vmlinux.gcc*
      text       data        bss      total filename
  29975593   21527689   16601200   68104482 gcc-boot/vmlinux.gcc13-before
  29969263   21528663   16601112   68099038 gcc-boot/vmlinux.gcc13-after
  30555626   21291299   17086620   68933545 gcc-boot/vmlinux.gcc15-before
  30550144   21292039   17086540   68928723 gcc-boot/vmlinux.gcc15-after

Thanks!

-Kees

[1] https://lpc.events/event/19/contributions/2136/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=dev/v6.18-rc6/alloc_obj/v5&id=f79ee96ad6a3cafdb274fe15d3ae067724e72327

 v6:
   - Drop _sz() helpers and simplify the resulting internals
   - Split _flex() helper into its own patch to make review easier
   - Explicitly use TYPE within the internals to make things more readable
   - Move treewide change details into the cover letter
 v5: https://lore.kernel.org/lkml/20251122014258.do.018-kees@kernel.org/
 v4: https://lore.kernel.org/lkml/20250315025852.it.568-kees@kernel.org/
 v3: https://lore.kernel.org/lkml/20240822231324.make.666-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20240807235433.work.317-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240719192744.work.264-kees@kernel.org/

Kees Cook (5):
  slab: Introduce kmalloc_obj() and family
  checkpatch: Suggest kmalloc_obj family for sizeof allocations
  compiler_types: Introduce __flex_counter() and family
  slab: Introduce kmalloc_flex() and family
  coccinelle: Add kmalloc_objs conversion script

 scripts/checkpatch.pl                     |  39 ++++++--
 scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
 Documentation/process/deprecated.rst      |  31 ++++++
 include/linux/compiler_types.h            |  31 ++++++
 include/linux/overflow.h                  |  42 +++++++++
 include/linux/slab.h                      | 106 +++++++++++++++++++++
 6 files changed, 352 insertions(+), 6 deletions(-)
 create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci

-- 
2.34.1

