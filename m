Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D61B3923;
	Sat, 26 Jul 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753564013; cv=none; b=XMNMglZ/l2SWIt8hKNlwYh8THLZ8SlMDe6QmU4dcovK5v9pTVoXJbYGqgCKp5drBQ6qgxOPqVHo9qoEwuL3wY5YKcS09K43xUA/b6Q5qHJoI4EyH8FHLxvoJ3JwxE3XyZaGRVvqwu/k5f/kifW2s8DR+114lkLjvVJTyW3H8T7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753564013; c=relaxed/simple;
	bh=ixZkf+J0G7OOFDBMZ81LdDOwXqmDE8SEL43e82Qe/uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOny24gEyCgCZikIzysh4vdgPNiC92AU1j+CayTsyqZdh0+52BS2rANtzQKj+b54Jxa/Mq4QF0WNER11fkFv4IfkPtp038CVF14nMFt/OjOXk8/9q4jxtMFMhQLHbE16dbkSVgNZjEYXx+1FTDc3bLVNBTmq2jUg4HBRR9aGz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biuDSRaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biuDSRaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD2AC4CEED;
	Sat, 26 Jul 2025 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753564012;
	bh=ixZkf+J0G7OOFDBMZ81LdDOwXqmDE8SEL43e82Qe/uo=;
	h=From:To:Cc:Subject:Date:From;
	b=biuDSRaFKFRNB3GH4jPlnuSRWWqB1pBmauWx5WCNB5IPk1HTdX09NwkieDFMVz4it
	 VPTL3wCtYyAWwHrnyMX+tQg0/ysxWdxeJkjQMV5FuggYnh5Ty8vlxKAS0KKH0VORiB
	 NSvxw9tSxsHPikK4lz8ailMSqO8ncA8Jo0TV0UW4IK4+YBfOmws2ZAvzdZOvCbPZI5
	 AkdRotRJPIRE+DAffenJarqTtyx6l/9YOOaM9WPCpw5158ciXHSGWVPX2tEErT17HD
	 uodhv3vEvRoeExlBqAl6AUUd9+DfYFK773kbPd+u9y6cXH9nyais+k+O94Px9g/EAV
	 uRWjpYQPHgE0A==
From: Kees Cook <kees@kernel.org>
To: Youling Tang <tangyouling@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Disseldorp <ddiss@suse.de>,
	Qun-Wei Lin <qun-wei.lin@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sched/task_stack: Add missing const qualifier to end_of_stack()
Date: Sat, 26 Jul 2025 14:06:46 -0700
Message-Id: <20250726210641.work.114-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=kees@kernel.org; h=from:subject:message-id; bh=ixZkf+J0G7OOFDBMZ81LdDOwXqmDE8SEL43e82Qe/uo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmtzmk5U4VyF8rPitus8PP9naK4vUpXjNgyk2qtL86cU KnlWbmto5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLq6owMDYIxRhGZ00/uecPO 3KSlcmHVDofSvoN/VBzvzWfrWT8tnpFhW9njc8GqwYJPhKZzqaQbPNiYxa/szsMlozDtSOA5tmY GAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add missing const qualifier to the non-CONFIG_THREAD_INFO_IN_TASK
version of end_of_stack() to match the CONFIG_THREAD_INFO_IN_TASK
version. Fixes a warning with CONFIG_KSTACK_ERASE=y on archs that don't
select THREAD_INFO_IN_TASK (such as LoongArch):

  error: passing 'const struct task_struct *' to parameter of type 'struct task_struct *' discards qualifiers

The stackleak_task_low_bound() function correctly uses a const task
parameter, but the legacy end_of_stack() prototype didn't like that.

Build tested on loongarch (with CONFIG_KSTACK_ERASE=y) and m68k
(with CONFIG_DEBUG_STACK_USAGE=y).

Fixes: a45728fd4120 ("LoongArch: Enable HAVE_ARCH_STACKLEAK")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250726004313.GA3650901@ax162
Cc: Youling Tang <tangyouling@kylinos.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/sched/task_stack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 85c5a6392e02..1fab7e9043a3 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -53,7 +53,7 @@ static inline void setup_thread_stack(struct task_struct *p, struct task_struct
  * When the stack grows up, this is the highest address.
  * Beyond that position, we corrupt data on the next page.
  */
-static inline unsigned long *end_of_stack(struct task_struct *p)
+static inline unsigned long *end_of_stack(const struct task_struct *p)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	return (unsigned long *)((unsigned long)task_thread_info(p) + THREAD_SIZE) - 1;
-- 
2.34.1

