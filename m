Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164D1EA7DD;
	Sat, 26 Jul 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753565181; cv=none; b=MACTXu6vb2E6cZOMThYUdc3pALCNKCRwAHIXDlFTL7EG5dV6cju3b7ytTg3HkNIUtFSAfFnnf4Eau6gRL+T+acXWRW+ED5RHtkLur6evHGFzp5gd5Yz6qaNsX7P80spGzYhjpnTGHSzzSUtU6mg4XTNErE05wzwDWNSgVFfcLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753565181; c=relaxed/simple;
	bh=HRz6MADk8kXtX6zMCSuX7+PnJXnqXQTbzRUgSFNYQvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wx5zr7ekG6VMVL5kPLgvJRG+v0QkrKleqHYzRHP6vqO1P6cp6rSxdICm8K5kK0F0YuzWPoVXTvp98Rtj01RRI3KONNjJYnPE5txzUTVxn/ATcVooQdAZvd1Hmwr1325xGZQLfw8KuE3sQQGwWAmz6sujtGh0m46r3FQWsC/JUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG9z91ie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG9z91ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C35FC4CEED;
	Sat, 26 Jul 2025 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753565181;
	bh=HRz6MADk8kXtX6zMCSuX7+PnJXnqXQTbzRUgSFNYQvw=;
	h=From:To:Cc:Subject:Date:From;
	b=iG9z91ie9sWabPgWYlrkqgHmJAQSuqsfVUhuHsS24znfhvkKHOm7qG+XXyZn5vDMF
	 bXAn+YPOQSBraGWhMoe+lguIqQ5aXIVK8pgqHR4YASUkpITN/o2Vg3Z5uPjZUgg+W/
	 1mjuqKwSyvS6ziu9Hi9yCGZWCh4QCiQc13PYF5WU1J1hE21HWqeX3NMbp4BLjxpgEg
	 qQqrcTKBqfny+9Mk4I0bb9vJx5bbBNPVKYeYQEQMGT0jB6LKg3y9xnlYfw0LBW0uUc
	 UwQbtuiuEN29uZE9pT3FSt/pU3ZHnj1aKO09WS9Iv/v4mGL3UEoE28PU7bkNMH57JS
	 YqhwmT/2I58Eg==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Coiby Xu <coxu@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kstack_erase: Add -mgeneral-regs-only to silence Clang warnings
Date: Sat, 26 Jul 2025 14:26:19 -0700
Message-Id: <20250726212615.work.800-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=kees@kernel.org; h=from:subject:message-id; bh=HRz6MADk8kXtX6zMCSuX7+PnJXnqXQTbzRUgSFNYQvw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmt7r/jV86NNzhpZHvJVklCdorujTmbP27n4tCpefQmT HuTuShbRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESENBj+Wf1i3XXoJveJbXeV HFgbov7HHL3qG/Xi2TITPzG3Ip2jzIwMS5oM1t06NiP73WYxo85jn0J5A1hrn8n8NblewZ6l/Ua ZGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Once CONFIG_KSTACK_ERASE is enabled with Clang on i386, the build warns:

  kernel/kstack_erase.c:168:2: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]

Add -mgeneral-regs-only for the kstack_erase handler, to make Clang feel
better (it is effectively a no-op flag for the kernel). No binary
changes encountered.

Build & boot tested with Clang 21 on x86_64, and i386.
Build tested with GCC 14.2.0 on x86_64, i386, arm64, and arm.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20250726004313.GA3650901@ax162
Signed-off-by: Kees Cook <kees@kernel.org>
---
 kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index e4f01f1d4d0c..0ee9afd8b7cf 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
+CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
 KASAN_SANITIZE_kstack_erase.o := n
 KCSAN_SANITIZE_kstack_erase.o := n
-- 
2.34.1

