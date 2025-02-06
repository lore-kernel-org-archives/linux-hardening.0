Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E37199385;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865494; cv=none; b=f6CpW+kRsjh5B/0g31EIbPNmdt7KICwDi129Q9UCYMpuEvAQFZAPMi+P7CvNTpDh7coOqJJGMCkkxl3q+UU31Dfm+jz/e5iEZ6yby+xmYP26S9UBsPlMnN8KpipnGaLw1vYwdvZBfc1Rg+hsSoF6CNuUbINCksGVXzmSMWrQRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865494; c=relaxed/simple;
	bh=91NW6YxsPuJbVe3TMPcFmsEh91512TgV/JV4nGsNPQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/LCcoibXkxk9ozMDeFuAh+kBrTlwJduJ/arQ/p5QrHXDlsZOub3AbGuzf1Hs85QNAazp591qXshXhHzkWB2ngUKj0w7Q7ezsrSpRyGuKxaLjij/zubT1837h+1lketRIXXV6iu7WI1FbMjympOOLF9fFdztW5wHoSntENDx4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDZXDJqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDZXDJqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC5CC4CEDF;
	Thu,  6 Feb 2025 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738865493;
	bh=91NW6YxsPuJbVe3TMPcFmsEh91512TgV/JV4nGsNPQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDZXDJqdsiDEJH8nm7vStlfBSE3tLcw1hTN9zCDU2AEJ3daWpqpW6QQghoNoTXpOX
	 yllVXQ8dOIgBNnghe4QIyuxkLOMKJD3m1blrO6J9PustNQfsN8uoTvOpm7AIV8aB/4
	 le7CAM7Po49M0BhZwdvOKqAI9vm2igVYZIp3GhL2FVwZZofYu0k2dCdYVEXri5zIk8
	 azL90kGmmxKh+CBiMx8722jlCFT3HAVoL+itkrWIZRyh47Y45enPm0uJ+t1hfUk8VI
	 XqIHYfG7LzajYpHkjoH3MIdmrza2lIQcitMsuIVRW2Y6fcAugnNdCGNerJFxcWZ5kL
	 MJ3IY6jO/OWPg==
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	nathan@kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 3/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
Date: Thu,  6 Feb 2025 10:11:30 -0800
Message-Id: <20250206181133.3450635-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206175216.work.225-kees@kernel.org>
References: <20250206175216.work.225-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185; i=kees@kernel.org; h=from:subject; bh=91NW6YxsPuJbVe3TMPcFmsEh91512TgV/JV4nGsNPQE=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLfge+aZ34u+olw66rrsfm/uO9Xzn7NduNMEE+sT2KW QwnPz6u6ChlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjInScM/6OPFn86LvD4iOxz C9aqBccCbsyo+NJZGfloi7B6hVp1YgojwwWR/JO3r/fkM97+N3PunTWZS8vOml75sfhMYWDA8Vl KR9gA
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
index 493ac4862c77..01ac26be274d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -411,7 +411,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * must be discoverable by the compiler.
  */
 #define strtomem_pad(dest, src, pad)	do {				\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_char_array(dest) +		\
+				ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 									\
 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
@@ -434,7 +435,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * must be discoverable by the compiler.
  */
 #define strtomem(dest, src)	do {					\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_char_array(dest) +		\
+				ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 									\
 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
@@ -453,7 +455,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * Note that sizes of @dest and @src must be known at compile-time.
  */
 #define memtostr(dest, src)	do {					\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_char_array(dest) +		\
+				ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 	const size_t _src_chars = strnlen(src, _src_len);		\
 	const size_t _copy_len = min(_dest_len - 1, _src_chars);	\
@@ -478,7 +481,8 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  * Note that sizes of @dest and @src must be known at compile-time.
  */
 #define memtostr_pad(dest, src)		do {				\
-	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _dest_len = __must_be_char_array(dest) +		\
+				ARRAY_SIZE(dest);			\
 	const size_t _src_len = __builtin_object_size(src, 1);		\
 	const size_t _src_chars = strnlen(src, _src_len);		\
 	const size_t _copy_len = min(_dest_len - 1, _src_chars);	\
-- 
2.34.1

