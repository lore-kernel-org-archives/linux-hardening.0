Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A315ECCC;
	Sat, 20 Dec 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766212915; cv=none; b=uqij0RlxdmV+2ib1tKtRdXoiMVdnFMIvxJbJ+gzE2JcYdqICeRp7+zBQ86RFjs8GKbeYe2Mt/xOAGDfqoocRHoF2FZvJLg640sx0as4xH7pY3yc1uV4mOhCUqFrG5gwa3D++MOz8MlRFFYtH1XyyRbnK7OkwmzkbZWtPdZK/osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766212915; c=relaxed/simple;
	bh=0cYM1OGkisWER17OI/JlqgHBJhvaSLpBwGWv79i5mOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BZ4PodzudSygnEfcm96nHYrVWeNkhHLLmPrD7iyAitgYjFg/YEDyS/yXTjOKSRhCANhhwk1qRQCcr8It3f22j0XpOCpvU+XSY9PQaBIsyhqZx64Zh3IHgV49kmjs1KD+wrQQxoDTFf+WpclgYEMq7erF4Bw5/vzpFPJ47LDXsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Q8HXfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Q8HXfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579CBC4CEF5;
	Sat, 20 Dec 2025 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766212915;
	bh=0cYM1OGkisWER17OI/JlqgHBJhvaSLpBwGWv79i5mOY=;
	h=Date:From:To:Cc:Subject:From;
	b=R6Q8HXfTaM1mxlpJVIInwBxbjdVI3LZKbiEc4Y9Ka11Ok7k0FSQjGLVXkZLaWWm+s
	 EJlfpPDnsCIxsbC9wWD/yEQ0Y0X9XSLmF1DcJ9PW/auxENjIieuwt1xXSH6pigyefK
	 h1PYhZcRXnUPfEK2PxEjlUgbNIX9di3ZTDq1uRF+aO2rBOF0DNPLJuy3Colf+piyjB
	 NChFEH7uIp9NFUIESMXvrAzhIkh+wi2E6QPq9xzfkvUt/z1jaUHQFAEKSJku1puAv/
	 eq3stnViZdZrpWZ11mjaZZ1dWzZsYhKG7RRlke9BqHJhVW986sYBEUjlhn4UNmrSFI
	 IGv4/SkPwBD0w==
Date: Sat, 20 Dec 2025 15:41:49 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Raag Jadav <raag.jadav@intel.com>, Tomas Winkler <tomasw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
Message-ID: <aUZFLezigzZQVt55@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the UBSAN: array-index-out-of-bounds issue below by updating
counter nvm->nregions before the first access to flexible-array
member nvm->regions[].

from kernel bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=220823

Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15

Notice that this flexible array is annotated with the counted_by()
attribute, hence the counter must always be updated before the
first access to the array.

Cc: stable@vger.kernel.org
Fixes: ceb5ab3cb646 ("mtd: add driver for intel graphics non-volatile memory device")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-hardening/90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/devices/mtd_intel_dg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index 2bab30dcd35f..d3e89fe324b8 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -768,6 +768,9 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	if (!nvm)
 		return -ENOMEM;
 
+	/* Update nvm->nregions before first access to nvm->regions[] below. */
+	nvm->nregions = nregions;
+
 	kref_init(&nvm->refcnt);
 	mutex_init(&nvm->lock);
 
-- 
2.43.0

