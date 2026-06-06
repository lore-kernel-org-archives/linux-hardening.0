Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05DA3C0601;
	Sat,  6 Jun 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777646; cv=none; b=BLR/egh4XmgnyPphTRKahx09EgmbEM6RWnhpJIVEO51bnMLFvx4mi2cBOYI1ozObwhURXwlyTlBgmf7Mk50mqMgRm+po7eA7m/o42CGiU+SUXM7fui5fVwmxkTVCfbaILwsoDLTcHtWR9mVJTWib67+sPE/+0tFlKUoXDfdxifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777646; c=relaxed/simple;
	bh=YCwmdKe9zBDHIe8pFrWTPxrgd4M/HJQefntqkfhtnSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4p5HednHM4A+ANa5gD3+dSteQdCq3sjIZEwc6vw/XzYd6tRKF0PKq2pZ7lSxh7kPOYjM3kiri0cIbMmOrdX7uTzafppsn987WEjEqKOLh+gFNj642HL0Ii2W4VIIPsiq1fRCXoXVEoXx7IQKcViWes7Pyq5JxTvyySJKi/5IGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=UIq6fZeo; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="UIq6fZeo"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbr-007cFj-AM; Sat, 06 Jun 2026 22:27:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=4pWp8S0rBZBAXNgYdQYMTOum2xiqondSMGkfre6z5fw=; b=UIq6fZ
	eodnklewWCRvYBt0Z9wyicfjFIobKNRGxMqBQlLlMHLLtXFdAn4JuA+AFuDW91I5tIdwm7WJvdDIf
	V3RSI39WKsiHeMuWGSiuMfAdNsc/vPMkagOS7011b9yENpQb3BJsdBthrtGXe++S55qXQLNZm6U0z
	HRcpJUfUElrqJK8FC2+/HBsN5f+47TGe+jgvCP5UaBsTJpXt9ETBMhaO52EsV5nxBn3etjplKybKp
	+GWuadIZPX3SF7LEudc/ur7qwXryaUp+IZzPJZOW9kJxjdYetGQjSqvltkY8E66DAMprP/cytig1E
	IRs9+UE+L42PuUl6AZ/gTsguyPUA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-0005CD-KE; Sat, 06 Jun 2026 22:27:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbo-006V18-08;
	Sat, 06 Jun 2026 22:27:08 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/gpu/drm/tests/drm_dp_mst_helper_test: Use strscpy() to copy the test description
Date: Sat,  6 Jun 2026 21:26:30 +0100
Message-Id: <20260606202633.5018-36-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The buffer length is known to be KUNIT_PARAM_DESC_SIZE

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/gpu/drm/tests/drm_dp_mst_helper_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
index 9e0e2fb65944..6d2be903d17e 100644
--- a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
@@ -552,7 +552,7 @@ static void drm_test_dp_mst_sideband_msg_req_decode(struct kunit *test)
 static void
 drm_dp_mst_sideband_msg_req_desc(const struct drm_dp_mst_sideband_msg_req_test *t, char *desc)
 {
-	strcpy(desc, t->desc);
+	strscpy(desc, t->desc, KUNIT_PARAM_DESC_SIZE);
 }
 
 KUNIT_ARRAY_PARAM(drm_dp_mst_sideband_msg_req, drm_dp_mst_sideband_msg_req_cases,
-- 
2.39.5

