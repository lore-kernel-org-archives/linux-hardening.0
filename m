Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108A4E0B7A;
	Thu, 17 Sep 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679587; cv=none; b=X9s9BR0QQsuYcW5ngdscvOt/oGHPUmvqidLgoBsiJOjWPUHLpGRbBC6KwJ5GB+Clhj5FXEoiMo4pRx6HETElKWpzc3bvMTAg1O+4VauPZzVgv0/vsHZXrMRZKWFLPnUiZPhhRzG0fN1maYVupB08A1qjOlOQrZWl52ICDzN8R3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679587; c=relaxed/simple;
	bh=d4tVVwHJienj9tH8PhjAwkusagBy7idEegdJpCu4X74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sU7wQx0gFViUqsUuBvBzoVDBmvMAFcfFIiEzVEPpwBjInLSQxQzCpCOd86uLVrTiTR2C1Y2q8rPPdRwbJs8voeUyoAD5eKw1D4+hq7urN4PeTVQKOkzwvcoWn41NHE0Up3NxfdPES21DSLI9Y6kH+IYBMT3ajZBRw5L/K+JbGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmMzq+Iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmMzq+Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A31F00893;
	Thu, 17 Sep 2026 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679585;
	bh=IysZGj9mvs6CQv7lZ09Up1KR0PwOX6bfDHWl8P/2Jvk=;
	h=From:To:Cc:Subject:Date;
	b=mmMzq+IugAXiI9SHOJDRvwMsw3OuV9e1h4IGUKwGCbcUvj7Sy/jn9kBmRHLEhTR3F
	 c/x02B+uRdv9SZdqhMZEZ6s350HUDSvw9DV+2E+h7HExtIAhDbWyIC0JhFtuGvqLRv
	 E8fDgeINWKVIJbesQxuc651UZRkRYv0t3o21ESXc7uyzMMivfs7j5Z69GHuRl5OIhV
	 V2Z7HN5apM0PbgV7JlCc1UBFINJvbPyHXqBzMBhJlxDlG63xwCQfEkYkbIGRUPeIxP
	 pzKoJRQC6jgr9isLG+d8K8THcTLZA1rpX6hnOQ5ywDCo4A9C2joouDFN+DgEi8RPTt
	 zKAdUyHv7BuzA==
From: Kees Cook <kees@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanley Chang <stanley_chang@realtek.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Charles Han <hanchunchao@inspur.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] phy: realtek: usb: Remove const from phy_cfg allocation type
Date: Thu, 17 Sep 2026 14:13:04 -0700
Message-Id: <20260917211303.i.538-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2685; i=kees@kernel.org; h=from:subject:message-id; bh=dAqZ8oM1ediuouK8ipj2w379RAQqiQUmISyB1GxVvm4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwh/kCr/Nunbz5+cQ9w1bzG5m7VB98FnnNS+f0X2rK 7cnaNcadpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEdgYjw/tTTTlCPK9EC5tE EyvOHrvfZfC86pLpxA+WC25PUZzfEsrI8CQxbOUKT8sHdxPmzNd79cNLUCXg+ish+YDJElfWpBw zYgcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

In both the USB2 and USB3 PHY drivers, the assigned type is
"struct phy_cfg *", but the converted allocation type would be
"const struct phy_cfg *", as the size was taken from the local
"phy_cfg", which points to const as it comes from
of_device_get_match_data(). As there is no general way to remove const
qualifiers, take the size from the assignment target instead. No change
in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/phy/realtek/phy-rtk-usb2.o
drivers/phy/realtek/phy-rtk-usb3.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stanley Chang <stanley_chang@realtek.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Charles Han <hanchunchao@inspur.com>
Cc: <linux-phy@lists.infradead.org>
---
 drivers/phy/realtek/phy-rtk-usb2.c | 3 ++-
 drivers/phy/realtek/phy-rtk-usb3.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy-rtk-usb2.c
index 248550ef98ca..1f08b151d90a 100644
--- a/drivers/phy/realtek/phy-rtk-usb2.c
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -1022,7 +1022,8 @@ static int rtk_usb2phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rtk_phy->dev			= &pdev->dev;
-	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*phy_cfg), GFP_KERNEL);
+	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*rtk_phy->phy_cfg),
+					GFP_KERNEL);
 	if (!rtk_phy->phy_cfg)
 		return -ENOMEM;
 
diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
index cce453686db2..4231a8aa0ba5 100644
--- a/drivers/phy/realtek/phy-rtk-usb3.c
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -576,7 +576,8 @@ static int rtk_usb3phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rtk_phy->dev			= &pdev->dev;
-	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*phy_cfg), GFP_KERNEL);
+	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*rtk_phy->phy_cfg),
+					GFP_KERNEL);
 	if (!rtk_phy->phy_cfg)
 		return -ENOMEM;
 
-- 
2.34.1

