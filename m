Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041C39CCE6;
	Mon, 14 Sep 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425141; cv=none; b=DtYpDibn6uu6g2yz6ZulGQQUe0FdLOkLFNuDPBMW0hZbC0ueyUNlJZ2fB9SrRH6MW7kQpD7FyDvpfnGVGZLMJ1AjkGD+F046G2WmJGFWkXt7p4y2oLU3kx9SwDKX9150MThGEdhNtikNlOSwWm5i1INrMQ6dAzK1/U8KLly9xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425141; c=relaxed/simple;
	bh=qijXd2QkQ3HWA4BpjJ7QTWYCf8fopTwhtZmjFOO2pcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jOrPv5rCCEaU8sV32AsDXfOebq+UexiB13D4g/zf8uwOkpg+OKTM2orZHpy84DwlZ/Fe5Jw0MUfDYgu5WIXWGnJ7DMZPqfu4Gxs4zdo6+IOVLJdfBouvkwRc19nq/AoL64Krkm5xkCQqEQ9qY74IAGxphx1ToN9vVUSAt6BR3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJIMboED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJIMboED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E431F000FF;
	Mon, 14 Sep 2026 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789425139;
	bh=KOcA2tcYSGnDhJMYp2xxbrOyIjGECs9CmcVH5IitgEo=;
	h=From:To:Cc:Subject:Date;
	b=OJIMboEDjb8wnTlLoFItfkx9VEnB0HBrVsFvYs3nT8IACR02rgiIdWIveIDXmegG4
	 Chqh8XXbMdMvL5eCfPkx+BCq5z4D2IBAMaTdlpPonu9LpZXccjQr+We+OiqngkUpcI
	 XqB0kE9fOtGzNYf6bQzn8T+89DxYlyVFop5M7VnXsfLlFVLe3qrg2eYIxt3Xqyr58c
	 giZrQj9iv681jMvXA7+dIo37n8iMdZ6Ecsbrc2iKHeM239kd6n986RjPQrHQZdwfnx
	 a51gDM6jAo8CJHlgm77ZSr5CEzN8jyD25hif1eZNNNogp77S6KKNpAI5YBRGxOfH7a
	 r8kEGVEHlxHew==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] devres: Provide kmalloc_obj*-style API for devm_kmalloc
Date: Mon, 14 Sep 2026 15:32:15 -0700
Message-Id: <20260914223212.i.829-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=kees@kernel.org; h=from:subject:message-id; bh=qijXd2QkQ3HWA4BpjJ7QTWYCf8fopTwhtZmjFOO2pcA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkrSj9wCz48ajQtkP/S1t6wJyfZ/gcdS+kXu7WqOFh74 hR+s56/HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPZ95aRYeML871r0hIWhL+v dNUwyWdVdtrvwhIRv67h6JYo7qfntjP80z1+w8/u4f9kCftJy48Z/ft5KX2u8vLk96eSeeaI/gh L5QcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

As a continuation of the type-based allocator work, this introduces the
wrappers for devm_kmalloc()-family to use the _obj/_objs/_flex API that
the kmalloc()-family has moved to. Along with the coming changes to
scripts/coccinelle/api/kmalloc_objs.cocci to support devm_kmalloc()
conversions, this will result in the following uses:

            6644    devm_kzalloc_obj()
            1714    devm_kzalloc_objs()
             296    devm_kzalloc_flex()
              89    devm_kmalloc_objs()
              83    devm_kmalloc_obj()
               2    devm_kmalloc_flex()

which totals out in diffstat to:

 5908 files changed, 10013 insertions(+), 12082 deletions(-)

-Kees

Kees Cook (2):
  mm: Move default_gfp() into gfp_types.h
  devres: Provide kmalloc_obj*-style API for devm_kmalloc

 include/linux/device/devres.h | 102 ++++++++++++++++++++++++++++++++++
 include/linux/gfp.h           |   4 --
 include/linux/gfp_types.h     |   4 ++
 3 files changed, 106 insertions(+), 4 deletions(-)

-- 
2.34.1

