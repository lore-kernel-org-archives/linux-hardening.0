Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776027;
	b=O21puGP0a1lz6CzaKuz66WhdqyJXDGspwcLMEJbyJZZ8mFYj8YoPm0V344IzM8AIAH8U
	 Nydc+Xj+R8UI6jomJP0lhgNBQvdujrohl22bUD/sB5+shNYA4rc2mGw1ntpwzTnQdVvl1
	 zngB/UQlmJQWE49uBdS4dIJ8r/BaeBbdFaPegeGoR8ocMulDkYw47Bh/ZfRuJ2r1gViUw
	 mNgg0c5H5DsOtho5RlACzqGNtZqV0Ls3lhpdAXILSpHO9b9GNEE5AkgkbMAdIrXYCnNtK
	 XrjPQw7AuZshrpyUC14ofhSfZlg4SyDt9EO0gwSYpMuSjly+06fI7Z/QnlLJ7WIPQYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0MjmSAAhpe5cqP7I84bvnQ40cKtlwbqwpo+pqHT1S+8=;
	b=YBMblQG8O8OAhkIqwTYzfITGUeDhEb5WLzuc8I7wQPRjeIi/aRHZGK8a75bfulWW/jTJ
	 SK2VimjoqatgE1yBt4RvdRYtQ0mS6b0OTn+0+slICanNA0zK/wmyHkTefmN4cTlASaBLq
	 6UON6Pztdo1CgS0KGLg+83JbJv7P+DnFqsdB4xj5YWQiFqcyQamzueGjr4gknE2nVVosq
	 gdUlshOQZLJDzkLVij7lhXL8aNFv9U9F97fIT+5Ftr13b4/MQjcKxXfVprdUw6PSFKapS
	 Z5RTla1q3U9QlV3FT3JZF9XRU/zUupvgiZgJ/EnBh5607VZIGPBluU6SyRSUkNo/4wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBsrZ6+T;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB6606A32E
	for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 10:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFAB6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBsrZ6+T
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2329946a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795776025; x=1796380825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MjmSAAhpe5cqP7I84bvnQ40cKtlwbqwpo+pqHT1S+8=;
        b=dBsrZ6+Tx9NngHi25UXo3zVvlNSGzeTecI35aa1EMzKiA20cYwQ9kIYSYbJXlFE45n
         xo/CRMrccnn+ohJyXqDOegZX4zHq3Tz39Kr31OrO2tPOY9ulF0bvadZIZC2ZAaApyfIu
         wxrWczUDV9bNQ02PA9XmPgb9LqJGmHl8zjasWuIfbY5raGGho+ljxtFOYgGLj9NERqsI
         IefaIQTLcYcLlfYGL29MSwFvkYIhjdeTQG+M7RjbW/3ke3+GN/tOQFcwR8iWmFmI9OSa
         YVt1I/aoRdY49/Hu54a8Fo7/jjtqi34jWsI/bCX2VYdcbC1hqzP3O8TgARmmRpZDDdQZ
         507Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776025; x=1796380825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MjmSAAhpe5cqP7I84bvnQ40cKtlwbqwpo+pqHT1S+8=;
        b=XFJvdLEqXn8RwDWTpPZtxQOuRoMpFM6Y/hU6Wpp2Ftfd8nGG3PgU8eSL+P2FRroG3D
         cHH8qJpZzDuF4U3Y8psPCo4zkaeMvMbtuVKahTLKzW4cRFlY5zWsEwuRHV4MrX/HZxSv
         z/TbQB03swSbn2GXzkQEHwlTEkdyljKlq4dwW7vkYMbcjdZqrnIhCLJKayDQzqHykul+
         iRSZlSjw6PX5+WGTFBXY9K/ejsA0Yqvor9oM/I5Ptzxxl3javLc0sCGiX034IaRALswx
         eYGzAkm3wNJK5X6lxJSf4VWP74FXRXdg9DTsaHpa0oYqYZqGyvcBddJJQypDfXhd7Fh1
         uyxw==
X-Forwarded-Encrypted: i=1; AL+hErGFk17GKSMgomXx9nHKTQc+zhfLeTbnJzkA2K7MqaF5Xx2vyXmuvFGsRfZ38Ex7ipyQH4Kaa6LXA0NELOXcCD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sSIhZzrGOPwHALZpecgvAYD4BkDXt/BcsqCxjKxzHgm4bXqY6
	fCIYhNUEi0bYXB2X6iPFA+UUj63m802+vRnsdaZ4OXFEFS52Z6eco6NIvWQybJdEd/g=
