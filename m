Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0DE41DDF9;
	Tue, 14 Jul 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057803; cv=none; b=HxkhPSGqVdqW5EqGTqum8RjWhpCCdf2Hm7V/07FAxWYRAQhpjSwQQx4pkqk9CH/5AYPndWZresYyykB13sKVutHrlPQKQYQ/ro7QiYmvacdu90C7H5Bpryv3UzQ27yPteSSnLXibbvoy3xhqSiSRe8ASxI7h/Ol+Nq5XQdmrPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057803; c=relaxed/simple;
	bh=/m3Qkuf6/ar3+WA6/bC0iH3GQf1MX3/OjuI6168hCgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=laBbzI98eB3aDXhaj2jWHbrVy5z7Y9op05H2/r9/dyvH97muTMjzHltJg0TBWWdzYt+FcbBLwWeRsjtWvy5XmCMjvWoVkVMd/oMG7i8uawP3bLWTCEBayxr8P8BlnOie66+MsRvVqZvGbAk83sC3w7sPwEuPo6Boa/yU2RPph08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=k4wrp//1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+J+64c/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="k4wrp//1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+J+64c/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C9AD91D00025;
	Tue, 14 Jul 2026 15:36:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Jul 2026 15:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1784057800; x=1784144200; bh=bBepFvY1LKlSxlgL4l06nBRvhcWtf9at
	VR4FTFTQN/s=; b=k4wrp//1Hq1CGzDI2Re45jcIxItk/kyClRcbmdhZyqL/tPPV
	O2UiQ0WkV+K0+017+4bZAQ2I4evnybgV/0WBtcQk56m4jE7xXztaKQUItXS3sMJA
	4ltmx1oOslBByUMRfLB4aR/LufKOgMm4I4gu5o6JwAhz8HzuMvqDMxMPD4vS2i/s
	XyXEVEB0nWmcZLm1Q8WluFoFsig7gXXKiU5HXUk35opAyQAlKXqd/6IMQ1H1z1+V
	Yvw9CRVnltlbKDyAcCz+6/PCgyC/zP8Qr6gZLXcE5hJupAChY6MjXBMUj6AUF3WO
	5iw89TvCQh/i7TR+SsbEksbm2zfcmIFb8ZeaNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784057800; x=
	1784144200; bh=bBepFvY1LKlSxlgL4l06nBRvhcWtf9atVR4FTFTQN/s=; b=m
	+J+64c/T6SSEGgfmzf7WOg9pVRnMrBavbfPWxArJed635s/F/xdQ2+MpFO3FEQiu
	nVffHMgIpt9Lvf3TEfR9+zAqOX+q7PYQu84e0Jxun+QHmjBpfggQ/RrdwiLTbqvu
	WlS5RpUIb9o7JiPtOGBlQU1tpR6NgiApDMFBTIHR1yKAw2CSFb0qccPoKar0Uk1q
	+lDa/Vl9sAvdqWNtBxznmYqJ1lsmfqjeTbbQNfM9oOdLOTHhCOObJrGrLfep8oTh
	5F1WkDCI3I+r7SgV518cP5907v63pCNrYmhdPRHc4EY9piLA6yDwhgS+unHo/LE8
	bIEnR+JO8hKUSN0rP+/2w==
X-ME-Sender: <xms:yI9Wak5UvcDZJH-yVQwD8BIi6WbcsVlQJ2UpVFs8bPvom220DBdanQ>
    <xme:yI9Wau1SP4qepowCipP6RggHuwtW2HqOuBHWh5wbJHmH2It7uYfXrCY_jrGMsm8gV
    JrAHEwcF4FDd5KhrAkfQHpHTAHQ6tohK4N8IjWUB-4App2xFL56VLY>
