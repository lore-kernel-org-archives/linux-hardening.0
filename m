Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359940;
	b=uadihPwNIqKVOytqS97CpjL2cZKoZWMpDLsDaYHYYEfZz7Apd0H1f97DGiUR9gbnbsut
	 4ojCRn1DmQI7xbG3Oc9R5JLrTQazDDAr86Vy48R1TtolJNBz9WqnvIFBgA6HGPu2UETLO
	 ESo4vpHScnjMQmpvgqVltoDxEtlPC098diO1zhglwv0Sw4uKOCifbTMIEtvQMo0Rqh8QQ
	 hJqFHSUzBurEIX5X5dGeJYfOxu0cc/+Eq87K/pI3trSRPVbLbj4gDYEAv9hHy/hQvQK0w
	 UKS7JItlwy9OPrfD7dTUYwh0Th+mF++ERR61VQjZ04E2ozoLq2Ej3L4nctrHfDZGrgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gNyPl8hvDz2s418waBm5wB0iV5wzq1cuI+c5xRhCVXE=;
	b=dY0u0AwUD4cnAy0EdF2h4ZoR2dXgeRCpL17rxHFyYh8x3hB2WK9dNB3Hq1FDO5w3TosL
	 4X1Bgb3lYqkImYkvXgWW2xMEq5Y2k256WK3LTjLmUQP4J8IjxP32gY0tlK+ylCe+NrQBM
	 xXszOTELiWs7R0fln78LcUKp98xr+NSDXNPbn2oZXTQO52XTGeKdJqSYAe51I4DLFaq2l
	 V5/LjMqZWAkRqgQzoy+O5fMbmtGQkZSSlHZavRteCNDCkZbeWUdWL30r5vk0Ig8DFENN+
	 nNof0xt/o5jE4HTLSj3bjt9hyEJAAqw/k6YXcp1ihidusgWT5d13qEGGIdXvWgxCX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixHBnGoN;
	arc=none smtp.remote-ip=74.125.231.75
Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3898606A321
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 01:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3898606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixHBnGoN
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-4a77fe1bc0bso1161152fac.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 17:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359938; x=1794964738; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gNyPl8hvDz2s418waBm5wB0iV5wzq1cuI+c5xRhCVXE=;
        b=ixHBnGoNmKLHQjnp1EcyhfIGBb4m/7l4WLpuZeHvcXjjRCFSyz6DiGp+CUUuZyL+ni
         sc7rZxVGjrXwtLjtapYWMxcVvz4WZXQhUqirQ0embkyJvK80VU2yv0WPJa/LWjjvJr09
         AiP+81YK5M0TG7Z1djmSyh0qoTsF+q/HU5yYIWBHl0wxl7BwrdqfXfmNg7Nyqvti88E1
         pKd/OISxGMwBdHXLr+6vH6utbPQ/DGkbOtVYU0JO3mtOLHJEAddsSZuLvqsfU5AX5/GO
         NUDrOPTHrgyX/zlKuTDRhkbNiNlKLPWEN/DSBXJXV4RUgC5ymdOXq6DbNfVeEqVclr/w
         /juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359938; x=1794964738;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gNyPl8hvDz2s418waBm5wB0iV5wzq1cuI+c5xRhCVXE=;
        b=OMO/v7ruVL1cEa7R9YPJT1ffmjZ5s4ZWgDLWhjrgW/PcoopUm91lzj98YbnssOtGHN
         5tEByvtjsKlqcEwRJVR1PVxo3xJsARSjUHVuRG7oFM3p8xNMyxjWw/GmbodDVDj8Fw/X
         nF74chArmwWjBfGXb+BL7EQny8wGAGBvw3hf1gAnIaN9Bp0hD+c4b2DpHXusLmQchv9m
         T8julVmeeABklIHzylZgtPnT+CVWemcIDUZa8ge6SLsi75TTq5zfntXIVcypfpf8zbaS
         XKy+aJcfKWQaji/e4azzT22nDyTtSleVi37vFiK+yK4l4lT5T7tXO4SmMrmtEX16eccy
         3ugg==
X-Forwarded-Encrypted: i=1; AL+hErEBQXHMYb1AehqKIG+tGDiryKQqv4P3SHCiKr85Eq6mw95XeAV23+2Fxh2nYCgVNCgfvYDMM49K4utvKmbuAgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7UeAKAYgZvOUmhC0nOWg6Lj3DFzOFLP587Yb3CY717C9cQX04
	sNWFgDSLToC6aCBX4Usa7Rje/nLDfJCau+JsGoas9Ra3R0O7+fJ5cpi+
