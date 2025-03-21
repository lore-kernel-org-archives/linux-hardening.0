Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B797231A2A;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589669; cv=none; b=WUV84Tkh0MPxP+zYYR3QiX51yUQBm5jOLODHgU3LSdAJ6GWMJOD+DsUEKr6Q6PHD4S2rubZZTnkpe3okzDOJ5j/t/eW6arx7GdPfGktZ+INklVjkYo97xo7LqQUKw5xLtV9zfbdFPkwROz+Q5xoVgnioU6kkfX4y52nglylCtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589669; c=relaxed/simple;
	bh=M3xcYD/EBXFYH5zdC+1YVFNPZXTHXbETRb7Q0Fqz4VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I1KGk3CvT3CYDRtJum6WP/1Iip6QZVBgb+mqNOCMoLp8aN/6qMweW4IIrVUHHLrraz4ZDowd9VGI7JiOjsjRnpSziyNE13nGaSck2xDL/U4WhNrPawMFidxEKUKqwrXhi0vGI5Gw4a9D8JwnmU0Q5vXZlk62//0uMWiaxDv29sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XavDrsD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XavDrsD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE91C4AF0B;
	Fri, 21 Mar 2025 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589669;
	bh=M3xcYD/EBXFYH5zdC+1YVFNPZXTHXbETRb7Q0Fqz4VI=;
	h=From:To:Cc:Subject:Date:From;
	b=XavDrsD+7tYh4u1Qnj9BpWAgM/K9aoaPjrajpp5QZHhpUbF1UB23McDoxKSvK8gwk
	 0reVW5WWwoakFdypA/ubBNlr2jw6oK4b1M1/JKcfnGs13zH/k8gDkGpHQ8cItbrSnH
	 EvppQc5cWFEMnBRrsp7LGO2/1sM4YRl3K2/TYalknHDnuMBLygVxVHBwMtJy/NC14a
	 giy90UTXRB5oHBwJ1VB+RP0IfcIoUV8zmP2X3Zkv0D+zYWYY8S5iCRb5rO5vJWZV6B
	 FPQmj/STn4M/h3IyQE9sh173m2zo2H0aY7s6C+RCVRCcP9y/RVFkIEDhtOo3+p9xUl
	 jMFrPlzlfRTVA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [RFC 0/5] slab: Set freed variables to NULL by default
Date: Fri, 21 Mar 2025 13:40:56 -0700
Message-Id: <20250321202620.work.175-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=kees@kernel.org; h=from:subject:message-id; bh=M3xcYD/EBXFYH5zdC+1YVFNPZXTHXbETRb7Q0Fqz4VI=; b=owGbwMvMwCVmps19z/KJym7G02pJDOl3z91+/y16T5StIrf0xtIb5som8geylT7VBi222G9p2 NZU/b2qo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLCOxj+6TPOaDtmNyl5rcy9 qw3PnvuzsjRv+BAxYy7zQiXJpdHmXxj+KWTfOXmUZ1JAZfTOwrvJV0WbH2z7VbxNz6IicG3cFZv vTAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

This is very much an RFC series, but I wanted to make sure it actually
worked before I proposed it. This series seeks to give kfree() the
side-effect of assigning NULL to the kfree() argument when possible.
This would make a subset of "dangling pointer" flaws turn into NULL
derefs instead of Use-After-Free[1]. It effectively turns:

	kfree(var);

into:

	kfree(var);
	var = NULL;

when "var" is actually addressable. (i.e. not "kfree(get_ptrs())" etc.)

It depends on a builtin, __builtin_is_lvalue(), which is not landed in any
compiler yet, but I do have it working in a Clang patch[2]. This should
be essentially free (pardon the pun), so I think if folks can tolerate
a little bit of renaming needed for when kfree is needed as a function
and not a macro, it should be good. Please let me know what you think.

Thanks!

-Kees

(Yes, I'm still working on the kmalloc_objs() series, but I needed to
take a break from fixing all the allocation corner cases I've found there.)

[1] https://github.com/KSPP/linux/issues/87
[2] https://github.com/kees/llvm-project/commits/builtin_is_lvalue/

Kees Cook (5):
  treewide: Replace kfree() casts with union members
  treewide: Prepare for kfree() to __kfree() rename
  compiler_types: Introduce __is_lvalue()
  slab: Set freed variables to NULL by default
  [DEBUG] slab: Report number of NULLings

 arch/mips/alchemy/common/dbdma.c |  2 +-
 include/linux/compiler_types.h   | 10 ++++++++++
 include/linux/netlink.h          |  1 +
 include/linux/slab.h             | 33 ++++++++++++++++++++++++++++++--
 include/net/pkt_cls.h            |  5 ++++-
 io_uring/futex.c                 |  2 +-
 io_uring/io_uring.c              | 12 ++++++------
 kernel/bpf/core.c                |  3 ++-
 mm/slab_common.c                 | 12 ++++++++----
 mm/slub.c                        |  6 +++---
 net/sched/ematch.c               |  2 +-
 net/wireless/nl80211.c           |  2 +-
 12 files changed, 69 insertions(+), 21 deletions(-)

-- 
2.34.1

