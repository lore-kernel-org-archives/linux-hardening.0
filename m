Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD083AEF57
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486117; cv=none; b=MaqnjIXN5wsszyK58AnxsgMh7LlcSQcj9Fq03BXMSoe0v8hIX+aNrQkqW/br9eajzOqlYjYCn+0HQgVVdnALqeBryp7TY0jSpF+ciOVrukzAUbJDFVO6MP/Y3oYK7cpVwJ8UHIaQcuvxkoyMToLXlV/27miUbUxhgCnUYBH+k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486117; c=relaxed/simple;
	bh=RvxwmdSiS+ysihBmtuaAlsjP4h9VAcJpN8WPUqG+GWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ua88EeY9n2F1/vgI8IhVi3bZOGv5++zzZ3J+vSsb0nWpanGe7YX5iXoWgLbuTskg79KluoFldD2v9GGD94wQhGELCrb/JbkRXQwtjfEfn9xW+6tdFRXyMQGNafV3mtGWhqg6HfbLja5RLx4P0xGP+qsRoNJRAyBlbsU7PyXvhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLYYJ+WV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLYYJ+WV"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso983030a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486104; x=1779090904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13xuXwVyqvQTA5bNs1t2Swfq8JbojPnN3d374a7kRkw=;
        b=dLYYJ+WVDHjt2fGvwi9tdXzTsu7D1uygw/ekbz3wb8ImwyBSGLKB6AJmZPIaj06PMd
         LnzMRnRlKTfPY51/Z9r5xmQfBR2Cbbq50DJHMEFzNnEVIj0igQgIUMQjqOycFwXPpbrB
         CikVMDZnAFMMaSDphx6JFApb1CZRz0o+vVaXbu7ir1NFLHk2lZrkMNGWY6kLLX8gcP/V
         RC1CtgmZOBHEYDqzFlRHFAXg8IvSlLe7JzpSfIDulMf82oWVNYKYG/NS2g8zqnytXw0W
         ITsrjek8JUsxJCVEoNujx6Od/s0GF2JayO02seR+zIOLromSfglph+CgB5ncxPMLicfO
         6kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486104; x=1779090904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13xuXwVyqvQTA5bNs1t2Swfq8JbojPnN3d374a7kRkw=;
        b=DnLNv2VpWivzQ6+CZADEGCKza5ntNl0VFwtfhucNri9JzzZ3CJVCeIM6ND+JYk9LxO
         FRzDWll83ex6B7dLOVdeuE6gy2bOo3Ev4vuL/mUKEjbBEfG18yThugnVDfpWhFn4jqBN
         VZkpISqQXiEoYCA67/AIVZKoTWwIgR/J+3VVl5CWSXea3+Tf/fWVF4CZd2c3gkZLJbI7
         AG3TaQv2lRNCZFHG1j/A4pwvVFznYvfxiiRb+kcVGWh3vJUVgOhvSiQgktYlo8/MwkRv
         GUTtfWCrSMmG/Bl4HUoxxxfloedG+SPFBpze7jHU/OwuSHuybTsIfaaV1tl2uhhHxxTM
         eyFw==
X-Forwarded-Encrypted: i=1; AFNElJ/pTAoZC4fDSZ5rrUOB7YCcEvrO4pWVM90b0SFMphGGG46LQCjzeZeOwLXmcVnzhNARsA2Zmelwf597FGrgGp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFxH+Y+/3jyZ8Ciq80bfp7Gbq8YJmTKJXaB0Kd46dllPeqJga
	3ZYOLgh9ivI+xTkBTYJLrFM0/fhIrBzjovGBePCulu8Nk3i2bv0AirKqX9gD8L0A
X-Gm-Gg: Acq92OEhoxw1t0Yp/ysx/zz9OJuNYWTlAq11LwDnIT6XM67zMLKB6RSmuAX/sKQ4xKZ
	/aNnNq6ArfpiAQvUzRqGG2tRQAskSwX+AG2XxfdrY/L2ViZMAgYM5J1PT1S2T8M9VjYIqRn/a4p
	WkxA5IqO6ShGIn90oa6TnkSMDVm/NS9UH5jj0LuudHGM8Y4Ad6ju+We262JwBUhSzPXeqNieFPi
	JJ+nGbSWkigUQpkiwYLhBZEh6O5ynKoAIAnMygudwBXQuJMX+QKY+ZCgPXJDacYD4z5SJETJ65O
	t8UxupEpt28CabUbLzBB2uPVq8PVdGzZSE0lpaLMoBWq6JR1WRnlTbmMero1dFuSQE0Nw8+I7dW
	hUsyK9MzBN6FNS7eEoiSxjnZu0XWgD6Sv5S8tUnzRcy4RlHvNk6ShDgEYnf9pECR812GoQU8qbg
	YLToK927O2lupITiZDunHACmCF/OXQMWaNF3dgXdtHF+GhsDGKlDR1WEBDtFZAKLL43tWPe/EKM
	WxXyjFWBAdtSNCDTJWYD7QUD1O4TjoUmbo=
X-Received: by 2002:a17:90b:1647:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-3662e1f05b5mr16303587a91.21.1778486104281;
        Mon, 11 May 2026 00:55:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e359b0sm88494425ad.51.2026.05.11.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:55:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ALSA: seq: Use flexible array for MIDI channels
Date: Mon, 11 May 2026 00:54:47 -0700
Message-ID: <20260511075447.445350-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store MIDI channel entries in the MIDI channel set allocation instead
of allocating them separately.

