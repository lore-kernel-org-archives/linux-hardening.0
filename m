Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6913A759E
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486230; cv=none; b=pUnv0g5vQ7ttHzXj83HQI6UXFtTXBTWY2cJM2+qGvSfSeaq9wruQLSejwiJnyTRxSxW7OEzM1TF55NIpa2PWlV4kLGAS6yrqtCiwMmFds4Lp9CWjmnTWzTrvKEzKDg6kHy+MKSBUiUPOyRjUuzmW4X4UTT8de1JwYD02g/symDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486230; c=relaxed/simple;
	bh=8fKsYpQ2rofgYvPFqVTqHqV3iwH1OdGnQ3Q0OFMQAZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVMdyZgs+9FgIR45HDySML6SMxqd/zahqTGpXhDckPrKqTyvCFUFlVWl+/Wp7ClU4DDRRuwJTV+dvbR/xvZDpHPQiIdYC9xkVbYtBPn0rFPdDLwtQQHpdvBCdLRzUDpRuZWSefGWIWnBxUXVdOLuL/18hlR2vyPN0kZoO6PJhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+zTVlho; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+zTVlho"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-835386ff122so3625897b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486218; x=1779091018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuDIDre46wS+yv63NbwPzOOkKtvuj3ZvNxFH0y1TnKY=;
        b=f+zTVlhokB90lRHfBWoCedoqsBEu9XCTA9heaFXin8XTojburHmH+SIn+JKDuIRw0n
         Y3UrfJP5OGoexgkY5jz3u7jnNoM4/0Bryw8d0Nnpxem21KRPRGoO1ShO6aXdlHwZoGlN
         hafhJZ9WfF09VnVX25ORkuy1iBot5m5o/6d2rCk62h/+pFLLc8ef3QN3yEH0DLRKnBRd
         /iTGAyIFDTibOCIIQM3fcIptWCZ83SbUHQcRFIfFmD/5/pcg7r0443EOO+r/B0OGGXLz
         JSk2oFnAksQKlZNviHDUUOEsvxBYLVt4AylH6ROPUgUykgU4MAME9itgkNRASGa588fT
         DptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486218; x=1779091018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuDIDre46wS+yv63NbwPzOOkKtvuj3ZvNxFH0y1TnKY=;
        b=EagTFmjGmWV6efNkLTEGoARvG/XE8bWhzIJeyFqfrHSvOjJnMm11mG6bdlc4twAWWR
         ZR4j/OM93AAOxomY/U0T6mPoM8Abs7ItLDAiaRGZ6WJippXxYR5B0Iszhue9XSZACAuV
         /1Po+/wKFyKpOY57LnjVhHR/YA8FKxRTwhjbvwJQ/InS1EOL2mwSTbDI3IGk210UIg8D
         +g2pDmtZQHKoK1O3Tn/7zky9YXgCCjDZibwZ2OUXORloDbroBeSJPTMCUZIm1rglIu0K
         b1E7CPNp02KkF5QJOOrglk/ifoD0gsmMVN0eP6flnf/f/KEBFwandTSWb5EBNkBsuKiQ
         lXmw==
X-Forwarded-Encrypted: i=1; AFNElJ91cDtPW9AcgF+6lwkjIktXO0jfOvitAbg73M4TnkBmxp11EODmounAw3FBKKwWbJrXFLuQ0slnfTtF4ZyK5vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXPVGKFFAz3ppMjXmDSQEJBy5SrV5lEGRNbMEyXMKHXTmrQ1/
	L7LvFyIYobJahVbZkikMW3ffW2XUq6wdg/MxeJK/4QBl6tSI3y3Jx9kq
X-Gm-Gg: Acq92OEEVCPXB+SCe0Bszfbe6M2FiATx2+I3VX7q+HC0lTAQakKE+ug4rZfhDaoLRCi
	CyBrZAiHtSFni/uBVL8/6CzV7EjjOXqnRagqocpU9zxF97DCdYSoEAx6zBBpcXU6EU2z9NgwO3l
	rtdXpYMh6zDk6Exmsz9I/GrtgEpRWjzgIWNZnlzPKR0dOP7wxtLu8j/9kvGjdlt/v0Qpympwhsd
	DAXxL8gYl/waoqVoE2de6AIj2AQnbJgdnsywPdjt86bgxgxTuSvFa4isMaGEQsOSwGropXU7H7s
	RpPR6udaUFgoEl1vINUgnGybRjAUcazSbMx9LH5QVkwPExzIpHh7GpZ70Tr9Vx/K8LrZ+G9hD1a
	0QbC3MHc1Mcm66xheFN6boeNUV70El5pW1e+yuI/BGoTV7IwNa++XXjfRW4g+CvZcA4VqamWOSZ
	ua3iCj0MfILYPPpjfGx9ojE4tE9GaTDdc06hPQ5oUyAS5FgvQfI8QOiwCJPvTG3IyrIp6wCcGqP
	yj1OSd/s2i9PLF/9sHJoWmdKXVETfmwdF0=
X-Received: by 2002:a05:6a00:cc1:b0:827:2a07:231d with SMTP id d2e1a72fcca58-83a5c4bfddamr21886438b3a.17.1778486217918;
        Mon, 11 May 2026 00:56:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm23680825b3a.41.2026.05.11.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:56:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Christian Lamparter <chunkeey@googlemail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH wireless-next] wifi: p54: Use flexible array for channel list
Date: Mon, 11 May 2026 00:56:40 -0700
Message-ID: <20260511075640.446181-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store generated channel entries in the p54 channel list allocation
instead of allocating them separately.

This ties the temporary channel entries to the list lifetime, removes a
separate allocation failure path, and lets __counted_by() describe the
array bounds.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/intersil/p54/eeprom.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 95580921d933..c617bec787a3 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -77,10 +77,10 @@ struct p54_channel_entry {
 };
 
 struct p54_channel_list {
-	struct p54_channel_entry *channels;
 	size_t entries;
 	size_t max_entries;
 	size_t band_channel_num[NUM_NL80211_BANDS];
+	struct p54_channel_entry channels[] __counted_by(max_entries);
 };
 
 static int p54_get_band_from_freq(u16 freq)
@@ -335,24 +335,21 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
 	max_channel_num = max_t(unsigned int, max_channel_num,
 				priv->curve_data->entries);
 
-	list = kzalloc_obj(*list);
+	list = kzalloc_flex(*list, channels, max_channel_num);
 	if (!list) {
 		ret = -ENOMEM;
 		goto free;
 	}
-	priv->chan_num = max_channel_num;
+
+	list->max_entries = max_channel_num;
+
 	priv->survey = kzalloc_objs(struct survey_info, max_channel_num);
 	if (!priv->survey) {
 		ret = -ENOMEM;
 		goto free;
 	}
 
-	list->max_entries = max_channel_num;
-	list->channels = kzalloc_objs(struct p54_channel_entry, max_channel_num);
-	if (!list->channels) {
-		ret = -ENOMEM;
-		goto free;
-	}
+	priv->chan_num = max_channel_num;
 
 	for (i = 0; i < max_channel_num; i++) {
 		if (i < priv->iq_autocal_len) {
@@ -401,10 +398,7 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
 	}
 
 free:
-	if (list) {
-		kfree(list->channels);
-		kfree(list);
-	}
+	kfree(list);
 	if (ret) {
 		kfree(priv->survey);
 		priv->survey = NULL;
-- 
2.54.0

