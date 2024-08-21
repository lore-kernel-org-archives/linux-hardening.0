Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD95227;
	Wed, 21 Aug 2024 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724201460; cv=none; b=tCLMGcHvHHefItIhjqTbAFTRov/LJ7Ear/GuGpNT7PBH+YfBJlylgpOkzRy0hYEUZrgiJkGwvJ40V8pH4SSZ0hU/+TXbEoxuvNiW7WclhvZVxKFsRp5NTSqjkv6SHXmQD4VzI0j4MKv6jELlD9HGBg23HzOHDZtbiK6kZGYjtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724201460; c=relaxed/simple;
	bh=MMIPR++xC4Kxl0qx3QpEQFYibLJHZ0WBuJz0u9FG8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s0hGOUrRI5M0cE4ITdcc+Q/CRgAKdDgw2DAPfdBhebBpCwFNbK3SkZVcxMtZpDK0fNt103aWLTs3BcS7bGYiRbJByunL2nI6WdKLVAcd1Dj5VUg0IRCEMlHxJJQVi0ek5dKtYVYfMh2fHvZHyjo3gHI2BHPVelRJgT5uytIRR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGDaaMoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGDaaMoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72621C4AF12;
	Wed, 21 Aug 2024 00:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724201460;
	bh=MMIPR++xC4Kxl0qx3QpEQFYibLJHZ0WBuJz0u9FG8Ls=;
	h=Date:From:To:Cc:Subject:From;
	b=YGDaaMoBOcm195MUxo0J1sIHd3EI71AAyN4+WATK/dt4PTYWPWfVin3mMWBBp2dOf
	 vs/EMEUcopSmQQa2zLhzHID4prfpVvaR4QX5UyyiUQsU8pGvEv3tXXUw76dp+lQbj0
	 Q4fgMBqaFgD910RPClrfYLxCdBlTwyO/uwNb/aWWywPpimUQ6EGqeF4WGynK15UXUu
	 D4lSfQc+TVvfq4/YtNCSmha97fuWqE48x+LhvDYxMVHnDekjiDx2MC85kdCu52RIPm
	 RRBhVJO9X8R6MyFy6Q5oD6Zn1PGJX1Y4ARijGhafpemw57SG0/mOSHnysYCC7vc2wb
	 aEbX0FZ3RiIoQ==
Date: Tue, 20 Aug 2024 18:50:56 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] xen/pci: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <ZsU58MvoYEEqBHZl@elsanto>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with this, fix the following warning:

drivers/xen/pci.c:48:55: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/xen/pci.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 72d4e3f193af..a2facd8f7e51 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -44,15 +44,11 @@ static int xen_add_device(struct device *dev)
 	}
 #endif
 	if (pci_seg_supported) {
-		struct {
-			struct physdev_pci_device_add add;
-			uint32_t pxm;
-		} add_ext = {
-			.add.seg = pci_domain_nr(pci_dev->bus),
-			.add.bus = pci_dev->bus->number,
-			.add.devfn = pci_dev->devfn
-		};
-		struct physdev_pci_device_add *add = &add_ext.add;
+		DEFINE_RAW_FLEX(struct physdev_pci_device_add, add, optarr, 1);
+
+		add->seg = pci_domain_nr(pci_dev->bus);
+		add->bus = pci_dev->bus->number;
+		add->devfn = pci_dev->devfn;
 
 #ifdef CONFIG_ACPI
 		acpi_handle handle;
-- 
2.34.1

