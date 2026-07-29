Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0845C6EE;
	Wed, 29 Jul 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341218; cv=none; b=mnhFgzIpyI10UGGLdJQVOtpQKwg/dNgmPQS3rXqSd6darVOapqDyJqiHaXqQ3vAu0KBAehv/byOb6vIbU9QL2SPjmdOy59xgUraRQsaPy5SMSgFSjnrZY//0PhkZ+/NMPoNG3JhfwbfLIdikJU3W3/QA1UJ0Y6bFOkkB7PY3f0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341218; c=relaxed/simple;
	bh=FfOeQV3/VqQQRhXje8G4tPDLphE4Do2dCfVBuXRZ1XA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TJpElISH3x3PzMgwrA+vwMfpeGRvNIFqHmbRI7VKCXUfLeF9fkdRznQOyoijV734Mwuiy8SBN10mSer07/xvaDKwaZVQdI44izRYdAk1Hobcoth/L+wVim5z4jBc0eT7UMtShaDouQ0vKN+BDPbIAwkCcC+CfMUs5xDXGPbCwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=bifkmnSU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ECX36TCT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="bifkmnSU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ECX36TCT"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F3161400377;
	Wed, 29 Jul 2026 12:06:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 29 Jul 2026 12:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1785341215; x=1785427615; bh=UlvofTccL8cISTq7h7H7Oq/O+yjKvvQR
	VybOtleGgsI=; b=bifkmnSUlmujmOgvHlTivbMT+Tvabqnz8hqaH1VbjJgx5pXF
	plzZ/Tr2IAGnnEK67ZAe27mIT/DPcBUbF0QvK1fChIP2TbHY1WpGbHRELLPjFORY
	SGjFvg1GW+hk1C6h8ZfMj2Z7aJMhw0qCCk1/0oftnNtFVu6WRgitfrpRKbEKfgp3
	XokzSpy7dMGRxz+BcwF1WjjkDYXXhCs2tcZSt7ZjsE6ntXXxVDEQaXiqAmOI2uw0
	3M5gE4c16ha1CjXWGkHaBQwrFjE2GFttdhOTMZQGSoSqmLTH+S87z5Q3pOEjuHvI
	EuyxIcdKgc8537wLHYbpfpw+CyXrPU2SHm0Htw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785341215; x=
	1785427615; bh=UlvofTccL8cISTq7h7H7Oq/O+yjKvvQRVybOtleGgsI=; b=E
	CX36TCTBUB9thke4ZluA5OhE/TBn4Of9x0s3KEzBDVtcvhwL19ozA7OChVcD1+Yg
	kg1Oy8GqtATWp8tnoz1kxJx/csBLn7DP81HAEKUCrNv4hZmNePfJPH3kzL1WMlLC
	CEoKOhVWC6dMuFQUwB/W8DJ6iAm+pv8dJ6vD/C6a6OTwH349E5pBZc9vtDZU+GSL
	jsGMgo3pJr4t0dfe0WTVmnrbKLTO1XMBoBJyrO2jN4jLjR2TgBJuqzS8mvN8ho7h
	eIMfgLT4ODOsr8X3hiBxASdo9w3/5KLwYMmTaeNvm1XSsB4v8ZgQ+oaMXZnr1Sg8
	baNFYYIbzoAMltJgxMqew==
X-ME-Sender: <xms:HiVqaiP9ghgUMbU4pBbkUcxH-bLei0wuaO67p8VO6CrkTkPKCkJHNQ>
    <xme:HiVqar5Yp2ShBejxv9CAdgoyKPyhgeHMUfvhZxWpKq19ULTfUHYKy5KFNto6ffVhW
    UNL-R7z2Bv39shoX5g8fxPnzec5_li-U4McqcyM--NzwTqHV8wTXNia>
X-ME-Received: <xmr:HiVqaoTzK9aGI6luCubjNb2clyBBeN9EwOzLB_FUe8Om_aA_ruDVLhtaaTI>
X-ME-Proxy-Cause: dmFkZTEafOHv7804xsFEIi+mdBxagvVks5eCWYPViAYV+VnZVE5Ab9TED/UAKoJDZjrNZg
    vJsSqqTo5pbTy5FpGa+DOhN22IPRWljsSutpEGdjhLDakdxQRGa7eXABT7AwP8RPveNp8+
    pQrdENvzYF+fiM2Sm3RHe7Rcm+s/92c88WAb6NdyChIArPPkIB+dZ+5tfkvT96m7ozvtXI
    9RclFeaNS6wkT0b1bgQV73rqVyEL+mzCMAGeQXAO4SERlynxGg2i0EBIdrffRBIIK57VUf
    pk4qFzmlgQO+fcDVN0yeHywiprnATg1SMJsch5NPXjVASXlMOSvxfno9WcXcyYshpPBJPf
    rnrLvHC7JLzeBo5wnURHPRHFSOKDqavqVkBbwWv340Rp0PpRp63Wxdf8uF75B0LDAZHc7k
    9yzzGi/FWCRLyQAoqnEQH08Td9CkWOveTvg8BG1gIYD2FOlcsULxbL07quLBiJqU7I+Fsk
    a7/BAiUOEDg2TwTJx9Rre4kBMVFCUyhCsd5zc+bkjHA+v5HznHNHPSDMytxr5jeC1Md6Ak
    OkrRwVL9uWMAbmkTAZmeZT6D86y9+0VPYnVYzaeFgIwF179RPw94nYETjzx2Cz+RBqIPbt
    upOMd9ZNqBa1uxDePv67zMWuA8PJ/zZzRRzb5SwcKgVNty7uFMYZ2bjPJlsQ
