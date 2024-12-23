Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC051B4F17;
	Mon, 23 Dec 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970873; cv=none; b=g5s44LvHGejBIkgfAxxiy1kMmzAZaTLIUa4zC1pIPIEjtaDiqHBpFeHJ2KPDcAOFonqe4O/2irvLkNg3/5eQa6T20NRMckZHCB8Equ64Hs2LpH+Jv3wR83YPlFtJT2uW2em/vXeVE4AOq87Xyxjo2pSM9G4ojm/nj+LqL0d0+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970873; c=relaxed/simple;
	bh=jt24JKjEW5Ctr5ZnYI8+K8/4xkVmTpnr9xMlhLEhomQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oxE/wonJjOGiLWlvAaYDjo4AsoXqf4sLpCUlyfx7f6kOeFzDcuu7NVcWLLHBt45NIriLkP6wwhAQ96gbzhiC7IMWLuh8J7lRE4CHagWf/UjxL0/kV72tvfpf+Qc6yfXQLfu9nmdlFjO196kjYvKD0CFnc7DhlkdAE8C75FC8LRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=oFCLbqr9; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="oFCLbqr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=protonmail3; t=1734970863; x=1735230063;
	bh=akUmr6bOc+fOEizuHMtWgqa48aPdr3+dMVwuE/0mScA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=oFCLbqr9g9+kYm/ypdy6ge5KsZFsBMbilXsEOYPmrnEQrrMf0GF2+H4praGOc5Adq
	 +HGnjKtYFT5Z/kEt00aRVBhBYbkmoNPoecL8XnwSSwBC/QiNH0mnvxKohIRFx2HT3m
	 Dto1akoMjsXdHdbrSivAd0NtCDqSTLwLqdeh80h0msQvOwx7eHvj/ZvhE5TFf8eM4J
	 ql7FckkUEdbKv+MVsb9Nrz7wFVgamO1gQM0v+SOZJZjBhPp4GKotMmfuqG1tpsoa6v
	 NnFxEypOeGneUly5vgdoGAiS/+nXIZ587tqmugORQCkoaVepCjqYDcDoiGcf3SRd57
	 BQFPdqc5EfmOg==
Date: Mon, 23 Dec 2024 16:20:59 +0000
To: "rafael@kernel.org" <rafael@kernel.org>
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal/debugfs: change kzalloc to kcalloc
Message-ID: <LD_0bVRqzr2SEjrmrDHAWn0PurFdkgxZD6QS2zowUh5uqA7or1pd88vdA5wyXbTx1Z6dfZzt7pq6xfQ1EnvD4fIt26nWG5-zGEmNLhIcXTE=@ethancedwards.com>
Feedback-ID: 28410670:user:proton
X-Pm-Message-ID: ef2dd8441b364721ef05f54745cd160004b2625f
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Use 2-factor multiplication argument form kcalloc() instead
of instead of the deprecated kzalloc() [1].

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded=
-arithmetic-in-allocator-arguments
Link: https://github.com/KSPP/linux/issues/162

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/thermal/thermal_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_de=
bugfs.c
index c800504c3cfe..29dc1431a252 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device *t=
z)

        tz_dbg->tz =3D tz;

-       tz_dbg->trips_crossed =3D kzalloc(sizeof(int) * tz->num_trips, GFP_=
KERNEL);
+       tz_dbg->trips_crossed =3D kcalloc(z->num_trips, sizeof(int), GFP_KE=
RNEL);
        if (!tz_dbg->trips_crossed) {
                thermal_debugfs_remove_id(thermal_dbg);
                return;
--
2.47.1

