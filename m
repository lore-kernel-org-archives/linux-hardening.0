Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FE23A9BD
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767019; cv=none; b=jm1mm8oVirP3DkIyhgrXTJ7a8V5+xnrytWRFe9qIXSkejUYBt7iNGD4hS+JCMxbO1PVDApnK3DEoUnljQdo0HTVHyNvgr+bbmpk94FUCIYtb0+UC86KoGlWfhHaOj3IydXn/jnGTFeE8MqXFtkDIb1GPlIxJU2wqK5J31QMb3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767019; c=relaxed/simple;
	bh=m68gnYmctKVpeghMNZk6qG10siwQrI61Fd4jyCWFufU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/UQEAURF2NuM1IgKFhuqg4NqpUvSqyukFgMQRnPixmP0zO0bmWKNo4gCLSv9Vyn8uY5uUJ8EK+4MjSGA1OJyadI/mqK60RImYLV+oLVVhsai4xqzHBys/wLqpM8yVNUjmFPBsNbNNEd6JyE+Ooc1nL7LGEKtum8Ng4XXyvQ7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlwN4eXQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlwN4eXQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae505619baso30883435ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 19:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772767018; x=1773371818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoG/ryHBSZlzW7QNKPkSRF4IaoRTutm96Nzl+aL2qjM=;
        b=HlwN4eXQNE3ekE3YOv9efdQMuAI0mQ2cc5dTNpBIBDLPo+6ShBts0/5ABLbvDp8pzX
         MZ3tCAsrQaBmgOYvac5Q4EZlVQvfiIGl/1SRZLm7N7+ri46+l6hz1jJZRXLENenY4Oni
         7hBj60f3P6SjFhKYURdJs6Bao8NaubdHjoHRvxDSa8rwqMkz3tK/YQHD7fO93QuIP5P/
         PBG3xUXkC3IndBqcOVzl7bCnwYkHd5NDSzd7ClWdTHk6f2l70mU7qrrk3oIUhlxUEmRc
         QVObJT9g2qcbOKbNl8MqaNAlxq9RREAl280Y+gRWY/EYAJEeGP+6EPexivkKdBW7Emoe
         H2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772767018; x=1773371818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoG/ryHBSZlzW7QNKPkSRF4IaoRTutm96Nzl+aL2qjM=;
        b=gFP0EwkZS60q3+3s7jh8L6Ge1aEmUsMRUx0qOM4ixFNufxSS+o+zEd2M4mF87WPaTL
         I50rSDmAb99l2Et//HrL39cS3Nzboi9v1toz7jFBaeiSS9aaFFwReheTOinXBpicAMZq
         /C9X7Xy4H8fzuRCDowAEhLcKopZpanwsyvrwZyfAfntTwcp7cACiJruI2fJD54lvVXo+
         wgPscfCt9ofwQMafeVQ7Z6c/hauqkCUJiFtd7M8ExYQUkkQRkDFcBsiaYZifKa+hVRJE
         XbuwTxOvauVRKrz8ua7MtFMELPg/BEGmWpOOwrfz0bY/fJidMhZsXc66d1yxZE49z5xl
         MDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9xvq/ioJJJUPuS8uZTtxFZQoxcWuzKcBrwG0UsKWSEhFeXEMO6SoepUtQfgMsx2zMme6k+xcyt+5QHKWxgb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9ERNCEiAKnz97Mh5WxBw7z+dE1x85v6JuZcna9m6LgTcsgnF
	BawYgYEcjOfbZK5goeL73an0LdXLvBQb3KN3ohK1Fw8mqmf//273i4TD7ZuwBVJR
X-Gm-Gg: ATEYQzz9pu60OW6UkLatov1PE1GzeIKxYZAGFKRueQM9XaAI0foUDQt/WFel+8bekf4
	h6NE5+QXC/apeInXOe+lc82v4alzX4M8aqcFCbN3vav7jjK0c4K/FhGeWiWX5nklvyRVpgi6Wfy
	lq3MvSHX/OnGedb4q8Qat4vFzbR2qnVls4ISRW7frxC8lUYXKi1qzaz15UzjeG1sCZSLL1uv0Ka
	AuH+PMgw5rU4WNGmTs0VWQcX70r0YbFRkx9z4gCF3Af7WclmzKxs9e5x0NHmp476I4p1ashEZfe
	HLU67c9AvVN3eiZ7XfcONeWsZCjXe/m4BYIUKJh/L4OQIOdv7ip7pXiihLmgKzbroETXUoG4gWB
	VObyD4zw4Lk4JD3aC3gDI0W1WxAEw+5dxGMp+rlHT80pkrW9QpcJSd+oW6nkA02+CHcDj9fQAZS
	21ASLrmA89PoHjqpjsJ6u5EMXUb7Og0m5EccPtJI67hT8oLYgUIQ5efEo=
X-Received: by 2002:a17:903:1b6c:b0:2ae:5345:89ee with SMTP id d9443c01a7336-2ae823fee84mr8684175ad.1.1772767017919;
        Thu, 05 Mar 2026 19:16:57 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7864dsm1749235ad.49.2026.03.05.19.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:16:57 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: typec: tcpm: kzalloc + kcalloc to kzalloc_flex
Date: Thu,  5 Mar 2026 19:16:39 -0800
Message-ID: <20260306031639.46942-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation and allows using __counted_by for extra runtime
analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1d2f3af034c5..272f9187b12d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -605,9 +605,9 @@ struct altmode_vdm_event {
 	struct kthread_work work;
 	struct tcpm_port *port;
 	u32 header;
-	u32 *data;
 	int cnt;
 	enum tcpm_transmit_type tx_sop_type;
+	u32 data[] __counted_by(cnt);
 };
 
 static const char * const pd_rev[] = {
@@ -1653,7 +1653,6 @@ static void tcpm_queue_vdm_work(struct kthread_work *work)
 	tcpm_queue_vdm(port, event->header, event->data, event->cnt, event->tx_sop_type);
 
 port_unlock:
-	kfree(event->data);
 	kfree(event);
 	mutex_unlock(&port->lock);
 }
@@ -1662,35 +1661,27 @@ static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
 				   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
 {
 	struct altmode_vdm_event *event;
-	u32 *data_cpy;
 	int ret = -ENOMEM;
 
-	event = kzalloc_obj(*event);
+	event = kzalloc_flex(*event, data, cnt);
 	if (!event)
 		goto err_event;
 
-	data_cpy = kcalloc(cnt, sizeof(u32), GFP_KERNEL);
-	if (!data_cpy)
-		goto err_data;
-
 	kthread_init_work(&event->work, tcpm_queue_vdm_work);
+	event->cnt = cnt;
 	event->port = port;
 	event->header = header;
-	memcpy(data_cpy, data, sizeof(u32) * cnt);
-	event->data = data_cpy;
-	event->cnt = cnt;
+	memcpy(event->data, data, sizeof(u32) * cnt);
 	event->tx_sop_type = tx_sop_type;
 
 	ret = kthread_queue_work(port->wq, &event->work);
 	if (!ret) {
 		ret = -EBUSY;
-		goto err_queue;
+		goto err_data;
 	}
 
 	return 0;
 
-err_queue:
-	kfree(data_cpy);
 err_data:
 	kfree(event);
 err_event:
-- 
2.53.0

