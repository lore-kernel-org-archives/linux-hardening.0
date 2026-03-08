Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53506328B58
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003323; cv=none; b=UvOHJczzbNF3Drr7bZqpivRFuN/JfRV+8ML6EvIGRl+xnh9Gt7gXyRi0UUDxLw5CYIOPQo3SkupPMGwLPHMwuo6udHLHW8/0sdzahlGArs03q+xKBLOaBlkTk5qOPwBbSrp5+z/UvaGlLFY9OTibwxf6sEGNHItaqEbV4op/CdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003323; c=relaxed/simple;
	bh=V+HaIjOxeZCvqXsVvP4U91p/1MNE7Xa2RqirRnIi+Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqD99oZusJeIpISj8A7pqKvXIR0RTi7gkUrCQwA/ZUJdvD+OimvU9yxx4bPVij6LhCYdskeKM427dt8rwG83zC0pUu78Mro5GtZvQ2Dp68fs6qTAGsXej7cPNKozEzbgPwM+29p5J2DB/eozbc3/5KHMPBHDeyrMdtdDEXFOVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYL2LuRX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYL2LuRX"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3598df39444so4652178a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773003322; x=1773608122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSbXQF0TQ/oDDYSYqKtbfxF1Vwex7qbylX5vtAN5cVI=;
        b=NYL2LuRXV/lfh7HitJmrW+4anrxO+JyAloZDn1LzlCATHj1ZWUb/YlB7khmikVwEF4
         J93r9H5p7zLOc3Q+5QrJ1Wsg7bw7VQAwYzjjpelur/F/UdwrW1o83AACINJnU98ioIPR
         i0M7E8888eroHb3CH53XnBccWEgJyhNKol5mmpV1wWOWsb6X14VIZi9WlVb2ffpDRyIn
         TfLoTl3YnpoCzhxNuN7zu7SzEdcjTcTkl9XqMwTcoO5lVM2+CP7RFIsRnwq/ooX77qGN
         FpOKK5foYEuhve3RHxhwj/CpKPw5kkVr0ZQezXcl7uUPhMgJNJ37DigEP81cIQR4gqnh
         2xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773003322; x=1773608122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSbXQF0TQ/oDDYSYqKtbfxF1Vwex7qbylX5vtAN5cVI=;
        b=HH0/KrYHDCZHrWJTQLDr+OQ0/8oYzE96TGDzIfbNc8QOtqmOlI+sUdXeLB260vlCbg
         2YHzO+rZ2qgp3sgKbTvJ5o/Xp1E6y/hpJkk1kl41CZf/AUVV3EKgPjGbR9maJXw3VBua
         S6rKmI+W24SDMYttTG1teU1RkG84gMbRRq3Su8LUXxd75JPKEjPAlbLirKm5DUbMZEJr
         6ZM2Akm32/NuQgO8+/EeiO1zlQHC2SzJdo8HnQSNrSDKewITt5k6dDFsuEMEgJ3ZAzvU
         YutpBlwwqEKAj3xi5LbHnjutoIoprbeApa5OFT4VtYgYLVnWREycSQV4LAouTh2/dHdT
         lI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsOUwhAtRalkD0Pq2bYQUGOWztgSVs4wUSI/+7EppKnxX4aEuoGBMHv/wk5kaLNfJSidjpucQct1VRUdJGx9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsR8iBsoHMHzkOb7G5iuJ+ikUj8MeIMWuX8STlk6swFgwaaLpn
	lXatzGZNwWUFb0n3oFNWqEWNpWwmJ2RwAiHPwZwJPrmKGn5e2+Z0/dnKQBOI9gK0
X-Gm-Gg: ATEYQzyHDFNbpawXsp9cq8g3mp5bh+23mMBJ8QkHP+5B5NUB2O6JNi3pWgavW9H6RbT
	RpyqJ8Bhrz4CD+IphFWgMEwjmWQHmafZ5A70qTkmSDnWM+KyUCT/ugBAWpG8WLA0+4p/MPZrDY4
	iojsGrws7POdibH78IoXlwVo8RuMs8KDgO3hzZ0GcCuDOLQV+qOH1DU+j6eQkBz0xhdr66SX9pK
	dx+mC85VNVIeyg3EPk0BzD44bg58CDf6z/cW35MGyGaPucYZKvEV1IG5XgC7jGVv3t/Mi0zgwr5
	H823z/jPkN41+M2gB0cO6lStrAt5mqzTR5xd45HizoHQUAbB3I/A3yy2lfkPnLcGHjoF7uK3eNt
	eUQy8nIiPcgqf4EKoRbAoDTZPqdGJ1FF52R+OKC75ObdPurW5UEcMhpis+cT8eos8FvchrquyHn
	LC9HqAU2K9uIYQS9LZWMQePOl4/eeK6bKbyQHS6DoxiTqTYr70Cl2RgkufKs/K0z3L
