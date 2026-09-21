Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAB44A725;
	Mon, 21 Sep 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977503; cv=none; b=PKrBt0Fu9/Nbl1eVGhf3OszhM9qA0NE+a4kLKqNlvgYr5h5ylW7zLyvmatI3Z4OLI6ccZFSCD4icvu1zRXETz6UPt71/nKEe3h+QtkuS1OV8Tagk6bhkHa4B6GFEV+ac3M0d/2feom6EjT4W6OgkM+QNITa1OJmjb6czWcM7DCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977503; c=relaxed/simple;
	bh=joPrY7JNNShNrQs9z9UcLkD5WrmYCF+i0Wpx7ebGiPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDdUmqd1YnRZykG9zMrBlD49EmX5BIVOb8MznsuklePleoEi2lTpJ0/+zpNQa7zDszOorsEf78A9ONPVQZR4xOmZWfkjARbUx3JfrYaXO3SlyiLCDecHK9B+vSxNTAKhOZiySajEljGgKfjOyAwGJgi7wERyGzUyqq2hO9JsTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT4dTiZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT4dTiZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF991F000FF;
	Mon, 21 Sep 2026 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977500;
	bh=t+8KVL++G1Km0Bee3Trq1syqDNE1OnQ/qkWeKzei95o=;
	h=From:To:Cc:Subject:Date;
	b=fT4dTiZZpoj1elRQGQbDEEgl8/DcvFOTs0SA03nvSW+9nwlw9KLQ88nVPUrkOekko
	 RM/57GNFfFmK7Ytw+QM/sNvRAwl0ZkuY0dodriIs6MJ7tdYLU7em8SbIJsnHpANmVe
	 Fi4l9D0Gwnlkd24epzzyf8ENH2bdX5jrPXMtCS/49LaHxrkqQOt4vSF/IC9HRPfnOl
	 /7rsK9jUpTsKLgo6OT8O3rJeNCT8Zyleg2bzhXU+vU57/SxRaAR5QWC8qzgpxsM9l9
	 i7k6OuTdSJUjIdmfrEvO2HQqkkNMR31F/DkBMoRuxFB3VKHRLvxspAC5kB90VB2M8q
	 082GauR5SEQ9g==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/7] net: skb: isolate skb data area allocations into a separate bucket
Date: Mon, 21 Sep 2026 00:58:11 -0700
Message-Id: <20260921075811.too.775-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=kees@kernel.org; h=from:subject:message-id; bh=joPrY7JNNShNrQs9z9UcLkD5WrmYCF+i0Wpx7ebGiPA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkbHs+wWJTxKu2o0Mwfuf9Em3UcZZ78+DfDktncsuTj/ kQRx8mXO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACayzZGR4Yaa3Ilp845Nz8iu 2XG3+exUpj17zQtmTq0S897nsY/BR5DhDw9rXXbh+uPZ/6/lvdkifO9IbeSXN5uFV0TXrzpoZ1v +hxMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

I wanted to get this rolling again, and got the buckets able to handle
memcg (GFP_KERNEL_ACCOUNT) with isolation (since it's common due to
AF_UNIX), and GFP_DMA with fall back (since it's rare). It gave me an
excuse to build out bucket kunit tests too, and that (and LLM review)
found a couple other issues that needed fixing too.

The bulk of this is mm/slab, but the final patch is netdev, but Jakub
had acked it before. I've dropped that Ack since time has passed, but
I'm hoping it will get a re-Ack and this whole series can go via slab.

Thanks!

-Kees

v4:
 - fix a bunch of little things wrong with kmem_buckets
 - provide cache-type fallback when using buckets
 - handle memcg when using buckets
v3: https://lore.kernel.org/all/20260702170728.168755-1-pfalcato@suse.de/

Kees Cook (6):
  mm/slab: Mark the kmem_buckets_create() context as a Context: section
  mm/slab: Give bucket caches the alignment of the caches they mirror
  mm/slab: Add kmem_buckets_destroy()
  mm/slab: Add tests for the existing kmem_buckets behaviour
  mm/slab: Provide kmalloc type fallback for bucket allocations
  mm/slab: Let a bucket set handle __GFP_ACCOUNT

Pedro Falcato (1):
  net: skb: isolate skb data area allocations into a separate bucket

 include/linux/slab.h   |  59 +++++++-
 mm/slab.h              |  44 +++++-
 lib/tests/slub_kunit.c | 316 +++++++++++++++++++++++++++++++++++++++++
 mm/slab_common.c       | 167 ++++++++++++++++++----
 net/core/skbuff.c      |  11 +-
 5 files changed, 566 insertions(+), 31 deletions(-)

-- 
2.34.1

