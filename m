Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452010;
	b=mXB1a4qD+VPlIZYP/aaEva70wBmWzGfEWO7/uedRSwczcuOC9NMRP8WVGU4arXxuMghW
	 Aifro3V6ETO8RbPGLGf1uL2ctkyKAq6IzGjJNSVzZ0MeGtod1qQdxC1Akes3Y6Ga/RpGq
	 FlcavhRoyGDODqUsvZyfYp/5f4NCbM0SmdzoSFtZxd4A4dDa9JuVqfDyR96gehQ2ojy62
	 mLkwOytpOWRVZl97R9j4y3XL5vTTD/vkOZRQihQzT7LiiH9ibXeAvZqPUjZ/2rlEdRtTW
	 ML8OqGzWocWP74qF7ozEasx70jq20CGh9xFHkl7TGNGp00Ir4AWCdZ6i/QB/DsQC5nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nc4XLNPToEMaydN4Y5LPmHECaS4FBVXGXKRGT4Pu6v8=;
	b=fCeGPDxiIW9cdM+BK8uVBvRPino2qoI45UitiKMj+ihRAK2VCqIZg71tY4Sd6eZSGPUg
	 R67gCgmNtSPu6UM/tcVDTPrRoWMAc5kOaTY6oyMQbmIXjsHKK1fkRQrRrC9YZE+dyHQuz
	 S+YAldYMbuYSfC8tDfrXoBlLZCdl7ssQADTCVaB31a8MXFaX1YsrNpnCa+fDtkF0UU8Vw
	 me0XQ0G5UUM53UL3uLYt1L/rcu+UfCHiQfKN54Ogt3wEsSaB/Rd53Iryn5UxTSqjaaNkW
	 0uwEOSUyC8nF33D+krpuqq+cheuxPWqF4d0Khv+furDjfrmtAtiDvBJxnPh7oi+PuiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ausil.us;
	spf=pass smtp.mailfrom=ausil.us;
	dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=akEjgfZW;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1463606A321
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 02:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1463606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ausil.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ausil.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=akEjgfZW
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc758830601so2327480a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 18:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ausil.us; s=google; t=1794452008; x=1795056808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nc4XLNPToEMaydN4Y5LPmHECaS4FBVXGXKRGT4Pu6v8=;
        b=akEjgfZW2c9l/EHMTj/y8UJnf+VdnqxXROFLwwnOpgzYiaNGygiB1U1QeTFjG6S2Xo
         wpcBhe3O0zcUjSOBL1aRk7UhVwVaDEqLifEJmjCtDYAlbZXSxKUSouFA6gTXOxaHP/8Y
         22sbMMh5kr4mw2em4P75pXVFJx9MiFfXqZOlSCX/qD/aJWinzPygNUnLg7daruJADX2p
         WEa2vGDwelccNRzRpDe79u7EIsn88utl2Q0je09uBSB5ykH1Q9uj82S6TO5JVK7yCWiP
         2qD1lR7HrgJ+7D22rqNT10s5vr0/O5aiveqgPC3VSnxOHai4yEtQ+Q0SryW3R/LwM/Df
         DD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794452008; x=1795056808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nc4XLNPToEMaydN4Y5LPmHECaS4FBVXGXKRGT4Pu6v8=;
        b=wZZ1coo7BosCl3hKITd5GfRfCbEznRjRGob0HC4jHwjyID0nm1ZzCF23m9Q7zbvww8
         qxnboZmpZI1iooYpJxbLAsCyDq3H/7mvCLH6woyKYyiMXnIzYJMri0DrfXPGJAWuZTGo
         8ZORRAHQaf6XCEgHe34EDEoxsECujki3ZPV96a8QFIZoNZsxeTVH6bpzi7n+j1Gs50Zg
         ttUgmkd3tdsmjSXSV3Rmu5rSSc0NS3yWqIT5/oGMXglkjnJ4S65YM0eVTc20ah4dsq5p
         jSfQaYrTuAZVnnSiKCTrbX7QtGyJ8d7sIcRYNUh+xT/gmojIcCiXgQqGY6mDL3KON6m7
         qkOg==
X-Forwarded-Encrypted: i=1; AL+hErE0hbUwM/JVZU700pqiYLYyfEzlif1qCr5C5Nw9TimhE/h+su12DDwbR7qbX7ONNMhFFjqLXrunMcq+q5krD14=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LudR44PruEfgmBxGm1TQPyIcYxNADVuZs4rUoOOc0yj/Nf8zC
	CqzjUhT9TrTSFCC4dgrUPP5FFzlJ339IcVJBR5K4g3NVrpvHjnbE30zrubaM7tYbofJ2+E7iREN
	7PFgTxK1Maqb09WxbI2bgTjX9UNbmjfAcoi+W
X-Gm-Gg: AYBFou3Cb3+MqeV4LU7k6ZRbLCGghtdWoSNOmCYZMQLOANLm3RqAxJWW+QsGLbI2bXS
	iE6Gu/enKcp4y9KvhTnX/Hw262esDFDxox9UuItR8jFgTUz1WkI6farN/yAE9z2daR1s+xCgPHP
	mXsYmzSIKRH6KL/6FKacfYkUibZzQKSrGWaikiEbnW57LQ0bHTGIbCqmDCWKOC9REVkFXY+8eF4
	6k6l5lxz7GEWaeyvA9NeFvr7apH9VNaFVvBYYbdxp4cog4zwsMXkhki4vrJZIrVOjHyFEPq4hWI
	Q8NzyLBJ564u+b8Lr97Zcc4q8qdwMj0ztbGhCin0H643akL2qvVOuEvyIyQP0ZtwcfvooJFb2rk
	r0KZKknLqfpad5kvrR/rh120=
