Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14251DA5F;
	Thu, 29 May 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542723; cv=none; b=u1u6alhHtze5GOeXWQDUEXZYNdI8nvx4kv1hFzrt7eKQNIndrRpk1CS1YdD86L3S2USD36phP+IPm+0AamhoVsFNOtlpjxsZUoeCbExckO+xyetj3HjDlR7HffAW57QaKyehrGS3BVdHRbqh8ejubtQhhKt/fDYTyyUhv8Sw3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542723; c=relaxed/simple;
	bh=ESVRc0/V8iZYcObbnzBJGUVQAxbYbamjKdKKM7L9Qyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ai0SyCzXsYm8VpRvmdthAY7yBUG/S8+am5WuQ58boJqpHYferkaDHeiNCtzc99IOxps4090fLjU5Nv61oXQelE6kgxCCcPOOMKdaNcM0HB+13uiAFuTgh8psCJuFQ/a4cUnBXndkX424zxlFrGLj+9gB/M18tyySW2epwr78crE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8ir0CSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8ir0CSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDA0C4CEE7;
	Thu, 29 May 2025 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748542722;
	bh=ESVRc0/V8iZYcObbnzBJGUVQAxbYbamjKdKKM7L9Qyg=;
	h=From:To:Cc:Subject:Date:From;
	b=n8ir0CSEmy6bIGSbyNxD10QqoifIt1Gqxh7Gsx2sy29RycjNVgQot7RAjiXILql+h
	 dgvd3gNc9TJf6pTq8octJa1POiGhfYajEyzjhrsMBHLXpHXtIoJBUByaqH95IoA3sS
	 EyZJyaTpFbZXD1ojb1hGLKR7D5M77siOx1ly8NIQ8pWwvWRt1WjFDwblhTUmE1sGtN
	 QY6yvGjvx3zb6QE8DWyrRSxkDqrBgmdXrZpgA1hK8UyusKrIfJLqof9ti/aC/yq5sx
	 FIqUjXo7nAGgj2QHGvX2YTaq51rZIok/ptXhcWl68upja5/c/fN/FiW5Yl7/bSdd8n
	 Mul12ddO5PGGg==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches
Date: Thu, 29 May 2025 11:18:37 -0700
Message-Id: <20250529181831.work.439-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=kees@kernel.org; h=from:subject:message-id; bh=ESVRc0/V8iZYcObbnzBJGUVQAxbYbamjKdKKM7L9Qyg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkWS/58TEh4pBSa6nHtuPec9MuRK25fyY4P+XTViv338 0xjo+xHHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOJ/cbI0JccesCqUu3Ypa/R Br3Paj58//nziGb4e+HbWjV8AdFXNjL8s+58tDZzdrCh+byfG1ZvVTScrpfy4f2Dginpt+aJKW7 byw4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless the
__no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions[1], we have
to handle differences in how GCC's inline optimizations get resolved.
For thinkpad_acpi routines, this means forcing two functions to be
inline with __always_inline.

Link: https://lore.kernel.org/lkml/20250523043935.2009972-11-kees@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
This is split out of https://lore.kernel.org/lkml/20250523043935.2009972-4-kees@kernel.org/
at Ilpo's request.
---
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: <ibm-acpi-devel@lists.sourceforge.net>
Cc: <platform-driver-x86@vger.kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 657625dd60a0..dc1fc069fed9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -558,12 +558,12 @@ static unsigned long __init tpacpi_check_quirks(
 	return 0;
 }
 
-static inline bool __pure __init tpacpi_is_lenovo(void)
+static __always_inline bool __pure __init tpacpi_is_lenovo(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
 }
 
-static inline bool __pure __init tpacpi_is_ibm(void)
+static __always_inline bool __pure __init tpacpi_is_ibm(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
 }
-- 
2.34.1

