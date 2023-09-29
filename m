Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF8516E0
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 16:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E10C433C7;
	Fri, 29 Sep 2023 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696003598;
	bh=JjvdY6vNRaU1rCbwGgkNSNDb81US03BKyTCcV+LEmPM=;
	h=Date:From:To:Cc:Subject:From;
	b=e30T/zR3Px8FY8bLmSHYEjXs067XxvqClj1EJBQHwpfJQBDSKfIUYiDAqJnrACHgL
	 ar2NOy1poMvsQsZFHuAP7WtSeEHsX1xrHfkABQgjApuw4IpBPZyaUOTdDN4b+W0tOa
	 FVR6oL2W9qAep9+fTN8nOD93r6n8TA6P64JmUr6q1OFetkZhEjMrY2EySQdES1wcv/
	 0ewYZ3u+FKNvtFxeFG6CFSmTpsFC4sqqDryE2lr2DgH15NNcOr33pnHti682imoHjc
	 c9KoRsJHI0PxhF6iVdprbM1byqep7GcCeCqlXiwx2nFjlZGKDlt04FTospMVv4hjG6
	 bdv/SgZsrBSGA==
Date: Fri, 29 Sep 2023 18:06:32 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 midi_runtime
Message-ID: <ZRb2CKHuaCu0u38i@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`struct urb` is a flexible structure, which means that it contains a
flexible-array member at the bottom. This could potentially lead to an
overwrite of the objects following `out_urb` in `struct midi_runtime`,
among them a function pointer.

Fix this by placing the declaration of object `out_urb` at the end of
`struct midi_runtime`.

Fixes: c6d43ba816d1 ("ALSA: usb/6fire - Driver for TerraTec DMX 6Fire USB")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/usb/6fire/midi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/midi.h b/sound/usb/6fire/midi.h
index 47640c845903..df3f41913274 100644
--- a/sound/usb/6fire/midi.h
+++ b/sound/usb/6fire/midi.h
@@ -22,12 +22,12 @@ struct midi_runtime {
 	spinlock_t in_lock;
 	spinlock_t out_lock;
 	struct snd_rawmidi_substream *out;
-	struct urb out_urb;
 	u8 out_serial; /* serial number of out packet */
 	u8 *out_buffer;
 	int buffer_offset;
 
 	void (*in_received)(struct midi_runtime *rt, u8 *data, int length);
+	struct urb out_urb;
 };
 
 int usb6fire_midi_init(struct sfire_chip *chip);
-- 
2.34.1