X-Received: by 2002:a17:90b:590f:b0:3ab:2c2b:1026 with SMTP id 98e67ed59e1d1-3b182eec413mr4274267a91.34.1794452007867;
        Wed, 11 Nov 2026 18:53:27 -0800 (PST)
Received: from thor.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181c053cdsm1542175a91.0.2026.11.11.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:53:27 -0800 (PST)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: broonie@kernel.org,
	lgirdwood@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-sound@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	linux-spi@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org,
	Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH] ASoC: soc-core: start rtd->num_components at zero
Date: Wed, 11 Nov 2026 20:52:51 -0600
Message-ID: <20261112025252.71375-1-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
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

Since the conversion to devm_kzalloc_flex(), the allocator sets the
__counted_by() counter num_components to the allocated length
(num_cpus + num_codecs + num_platforms). This only happens when the
compiler supports __builtin_counted_by_ref() (GCC 16 here). With
older compilers the counter stays zero, as before.

snd_soc_rtd_add_component() treats num_components as the number of
components added so far: it increments the counter and stores the
new component at num_components - 1. Starting from the preset
length, every component is written past the end of the allocation.
On a link with one CPU, one codec and one platform, entries 3 to 5
of a 3-entry array are written, and components[0] stays NULL.

for_each_rtd_components() stops at that NULL entry, so
soc_probe_link_components() probes no component, and
component->card stays NULL for every component on the card. The
first DAI .probe callback that uses its component's card then
dereferences NULL. On an HP OmniBook X 14 (MediaTek MT8901
SoundWire with CS42L43 and CS35L56 codecs) binding the card
crashes in cs42l43_dai_probe():

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
  Internal error: Oops: 0000000096000004 [#1]  SMP
  pc : snd_soc_card_get_kcontrol+0x18/0x40 [snd_soc_core]
  lr : snd_soc_component_get_kcontrol+0x6c/0xc0 [snd_soc_core]
  Call trace:
   snd_soc_card_get_kcontrol+0x18/0x40 [snd_soc_core] (P)
   snd_soc_component_get_kcontrol+0x6c/0xc0 [snd_soc_core]
   cs42l43_dai_probe+0xb0/0x148 [snd_soc_cs42l43]
   snd_soc_pcm_dai_probe+0x70/0xf8 [snd_soc_core]
   snd_soc_bind_card+0x4d4/0x8c0 [snd_soc_core]
   call_soc_bind_card+0x70/0xf0 [snd_soc_core]
   snd_soc_register_card+0xd8/0x110 [snd_soc_core]
   devm_snd_soc_register_card+0x20/0x38 [snd_soc_core]
   mt8901_card_probe+0x258/0x5c8 [mt8901_acp_sdw_legacy_mach]
   platform_probe+0x88/0xc0

Reset the counter after allocation, so components are added from
index 0 again as they were before the conversion.

The bug was found, and this fix written, with the help of an AI
coding assistant (Claude). Tested on the HP OmniBook X 14: the card
binds and playback and capture work.

Fixes: 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the devm_kmalloc_obj() family")
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
An alternative fix would be to keep num_components as the array size
and have snd_soc_rtd_add_component() fill the first NULL slot. The
counter would still need to be set explicitly, because the preset does
not happen on compilers without __builtin_counted_by_ref(). Resetting it
keeps the original design and the tighter __counted_by() bounds.

Kees, the same pattern (a *_flex() allocation followed by code that uses
the counter as a fill index starting from zero) looks to be present in
two places converted by 69050f8d6d07 ("treewide: Replace kmalloc with
kmalloc_obj for non-scalar types"). I have only read the code for these.
I have no hardware for either and have not reproduced them, so please
treat them as possible issues rather than confirmed bugs:

 - drivers/spi/spi-axi-spi-engine.c: spi_engine_optimize_message()
   allocates p with kzalloc_flex(*p, instructions, p_dry.length + 1),
   which presets p->length, and spi_engine_compile_message() then
   appends with p->length++ through spi_engine_program_add_cmd().

 - drivers/net/wireless/intel/iwlwifi/mld/d3.c:
   iwl_mld_process_netdetect_res() allocates netdetect_info with
   kzalloc_flex(..., matches, n_matches), presetting n_matches, and
   iwl_mld_set_netdetect_info() stores at matches[n_matches] and then
   increments it. The per-match kzalloc_flex(..., channels, n_channels)
   has the same issue with match->n_channels.

If they are real, the fix would be the same as here. I'm happy to send
patches. It may also be worth a Coccinelle check for this pattern.

 sound/soc/soc-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 68b54e509b65..e4d911577c5f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -388,6 +388,13 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 		return NULL;
 	}
 
+	/*
+	 * devm_kzalloc_flex() presets the __counted_by() counter to the
+	 * allocated size, but snd_soc_rtd_add_component() uses
+	 * num_components as the number of components added so far.
+	 */
+	rtd->num_components = 0;
+
 	rtd->dev = dev;
 	INIT_LIST_HEAD(&rtd->list);
 	for_each_pcm_streams(stream) {
-- 
2.56.0

