Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D241BBBE5
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355101; cv=none; b=YeW6PmL3uB4T+TRlf/DxXuptnpu0FFq+MSnMic7Q8CICiUuq/418dhiwhvkkQEQwavjcwH3VetYqzQpasTn5VVmSUQOqpF5TjtV6wiqaTsJnz3pfQSV7vBOJ7MFWj8paliGSfHjolHH4HldVQzvbmsJn5bA4Iw2AJFiaKb+U/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355101; c=relaxed/simple;
	bh=PhE0zHyhBPpXrP8vj024jFThH76fT2vGmRe0f5Rv87M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U9DIsCwqgIKfchGlLHbJEBgm/wvdoHsaLvfIV5Ta2CXBcl5Be0D5uJQYkuoylnG+K/+2OUbdszRDS/+4KwDhlCPlpsCYNLfKonKLHFSM24QNsaCMNbD92ZxKhIANkiOeW0/Ljl/XBWDb6m3eDjr/5yWiCXn0J2TVCvy7N+9/+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:520d:93ad:ff6d:335e])
	by xavier.telenet-ops.be with bizsmtp
	id tryD2C00F30Ayot01ryDmm; Tue, 30 Jul 2024 17:58:17 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYpEU-004BRd-Ki;
	Tue, 30 Jul 2024 17:58:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYpEr-00EdEl-L7;
	Tue, 30 Jul 2024 17:58:13 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Chris Down <chris@chrisdown.name>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
Date: Tue, 30 Jul 2024 17:58:12 +0200
Message-Id: <ae4d951d022e6c34b87ae46e15f1522f8d6d3480.1722355024.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With -Werror:

    In function ‘r100_cp_init_microcode’,
	inlined from ‘r100_cp_init’ at drivers/gpu/drm/radeon/r100.c:1136:7:
    include/linux/printk.h:465:44: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
      465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
	  |                                            ^
    include/linux/printk.h:437:17: note: in definition of macro ‘printk_index_wrap’
      437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
	  |                 ^~~~~~~
    include/linux/printk.h:508:9: note: in expansion of macro ‘printk’
      508 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
	  |         ^~~~~~
    drivers/gpu/drm/radeon/r100.c:1062:17: note: in expansion of macro ‘pr_err’
     1062 |                 pr_err("radeon_cp: Failed to load firmware \"%s\"\n", fw_name);
	  |                 ^~~~~~

Fix this by converting the if/else if/... construct into a proper
switch() statement with a default to handle the error case.

As a bonus, the generated code is ca. 100 bytes smaller (with gcc 11.4.0
targeting arm32).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/gpu/drm/radeon/r100.c | 70 ++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 0b1e19345f43a771..bfd42e3e161e984f 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1016,45 +1016,65 @@ static int r100_cp_init_microcode(struct radeon_device *rdev)
 
 	DRM_DEBUG_KMS("\n");
 
-	if ((rdev->family == CHIP_R100) || (rdev->family == CHIP_RV100) ||
-	    (rdev->family == CHIP_RV200) || (rdev->family == CHIP_RS100) ||
-	    (rdev->family == CHIP_RS200)) {
+	switch (rdev->family) {
+	case CHIP_R100:
+	case CHIP_RV100:
+	case CHIP_RV200:
+	case CHIP_RS100:
+	case CHIP_RS200:
 		DRM_INFO("Loading R100 Microcode\n");
 		fw_name = FIRMWARE_R100;
-	} else if ((rdev->family == CHIP_R200) ||
-		   (rdev->family == CHIP_RV250) ||
-		   (rdev->family == CHIP_RV280) ||
-		   (rdev->family == CHIP_RS300)) {
+		break;
+
+	case CHIP_R200:
+	case CHIP_RV250:
+	case CHIP_RV280:
+	case CHIP_RS300:
 		DRM_INFO("Loading R200 Microcode\n");
 		fw_name = FIRMWARE_R200;
-	} else if ((rdev->family == CHIP_R300) ||
-		   (rdev->family == CHIP_R350) ||
-		   (rdev->family == CHIP_RV350) ||
-		   (rdev->family == CHIP_RV380) ||
-		   (rdev->family == CHIP_RS400) ||
-		   (rdev->family == CHIP_RS480)) {
+		break;
+
+	case CHIP_R300:
+	case CHIP_R350:
+	case CHIP_RV350:
+	case CHIP_RV380:
+	case CHIP_RS400:
+	case CHIP_RS480:
 		DRM_INFO("Loading R300 Microcode\n");
 		fw_name = FIRMWARE_R300;
-	} else if ((rdev->family == CHIP_R420) ||
-		   (rdev->family == CHIP_R423) ||
-		   (rdev->family == CHIP_RV410)) {
+		break;
+
+	case CHIP_R420:
+	case CHIP_R423:
+	case CHIP_RV410:
 		DRM_INFO("Loading R400 Microcode\n");
 		fw_name = FIRMWARE_R420;
-	} else if ((rdev->family == CHIP_RS690) ||
-		   (rdev->family == CHIP_RS740)) {
+		break;
+
+	case CHIP_RS690:
+	case CHIP_RS740:
 		DRM_INFO("Loading RS690/RS740 Microcode\n");
 		fw_name = FIRMWARE_RS690;
-	} else if (rdev->family == CHIP_RS600) {
+		break;
+
+	case CHIP_RS600:
 		DRM_INFO("Loading RS600 Microcode\n");
 		fw_name = FIRMWARE_RS600;
-	} else if ((rdev->family == CHIP_RV515) ||
-		   (rdev->family == CHIP_R520) ||
-		   (rdev->family == CHIP_RV530) ||
-		   (rdev->family == CHIP_R580) ||
-		   (rdev->family == CHIP_RV560) ||
-		   (rdev->family == CHIP_RV570)) {
+		break;
+
+	case CHIP_RV515:
+	case CHIP_R520:
+	case CHIP_RV530:
+	case CHIP_R580:
+	case CHIP_RV560:
+	case CHIP_RV570:
 		DRM_INFO("Loading R500 Microcode\n");
 		fw_name = FIRMWARE_R520;
+		break;
+
+	default:
+		DRM_ERROR("Unsupported Radeon family %u\n", rdev->family);
+		return -EINVAL;
 	}
 
 	err = request_firmware(&rdev->me_fw, fw_name, rdev->dev);
-- 
2.34.1

