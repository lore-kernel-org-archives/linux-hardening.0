Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E0175D2C;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188790; cv=none; b=Uh9V1tRXMarpHyrTvE8BgDF4A5IDMlXHHVYQLijNGUfN5sSnlCyaWrjzd2TGO6mcmLugPr+zdbczzboeW+BBuJSrZ58OP4cCd17PSVPEpzMGmY90h/Uu5Pr7QS2ckAP7j5+HPt6BTOY0enwmHj/zVg3XssWZDnlBEZcA+nTjNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188790; c=relaxed/simple;
	bh=IOKrBmQTG4OCsB4r8APic0P3ePvMpjBK8oET24uorNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p47Z6VKm91M+bHV0m3Jj0oCqCqzNYakRnAhujQ86rGuVZBJFDGfk5sdce0SCk/KcykAHeYYf3DBfJUQ4tXQVlfscaHBGu8s9sQe/CYBcdfRY2S+yTf+cvOmxzlcGmTAYTHGSWs/GJgcebcAmb5YqKxCsvD5TLlGdwjQGMkeR6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRMilmi1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRMilmi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CD6C4AF09;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188789;
	bh=IOKrBmQTG4OCsB4r8APic0P3ePvMpjBK8oET24uorNs=;
	h=From:To:Cc:Subject:Date:From;
	b=LRMilmi1+/MCcvYuOD94XlvNl3TjcXQ2ZxBr7PEiT3TsUQZZ0eVEqZdVDHHHMLmjY
	 PlrPk82FZ0dePn/z+JiB9yxpUTleJPyX1E+6z+QDx5/iS5JG8vvB2IIBwzE49aXcTK
	 ykRjKafgxqhtz7Nn4LaBwf8NKmt0eV/qImAjkWqspaeRheTopJi3Y5wZ/GcL5LrSn7
	 SzTiKwdHLRO1TQvoaFXaMuDS5tJY0qKE1aIsYGijbsvRiLwVgKC4JeYcTsDlDVYVbh
	 SHSdyjHz+kHZuFaEcoPofdn37P3nWn2zkDIOxxZJJkdHmYXY9SwqLmatLqNINv3rrT
	 nsg234Ad5lODQ==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [RFC][PATCH 0/5] slab: Allocate and use per-call-site caches
Date: Fri,  9 Aug 2024 00:33:01 -0700
Message-Id: <20240809072532.work.266-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=kees@kernel.org; h=from:subject:message-id; bh=IOKrBmQTG4OCsB4r8APic0P3ePvMpjBK8oET24uorNs=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbjxnoT/vKcETnWu/mV1ZSx+sevP0o1/M5kovLOf7Fq 1kr/ips6ChlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjIvAKGP9xV3Azf/+uatwgG WB55bzDtcVSoa9W1JQ819Pfm1KaYLWb4H1txVonzcPDi2Oo/L+/mSvftMp1w0fVuG6OPmM8phY2 z2QE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Here's my current progress on using per-call-site kmalloc caches (instead
of KMALLOC_NORMAL), as a defense against the common heap-grooming attacks
that construct malicious objects in the same cache as a target object.

I'd like to get feedback on the general approach before I continue with
it. I've noted in the later patches what additional improvements I'd
like to make. The first 3 patches are relatively small infrastructure
changes.

Thanks!

-Kees

Kees Cook (5):
  slab: Introduce kmem_buckets_destroy()
  codetag: Run module_load hooks for builtin codetags
  codetag: Introduce codetag_early_walk()
  alloc_tag: Track fixed vs dynamic sized kmalloc calls
  slab: Allocate and use per-call-site caches

 include/linux/alloc_tag.h |  38 +++++++++--
 include/linux/codetag.h   |   2 +
 include/linux/slab.h      |  17 ++---
 lib/alloc_tag.c           | 129 +++++++++++++++++++++++++++++++++++---
 lib/codetag.c             |  21 +++++--
 mm/Kconfig                |  25 ++++++++
 mm/slab_common.c          |  18 +++++-
 mm/slub.c                 |  31 ++++++++-
 8 files changed, 253 insertions(+), 28 deletions(-)

-- 
2.34.1

