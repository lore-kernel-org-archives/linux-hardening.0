Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450922D781D;
	Mon, 11 Aug 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918847; cv=none; b=uJHUvYc7yZeYG0xfO7ndMe5EjJVN1FZ5lde9BUQ00zS0rFgdmMeNXcoliB14jc5SN+8++x7y/zGlrloXnEXLGN8oW79pHwNHjA65ptaCSf7TJqxypu+gYL6nNxplbGOGlM4EzhjZXwCzokGgseaYiQR+/meBR6P8+TZ0e2r6tOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918847; c=relaxed/simple;
	bh=aqJESQduy9tFCdv0UBjs2PmEVls0xlloVCuMQby/UDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ll8Rwr/DKBWYIfjUbNYGFCJwjTzwYYK+htM8Bo4qkjeQBZ1u1qvOUJ4+saAy91+mbdf5UVvkN55fVVHQWtfqxC5J1BPZRDeHIf0qFSisBOaAVf7+ui478ByEF4iuDQxDZrA4PWAe4BSr2fZhBNR20m2MgmkPhP/UwCRur+X6fZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOpd6ZsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOpd6ZsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CE5C4CEED;
	Mon, 11 Aug 2025 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754918846;
	bh=aqJESQduy9tFCdv0UBjs2PmEVls0xlloVCuMQby/UDQ=;
	h=Date:From:To:Cc:Subject:From;
	b=YOpd6ZsLSICIvr5+1smLKQZJdvJAq23T44dQd03V8TpUuoyYzoqP2K9b/P7GQjwHc
	 25u9vfGxh+7lg5Wg1tFmaxxJ9s089744fZgZ7qJXgCJ64Plh4jelJAVgUMWAy0yR9s
	 n6+l+XuyMNQE4FgW4z7uzoNgKhCF9FICDWrWAo0cmRGy5p3clOi2tesWM45jcGaupb
	 OOAVbVozSmv4fzNi1rclNiQwKnyH7AeHs908V9FsmOOO8yGBsXjvxnMX+Y+GXsG490
	 H1+phv9C3KRGoOSOBaz3yGhqp36v1/1BEXfgulKqdRKMahdxxs/QJ1fE7t1E6iUI19
	 a5aEV2/tPIO3A==
Date: Mon, 11 Aug 2025 22:27:22 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] platform/chrome: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aJnvuv334M7TljoB@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix the following warning:

drivers/platform/chrome/cros_ec.c:106:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use the new TRAILING_OVERLAP() helper instead of DEFINE_RAW_FLEX().

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-apE0ZmckBjRDyx@kspp/

 drivers/platform/chrome/cros_ec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fd58781a2fb7..b1730362e399 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -102,14 +102,13 @@ EXPORT_SYMBOL(cros_ec_irq_thread);
 static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 {
 	int ret;
-	struct {
-		struct cros_ec_command msg;
+	TRAILING_OVERLAP(struct cros_ec_command, msg, data,
 		union {
 			struct ec_params_host_sleep_event req0;
 			struct ec_params_host_sleep_event_v1 req1;
 			struct ec_response_host_sleep_event_v1 resp1;
 		} u;
-	} __packed buf;
+	) __packed buf;
 
 	memset(&buf, 0, sizeof(buf));
 
-- 
2.43.0

