Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77B39281D;
	Mon, 10 Aug 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369534; cv=none; b=FwjcAtvl4JybNTG/dp318XYN8gPxdDoPpg7IWrvbexoQY1ecEhL44L+O1HyTsyakhdNqZL4Y0BioLpAWZ/IKXzfbKltui17BUDjL6VeuKtnP9Tlg8boNpBSvjaVPNoSnFH8nDW+el1ZL9upurn4EgMR/Tq/3xRJaXJM8OeJ2yx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369534; c=relaxed/simple;
	bh=ZVC9hqwNLYXhTu7K3JcH4RET0yoqZoR939Fl0i+siRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzjp5S5QrMJJM9AKXIZYuRW0AMWQHSzfY8XFgmYXwzcR7a4PEP+aMSLR8tP8o44oNd7YDt0UGXJib81ffaKmXlVRe3esFMGY7Hmb0cCtcV9oeGMoQyf/vk2vxWKwE7+sus/iQJ2y0vjXXKzKv1K8oGtS83EFyN1elbJE48MALVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M5TJQhDa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M5TJQhDa"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B537C40E029F;
	Mon, 10 Aug 2026 13:45:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1ayom8aGKanv; Mon, 10 Aug 2026 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786369515; bh=5gskXmXFQax6RkQ9XQrDZ6g7ObBgi9GrbHp5Ul4Fa4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5TJQhDa4pYw7N+V4bwclBils9xRXhycFyRgy53FwVwXjpnc0Sa313xMPvjZ0Sq0n
	 sNAbhBlb+kx6NeYM9k2vIWYzGBtp0bmIujN6d10p45kEh9SSm5RqQBW7/6OzmhYYvQ
	 Qi1VHo+FqvcSARrk3UqeYdzzKGbW/pYJJDf//pbvNV82cyXE2GhfZTnDviKxRjE3Zy
	 fTyVMgdB1JcFG4tM+XDEY1VevqKrXFa2IeRqU6Qoe2zimUpVrYii/nI3eZpZhpKMjl
	 SxqJNgRA1cHSvdAfQNfONqUpfB6Sri+LPe2Ep0eYfSDCPCMyNnR978Y+Zz98CpgzSp
	 aXW+EF2Oh1XrqOVAJ6uY72dOf/y0/+Mp/7mKXVZymwXWas7sAxFCT1hMqvNwcQd2WP
	 Lk1Yu4z190FFOxDVeZslRkqt+6eraYt/L7oeXapzq6TEgkiPS/qyy7MswdS13lnHIq
	 1RlgKzjlyrmfXgebR9vCuLE4cYe+QSeNOIUu11GSPU/3KXD7n/7GTxVWm7fo0ZnlvA
	 ZqdWof7dKLWsbVMtaijY4AL1PUz5ltOZw0yZCjqjdm2O1pCTvOM0HKIi+hALPA5tS8
	 VyYoooroPiYmpfdWmV2RzYLWNCmO3dlWqxoQir7OWy8UhOLbcAhkd6JM7dEtilO1oD
	 HIjoM77Aeh2zz3LAylT31WLI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42CD640E019C;
	Mon, 10 Aug 2026 13:45:09 +0000 (UTC)
Date: Mon, 10 Aug 2026 06:45:06 -0700
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rric@kernel.org>
Cc: Ian Bridges <icb@fastmail.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <20260810134506.GAannV4uJN0I1UXh0q@fat_crate.local>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
 <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
 <annRsN6UBDPsFLr2@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <annRsN6UBDPsFLr2@rric.localdomain>

On Mon, Aug 10, 2026 at 03:27:12PM +0200, Robert Richter wrote:
> However, the driver has several issues. I asked Marvell a while ago to
> take over maintainership, but never got a response. I don't have
> hardware to test changes. If you mean to mark the driver obsolete, I
> am good with it. On the other hand, the issues found may not actually
> trigger and only affect a single system. If we can live with it, we
> could leave it as is.

I am sorting out stuff which needs maintaining from obsolete gunk, which is not
used anymore and which doesn't need any maintenance effort or no one cares for
it anymore and there's no point to waste precious resources for.

So I'm going to do this but we can always revert it if someone shows interest.

---
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Mon Aug 10 06:40:13 2026 -0700

    EDAC/thunderx: Orphan it
    
    Robert doesn't have hardware to test patches anymore and no one else has
    shown interest in maintaining this driver, so orphan it, for now at
    least.
    
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

diff --git a/MAINTAINERS b/MAINTAINERS
index d413dac5c8b3..671515d21bfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9308,9 +9308,8 @@ S:	Maintained
 F:	drivers/edac/octeon_edac*
 
 EDAC-CAVIUM THUNDERX
-M:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
-S:	Odd Fixes
+S:	Orphan
 F:	drivers/edac/thunderx_edac*
 
 EDAC-CORE

---

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
