Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9E3AA1B6;
	Mon,  8 Jun 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912533; cv=none; b=c820nuAZbXQ1PbSs30/2gEOPkSYmcmlONrHcRQsQO//CuNIEQ7Wi0Qfcpzo89yOW9IDVDys7vcx8WrSiAjIEIJfk663LvVp26xX2yaQDqt79o2fOycLrpLiIgcTpNMrEC121EzJ3Sj+voFdM5Z+brJ+3XLTmnnM+Ju+NUwRarGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912533; c=relaxed/simple;
	bh=UiNGrVKKN6VUg30qkVNpjkkSp+hYDONhcrBbgyJXMSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bgshr1Hi/BmjhX7GtCUxwnT+Ja/5JvyE/Mcd5Vryv0Eyd85hRb/uES0nJD2ClWphHQb5Ho7T+cQHgjwR0RTSDpB2c4NUiTV9HHLiGMrtbEBB+PEgqrmfZ/DRKIUl2eWjnyOvd5+cImfXNcc4sZ09IAuME5xIxF9k3uIXSJk7LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=OMDJJPlv; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="OMDJJPlv"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhV-00BRuV-CW; Mon, 08 Jun 2026 11:55:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=WCh9uWNF9SibsB1K3v1cueJAJRBgOsBn5WEx6kVnxVU=; b=OMDJJP
	lvEcPge/2kBbAyfRc91Th6yl1NgRVEnMnJnYvk+H3mnbaPy3+grj91QQ18fzZuIxCJPxlcgraRJ/5
	R7Z2hkMSi0Qm31781jON14mqwVvrz2uiDGPdsn71BT8ubr2TpPoIITicmXUVMsCrWHPob43UEd0GS
	qg80HDOuJlEIk5I355mR4oiH2MI0jTFVRkTlH0Qn4nApJ9uw1q+kSaDR5RfGF/0C1Ivxdy4pimlNj
	o3it2Db4efe91ZOSp+9CSuCMhbM3LeGVs3gQLBqHnPxtTA+rUxPzowISepvrwgHuSgLzFoRnq6JB5
	8bTUIep+H73HyNVhC3sdeWGc09bw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhP-0003ZG-R1; Mon, 08 Jun 2026 11:55:15 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhE-00Afz8-Nj;
	Mon, 08 Jun 2026 11:55:04 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/bus/fsl-mc: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:56 +0100
Message-Id: <20260608095500.2567-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures than overflow of the target
buffer cannot happen.

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

 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 221146e4860b..372175fe169c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -903,7 +903,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
-	strcpy(endpoint1.type, mc_dev->obj_desc.type);
+	strscpy(endpoint1.type, mc_dev->obj_desc.type);
 	endpoint1.id = mc_dev->obj_desc.id;
 	endpoint1.if_id = if_id;
 
@@ -920,7 +920,7 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 		return ERR_PTR(err);
 	}
 
-	strcpy(endpoint_desc.type, endpoint2.type);
+	strscpy(endpoint_desc.type, endpoint2.type);
 	endpoint_desc.id = endpoint2.id;
 	endpoint = fsl_mc_device_lookup(&endpoint_desc, mc_bus_dev);
 	if (endpoint)
-- 
2.39.5