X-ME-Proxy: <xmx:HiVqaoBL_aFpJHmVlF8P57p_YoZb3Dh4W2NMXJFR3QOErMH9bu21ZA>
    <xmx:HiVqaoEB8g---ZZpxkJM5gSpdEPLKMTJP_gz5FUb85CS25dMy0qMFQ>
    <xmx:HiVqaiD4_waOIEjGeHDD8n44SAcjMOY_O-iZv27e3jT8rkUK88iotg>
    <xmx:HiVqagU6HrmKltA64uvXhWxtoGY0ad1JainBnKJeJ9Do0mttBNLh_A>
    <xmx:HyVqaqrkrtvypUUSvtz9VZQ7wtwuWu4R2ze5s1BkRRwlTd698W2FK27Z>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 12:06:54 -0400 (EDT)
Date: Wed, 29 Jul 2026 11:06:52 -0500
From: Ian Bridges <icb@fastmail.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2] ALSA: hda/generic: Replace strlcat() with strscpy()
Message-ID: <amolHJpiluNmBsDU@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its uses in
fill_pcm_stream_name() and get_jack_mode_name(). Both appends become
bounded strscpy() calls at a known position.

In fill_pcm_stream_name() the trim walk itself lands on the append
position. It stops at the trim point when the name has a decoration
to drop, and at the terminating NUL otherwise, so the suffix
overwrites from there and no length bookkeeping is needed.

get_jack_mode_name() measures the label once with strnlen() because
snd_hda_get_pin_label() does not return a length.

The produced strings are unchanged.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
v2: land on the append position instead of measuring before every
append. In fill_pcm_stream_name() the trim walk already finishes at
the append position, so the suffix goes down with one bounded
strscpy() and no length bookkeeping, matching the pattern of commit
86dc52c5c96e ("ALSA: usb-audio: simplify mixer control name
handling"). get_jack_mode_name() keeps one strnlen() because
snd_hda_get_pin_label() returns no length. Other shapes were built
and measured for this respin, including the seq_buf form suggested
in the thread. That one moves the fill-only-when-empty guard of
fill_pcm_stream_name() into all three callers, because
seq_buf_init() clears the first byte, and every call site grew.

v1: https://lore.kernel.org/all/alaPxW5S5PT_-kZi@dev/

 sound/hda/codecs/generic.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/hda/codecs/generic.c b/sound/hda/codecs/generic.c
index 660a9f2c0ded..5e23d1345b43 100644
--- a/sound/hda/codecs/generic.c
+++ b/sound/hda/codecs/generic.c
@@ -2712,10 +2712,12 @@ static void get_jack_mode_name(struct hda_codec *codec, hda_nid_t pin,
 			       char *name, size_t name_len)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	size_t used;
 	int idx = 0;
 
 	snd_hda_get_pin_label(codec, pin, &spec->autocfg, name, name_len, &idx);
-	strlcat(name, " Jack Mode", name_len);
+	used = strnlen(name, name_len);
+	strscpy(name + used, " Jack Mode", name_len - used);
 
 	for (; find_kctl_name(codec, name, idx); idx++)
 		;
@@ -5686,16 +5688,15 @@ static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
 
 	if (*str)
 		return;
+
 	strscpy(str, chip_name, len);
 
-	/* drop non-alnum chars after a space */
-	for (p = strchr(str, ' '); p; p = strchr(p + 1, ' ')) {
-		if (!isalnum(p[1])) {
-			*p = 0;
+	/* find the append position, trimming decorations if present */
+	for (p = str; *p; p++)
+		if (*p == ' ' && !isalnum(p[1]))
 			break;
-		}
-	}
-	strlcat(str, sfx, len);
+
+	strscpy(p, sfx, len - (p - str));
 }
 
 /* copy PCM stream info from @default_str, and override non-NULL entries
-- 
2.47.3

