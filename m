Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67440846F;
	Fri, 13 Dec 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734055781; cv=none; b=oCPE4LSFcFJtCxRmgaBI9C5yyjMsFvtqwiZIoPEAQSEX6j0RkK+8P5ukY8atIzICVv6lpTO+OHQTp2ur9euFArxPbcYhiSLHqoyoVjWdfht9QtJCeJK0IKWZnlvnG0DKPbHqTHSLhPieq2D7qFe+LPf4dLXMI6bptyRd4pF6Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734055781; c=relaxed/simple;
	bh=Np3GnoNjjRYHNMfs4ajAm6/M35qHq8wB6mRPx06qig8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eR5ZBJn8DeHZ285YvrYg7bqqLdViIWnrhPZc6oC+ERXd6QJLH2aYoSvDTeCdVwR1Gej1dNkHq8qJSZKUklifl1ryGefVVn+Jua+9Rn877WXCOpNo9667f3wJMXjswGEuL5NE9K0B0O+12PPp6p+S0JyJ34r2c3GRx77kA3MHflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkOPoXTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkOPoXTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5602C4CECE;
	Fri, 13 Dec 2024 02:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734055781;
	bh=Np3GnoNjjRYHNMfs4ajAm6/M35qHq8wB6mRPx06qig8=;
	h=From:To:Cc:Subject:Date:From;
	b=EkOPoXTiOH+lSEh1RK4mRrb6GsB3lVZA9LPd/XWhh+XKK1AJ59QfdC5NlHdtLjvKH
	 +9+18f7TuiUUFDPDFth8v/sIZtGAodUqZNOr3IEuFA/9rooNAS37MXNs/4GHfCM9eM
	 NUHKPLNEokl8sEGR0WgsbTbI+o+6SGLaJrNnOxvLhPlW2oJUfXKrwVkAACEVfmUUKm
	 oP7uQRf7mIxLmn+4/spVBYGY9edDwEExX0bl0jp3OeOCtofOI8gRAU7ef4GsamxOF1
	 IGzaHc651BcHlUli9/AkrNg2mWwkPY3+pgGl+BmaBcTrAkjC28r7jbl7loYTiGVI34
	 LZ39hE2ZAx7bw==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Qing Zhao" <qing.zhao@oracle.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Hide run-time copy size from value range tracking
Date: Thu, 12 Dec 2024 18:09:33 -0800
Message-Id: <20241213020929.work.498-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6060; i=kees@kernel.org; h=from:subject:message-id; bh=Np3GnoNjjRYHNMfs4ajAm6/M35qHq8wB6mRPx06qig8=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnR02NmbxateHynujTJ/MZ7Xf6dJ6+l9a5Xkpx9qeDel rDGB1HxHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOJPcfIsGzrAv5rjifzVtg+ aJgxy/n8uy23v2+TuuzbExj2o/v6nJkMv9k1yta6ml4/6brybuGyXa8n7nvM1HAt3zKgZorYd5d PggwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC performs value range tracking for variables as a way to provide better
diagnostics. One place this is regularly seen is with warnings associated
with bounds-checking, e.g. -Wstringop-overflow, -Wstringop-overread,
-Warray-bounds, etc. In order to keep the signal-to-noise ratio high,
warnings aren't emitted when a value range spans the entire value range
representable by a given variable. For example:

	unsigned int len;
	char dst[8];
	...
	memcpy(dst, src, len);

If len's value is unknown, it has the full "unsigned int" range of [0,
UINT_MAX], and bounds checks against memcpy() will be ignored. However,
when a code path has been able to narrow the range:

	if (len > 16)
		return;
	memcpy(dst, src, len);

Then a range will be updated for the execution path. Above, len is now
[0, 16], so we might see a -Wstringop-overflow warning like:

	error: '__builtin_memcpy' writing between 9 and 16 bytes from to region of size 8 [-Werror=stringop-overflow]

When building with CONFIG_FORTIFY_SOURCE, the run-time bounds checking
can appear to narrow value ranges for lengths for memcpy(), depending on
how the compile constructs the execution paths during optimization
passes, due to the checks on the size. For example:

	if (p_size_field != SIZE_MAX &&
	    p_size != p_size_field && p_size_field < size)

As intentionally designed, these checks only affect the kernel warnings
emitted at run-time and do not block the potentially overflowing memcpy(),
so GCC thinks it needs to produce a warning about the resulting value
range that might be reaching the memcpy().

We have seen this manifest a few times now, with the most recent being
with cpumasks:

In function ‘bitmap_copy’,
    inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
    inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
  633 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
kernel/padata.c: In function ‘__padata_set_cpumasks’:
kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
  713 |                                  cpumask_var_t pcpumask,
      |                                  ~~~~~~~~~~~~~~^~~~~~~~

This warning is _not_ emitted when CONFIG_FORTIFY_SOURCE is disabled,
and with the recent -fdiagnostics-details we can confirm the origin of
the warning is due to the FORTIFY range checking:

../include/linux/bitmap.h:259:17: note: in expansion of macro 'memcpy'
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
  '__padata_set_cpumasks': events 1-2
../include/linux/fortify-string.h:613:36:
  612 |         if (p_size_field != SIZE_MAX &&
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  613 |             p_size != p_size_field && p_size_field < size)
      |             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
      |                                    |
      |                                    (1) when the condition is evaluated to false
      |                                    (2) when the condition is evaluated to true
  '__padata_set_cpumasks': event 3
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
      |                                 |
      |                                 (3) out of array bounds here

(Note that this warning started appearing since bitmap functions were
recently marked __always_inline, which allowed GCC to gain visibility
into the variables as they passed through the FORTIFY implementation.)

In order to silence this false positive but keep deterministic
compile-time warnings intact, hide the length variable from GCC with
OPTIMIZE_HIDE_VAR() before calling the builtin memcpy.

Reported-by: "Thomas Weißschuh" <linux@weissschuh.net>
Closes: https://lore.kernel.org/all/db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de/
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/all/20241112124127.1666300-1-nilay@linux.ibm.com/
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Qing Zhao" <qing.zhao@oracle.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/fortify-string.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 0d99bf11d260..cab419f3a05f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -630,7 +630,16 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 		  __fortify_size,					\
 		  "field \"" #p "\" at " FILE_LINE,			\
 		  __p_size_field);					\
-	__underlying_##op(p, q, __fortify_size);			\
+	if (__builtin_constant_p(__fortify_size)) {			\
+		/* Pass through compile-time value for real warnings. */\
+		__underlying_##op(p, q, __fortify_size);		\
+	} else {							\
+		/* Hide the run-time size from compile-time value */	\
+		/* range tracking to silence false positives. */	\
+		size_t ___fortify_size = __fortify_size;		\
+		OPTIMIZER_HIDE_VAR(___fortify_size);			\
+		__underlying_##op(p, q, ___fortify_size);		\
+	}								\
 })
 
 /*
-- 
2.34.1

