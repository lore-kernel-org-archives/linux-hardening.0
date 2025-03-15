Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A89846F;
	Sat, 15 Mar 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008554; cv=none; b=V69Efrv37l2SO/A4Pt9lpL+H/tN46k7oQ+HxatGU40j5PR+un/+6beRm9yObQ1NdfRmG6LB0aT9U1EffryjfSTJ613Bw6otEyo1baNBDsil6z88c7taDQ7dUE0N/vUVTD/7ik7pU00tpHOjw0aYZMawTrMDeE+OKJal4Qjp/+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008554; c=relaxed/simple;
	bh=YOIQ3ZtSX2tS6vlyFTaYggtRceIaGQgB5shVVBaSPf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzy0+KV4zokayEV1mfZUTqzC51KjgYXFW2v2+bU7aZVH3q0zD882VlNm5K6VTo72co8nAuEblrEhM0+IOoeKSLFNF5vOu3ocqO/EB5N+NY0ud3IZ82bqpVgipaNaoOFZXESsICW9njynIUgz0u+5E4i9sXFv//JF97H1lMkJnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7sYQkql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7sYQkql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60676C4CEE5;
	Sat, 15 Mar 2025 03:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742008553;
	bh=YOIQ3ZtSX2tS6vlyFTaYggtRceIaGQgB5shVVBaSPf8=;
	h=From:To:Cc:Subject:Date:From;
	b=M7sYQkqlOEiRIE4SRVqqraUu5q+cPrFuPwy686AVAmzPmEl5S1BDWcKGQwZ5aM0qE
	 RJ58h5EbH5z8dAtCpUHHvT6EZeKfgleYAYIeGMZF1BxSEsSW4v3B1gPcEJZc298UQ+
	 JrEB2HeR/I5ozwCp6mJeOINNCzCa4NvDZ2M2Gl0XZM/h3FedIbBzChOpQp8LN8pQbF
	 N8vsKOnlwMfE3fQJ90PL/qxFiE5i8snx43U/s2z0VF49BqTkfizA3i3Iu+N34x4mWW
	 hGbrcRc6Bn8Wa2Gnt3O5xKzjHRS0zZHtrbfFsX4PzXjE96eLIPKYhyi+ASgv7CFcmE
	 SZt1d9OedtKag==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 0/2] slab: Introduce kmalloc_obj() and family
Date: Fri, 14 Mar 2025 20:15:43 -0700
Message-Id: <20250315025852.it.568-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=kees@kernel.org; h=from:subject:message-id; bh=YOIQ3ZtSX2tS6vlyFTaYggtRceIaGQgB5shVVBaSPf8=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlXPjy4avtT6MtM1rKMB+/d62etWc5j7e7Gt/OX0qR7U 5/8nqOm31HKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRGFlGhpuq3Z9uagj3fdLd yZz3Ii176wr+DSbrZJXvLJx1STFpATsjw8drn452fJ0aZOG8ymL71WN3OXk83kfejro6/UVp8Qq DR5wA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Here's a refresh and update on the kmalloc_obj() API proposal. Please
see patch 2 for the specific details. And note that this is obviously
not v6.15 material! :)

Thanks!

-Kees

 v4:
 - split __flex_counter() out and add appropriate helpers
 - add flex array examples to commit log
 - add "size" details to commit log
 - add treewide conversion details to commit log
 - improve treewide Coccinelle scripting
 - fix documentation typos
 v3: https://lore.kernel.org/lkml/20240822231324.make.666-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20240807235433.work.317-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240719192744.work.264-kees@kernel.org/

Kees Cook (2):
  compiler_types: Introduce __flex_counter() and family
  slab: Introduce kmalloc_obj() and family

 Documentation/process/deprecated.rst |  42 +++++++
 include/linux/compiler_types.h       |  31 +++++
 include/linux/overflow.h             |  36 ++++++
 include/linux/slab.h                 | 170 +++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)

-- 
2.34.1

