Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC17E774;
	Fri, 31 May 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181830; cv=none; b=A8t/Ma4k/cPu51qhi3N/7fxt5bvi0FmWazdttBRsecKVF3FVNWPTzC0YBGrsuYMredkdwfWXOHn9lFaguF3LFicOn0C8+sEa5hdorUAhHkZnDD4EC9K/DSiPPyM6oi40vMLlSBy6Ommtnw+rSRyL0uwrv78A9l7YFu1U4Ia92xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181830; c=relaxed/simple;
	bh=AD6M0l/XhTHROLN84HPg7DK+mvf0+qhuriNkdX52eto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=deVNsHD51wOPFVZZ74+uXvTTNkucRPdkrxBqz3CikQHUlX13Ksr5HMiPTWJlfQ/8g1Sm/ojx/vt4yWlg7xL26wSemxv9tYdbqE9R9MRHl+3H55yHlbhAhHXPwGe884+nxNYDDIpXpfJ47SpG7I99mFiIQGtTpWDP+gY9DyeCJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXqURVvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXqURVvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC8C116B1;
	Fri, 31 May 2024 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717181830;
	bh=AD6M0l/XhTHROLN84HPg7DK+mvf0+qhuriNkdX52eto=;
	h=From:To:Cc:Subject:Date:From;
	b=LXqURVvonoO86l+SqVgDHx2+6B84YxN3Ty3Jalhip5f8LKmuDWXyaQKkN6oGxYISW
	 cw/2cdWVvesB8ubTgklEC72ezwDndA7f3d3e1+Xo/M63Xi+Gfdm+wKu54NJsfmPC42
	 MSXOXcVYgZ58Vf3f+EJgoyKiXhGmi9al0DMaD8HQeb2jCWMfibtUNoDaN2Y7C0BvWt
	 U4LL61/4Ou5r1cMT6h05RtRM8nwghSLBHWuF+KTjlzvAhlbuVvz8UZtqlmxPCDPbfy
	 KkPPa2GaCTC9pwPVf7n8sFmt2b+BUqwzAGlHP0nzdWljP+zHP31bS26cxzCzSkwhPA
	 u2tJWJ/shle+g==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Remove __kmalloc_node() test
Date: Fri, 31 May 2024 11:57:07 -0700
Message-Id: <20240531185703.work.588-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=kees@kernel.org; h=from:subject:message-id; bh=AD6M0l/XhTHROLN84HPg7DK+mvf0+qhuriNkdX52eto=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWh2DthOMchFi4h1JTCJc+Oc7ZIT8JDA+GPlTq O8+j+LvBiKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlodgwAKCRCJcvTf3G3A Juc9EACBg7g0AciMJlxpgOkrIEkAgz4JxUyNzcnSH9uUoC2yv8MCXe94HbZEDY7e+twT+Kme7c3 P503Bd31wDK0odVa9x+AfYv7p+7hg6lnKrs0p8m9wybIJIYB12+9OVtY8ue4mXw80s4eDYT6iBt aowOPKrdFswzoOqQ0QItii6khvk9d5ODMhDeyUb9/W5+o+VNFIlb2m+PjQ/yYt0O7Dt0oWTtIf/ O4LV6hS8RBaE3FOmiHfkY60Umwvlj+vwH/KBHiEeauwlQKrfJrxvotXHIvrNWfz8gSz+BNvVqgj 0gfhB8TzgxCEwKYOuqthrYFdgEE+31THl5RocK7YZcIe+SRLHCWzfwSx92LMMLFH2x4rxsHFYqU hxHkhKIJNRI1x1TD0mlOjQZ++Kj7aZgzUWMZviF7iG9eCWOTSwwT2dwW2/XhRIcpfgPyXoe0PIu sf8O2HoLGy9am5QU8EN3AN46jUH/BiVwZ/3fHwiZyeGRKEmx3RvZQCPWzukEGIxsf7m0rLXSqfq dfw7ORnoDjBIeGUQIIz5H6L5WW/OvhDL5b1qLAvtqycwJIxsQzmcvGAxRKYqcHHaiuSQDsiUZrt fA57Ae3G0JbDrmzWaD4FAY2zYHnJH7w9XlpCumPcaUP1G/wJKGlV3ZPRAod7lqZKEUluB0jJJMs AnHqrlsFegIWnK
 g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

__kmalloc_node() is considered an "internal" function to the Slab, so
drop it from explicit testing.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 39da5b3bc649..f9cc467334ce 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -235,9 +235,6 @@ static void fortify_test_alloc_size_##allocator##_dynamic(struct kunit *test) \
 		kmalloc_array_node(alloc_size, 1, gfp, NUMA_NO_NODE),	\
 		kfree(p));						\
 	checker(expected_size, __kmalloc(alloc_size, gfp),		\
-		kfree(p));						\
-	checker(expected_size,						\
-		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
 		kfree(p));						\
 									\
 	orig = kmalloc(alloc_size, gfp);				\
-- 
2.34.1

