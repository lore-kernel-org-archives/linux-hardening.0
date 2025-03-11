Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1C1EA7FD;
	Tue, 11 Mar 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680066; cv=none; b=oZo2qNEXRJIkI6K9Oc6nYs1Fzn5TKi5cyxfRMpJ3K/ldaVBwSl4Oy2/7RqF4gXpmiDV+BCPuztt2acNFlFJezZHpZizcFXMJpsN8nX73acZTcYEijEbw2jNOvN0+4gRQXqVPYoc/pO1iVGD5pI1HndcQPGS/H/KqkGPxN5+Ky4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680066; c=relaxed/simple;
	bh=uOV+CWp+20AHudZCinrMTZ1yMO6OJAaqMkrODzBxlQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CBCzBMSlL5bX7hpDEQrEiqMvHFz72+FZHkDlPq/iL3QPIvH+HpIk1zn+gzyjl1cdRfzrjzHP+wz/FYDPGNIbITOWK0NQ2MhQiTnwwyu8jK1r0Kl5pG+vOBKXPu73cHH+61mO3bFZSuQL2USy3/QmpzbhtjOteJaFR9BvwFlbo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3rV8rEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3rV8rEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AD2C4CEEA;
	Tue, 11 Mar 2025 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680066;
	bh=uOV+CWp+20AHudZCinrMTZ1yMO6OJAaqMkrODzBxlQg=;
	h=Date:From:To:Cc:Subject:From;
	b=h3rV8rEy688baN0gU9vGVCLciHL0sAkPsOKeXz+ZFtm6x8vChdVkX8XfaLQVRXeDw
	 wKTOGLj02VlcVvW/OwObsToYRC12/UiYV4smo9X2sdLgcF+LD8p3Hm94Gtg9St4zvf
	 X+7XNnxxkPC+c2kpPVgmvi/jGCbhK5zojwMpym7Ry2TfcUSpfkhL3F6uo7EwjBbMiz
	 E4A22qFv9B25HI6t5MUyXfV+MsPhbBgQIVHbRvnBLyiaphG4b4N+veak9/HvC6Mm34
	 XPL+VnLbWpFNSDR/LzxOpf2sRAng09mNpzm1QsDwAPJIkxZh/tzjaiKFpR0Bjrg0wg
	 O2TZDWBwvnWaw==
Date: Tue, 11 Mar 2025 18:31:05 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Scott Branden <scott.branden@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC] misc: bcm-vk: avoid -Wflex-array-member-not-at-end warning
Message-ID: <Z8_twT77rSIK-S_-@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I'm trying to fix the following warning:

drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

after a quick look, I don't see any code directly using the flexible
array `data[]`, so this patch should probably suffice:

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 386884c2a263..9344c2366a4b 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -311,7 +311,6 @@ struct bcm_vk_peer_log {
        u32 wr_idx;
        u32 buf_size;
        u32 mask;
-       char data[];
 };

What do you think?

Thanks
--
Gustavo
