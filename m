Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A14E73D7;
	Fri, 18 Sep 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733345; cv=none; b=qfGM5vyZkOMWFex1w9SuIIKIsLJMubko1dxrGM8+GfnpQyus2m95GM/lKszn1qN4WQ0PWHi/8so4KrSlcIfuZk+UAcqF3YW1pnqXVpsDuagQfupipWhvWrxkKF/jmzx34Dvkd+jGR83AlGxILXHFLFEynccGXt4onfwNfD9T14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733345; c=relaxed/simple;
	bh=AuGGcs2DZDBo46I7ZfUCMBaHbY6VLc3FrWgL5mw3y6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMqa9pP/1CZvyIwOgur9F2xh4/6Jc9k+3oqWZpC+WZ1bZo9MxkfjR+DNGIijQPeubFg4SJjiUFb5Ry7guSuCN4r/YZDgq/pgXhIG9iFpb5IrZCeLdjYnBNwsen4IDZxJMPvFZekAjXzLNqsoKEXLX8rjIZjJ/Eu7LU891r7hBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+wqVm/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+wqVm/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868711F000FF;
	Fri, 18 Sep 2026 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789733343;
	bh=AqydT2a07F6CNIzT2/wSQmW267CmztIRsGov5rxbY2E=;
	h=From:To:Cc:Subject:Date;
	b=W+wqVm/eAtvb9DCToCnAlyzUiwjWzj5z/khmbzRI58rFlU8XUloqodDmEAprefx/n
	 Pl43LS+bVyJxERtdcMwuzmnHT31iBsdNJPhFmlBcBQU3n5LbawB2RMKIeV5KnjiblT
	 cWqevlvxjBVmcQOijQLIxIlxtLMMDnpa3cnLnM0Sf7Kd5Fu+cTXFs0ZqQzQ6vLFMG3
	 O6bCDk2//OqQQ2es0DgeryuBULVr3vkTmjf+/QZeRfb6mvjrP4tqKP/DFbPCW0EOh+
	 L2Tv+gX/GzKLfxANF/UBTMYYBR8VNWwzlF2UV1vKwkpU0GarEp39coGYmnvw/MXxR+
	 +j0WBoCiz7mNA==
From: Thorsten Blum <blum@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/setup: Annotate pci_setup_rom::romdata with __counted_by()
Date: Fri, 18 Sep 2026 14:08:39 +0200
Message-ID: <20260918120841.26125-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=blum@kernel.org; h=from:subject; bh=AuGGcs2DZDBo46I7ZfUCMBaHbY6VLc3FrWgL5mw3y6w=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlrNU8KOXXuVdK4VxPpp3Xx1aEAf77VRpUFfBGnuppf9 E+ZkFvfUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABNhvszI8Nxv7s+cEt4GWxuZ K0sKDjGoMf1ansXxT6/2gcp6AYbGdEaGBdnPHk/+sK9cdvlM+/dhCzb0PTM+vUGGYWP2oZJlfuY BbAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add __counted_by() to pci_setup_rom::romdata to enable access bounds
checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/x86/include/asm/setup_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/setup_data.h b/arch/x86/include/asm/setup_data.h
index 7bb16f843c93..36ca725182f9 100644
--- a/arch/x86/include/asm/setup_data.h
+++ b/arch/x86/include/asm/setup_data.h
@@ -15,7 +15,7 @@ struct pci_setup_rom {
 	unsigned long bus;
 	unsigned long device;
 	unsigned long function;
-	uint8_t romdata[];
+	uint8_t romdata[] __counted_by(pcilen);
 };
 
 /* kexec external ABI */
