Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2D222591;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878016; cv=none; b=Hr4YVckvtB/mXKryM8QJFdy6VXTdbTWCObQ6FDN2JP/2C1MzAIlnFBNOUiExLQq1whgiWhIaHcm45yMnXVckHPK7Qp8r9ndkvg+AMisG5LC4zvm9WudaBCLTPCL9jI7TN99Guv/LVe1Dsg7wjQblahUbJC+1I6gYYf1PTogEQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878016; c=relaxed/simple;
	bh=78wBv+9G2VAp0kLDdXBV3e2olGRXqyDiAENcay93QmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxB2+V8TwvZ3inRZHXFFJI3+zXEnWNLFIliIKjifB140lqG8J8UxDRi4q9w1XefT0ZLcKUPhT6JQTVNruEir3Tobj/gjP26rSkMhfWqB9ug5k/809ybOmFpo+yHw3VmOJSbpqlPflB1GHMw7sfG0mbYhmjnFnhzi7RXqSRVRm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCapocjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCapocjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BBCC4CEE3;
	Thu,  6 Feb 2025 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878015;
	bh=78wBv+9G2VAp0kLDdXBV3e2olGRXqyDiAENcay93QmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCapocjTUW0bLcHO2dxCdYtT6Z5+Pur7RgkZsr3gc8oAaEGJ1bZN3BjXnxie1hsDK
	 6wbUTZ9XvHW8x0sXB4pOkQ8n8/sZY3IexkItUEjG6INHw9As1cOLjGgAJE33eKoQvc
	 XDGW+WFFc9FTEy3bz1OOGSRHm2vCHDNJJv4vyDw0xBP2rEOHEXw+MBO3e14H4AyGuz
	 akrcsu8dsHSO8CNs0HsOKQS8rqdFR18jiF90Sx15OABMkMoGUmUGLGDqAu3FR34pSe
	 UJfFhaKe0mobCzLSTqQHMJ+gtNuUHliCmQxPcD/9SVeslzv76dR7XLv91jLfqPU1HY
	 rhETZRVJa8A/A==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	nathan@kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
Date: Thu,  6 Feb 2025 13:40:08 -0800
Message-Id: <20250206214014.3567372-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206213532.it.087-kees@kernel.org>
References: <20250206213532.it.087-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189; i=kees@kernel.org; h=from:subject; bh=78wBv+9G2VAp0kLDdXBV3e2olGRXqyDiAENcay93QmU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLdczDhVbMnVuqFL2Dt6BbP+XT96rm3cqmL++vePTY/ b71OmHXjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImoTGT4p2u2cdrvRo27Igaz u49fd/godPb4vzlbSnef1yhhdymfoMzwT/mA8HM31qubcm5JxPW9ONYj931z1lXTyfN6FKc71/S xMAIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The destination argument of memtostr*() and strtomem*() must be a
fixed-size char array at compile time, so there is no need to use
__builtin_object_size() (which is useful for when an argument is
either a pointer or unknown). Instead use ARRAY_SIZE(), which has the
benefit of working around a bug in Clang (fixed[1] in 15+) that got
__builtin_object_size() wrong sometimes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501310832.kiAeOt2z-lkp@intel.com/
Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
Link: https://github.com/llvm/llvm-project/commit/d8e0a6d5e9dd2311641f9a8a5d2bf90829951ddc [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: nathan@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/string.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 493ac4862c77..fc5ae145bd78 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -411,7 +411,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * must be discoverable by the compiler.
  */
 #define strtomem_pad(dest, src, pad)	do {				\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_byte_array(dest) +		\
+				 ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 									\
 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
@@ -434,7 +435,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * must be discoverable by the compiler.
  */
 #define strtomem(dest, src)	do {					\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_byte_array(dest) +		\
+				 ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 									\
 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
@@ -453,7 +455,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * Note that sizes of @dest and @src must be known at compile-time.
  */
 #define memtostr(dest, src)	do {					\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_byte_array(dest) +		\
+				 ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 	const size_t _src_chars = strnlen(src, _src_len);		\
 	const size_t _copy_len = min(_dest_len - 1, _src_chars);	\
@@ -478,7 +481,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * Note that sizes of @dest and @src must be known at compile-time.
  */
 #define memtostr_pad(dest, src)		do {				\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_byte_array(dest) +		\
+				 ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 	const size_t _src_chars = strnlen(src, _src_len);		\
 	const size_t _copy_len = min(_dest_len - 1, _src_chars);	\
-- 
2.34.1

