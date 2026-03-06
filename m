Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5C3537CF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835919; cv=none; b=RnBRwCNUKrEDKDv5uBmwGkqrR1Gw40hCR5my80m7ixpPPnIq6Vl9vvynUVMWcnLT/QtFUh1GxSGo+hvzEllSf88+samwf18ftKvqD/J4+yfA+C6jpl++TmRAOEowlJs5mEVwIlt8xHZG5jWAGmaFuGmErEprv6SMqhC2X0aQIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835919; c=relaxed/simple;
	bh=vihrZtb4tzeCfekWdfgqrqGt/X8b9s4AqttZL63+HHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L22N6Om2AAr2/uKZPJ62HmOv6T/r/anykaaESVWNQUoa3DC0u5rUJxwRGPG78rHqZ/Qj1kHtmC++bLeMta/EB7kJO6eGIg4DgxYLISA9hBhCU+NwK9JBy1eSxjFGVrWnBFp1iPnZtuvJKqofU1KKCtObD86FJ0TqDuTDFhwpNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJp7hCA/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJp7hCA/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae3a2f6007so51080335ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772835917; x=1773440717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGeWdIkU9VejQgwZq5zb7Y2J6ZyCjsrY3OgmM4MXxHc=;
        b=XJp7hCA/ud3JfNsRhBQAlevid9vh07Qui6eGWxDQK2DkI6TDCmaFu2ldmmZkmZjIcW
         0fhIO8IdhIwPxCwCrwOw8GGUs+ANy7b8YE2PhzPWLPL87rIwp6ARqx/FinNUx5i3IuLi
         AXj/sOQFjOTc6KtykVXkLFZEf6I0aLiyNzdnunX1aMZ+XpAarx74QOFaM39aTsXIP3Ik
         yLhcnR6Z5V6MXY3hFT5erkPmEf16Zal+cMe1FnIAJTZkW4g63M78NE3WKwTnCMGni2yH
         NJ38MHWxnzEh8F0HH8mMqnfdk9CTdzj6rXX4i94UOmStuEWwryOc/bJoQw2LQOg/C7CU
         VZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835917; x=1773440717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGeWdIkU9VejQgwZq5zb7Y2J6ZyCjsrY3OgmM4MXxHc=;
        b=ZSQL3CT4im8NgX6SNjfmrXBhKxmxq7WUwszeyddO++3fq4/BroniCEWDVQdZWttICY
         z4TMjD3h5z9nBewy73rbTaUOcrKy5YqrqrKVE7TT74WksF1YjkAvmFs3putfYx6QaA8M
         c2AtdqEyjLzJ2nqAxxPNFNfJmWqc7vRRU4VoVvY1J0u/In6nShtsDszz/CvFqiS1CkcQ
         m3W4Lg2C9GIk1J6Q4vKmA9Ut8aAaImqt8fbZBOHSg/4ajemvKtyeUgmxQPUxn6x1kFxM
         zjghYxSsEFuWtZMTXsm0TrgvC04fSj3rHQV/NbBxqHsHaxTBIINnKeu2TCh3E3HJFqCq
         RSlg==
X-Forwarded-Encrypted: i=1; AJvYcCVEJIeNsgYj55DbPTvV1ryKkd0uZKuM4P+uEYT1jlk6cJMo1xvaiBIbyn6jSophWngUCz6oM+FCBZyJail7rYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF93L+mQ2IiECoO+e1nGKmP7h6AIrNs/KEaPJ4TBdMTkz2isUG
	8+tPBxNwiE6GUMTiN3VdMByPl6hbwJs/HJwf4SS/Rw+yh163fL2We8UQ
X-Gm-Gg: ATEYQzyq15A00hBeXpNMZlUduh9HRGDYEJDIwH9eASlSXY+R/odJtM5w8Xh2D6unZsB
	StA8SIh8g6zezpWlqVzSzL8kb0YdmGKCEB+CL+WJ9tHPfQqZ7jdlOgkjJ0uhImhevziuXDWY3dW
	K9hHFSvyH7so0NXmNfb+O7OyYoJ3B2bcAoqkD/l2ouNnaUmM05MEfs31lHqm3UV5QygKK88A+16
	GmvAcqACHn7kou2ep1/6ITHxE/vRQ16tnCX+PcrDcv6IqQ4bTM/lR4STj8phMIVpQd7WdAdI566
	mzQ8gQK7Zy6ifLOZAuNj5Xhg4GWhRCIL3EPvXCtIaOMbH5tmYni2utjbtrLB8Ki1W48izeFcH4G
	ThO9y63T8JGvfj7THNZqU82E2qGQXMRZ9l2OSKy9H6XeDgRbLX3NwIx3X3KCRKKH3Cd7pgVc0AG
	ZdXIdg5riUsV2GA6UNEWGAjGhRxC3kY/p7QJSYDhkN+0RIB+zMunixF5w=
X-Received: by 2002:a17:902:ce82:b0:2aa:ea8e:f118 with SMTP id d9443c01a7336-2ae8241ddf9mr42623695ad.3.1772835917227;
        Fri, 06 Mar 2026 14:25:17 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e7c58asm32516605ad.25.2026.03.06.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:25:16 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 1/2] phy: miphy28lp: add COMPILE_TEST
Date: Fri,  6 Mar 2026 14:24:56 -0800
Message-ID: <20260306222457.8400-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306222457.8400-1-rosenp@gmail.com>
References: <20260306222457.8400-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's nothing special here to prevent compilation on non ARM hosts.

Matches every other st phy driver.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/phy/st/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
index 304614b6dabf..49206185e563 100644
--- a/drivers/phy/st/Kconfig
+++ b/drivers/phy/st/Kconfig
@@ -4,7 +4,7 @@
 #
 config PHY_MIPHY28LP
 	tristate "STMicroelectronics MIPHY28LP PHY driver for STiH407"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	select GENERIC_PHY
 	help
 	  Enable this to support the miphy transceiver (for SATA/PCIE/USB3)
--
2.53.0

