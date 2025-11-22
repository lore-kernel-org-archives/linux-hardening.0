Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3232C11C9;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775786; cv=none; b=FRgUXg0ZWWqyxS7kAaMySijqOTUs4PI6g/crQ2OWht7nFONksbQtIJveWbykDsGCBeGDpMQ9hIjcL/CQA5UnFSg8aq0s6rNw/ucAgOlxhrH78T3I7r5eRJzpeMO9z8+j/aACxMdf8Ol8e59dyp0yIql0yycZm9dq1jjC2NJ8uuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775786; c=relaxed/simple;
	bh=b0N2+6axFL60SmL5qq5mSm+WP+EAAIDcygJAHAmKD64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDSVU57Jndq3s4vbYZm7v2ZkMBoDr8ipubuXjX68S5a9Bautx1f/OMNDCh7tsOrOfSGRN14fcJBuO8FmlAIhgjVohrhNko0ytBuaY32QzJka0kSIajPD1+b/NIRfPh9ZbuG9sHi+GYPAvZE/EcLuTO1TRcE4bNTNck/iKlUC4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBkGrH6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBkGrH6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C603C4AF0D;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775785;
	bh=b0N2+6axFL60SmL5qq5mSm+WP+EAAIDcygJAHAmKD64=;
	h=From:To:Cc:Subject:Date:From;
	b=XBkGrH6XQV0rAAPjG07QkiTblZA7Dosnd9q4wS/SttoChQxGFDGEtw3c/+uSX9ZuY
	 Zx2mkX5+8Vvd3F+p4coxqRU6MmDRdnFZDnhD0K/ihwUfthtQp1OB+lkHvPlOyJiblo
	 qDiXXQYy33Qn/1cpWVT3qVw/hVt97FJ8DzLC7F4wYtNXuieC8+sRJeu1hTlocj9SXc
	 8B0tPAW1xtUp1DmjAiTPz+VwljWcYJ1RgJBrMY0uJ63/17zj3HYzaGGTYLhMwVIt4r
	 c16bOa/gcSLIh7SSrtuBBAw4dQJX11bYYPtbqk3gFpMeDvjQFVN8tOEBQZgIN2D0Pa
	 DOcl4A+6IXPTg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
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
Subject: [PATCH v5 0/4] slab: Introduce kmalloc_obj() and family
Date: Fri, 21 Nov 2025 17:42:56 -0800
Message-Id: <20251122014258.do.018-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=kees@kernel.org; h=from:subject:message-id; bh=b0N2+6axFL60SmL5qq5mSm+WP+EAAIDcygJAHAmKD64=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmKoko3Vx3sM6x9fsUtUvjBdZOr2T63v3zR+eRSkRXIv f5jmfftjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkYKjAyTHHeOCn7oMaEkqul welvZ0wv6WtTfMs5fc0ubUupSt5lxxgZZh0OOdHlxfcnVN1s53SZWb4/bcREDX+7xZ43SV1a+cq TDwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Here's a refresh and update on the kmalloc_obj() API proposal for
discussion here and at LPC[1]. Please see patch 2 for the bulk of the
details. And note that this is obviously not v6.19 material! :)

The tree-wide patch for conversions is here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=dev/v6.18-rc6/alloc_obj/v5&id=f79ee96ad6a3cafdb274fe15d3ae067724e72327

Thanks!

-Kees

[1] https://lpc.events/event/19/contributions/2136/

 v5:
  - switch to using assignment with type as first argument (Linus)
  - fix various comment, commit log, and kern-docs (Randy, Miguel)
  - renamed flex_counter internal helpers with "__" prefix (Przemek)
 v4: https://lore.kernel.org/lkml/20250315025852.it.568-kees@kernel.org/
 v3: https://lore.kernel.org/lkml/20240822231324.make.666-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20240807235433.work.317-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240719192744.work.264-kees@kernel.org/

Kees Cook (4):
  compiler_types: Introduce __flex_counter() and family
  slab: Introduce kmalloc_obj() and family
  checkpatch: Suggest kmalloc_obj family for sizeof allocations
  coccinelle: Add kmalloc_objs conversion script

 scripts/checkpatch.pl                     |  39 ++++-
 scripts/coccinelle/api/kmalloc_objs.cocci | 168 +++++++++++++++++++++
 Documentation/process/deprecated.rst      |  42 ++++++
 include/linux/compiler_types.h            |  31 ++++
 include/linux/overflow.h                  |  40 +++++
 include/linux/slab.h                      | 172 ++++++++++++++++++++++
 6 files changed, 486 insertions(+), 6 deletions(-)
 create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci

-- 
2.34.1