X-Gm-Gg: AZFdTZdGN5J/+3AFOT0c3Mt8DXhSAZW3j8ayP3LxOJvgkmnYkGyMjgk6aYnhcWi2r69
	IzfzhZ57PoQIEoWKDNBqOe0CZbL110LSCmZeRERsJclky05zn5lcO7k0qwy5dFJvAPFpe0KSbW3
	8Ye0162oV+kFADGwuxpfdLEdr7yEY/xNzP4cseqv7jcjsGRfFI8/wqpwSNzuzklKzmsjdDaAIYc
	rlGzUF0ggZxw/SoHkByZxLCfLA2khepsAfJW0AtR7L+uAQpQydXi9o9Udb1WW/+hrRHsNCh9Gq7
	IhQTb+t5005zfg7AXYlKMJAGA1LiPYweHgSQorb1D2oBNKbquxhle1csbJ8X+agQjmBe63+sldP
	OJrCkBa/H586TpdKixjKOQ+9B2xcafpoecc7MpZY3OrTdGHPxAzfIohgvdCtNLZqQ4fUIYEUvcP
	CP413FR9PldhPfIXXRbz9Xphf6wCxcvXg2VVyzrMjUWoagUlCJ+1lOgzg9ogJpl0OxTlefs6Dh7
	rM5/YvKRg5alJ5WzBxf9MkNyNyQ//dB7qE1gzhVsVL60YM7HsJCOGEJKDvslmW/SXAVzIB4r5+9
	rKuVW68T+3L9SHsimCcpMZoUaXzzQo+w3H/W0Xeisn1KLnj8eIpgOtLvTXqs6R8EAHazpBSs930
	KBHWK1D0OEyLTtoZQnAp8zu6JOPMQMucSYBuPnME=
X-Received: by 2002:aa7:d353:0:b0:6ba:22f7:189e with SMTP id 4fb4d7f45d1cf-6ba37d63cdbmr12166261a12.7.1795776025312;
        Fri, 27 Nov 2026 02:40:25 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb11ff543fsm3919199a12.2.2026.11.27.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:40:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 10:40:21 +0000
Subject: [PATCH 1/3] phy: samsung: gs101-ufs: terminate pre_pwr_hs config
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-gs101-ufs-phy-oob-v1-1-144b0e04c3a8@linaro.org>
References: <20261127-gs101-ufs-phy-oob-v1-0-144b0e04c3a8@linaro.org>
In-Reply-To: <20261127-gs101-ufs-phy-oob-v1-0-144b0e04c3a8@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Booting a gs101 platform with KASAN triggers a global-out-of-bounds
read during UFS PHY calibration:

    BUG: KASAN: global-out-of-bounds in
     samsung_ufs_phy_calibrate+0x144/0x530
    Read of size 1 at addr ffff8000825a894d by task (udev-worker)/179
    Call trace:
     kasan_report+0xb0/0x108
     __asan_load1+0x98/0xa0
     samsung_ufs_phy_calibrate+0x144/0x530
     phy_calibrate+0x70/0xc0
     exynos_ufs_pre_pwr_mode+0x280/0x2b0 [ufs_exynos]
     exynos_ufs_pwr_change_notify+0x208/0x2b8 [ufs_exynos]
     ufshcd_change_power_mode+0x58/0xd0
     ufshcd_config_pwr_mode+0xf4/0x1f0
     ufshcd_post_device_init+0x2fc/0x4c8
     ufshcd_init+0x12bc/0x18a0
     ufshcd_pltfrm_init+0x200/0x3d0
     exynos_ufs_probe+0x48/0xa0 [ufs_exynos]
    The buggy address belongs to the variable:
     tensor_gs101_pre_pwr_hs_config+0x2d/0x40

samsung_ufs_phy_calibrate() iterates through each configuration table
with for_each_phy_cfg(), stopping only when cfg->id is 0.
tensor_gs101_pre_pwr_hs_config[] omits the END_UFS_PHY_CFG sentinel,
so the loop reads past the end of the two-element array into adjacent
memory (offset 0x2d is cfg[2].id).

Add the missing END_UFS_PHY_CFG terminator to
tensor_gs101_pre_pwr_hs_config[].

Fixes: c1cf725db106 ("phy: samsung-ufs: ufs: Add support for gs101 UFS phy tuning")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-gs101-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/samsung/phy-gs101-ufs.c b/drivers/phy/samsung/phy-gs101-ufs.c
index a15e1f453f7f..d4af94f3fed4 100644
--- a/drivers/phy/samsung/phy-gs101-ufs.c
+++ b/drivers/phy/samsung/phy-gs101-ufs.c
@@ -98,6 +98,7 @@ static const struct samsung_ufs_phy_cfg tensor_gs101_pre_init_cfg[] = {
 static const struct samsung_ufs_phy_cfg tensor_gs101_pre_pwr_hs_config[] = {
 	PHY_TRSV_REG_CFG_GS101(0x369, 0x11, PWR_MODE_ANY),
 	PHY_TRSV_REG_CFG_GS101(0x246, 0x03, PWR_MODE_ANY),
+	END_UFS_PHY_CFG,
 };
 
 /* Calibration for HS mode series A/B */

-- 
2.56.1.839.g22a8290db9-goog

