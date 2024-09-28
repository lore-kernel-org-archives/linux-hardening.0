Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A61136358;
	Sat, 28 Sep 2024 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727557716; cv=none; b=DQ6vdnKZqjvgug6HrHHCT+XmlWFdhhjCfx9DatamWzwnfKHENAVa5qjNZM9+1cE6vNkQmLT114W7wxvQvYqO6aOCUATs/OFKcPmKCEod6J4MWVD+cGn28zVYNqMc9RFQUjLug8IeqFTY7/VwGsdBpMlEXfBLZ8gBvUYZiqikD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727557716; c=relaxed/simple;
	bh=4Xmit0s6cg5hAP8OdkN+IzG4qiO6XhKktY2ixLwGd/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0HvMT+aBXRR2a+J0RXyAGA1WqSzrs8xKKRNW1VEGhmq9b99d/YnAr5N6jQAmEEVvNchFzz9xoHbOq/u63orjg+yogZ8yysuZb63ch5CI0cJ8mYk/BxGmONedG2wqw71JBtMOsO6cuwqce+zSgZRpB2WAfvxukYptB3Uk59gzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0P7nLBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0P7nLBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1FDC4CEC3;
	Sat, 28 Sep 2024 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727557716;
	bh=4Xmit0s6cg5hAP8OdkN+IzG4qiO6XhKktY2ixLwGd/o=;
	h=From:To:Cc:Subject:Date:From;
	b=k0P7nLBuQ06YEZkCK8iQBLlPixyyujIpA1EZE+82NEwaboD17N2JkRQs5KhoaftWT
	 gz3Ss9du0tJb4Ss6iBl+uX2/N4wFBQRtqmGcnd9lYtgK/ssSeEOKRYbp/7cj8xxioW
	 U32IgGdUZSFfirIYEywKtfvzZqeQwD+GXrU4FCsppDF3QZ8FUeEXns1Yl+pSelixUp
	 O2FcwnfVtNRxEgo00k0rWw+MKveGdynVLpqnchSo/KBZs0oXatxO2IAs2vb0JRUXYz
	 kCVMRmJAUFun0aaYirAQj7VGT4oKFHhmEE4vHk7rqEhJYSJxrV/VxH+M6WRrV1weII
	 Rr9erfEXrVZhA==
From: Kees Cook <kees@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Kisel <romank@linux.microsoft.com>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Vijay Nag <nagvijay@microsoft.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] coredump: Do not lock during 'comm' reporting
Date: Sat, 28 Sep 2024 14:08:31 -0700
Message-Id: <20240928210830.work.307-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=kees@kernel.org; h=from:subject:message-id; bh=4Xmit0s6cg5hAP8OdkN+IzG4qiO6XhKktY2ixLwGd/o=; b=owGbwMvMwCVmps19z/KJym7G02pJDGk/CvyVTWusvot4f9knNTHYyH42e0yA5MUn/tYLYp8F2 Bn98aztKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEj7JkaGzqcbfq/5vqP+2JoF Had5AnT/r5xY5OaxIHfW8Ym5v7MVDzP8z70ePeXA3apbNrVvhOL/zhPj/RxpGJr5fIXM0xdrfxW ZsQMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The 'comm' member will always be NUL terminated, and this is not
fast-path, so we can just perform a direct memcpy during a coredump
instead of potentially deadlocking while holding the task struct lock.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Closes: https://lore.kernel.org/all/d122ece6-3606-49de-ae4d-8da88846bef2@oracle.com
Fixes: c114e9948c2b ("coredump: Standartize and fix logging")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Kisel <romank@linux.microsoft.com>
Cc: Xiaoming Ni <nixiaoming@huawei.com>

Vegard, can you validate that this fixes the problem for you? I have
been wrecked by covid, so very slow to respond here. There's a related
thread about this locked, but we can just totally bypass it here.

---
 include/linux/coredump.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index edeb8532ce0f..a99079115a38 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -52,8 +52,8 @@ extern int do_coredump(const kernel_siginfo_t *siginfo);
 #define __COREDUMP_PRINTK(Level, Format, ...) \
 	do {	\
 		char comm[TASK_COMM_LEN];	\
-	\
-		get_task_comm(comm, current);	\
+		/* This will always be NUL terminated. */ \
+		memcpy(comm, current->comm, sizeof(comm)); \
 		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
 			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
 	} while (0)	\
-- 
2.34.1

