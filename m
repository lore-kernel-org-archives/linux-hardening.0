Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAD3815DD;
	Sat, 19 Sep 2026 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779585; cv=none; b=JUGy89MZirQPOvWZVC/3Wv+t0PrF2JSSGLDiOZCrVb585YptRQnESglEDBvwThR3DnBC6wcp5i8UzSwSiHT1MRB0XIFCkNPzQep6q5JKjAimzoSY8iETUeEPwONeEqyS08vdPvC6a9XpZ8RJQgR7/iM4JuXhVU2Crxw+B3Z66NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779585; c=relaxed/simple;
	bh=Eh+8luPv21YxI7DAQtntr/JfTWUjAFJVdKNxbEq5zS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRlQ/JnMcPea1vpjrFY6h0dKlO0CqEaJz1u0rFXvnPQxxG+8jrnyyYYVTf1P8VCo/F1FXrQMpAEPGT+MPGEOCVVRYTOSBf/i4u0WtPHScJS/mYyz59Vp5L2HvIMOiITQJrt9vxhek7Uzh69YlYR45865k2cnuSbmVJr2jbXF5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTHkqHfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTHkqHfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F01F0089A;
	Sat, 19 Sep 2026 00:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779570;
	bh=AjKQzaUxoyCT/42m/TXQZ2kS/JUrVXnxomuyGbrtELs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTHkqHfXfLH0EaLGd+4f0khJ2KqYT4CEj75kEIUTUVKgnqQdeEUF4vLjjwLXalH2a
	 bFYZzeg5NhMBT+dUWK5UxlHevZk1+vYBv8Olk53m/GUCRKYqXjHtga4Hajmpyx2M4V
	 2IXL9nLuWLxALkn3+HTwFrVyjl6xX13wUghUldEAfzOZvygFuPOIby5UYUp9HXo+oi
	 I/k71i9pdKnKqJuUVRODeX+g2T91R+KgzzAF2XcuP70tPMR08ZO2Jo/Uf28wGje21m
	 R8HEwflJrG7SRD+9kxunowIkLJzyxr0ms1tAcAQRLZJSEv6Nkq02rNcFiFoc6ptndT
	 mPp+r8tDpn0zQ==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Matthew Maurer <mmaurer@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Gary Guo <gary@garyguo.net>,
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
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] kconfig: Add "ld-option-str"
Date: Fri, 18 Sep 2026 17:59:27 -0700
Message-Id: <20260919005929.4077729-3-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=kees@kernel.org; h=from:subject; bh=Eh+8luPv21YxI7DAQtntr/JfTWUjAFJVdKNxbEq5zS0=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlr7+XvurE0cn7//S8b28s5Hki1Ji1NuWeY837n08iMh imX9cSndJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkbDcjw1Ymno9MR8/NjpU8 yfXxLcPyRdu5l8pxGi9eZtYQ+e+u+DNGhpevKnO/6lq9Sis3fJF5b+/UH81XwzRZU9RV/adXp4Y fZwMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add the linker counterpart to $(cc-option-str), sharing a $(ld-probe)
with $(ld-option) the way the compiler macros share $(cc-probe). Like
$(cc-option-str), it can now be used as:

	config LD_OPT_FOO
		def_string "$(ld-option-str,--new-option,--old-option)"

An omitted fallback expands to the empty string.

Build tested ARCH=x86_64 defconfig with GCC 16.2.0, and checked against
GNU ld 2.47.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
Cc: Gary Guo <gary@garyguo.net>
Cc: <linux-kbuild@vger.kernel.org>
---
 scripts/Kconfig.include | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 4ef2b64e97be..622d21e6953f 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -37,9 +37,19 @@ cc-option = $(success,$(cc-probe,$(1)))
 # <fallback> defaults to an empty string and is returned untested.
 cc-option-str = $(if-success,$(cc-probe,$(1)),$(1),$(2))
 
+# $(ld-probe,<flag>)
+# The command $(ld-option) and $(ld-option-str) test <flag> with. Not meant
+# to be called directly; use one of those two instead.
+ld-probe = $(LD) -v $(1)
+
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
-ld-option = $(success,$(LD) -v $(1))
+ld-option = $(success,$(ld-probe,$(1)))
+
+# $(ld-option-str,<flag>[,<fallback>])
+# Return <flag> if the linker supports it, <fallback> otherwise.
+# <fallback> defaults to an empty string and is returned untested.
+ld-option-str = $(if-success,$(ld-probe,$(1)),$(1),$(2))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-- 
2.34.1