X-Received: by 2002:a17:90b:33c7:b0:359:8eaa:7f42 with SMTP id 98e67ed59e1d1-359be2f90edmr8194647a91.18.1773003321560;
        Sun, 08 Mar 2026 13:55:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e195c40sm6951607a12.31.2026.03.08.13.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 13:55:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH ath-next] wifi: wil6210: use kzalloc_flex in wil_tid_ampdu_rx
Date: Sun,  8 Mar 2026 13:55:04 -0700
Message-ID: <20260308205504.26819-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use it to simplify allocation and freeing.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/wil6210/rx_reorder.c | 13 +++----------
 drivers/net/wireless/ath/wil6210/wil6210.h    |  4 ++--
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/rx_reorder.c b/drivers/net/wireless/ath/wil6210/rx_reorder.c
index 5841098ff8f9..3f11c6090234 100644
--- a/drivers/net/wireless/ath/wil6210/rx_reorder.c
+++ b/drivers/net/wireless/ath/wil6210/rx_reorder.c
@@ -241,21 +241,15 @@ void wil_rx_bar(struct wil6210_priv *wil, struct wil6210_vif *vif,
 struct wil_tid_ampdu_rx *wil_tid_ampdu_rx_alloc(struct wil6210_priv *wil,
 						int size, u16 ssn)
 {
-	struct wil_tid_ampdu_rx *r = kzalloc_obj(*r);
+	struct wil_tid_ampdu_rx *r;

+	r = kzalloc_flex(*r, reorder_buf, size);
 	if (!r)
 		return NULL;

-	r->reorder_buf =
-		kzalloc_objs(struct sk_buff *, size);
-	if (!r->reorder_buf) {
-		kfree(r);
-		return NULL;
-	}
-
+	r->buf_size = size;
 	r->ssn = ssn;
 	r->head_seq_num = ssn;
-	r->buf_size = size;
 	r->stored_mpdu_num = 0;
 	r->first_time = true;
 	r->mcast_last_seq = U16_MAX;
@@ -278,7 +272,6 @@ void wil_tid_ampdu_rx_free(struct wil6210_priv *wil,
 	for (i = 0; i < r->buf_size; i++)
 		kfree_skb(r->reorder_buf[i]);

-	kfree(r->reorder_buf);
 	kfree(r);
 }

diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 31e107c81e2d..768e6573cd29 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -659,7 +659,6 @@ struct pci_dev;
 /**
  * struct wil_tid_ampdu_rx - TID aggregation information (Rx).
  *
- * @reorder_buf: buffer to reorder incoming aggregated MPDUs
  * @last_rx: jiffies of last rx activity
  * @head_seq_num: head sequence number in reordering buffer.
  * @stored_mpdu_num: number of MPDUs in reordering buffer
@@ -672,9 +671,9 @@ struct pci_dev;
  * @first_time: true when this buffer used 1-st time
  * @mcast_last_seq: sequence number (SN) of last received multicast packet
  * @drop_dup_mcast: duplicate multicast frames dropped for this reorder buffer
+ * @reorder_buf: buffer to reorder incoming aggregated MPDUs
  */
 struct wil_tid_ampdu_rx {
-	struct sk_buff **reorder_buf;
 	unsigned long last_rx;
 	u16 head_seq_num;
 	u16 stored_mpdu_num;
@@ -687,6 +686,7 @@ struct wil_tid_ampdu_rx {
 	bool first_time; /* is it 1-st time this buffer used? */
 	u16 mcast_last_seq; /* multicast dup detection */
 	unsigned long long drop_dup_mcast;
+	struct sk_buff *reorder_buf[] __counted_by(buf_size);
 };

 /**
--
2.53.0