X-Gm-Gg: AYBFou1O46K5Q6MINf2uNcRSNnimyjFouWzs/xT52DKuHjb8PE5A9m+XJTU+TbiarH0
	ZljtabcvdijLyUFtGg9QmACDFI8zcaUoxNvLF08Xd51Ar0vALoxHr7NVCmRFxaXDco2HZjDkwYJ
	aUPLqyXy9snIj6paupDATwW/sa8DvG13+m4k0p0Pu93pSTn4EBpHnpwd3pykvjjxJZ9ZmsWvp/U
	97Dz1vGmSq8hi267H+e+Jzx2B+SfNymol7LfWqEkFhucZ0Mlx5YpcJYZ72UW/das0Q29Zd9tg7N
	v4YVioFnsYaZwTZQjZ0CLBetDPJvbXvynjJqRmasDTsZxeq/ig67a3UCCCxN7eflV4N6FBxeDxl
	FNXAqTKC7cZD0mQ3EF1xGTwyZuAWN90Z2ERN+NMXvbhdTaXnDTOxLpflEA/Q76icga8OSVuoXPC
	GT8nP+zXpMV7oXMIskgg6rvX0jpIOut8At2gIDl36zipojECmvbHGFIqYMj1sLwp7HlHFvLTqBo
	Wxwr1WSwWbgU7AnJJIH17zRjSLx+UZ1ZNV9t7DopHcy3EGhSL01hU5aW4HbeVR5Un0BqJ4xUoeV
	+YnohOTtzzF/KKT6jIE3zwBR
X-Received: by 2002:a05:6870:f61d:b0:485:d1ab:793c with SMTP id 586e51a60fabf-4ae46b8c334mr1051565fac.29.1794359938319;
        Tue, 10 Nov 2026 17:18:58 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae23095c16sm2489357fac.17.2026.11.10.17.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:18:56 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 19:18:53 -0600
Subject: [PATCH] ASoC: soc-core: start the runtime's component count at
 zero
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-rbrue-asoc-rtd-num-components-v1-1-fa0c9e0cb361@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDQAwAwK+EnA0YW0T3K6WHdU3bHMxKolIQ/
 17oPGBODHGVwAQnuhwaWg0TcANYPtneQjpjAuzarmfmlnzyXShHLeTbTLYvVOqyVhPbgsZb5om
 H4d6Pgg3g6vLS7/9/PK/rB3kgbNJvAAAA
X-Change-ID: 20261110-rbrue-asoc-rtd-num-components-93a1b188469e
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794359935; l=2050;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=ISg7w++wXHyL53KnX6PWd5Fq+DoqRxUq2YHTwfGGjcg=;
 b=wbo217doE1MovnyyC6sTYiw+dP+3D+mWK2mBBMyznqJSZf1dme7lbFHchWw868o9OFxhx2Ggp
 PP6G+cKDim7AjA3kswBmP0IQsZkiRCi7R8woGpbbXASTnjxZ1KB/DIl
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Since commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to
the devm_kmalloc_obj() family"), soc_new_pcm_runtime() allocates the
runtime with devm_kzalloc_flex(). Since components[] is
__counted_by(num_components), that also sets num_components to the array's
capacity, but snd_soc_rtd_add_component() treats num_components as the
number of components added so far and appends after it.

Every component is therefore written past the end of the allocation, and
for_each_rtd_components() stops at the first, still NULL, entry, so a
link's components are never found. On an MT8173 board the RT5514 link's
init can no longer route to the codec's AMICL widget and the card fails
to register:

  mt8173-mt6391 sound: ASoC: Failed to add route Int Mic -> AMICL(*)
  RT5514 Codec: ASoC error (-19): at snd_soc_link_init() on RT5514 Codec

Reset the count after the allocation.

Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Since v7.4-rc2, every ASoC card writes its runtimes' components past the
end of their allocation, because devm_kzalloc_flex() now sets the
__counted_by counter that snd_soc_rtd_add_component() expects to start at
zero. On an MT8173 tablet (amazon-suez) this left the card unregistered.
This fix brings it back.

This patch was developed with the help of an LLM.
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 68b54e509b65..7b3d980ef10d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -388,6 +388,8 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 		return NULL;
 	}
 
+	rtd->num_components = 0;
+
 	rtd->dev = dev;
 	INIT_LIST_HEAD(&rtd->list);
 	for_each_pcm_streams(stream) {

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261110-rbrue-asoc-rtd-num-components-93a1b188469e

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