X-ME-Received: <xmr:yI9WavCELBBmWiCRSzp6FREQpkqr2NG2283GOrBVeedv2glgtvMmpM0BC6k>
X-ME-Proxy-Cause: dmFkZTFI0lKS02VttvzmWLTXz6Ea7hhNAxH/RTsvO02/LouO39/kpuqH7Bk5BkFAxAhIvM
    9M+aAfcrUc03JSDKF8zi8FaT1wEgW6y3XnXHs1X6MAIkj7D1Yytui0iN7f1uYtCTVHBw0F
    hH35fpYkURb+1CWWCRcNrCgu42z3NkozeFUD8gx7JWdYDAn5QPinOiUgevXCNQyH3xD/WH
    Ne1QeFYw11DjcUYrIOKRMM9kahikcCCqKlqWbgwCErgkKUKrQgkXdaXmC6zkj+mCq+Qk38
    W/W4tit31xd6hpv+J3gEjBmKZUnyhBx1Z9WNYBLRML9+9ailxbSZPuU0jW/xQwTHSnXIYY
    P4UkJSS7+G6SDh7KcEMyZN9TEBUHtnZeZECLjNDD0ReyDNtBFufMBzV/jGzF9eLSs6hbTk
    5Aeg/zI+qWfLxrsV6sZxks9GHKgld8l80TXtvj6wE3eMERaPERyNefL2eLNGlw4Me10Xsl
    gn/J8egnMhn4qrH0eA5AK0J0HBzYIl9rTZSH0mr2jSLXATI0/WOk5ruAvbhw3M7Qu5Snen
    hl+A/uur/NryV6KewHGF8lHhN0z7jqsrgVLNqzDCSjdWRcFZ0FRMRI4AsKLtdlkQ+4ne1G
    58uaRzx4M92mObjfzXyGpjVYEyBHvvJiVHT/PINaXzo2Ser4B9ofFU27kDrA
X-ME-Proxy: <xmx:yI9WapN7FYdVciZoq8h8Vy9LtUIc643jrP3yw3WLSdacI2HUQXEYUw>
    <xmx:yI9WakYKc393qoaVJez5R2AeCqDs1j_c96lm_Q0Z4Me-trScKbrLPA>
    <xmx:yI9Waouzq6-y4KiAP6h0XrCcAzJXp5NemPxEQAdOKzXb3gZF_5m9sA>
    <xmx:yI9WamMjBITZF4u9VPCwKDKe2CCUIFcICOAYrj_XzMhIFwgfkkgX7w>
    <xmx:yI9WarpJJzSF6n4OZgyF--6psUzDzcqLdqfzDt4d5zSekXiwEaDz7jnX>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 15:36:39 -0400 (EDT)
Date: Tue, 14 Jul 2026 14:36:37 -0500
From: Ian Bridges <icb@fastmail.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: hda/generic: Replace strlcat() with strscpy()
Message-ID: <alaPxW5S5PT_-kZi@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its two
uses in the generic parser.

Both call sites append one suffix to a string that the function has
already bounded to the buffer size. A strscpy() anchored at the
current end of the string writes the same bytes, including when the
suffix is truncated.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
The patch was tested as follows.

- W=1 build of sound/hda/, zero warnings.
- A userspace differential harness compiled the old and the new
  functions side by side. The buffers were byte identical over their
  full length, including the bytes after the terminator.
- A QEMU runtime compare. A guest with an emulated HDA codec was
  booted on the base and on the patched kernel, and the captured
  /proc/asound state was byte identical. That covers the PCM stream
  names from fill_pcm_stream_name() live.

 sound/hda/codecs/generic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/generic.c b/sound/hda/codecs/generic.c
index 660a9f2c0ded..5f373cbf4a53 100644
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
@@ -5682,6 +5684,7 @@ static const struct hda_pcm_stream dyn_adc_pcm_analog_capture = {
 static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
 				 const char *chip_name)
 {
+	size_t used;
 	char *p;
 
 	if (*str)
@@ -5695,7 +5698,8 @@ static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
 			break;
 		}
 	}
-	strlcat(str, sfx, len);
+	used = strnlen(str, len);
+	strscpy(str + used, sfx, len - used);
 }
 
 /* copy PCM stream info from @default_str, and override non-NULL entries
-- 
2.47.3

