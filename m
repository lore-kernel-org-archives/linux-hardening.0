Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5B351C05
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835920; cv=none; b=uZ/lucyZeV+DeT96ipMsjFV3DCEB4xOCye+LL2lNDm/dlX8F0ewxsF0HQ/EVgcp/0Xwn3mv/KYJKcLjm/LCgRxXINlDWkrTAQ5+CXAJdQNpylYg0QVr+X5GseSIaGPRoj9bSR9SNJj91NpYv40XY/WjXxqykzpoEu2CdCKsXMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835920; c=relaxed/simple;
	bh=srW4jKzyMha/1O5aSnQEr40eDpunSZe3qN+17FfvzNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjPeSkYx6UgLnnoxkn7WlZodt4iarQlqOXwKM3R+lkyYSPH53RU8zaUimcyygHjy2n/XqHkqbuIT6XknEb2WoX79qk/Q9h2KXSa5PpKzqGTD2QwrVAl6cBt9RPbNP9UkTo65Ljp/3BzhTRol325q1Qb4lE9AP8gnaQxwf+zZRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2TFt097; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2TFt097"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso44307585ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772835918; x=1773440718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA9nb83nCkXGkJ9IKyGDJ21XOXhsf5BHbt5T5gtrqN0=;
        b=C2TFt097oixi3mc7rdlTY+7P96ckmYmU4Cg5XzJfZCAwrIVBXH6Idapq8RuqlSPlvV
         YFRY6P4n9ikurz39f6w0oh4UukA+S5u+w8DXw7U9FplF+KFwhWt9SI5f0Q1R8YyecSHY
         CbdJ1mInFfrRvAJ8Y+EgsoQJWfCvJTGUHBKoW3WGBvkN6H7aDW+FTFub76jTGitx78o4
         ynu/TEjsTGJCsVDUDZimgVvIJoj7DBWcInv3HD3vtvUzYLyuuuNY549dynbwOr2sIAet
         YNcSoa5sOfud9jO5wLxEZCdLXcypVQW2wIyBIUqXI6J5aT7PPFk7yowD7jW3H19vFrU3
         hCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835918; x=1773440718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BA9nb83nCkXGkJ9IKyGDJ21XOXhsf5BHbt5T5gtrqN0=;
        b=kVL+eKvJvWpIniuC8gjKkpaxaLeCL7RR1xGUQ1nZ9sNJagrOuE7+Uq6AUT8WVn2Cv3
         diYkWHb5YqUOh+qT4GCa61E/gWvHkzygormxBLjO5iwTsjX4HKFloGw73vkE9PdxxnYo
         ylbrBSFwe1X6ypnMfshQ3c7u0ObJiCxti8yMH7dugeEpXp0lxdx+vqkoPQeby8fo+AvC
         R0BC/mDNA2nMXxe7gHJSwDxwXcWjMw9cEjchFWPnXiB3/3PC/GjGNhkl7TTBATYD1e15
         9zpawfYGhGWf6iKvcnH29JLxyL2/spAZIFgc2TWsJoKX6w4OETTVuZ0epmFDF1D1q9fC
         5wXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5mBM16QvML4rhKddYtsJ0awvQsG8qNUrMzugQ1hCnb5K2ZA3Ih0pZYM9SrG5rXDEvgJzAZrft7c/4371JHgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrX1KUuKhQVkO85g7AvFw+A/L/9276bTpiMkuxdpO8O7HkTwBM
	8FfJWUWRlmqeC2q3NyL34jfsEIVhfRAmaFnZsHujS8zPqhDTwRS7i9SG
X-Gm-Gg: ATEYQzzxMUU9sve/TNljc7eTU4cmU0uftwpi+Co1YwIto1VfVuNsVth4d5L6uEyFagm
	TxxvL0NBQfIpZKmCO0diM6JZK5NMXLvt809m9pV7OHfJ1091d2ZidDMyTeLHrrJLesyLadn4V88
	WsT1eBk/uOcppM5Ew9cstOY25BBJP1C1ceYgj0l+grrLahRcpsRJT4W3MpDBWdzgyKyCoVQgwQD
	LVAbOEjatjZc7q+pS9YEHxenYJv4sKoJIYZF7QloISqASFm8aiAiH3uZzc5jac5HY2mKHDWCDdQ
	AHtfnTaAIM/CCYR8F4MZcj3h0JjFNdTxJ4TiJBaSMf8rqrxIEGtobaHavgTG2Jvdq4Cf0yNE7Ok
	SCUUh/RF4j86DzqO8yJdsoIMLUrMiczYCcPmHL+uY6ozhZFi0GdoUYEa3g1jQqZybO8CAq9J3ju
	VKdNm70u1VMxeX9MZogBW6fGrsn036gb0mQaaxeew2AtJYVt/FI7fKStw=
X-Received: by 2002:a17:902:e790:b0:2ae:5aed:1f4d with SMTP id d9443c01a7336-2ae8245cd73mr32902025ad.42.1772835918443;
        Fri, 06 Mar 2026 14:25:18 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e7c58asm32516605ad.25.2026.03.06.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:25:17 -0800 (PST)
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
Subject: [PATCHv2 2/2] phy: miphy28lp: kzalloc + kcalloc to single kzalloc
Date: Fri,  6 Mar 2026 14:24:57 -0800
Message-ID: <20260306222457.8400-3-rosenp@gmail.com>
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

Use flex array to simplify allocation.

Allows using __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/phy/st/phy-miphy28lp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 43cef89af55e..c576fc5569fe 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -224,8 +224,8 @@ struct miphy28lp_dev {
 	struct device *dev;
 	struct regmap *regmap;
 	struct mutex miphy_mutex;
-	struct miphy28lp_phy **phys;
 	int nphys;
+	struct miphy28lp_phy *phys[] __counted_by(nphys);
 };

 enum miphy_sata_gen { SATA_GEN1, SATA_GEN2, SATA_GEN3 };
@@ -1168,16 +1168,14 @@ static int miphy28lp_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct phy *phy;
 	int ret, port = 0;
+	size_t nphys;

-	miphy_dev = devm_kzalloc(&pdev->dev, sizeof(*miphy_dev), GFP_KERNEL);
+	nphys = of_get_child_count(np);
+	miphy_dev = devm_kzalloc(&pdev->dev, struct_size(miphy_dev, phys, nphys), GFP_KERNEL);
 	if (!miphy_dev)
 		return -ENOMEM;

-	miphy_dev->nphys = of_get_child_count(np);
-	miphy_dev->phys = devm_kcalloc(&pdev->dev, miphy_dev->nphys,
-				       sizeof(*miphy_dev->phys), GFP_KERNEL);
-	if (!miphy_dev->phys)
-		return -ENOMEM;
+	miphy_dev->nphys = nphys;

 	miphy_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(miphy_dev->regmap)) {
--
2.53.0

