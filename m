Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB162153D2;
	Wed, 16 Apr 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824030; cv=none; b=LrJ5xADgyEyU+9YKK2mFZ0DL2b9bNY3VYrEMwT5DzN351QtAUR3It0juqJUOg3ptyPmEo7Z56FvfLHS8Qp7qu5RGvM/dECtEJWGbnLSTz7sjmMqi4s4cbAIdNsOe/fsx+gv1Lx+r1GQujGgjaVsjqusIivp5QsvHZJ1gOdwxntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824030; c=relaxed/simple;
	bh=JkQc01G33utQwTTvGf9JQj+ZoRf8sigUW1uHVbU6Vn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6hCEX9BgP/3q14qC9h/CJ8qQqZEH74Yx4xYn8gsjRT30K3BbJdyiEcvTxtAcpfF5qWW7cmZ7yU+NFY5LoZYYbvRvH8coxr9QvWkJ3LeyYDjzQuvMcftvsEAIeZ7BNopMaZEIMIvbxFa4XdLkOok+JK16riyamWJYIZFPA+tQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUW5oIFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUW5oIFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A06C4CEE2;
	Wed, 16 Apr 2025 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744824029;
	bh=JkQc01G33utQwTTvGf9JQj+ZoRf8sigUW1uHVbU6Vn4=;
	h=From:To:Cc:Subject:Date:From;
	b=DUW5oIFLQ2+UIcz2mNwofou4olw/+wEiiJBU+/45omnMiI7oAonFkbCWM/ZxpGs1k
	 3gm9iFmSbokM5Vn5owAVVm+WI4iNZUgjZfDaoAn7mVdtD4DdZ1Uj57YwFfJhnVDnZH
	 BR9Dg4AqvVCRSc+f2Gj1CjkfFWh/y4dhAQLUcxyyFyXMHXGNIWJzi028GY4vhdrUFD
	 ZuZENRxRePAKHWW1vlmbQ96pTx4FXMS8TDtoRGbH/7/RG6EFQZForp1hIt+lHHPmG6
	 PP0YUgxFL6FnyM/OurA+AKk9SKBFUyG9w6z7ppK4mcgeOvy8q4icZhBsR9M5QqTmU7
	 mLDoySUL8UH8A==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	llvm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] compiler_types: Identify compiler versions for __builtin_dynamic_object_size
Date: Wed, 16 Apr 2025 10:20:20 -0700
Message-Id: <20250416172016.work.154-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=kees@kernel.org; h=from:subject:message-id; bh=JkQc01G33utQwTTvGf9JQj+ZoRf8sigUW1uHVbU6Vn4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/n11JnzfvUAGPv2hUUV/MOqVYCe/ofc/msN+12nHx2 3udNr+CjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl8287wP38j8/ZjzyMe5275 dFCO/6/D3lWxMY9rAjhXhd9Xl5x8U42RYePZesaqFs7euAXKQvd2pjWZF9WuDwg5lfm68V/Dsek HeAE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clarify when __builtin_dynamic_object_size() is available. All our
supported Clang versions support it. GCC 12 and later support it. Link
to documentation for both.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: llvm@lists.linux.dev
---
 include/linux/compiler_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 501cffddc2f4..20881cc761fa 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -449,6 +449,11 @@ struct ftrace_likely_data {
 /*
  * When the size of an allocated object is needed, use the best available
  * mechanism to find it. (For cases where sizeof() cannot be used.)
+ *
+ * Optional: only supported since gcc >= 12
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html
+ * clang: https://clang.llvm.org/docs/LanguageExtensions.html#evaluating-object-size
  */
 #if __has_builtin(__builtin_dynamic_object_size)
 #define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
-- 
2.34.1

