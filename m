Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219961;
	b=p5xwlQuGkKinHEooAkY1rg9mMb9tIGxMmj6l3L3kfvLGnXGenKdQ+RRgRl8lFuujCZ1o
	 +9xJjDhDf6dWXJRmsJltDpUs7lWTLhS7pdo7l/GwUiK61T4748fn+XAhAwWWbaJ75avuh
	 kuSj6K1HABnjOxRfBagS21TaHA7tW1SMdWJ9HBJ9HfSrckZOLgNK2l3vYPXWr2uXYI2Rr
	 SckgLE5d6cEKjuZe1h4tHySj31xpbr5raO4yWo9sEVFaE/UcSFGBhRRsV5ApXiioDGdzH
	 hT9GXMGF6UUVozN6KmN8wT5z1C6do+Y1IcH4oRKL3oCPZoCqSaz/TK6rrdcNHvz2JZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uHPeML+Gj2Ysyid/5nBfP8omp9YpKenMsUd7Cm1Nnmg=;
	b=XKAWI3S/WhZvdJ9M6F9xVcQpKnoV9x/PzCIqxowbQ42TFwOnD1DBIcvg45EI3p/iSeld
	 3hR4KSQtZQ6ykqTPqYYJi3PPw2kDAoE7IunYX6nks5/OLkWWh276Sd6cv2KdK0Dn4NUR7
	 /SNdRrqU98K2wVdal55vaI+xCRGdHnpTIAOlxEuoQWRoYtdjG/5lT2ZWnPJTMQbBLp01w
	 FIfH5Fu446NFFFjASINq3dycp0I53//1LcJm5x8RBntOvaBc5K/sbgZ/5xZRnzF+ekuig
	 HVf8TFCQsmq6Jid0WqMWiGLH1ZKmalolq8sAcH6AvgTGXCl6bjzd+u0u9dp9moGWl/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lg73tQk8;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DD606A325
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 10:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B4DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lg73tQk8
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so397116f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 09 Nov 2026 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794219959; x=1794824759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHPeML+Gj2Ysyid/5nBfP8omp9YpKenMsUd7Cm1Nnmg=;
        b=Lg73tQk8Ygi5OLpl6XZxHqCz2vd7pk2pZtjs5xQu5TZ+YLl6/ScJdYY7jI7Cals4FH
         qepztcy5IfS+SfS2Nnge0UZ8DJnBW1jh4/iwnN8N2CSqadh31idvtYCSAeYz//KdKMM2
         xagjOGRGKPXzIeFbsbONbIsy+ilTqy8nJ7XEF32DQasWL1cWsskAW3F+/beoWezYsfez
         jpwU8ajOa4UcbEqZx7sxtYzb3Iw53XVmD0h4uLvYNLHUuFHJFp+H4I3sxKtuJk0wAQNA
         8Tzybw1ruBG8h2znvmi0Xoract6pXBCkZvvnZNx5UzfTVreszMNumyBc71V9aOhtLVNU
         xkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219959; x=1794824759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uHPeML+Gj2Ysyid/5nBfP8omp9YpKenMsUd7Cm1Nnmg=;
        b=v1Umif7EU5E1Qa6WzuGHoOa3KLCa8SBjO59gXf8OB3rleTeyIaCn4fhoLYAFK6BOgo
         EbTQ5cz/zF7oH9spZTrT2ooOV8KkRdjP3BMHUY1XQk8xU2q8+T4B4JLt15LCqMIqKSt+
         K7ZK/OtOxfn3wa6dY2LCqNbzGQW9oEQ8KAD84oa6I/hirnTcZepguneV/biyvNgEtcjj
         011QlHBEdBETu3o0xKIJqzuu3p3Xhxt5mdg5bQSBfcNtBdrqJZSg9sQKfNKkvoXcO/b+
         GCVuofZQIDjxy0IMSZkDzjK+nJ5/qFbr8TKGUr5xLyJVLNxVeMQBXGbR/Lae9uGN6KiI
         4jZQ==
X-Forwarded-Encrypted: i=1; AL+hErEBIYIj/C3wDlV6Op6q1fka9LbjQExWUK3jj9fxdGXcJPUx3LkYly3aFbKQV80umx22YRi+GbgG0Yq2vbwPLbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ar8zHke2Urz/yH8fy/8WNCUiuozuhxtm11kLEyrsR6bElAFFH
	+HdlGU95s9TVcTTAmEVrtzulPdZ9fohaE16AsMcPhEAQgk2gBSfTadYf
