Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E510367B70;
	Sat, 19 Sep 2026 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779586; cv=none; b=k9Ao67mnWN6F872g8x9THDDGzg4MS4Xy05214B1+RpON/K7Dd5T7zgrCTRl2dvVEoq9agzgjMgNcv988hXoytnN1NfMx4IKopCiqDDcmP2UuhHhpJVkJvSaQWKXqIehyTrANAAjepDf+eElT8gnqRh2Qx8GgwelNc5ib2zXu4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779586; c=relaxed/simple;
	bh=OZ3W41pyrtXtWI9HWP2dt/yAb3x3ZpsbjEdKh4841xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDOfrn40swPHVbCBfNPMpuKBSIDac1I4v3njvO8mfyUJe8kAlJ4NfmgDHPWgvv2pqTnd2BH2sQdXEEk4iR+p97/D/1UsGuN1Qdqbcf6KsexzhBzQBbdQV+ss6rer6MnFhDxqX0zf7M5tvy1lJaBeZxoZD6GjBhAaosHzf7D8nOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnUHvEnp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnUHvEnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058021F00898;
	Sat, 19 Sep 2026 00:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779570;
	bh=emF9e08gzUL5NWN8mDK4wqe/eAr3Kz7Fj16r5RkCjvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnUHvEnp8vhrJ6m8DP+2ST+hB2LPGgRTPz5cOB6Fmue0dchWWDvz+Q0ze4MXdwINC
	 izlE4rDex6C3YsZ00hfzbionjOtb5hDiH8N5dEFESLUyT+3qXvqKjlKaagp4phcIuR
	 bJhGhiWB7nuCMfwnHKnOvMhPubO63WjRyYSmg9FsaeUmvLjIZ3KXkwmaywbkFhnv/o
	 ApP7r60EzR4g5ttAECtqPrOzFWJrni5IpXT98sAD2ifgte+/Rp62x+t4cbO3c1Fole
	 f7YBCmVGVXYyu++eRoNgsSzOFDS3+qs/cakC6TVAkgP4KoWl/6vwk554+2J6icdOnr
	 4KeXaYhvSkHIQ==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kbuild@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	Graham Roff <grahamr@qti.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] kconfig: Replace "cc-option-bit" with "cc-option-str"
Date: Fri, 18 Sep 2026 17:59:26 -0700
Message-Id: <20260919005929.4077729-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919005923.i.879-kees@kernel.org>
References: <20260919005923.i.879-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=kees@kernel.org; h=from:subject; bh=OZ3W41pyrtXtWI9HWP2dt/yAb3x3ZpsbjEdKh4841xI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlr7+WfL+1d9fy/ZoW5Y89T1fPMj/kTenr2L2eZeUwjf 4Ie87VnHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABN5fZSR4dMR49cPKnbZn4oP M74z35439/AvmY1XU8Mjt/fpnTDqZWf4p2f77fER30D38LnFuUoR4rPVeq8ubjV+MjNPQsvPOe4 sHwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

$(cc-option-bit) returns the flag it was given when the compiler accepts
it, and an empty string otherwise. It was originally only used
internally for machine bit flags, but it is generally useful[1].

Rename it to $(cc-option-str), which says what it returns rather than
what it was first used for, and extract the probe logic from the existing
$(cc-option) macro to reuse it. Additionally add support for an optional
fallback, much like the Kbuild cc-option macro. This can be used as:

	config CC_OPT_FOO
		def_string "$(cc-option-str,-fnew-option,-fold-option)"

If the fallback is omitted, it is just an empty string.

Build tested ARCH=x86_64 defconfig with GCC 16.2.0.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
Cc: <linux-kbuild@vger.kernel.org>
---
 scripts/Kconfig.include | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index fc10671c297c..4ef2b64e97be 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -23,9 +23,19 @@ success = $(if-success,$(1),y,n)
 # Return n if <command> exits with 0, y otherwise
 failure = $(if-success,$(1),n,y)
 
+# $(cc-probe,<flag>)
+# The command $(cc-option) and $(cc-option-str) test <flag> with. Not meant
+# to be called directly; use one of those two instead.
+cc-probe = trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o
+
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
-cc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
+cc-option = $(success,$(cc-probe,$(1)))
+
+# $(cc-option-str,<flag>[,<fallback>])
+# Return <flag> if the compiler supports it, <fallback> otherwise.
+# <fallback> defaults to an empty string and is returned untested.
+cc-option-str = $(if-success,$(cc-probe,$(1)),$(1),$(2))
 
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
@@ -61,9 +71,8 @@ ld-version := $(shell,set -- $(ld-info) && echo $2)
 # machine bit flags
 #  $(m32-flag): -m32 if the compiler supports it, or an empty string otherwise.
 #  $(m64-flag): -m64 if the compiler supports it, or an empty string otherwise.
-cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
-m32-flag := $(cc-option-bit,-m32)
-m64-flag := $(cc-option-bit,-m64)
+m32-flag := $(cc-option-str,-m32)
+m64-flag := $(cc-option-str,-m64)
 
 # Test whether the compiler can link userspace applications
 cc_can_link_user = $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(1))
-- 
2.34.1

