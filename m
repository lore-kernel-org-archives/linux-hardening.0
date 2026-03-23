Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DE3C73E5;
	Mon, 23 Mar 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286696; cv=none; b=NPsMmv6LGhTIW+/9LU2mVHVAuW5NDc0kaiYwmlUs3J72Vb9bMr3ZfWiawxGyBNZmXwdvwY08vAW2N6qN55fg/T8PLGTKLU0CO375MMhnP6JQYVL548KV4VewrWOwLGNO01I0+/y+bF+90c6TTBYnb/ENJqaWpIeZUTmRFg6wWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286696; c=relaxed/simple;
	bh=xYKa5g2CWUevgDPo8Y0Ncl5z1xFaGsm0/Xv0Zy+doaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hb3VHHh2Rf54CTWIgLQTi078tLFGy3yPhBTEHHZN8WaGpOd/i81triUAYenwe1BBOUxQ98EdSYJdTjFLQ+1XopjSEAHucZuZHYiIsOvd3DFcjJlmejHiciTR0giJHmfEknU3rgnYs6q5goRRCHbh57+5hOoYohsdAhYtdft2s7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4fjlTG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4fjlTG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32A2C4CEF7;
	Mon, 23 Mar 2026 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286696;
	bh=xYKa5g2CWUevgDPo8Y0Ncl5z1xFaGsm0/Xv0Zy+doaI=;
	h=From:To:Cc:Subject:Date:From;
	b=l4fjlTG91uwOHiRBXMGOV3uwdJlj3VuttXHew/8wiaoYOa0psMrKSido/AIUtFxrc
	 a1gvgjMjvqVdlNgdBFpRgq8JDF34Y7+XNs4HuCIciSbRv4fe67t34Jag1As+NqG2iQ
	 jjGd4aFLmMfxK/5BlmLqBKdVW24IhKdFnGBIX2z962e7GV0djdfnj47j+Q1WXmckZZ
	 07ehNjXi6X2xxPcB6ryJpKLvfhNl0rxcXd8sS1Xt6m9D0s1nA3fuweXIjYhyNApyEc
	 DKidNnQ0k4pteL+LsmuiSCmmo9B7p9tNylvNRGlFiD/lS4QIytiS3e0s07gjLN0HSs
	 Ku7QyLdhHdfYA==
From: Kees Cook <kees@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ACPICA: Replace strncpy() with strscpy_pad() in acpi_ut_safe_strncpy()
Date: Mon, 23 Mar 2026 10:24:52 -0700
Message-Id: <20260323172451.work.079-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=kees@kernel.org; h=from:subject:message-id; bh=xYKa5g2CWUevgDPo8Y0Ncl5z1xFaGsm0/Xv0Zy+doaI=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkHy1M+XHo0cdXHJ9//lxY5uj7uEtB87X8s8GfbOZcsY 7d+3Y22HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNZ8JKR4Xrovo55EXyh9n/4 pk4xefk9X8jOlv/1/icSp8PTdyftf83wT6cl/NNsr6zn/nUTXscvkkwRLdR65B3LWitXePXNifR b7AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] strncpy() with strscpy_pad() in
acpi_ut_safe_strncpy().

The function is a "safe strncpy" wrapper that does
strncpy(dest, source, dest_size) followed by manual NUL-termination
at dest[dest_size - 1]. strscpy_pad() is a direct replacement: it
NUL-terminates, zero-pads the remainder, and the manual termination
is no longer needed.

All callers pass NUL-terminated source strings (C string literals,
__FILE__ via ACPI_MODULE_NAME, or user-provided filenames that have
already been validated). The destinations are fixed-size char arrays
in ACPICA internal structures (allocation->module, aml_op_name,
acpi_gbl_db_debug_filename), all consumed as C strings.

No behavioral change: strscpy_pad() produces identical output to
strncpy() + manual NUL-termination for NUL-terminated sources that
are shorter than dest_size. For sources longer than dest_size,
strncpy() wrote dest_size non-NUL bytes then the manual termination
overwrote the last byte with NUL; strscpy_pad() writes dest_size-1
bytes plus NUL: same result.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
This touches the ACPICA component shared with the upstream ACPICA
project (https://github.com/acpica/acpica), where the function
is named AcpiUtSafeStrncpy(). The upstream codebase uses its own
platform abstraction layer (acenv.h/acgcc.h) where I've mapped various
kernel APIs before like ACPI_FLEX_ARRAY and similar helpers. However,
acpi_ut_safe_strncpy() is an explicit function implementation rather
than a macro mapping, so the approach for upstreaming this change to
ACPICA is not clear. What's the best way to land this?

(This is one of the last users of strncpy in the kernel.)
---
 drivers/acpi/acpica/utnonansi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..3a7952be6545 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */
 
-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
+	strscpy_pad(dest, source, dest_size);
 }
 
 #endif
-- 
2.34.1