X-Gm-Gg: AYBFou3790Nik6zYNNVJyBkZxJQwRPRdUkHWOD6VkLEAqC4yQaRaUHsev0WLxNjcilU
	57CyXl4IHC+TaHuJ5lnEi03kWa8+EnP7PV2xvrU6aEWmhMMgxaOnb1OeqV3Pl7VDz3IqZQFLSgh
	NPw/64+3Q0RMonrNXlhBFIte24pBTnjK+a+sChkAdA25iFsR0Le4q/OS3n2rgrdM7Gsub2EDnIm
	Eev5jPRi245e7GQUsJVja7HwE4KpmcmkJDZmpvvLrgyQ5yTyUojSluxxmssD4Flh1u9S7lkYTi+
	O92Po3Qtrmrs1W33JrrE6DLoh72/vYwsCVrwTUvBNLe2pUZ5C1JDC2VIUSlBDwNt7nbkeC6UFf/
	bbgh61EDoZEbhTcZVpzUTnCPBCv6GeD2kbx9JQ/b4x4ypA37rgZfGREJbGdhfNknGUszh5SVW2g
	SYjAIEh8pQR4FVyPULNwy9+3ghKsoGlIbh8jsr34OG7YedCeGKRVOI+Si+MVsfhcMv11vlj2Mjv
	LMecVqmlo+jNbklhZUzgh2HwJoFT1ft45OLm7hI+Xv3DkQ1z3T/xygOaYEBHFgikqpSHHkPudRh
	iAhI+uLehJJGFULecKTkDOqwiL9dtTAyOlGhtYDbGINlWbG2k0Hsw9VI5kwBhTM+bNVPrnrLCGL
	2pXZFtw==
X-Received: by 2002:a05:6000:260a:b0:491:f150:caa7 with SMTP id ffacd0b85a97d-4958487b45fmr6791123f8f.54.1794219958787;
        Mon, 09 Nov 2026 02:25:58 -0800 (PST)
Received: from emanueleg-nb (host-87-10-175-32.retail.telecomitalia.it. [87.10.175.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967003fefbsm5057940f8f.13.2026.11.09.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:25:58 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-core: reset rtd->num_components after allocation
Date: Mon,  9 Nov 2026 11:25:20 +0100
Message-ID: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>


Commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
devm_kmalloc_obj() family") switched the snd_soc_pcm_runtime allocation
in soc_new_pcm_runtime() to devm_kzalloc_flex(). components[] is
annotated with __counted_by(num_components), so when the compiler
provides __builtin_counted_by_ref() the allocation now also sets
rtd->num_components to the number of allocated slots.

snd_soc_rtd_add_component() fills components[] one entry at a time and
expects num_components to start at zero. Starting from the allocated
size, for_each_rtd_components() stops at the first, still NULL, entry,
so the runtime has no components: they are not probed, no controls or
user-visible PCM devices are created and the card registers empty,
without any error message. In addition, each added component is stored
past the end of components[]. On the tested board these stores still
land in the slack of the kmalloc bucket that devres rounds the
allocation up to, so KASAN does not report them.

Reset num_components after the allocation.

Seen on a Colibri iMX7D (simple-audio-card, fsl-sai, sgtl5000): the card
is listed in /proc/asound/cards, but /proc/asound/pcm is empty and

  amixer: Unable to find simple control 'Capture Mux',0
  aplay: main:850: audio open error: No such file or directory

Tested on that board with v7.4-rc2 built with GCC 15.2 (first seen with
GCC 16.2): the failure is there without this change; with it, playback,
capture and the codec controls work again.

The root cause analysis, this change and the testing were done with the
help of an AI coding assistant (Claude Code, Claude Opus 5.5).

Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
4dd10fbbeb9c only reached mainline in v7.4-rc2 (not in broonie/sound yet),
so this is based on v7.4-rc2.

The other devm_k[mz]alloc_flex() sites added by 4dd10fbbeb9c were checked
too: none of them fills a __counted_by() counter one entry at a time, so
this one looks like the only user hit by the preset counter.

 sound/soc/soc-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 68b54e509b65..06a1d5718997 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -387,6 +387,12 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 		device_unregister(dev);
 		return NULL;
 	}
+	/*
+	 * devm_kzalloc_flex() presets the __counted_by() counter to the
+	 * allocated size when the compiler has __builtin_counted_by_ref(),
+	 * but snd_soc_rtd_add_component() expects it to start from zero.
+	 */
+	rtd->num_components = 0;
 
 	rtd->dev = dev;
 	INIT_LIST_HEAD(&rtd->list);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

