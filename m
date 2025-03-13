Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B091E8329;
	Thu, 13 Mar 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905375; cv=none; b=bVlAujhKjHyCO/T0B1M1Dhjmxh6jLQSoPZ29ueuuzLbUwF6gwtsHLXtLKS/akmuHJuarDcBa0SvnqPPSQt3qG91c5wV8jo/jLqFNaoJz/bhFlSFrR0PBMNdzWkh9W2mh7CGVajY3kMbMEc/oUN7WQ6sj9ATWdk69gZOEkuGzTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905375; c=relaxed/simple;
	bh=n9Zkp4Na7wGSapRz2c+7Y16OW2pKFPO4q6AzB9VW2lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sGt4uw3wWqf7TnfQPOBsziC3sQfQ2K9zKy3PlT2F7WFTiuwuiUakokmoKf4Nwmgzy0AIGzAtcijEvMuXuPIYuxkw/k4h1ffRWrO1KFKzTyo3Aer8gkbreHt20dC+eOpF0VpfX+h+FkAPzi9jTVrMty+J9gODZ89Ty1HN6uhHXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJYMAVQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJYMAVQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDFCC4CEDD;
	Thu, 13 Mar 2025 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741905374;
	bh=n9Zkp4Na7wGSapRz2c+7Y16OW2pKFPO4q6AzB9VW2lQ=;
	h=Date:From:To:Cc:Subject:From;
	b=FJYMAVQJvITpEpLjR4CSGgLFXA7ZzRH/kcx/faiFArhXUlNw7GBf7L1bX7vXc/FD/
	 sqT9RQNHKQj/ovnidiYACIGAdfgp2rWvS2k2nPrjGsIlK/u8m45uzgsmAt7XOezhZ2
	 q7PM/LmSZIkOIVhkJixcWeEw0NxPg9zlLqHMY3hhri19x3IlD8Ng9//Tw+277z5bXt
	 gUR5G5/0EdlLsICYSSv7J31oLG46fz8Wf5jINI3q0CnIcYuYfYEcEmURqltaolxn5d
	 i/JhOPjA2ZY2J3zLsns0iCtJ4DgqQRTuMFBxZZ8ywFjNsJe3I6q3HAle05TstHGsvo
	 vNqwFOpcgRmug==
Date: Fri, 14 Mar 2025 09:06:16 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] misc: bcm-vk: avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z9Nd4AmgrQDiK1Gn@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the following warning by removing unused flex-array member
`data` in `struct bcm_vk_peer_log`:

drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/bcm-vk/bcm_vk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 386884c2a263..9344c2366a4b 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -311,7 +311,6 @@ struct bcm_vk_peer_log {
 	u32 wr_idx;
 	u32 buf_size;
 	u32 mask;
-	char data[];
 };
 
 /* max buf size allowed */
-- 
2.43.0