This ties the channel array lifetime directly to the channel set, removes
a separate allocation failure path, and lets __counted_by() describe the
array bounds. Move the embedded emux channel set to the end of its
containing structure so it can carry the flexible array.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 include/sound/emux_synth.h     |  2 +-
 include/sound/seq_midi_emul.h  |  6 +++---
 sound/core/seq/seq_midi_emul.c | 38 ++++++++++------------------------
 sound/synth/emux/emux_seq.c    | 11 +++-------
 4 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/include/sound/emux_synth.h b/include/sound/emux_synth.h
index 3f7f365ed248..2c0a976e00ab 100644
--- a/include/sound/emux_synth.h
+++ b/include/sound/emux_synth.h
@@ -125,7 +125,6 @@ struct snd_emux {
  */
 struct snd_emux_port {
 
-	struct snd_midi_channel_set chset;
 	struct snd_emux *emu;
 
 	char port_mode;			/* operation mode */
@@ -138,6 +137,7 @@ struct snd_emux_port {
 #if IS_ENABLED(CONFIG_SND_SEQUENCER_OSS)
 	struct snd_seq_oss_arg *oss_arg;
 #endif
+	struct snd_midi_channel_set chset;
 };
 
 /* port_mode */
diff --git a/include/sound/seq_midi_emul.h b/include/sound/seq_midi_emul.h
index 88799d1e1f53..afc765437870 100644
--- a/include/sound/seq_midi_emul.h
+++ b/include/sound/seq_midi_emul.h
@@ -55,14 +55,14 @@ struct snd_midi_channel_set {
 	int  client;			/* Client for this port */
 	int  port;			/* The port number */
 
-	int  max_channels;		/* Size of the channels array */
-	struct snd_midi_channel *channels;
-
 	unsigned char midi_mode;	/* MIDI operating mode */
 	unsigned char gs_master_volume;	/* SYSEX master volume: 0-127 */
 	unsigned char gs_chorus_mode;
 	unsigned char gs_reverb_mode;
 
+	int  max_channels;		/* Size of the channels array */
+	struct snd_midi_channel channels[] __counted_by(max_channels);
+
 };
 
 struct snd_midi_op {
diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
index fd067c85c524..a90ebc7b3811 100644
--- a/sound/core/seq/seq_midi_emul.c
+++ b/sound/core/seq/seq_midi_emul.c
@@ -81,9 +81,6 @@ snd_midi_process_event(const struct snd_midi_op *ops,
 		pr_debug("ALSA: seq_midi_emul: ev or chanbase NULL (snd_midi_process_event)\n");
 		return;
 	}
-	if (chanset->channels == NULL)
-		return;
-
 	if (snd_seq_ev_is_channel_type(ev)) {
 		dest_channel = ev->data.note.channel;
 		if (dest_channel >= chanset->max_channels) {
@@ -642,23 +639,6 @@ static void snd_midi_channel_init(struct snd_midi_channel *p, int n)
 		p->drum_channel = 1;	/* Default ch 10 as drums */
 }
 
-/*
- * Allocate and initialise a set of midi channel control blocks.
- */
-static struct snd_midi_channel *snd_midi_channel_init_set(int n)
-{
-	struct snd_midi_channel *chan;
-	int  i;
-
-	chan = kmalloc_objs(struct snd_midi_channel, n);
-	if (chan) {
-		for (i = 0; i < n; i++)
-			snd_midi_channel_init(chan+i, i);
-	}
-
-	return chan;
-}
-
 /*
  * reset all midi channels
  */
@@ -687,13 +667,18 @@ reset_all_channels(struct snd_midi_channel_set *chset)
 struct snd_midi_channel_set *snd_midi_channel_alloc_set(int n)
 {
 	struct snd_midi_channel_set *chset;
+	int i;
+
+	chset = kmalloc_flex(*chset, channels, n);
+	if (!chset)
+		return NULL;
+
+	chset->max_channels = n;
+	chset->private_data = NULL;
+
+	for (i = 0; i < n; i++)
+		snd_midi_channel_init(&chset->channels[i], i);
 
-	chset = kmalloc_obj(*chset);
-	if (chset) {
-		chset->channels = snd_midi_channel_init_set(n);
-		chset->private_data = NULL;
-		chset->max_channels = n;
-	}
 	return chset;
 }
 EXPORT_SYMBOL(snd_midi_channel_alloc_set);
@@ -717,7 +702,6 @@ void snd_midi_channel_free_set(struct snd_midi_channel_set *chset)
 {
 	if (chset == NULL)
 		return;
-	kfree(chset->channels);
 	kfree(chset);
 }
 EXPORT_SYMBOL(snd_midi_channel_free_set);
diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index 2ed01e9d79bb..01ad5b12b680 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -132,19 +132,15 @@ snd_emux_create_port(struct snd_emux *emu, char *name,
 	int i, type, cap;
 
 	/* Allocate structures for this channel */
-	p = kzalloc_obj(*p);
+	p = kzalloc_flex(*p, chset.channels, max_channels);
 	if (!p)
 		return NULL;
 
-	p->chset.channels = kzalloc_objs(*p->chset.channels, max_channels);
-	if (!p->chset.channels) {
-		kfree(p);
-		return NULL;
-	}
+	p->chset.max_channels = max_channels;
+
 	for (i = 0; i < max_channels; i++)
 		p->chset.channels[i].number = i;
 	p->chset.private_data = p;
-	p->chset.max_channels = max_channels;
 	p->emu = emu;
 	p->chset.client = emu->client;
 #ifdef SNDRV_EMUX_USE_RAW_EFFECT
@@ -182,7 +178,6 @@ free_port(void *private_data)
 #ifdef SNDRV_EMUX_USE_RAW_EFFECT
 		snd_emux_delete_effect(p);
 #endif
-		kfree(p->chset.channels);
 		kfree(p);
 	}
 }
-- 
2.54.0

