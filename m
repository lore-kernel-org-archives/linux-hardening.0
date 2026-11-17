Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927342;
	b=jVe2PTyu8oRh8AwjpEWVfEthVRqoNCm/108mZ7zbQBnS4UF5k4w+V4aiN5iPTnKwmSF0
	 H8VH+WMpWP8E3ntleI/GIly+cYr3m7iqdEwU9Bq99eAMtM9XtMs/ea4pnZ8D/Rf3yOZPv
	 lWm8nYoc65NVtK95TGukVPuF6mnHE8RGqBEAyZQN+Wo5JMiX9K+HwCTKkMg4n5OdIastS
	 5fGrzTV9NfI3Je7IUiKCgp4yAoCc56vl1tvYXDC/uH6lRqT9AJRv6My7e6UP8GSRkYzm2
	 KS9Nf6raA3jQJ+cboF7Ldtts008qJ3gn5FWwDdbKFYGAasKFAqBj5lEM16o3GcTTbWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
	b=WW2Ym76ErvZiLeLM0+hil6v/S7wzmJ+4tPBOT/pyUhshzam6IB3Us2EY6X8frsMDi6cD
	 pMVpN7UIR+YHHslFiU4cDoUh2yifoBEH/T0DEuV2XaPd2nLy/y0ilM5/nwdNzKQYTw/UU
	 BD+y5eZAc/V0c65he5nkJTg/fIVAsR0VPqRkLzFe97gJXi7pJCk1VEp6jW5B52PZjRqJj
	 3FJhxL1C/vZVAKpbsiuNDjVB/4MqZIe1kDNanfCd2kOpG9OG+9zurCPW+lopozh1yGgDD
	 CkTQ+DBA2qw0Bzio+oXSBHaLOE9NUNwxbzAKTeKLiWXK83uwIaZTKMdSQJ+mNGp/ueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5T1Vgai;
	arc=none smtp.remote-ip=209.85.222.197
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DD606A33F
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D36DD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5T1Vgai
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f3969a2a7so728443585a.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927341; x=1795532141; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
        b=T5T1VgaivdD0YfEnxADGj0sSnbChlsGKMyvYd28XOnFm2t/W6zWqHt6GffAlu+DdF8
         9eDYRC3Wt2sm7L2qAINRIEkFhbAyflBH+lCkkF5xc8jymU5GE+BKQZ+DLor+sZHS0qIM
         RpLVImvu04e9tBQWX+OZMWU7W3/818RoDPRZPJm3cIDJ6Jh3p1oyCrK/lnA1ssVbdlLw
         jlJEf3smedj7UfplYFzd7fmwR4Q3qG3jCs0bQvTKvdkbYyTChKNV31tcBFQWnYC4H1vn
         VihiHM74lldIWjSilWsBapO46SfrwOBzTdLw5EDXcouw8BWcdTUl5SBXmkZ7gOvESryi
         P9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927341; x=1795532141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKadNleMHJBLRP4szDxTc4A4+nJ0/Pl3hG9PQuxpOUk=;
        b=yUIsGNsJpAto1Ebvy6IhCkJdioOaov1jzIP6JOWqhQxFvXzOyXQ+CRoxO1N26heidZ
         TMZOWlwDrtpG7/CgYAKuLlrwwwNaxcxHvSZNw0h7KS7VYE1/DWOjLRpFvs81Mq8Z73zV
         dVhONERNyebC3BdFTbMNeQp/KW2o5kOxTnvzVr8G6hkRGRzyJQt04er6EOibiks9hbOr
         rJfL1fHDpxcoZX2t3/Kl3yK8EZDHLPsFyPipMc1maSBPtEITE5F4+otKxVZBMy12J8xh
         A8lHuUrACRYJ0wC6RQAEqxjkWcz7+CNEeb1atI64QjasIXIX4V9LEKmZVGDfxr3fa6zw
         62nQ==
X-Forwarded-Encrypted: i=1; AL+hErFdV+DJUH56XjNDfURL+EYJbQgIYbRY2HFtvFIpe3RV0nJG7HOPI8HNPVTH0K7X34JgINd9qdu8xlFpnBKoAm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iGJ8KgigJLdwCAJ3wpe4udcA8lbG/HCOqTsKCcmfgk45A8sVc
	RFhwEKgYrJygoo1/yf6bb9QF/FQ4yfxM8jGxo3Z3Cga6DGrwjzrrfhd8/E70t3HsROHJ81cpcjt
	3Aw==
X-Received: from qknvm11.prod.google.com ([2002:a05:620a:718b:b0:93f:43a4:a480])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:8908:b0:93f:47fa:b722
 with SMTP id af79cd13be357-9494bb858b5mr2039910785a.13.1794927340273; Tue, 17
 Nov 2026 06:55:40 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:08 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-3-stani@google.com>
Subject: [PATCH iwl-next 02/15] idpf: wipe mailbox send buffers on release
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	Emil Tantilov <emil.s.tantilov@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The mailbox messages are freed with kfree() once they were sent, or when
they couldn't be sent. Some messages hold secrets, e.g. the PSP TX keys
inserted into the SADB of the device. Free all of them with
kfree_sensitive() instead: the mailbox isn't a fast path.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c06b2d9bfe0a..fedac4716b08 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -129,7 +129,7 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
  */
 static void idpf_mb_clean(struct libie_ctlq_info *asq, bool deinit)
 {
-	libie_ctlq_xn_send_clean(asq, kfree, deinit);
+	libie_ctlq_xn_send_clean(asq, kfree_sensitive, deinit);
 }
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
@@ -218,7 +218,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 
 	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
-			kfree(send_buf);
+			kfree_sensitive(send_buf);
 
 		return err;
 	}
@@ -230,7 +230,7 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 	xn_params->send_buf.iov_len = send_buf_size;
 	xn_params->xnm = adapter->xnm;
 	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
-	xn_params->rel_tx_buf = kfree;
+	xn_params->rel_tx_buf = kfree_sensitive;
 	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
 
 	idpf_mb_clean(xn_params->ctlq, false);
@@ -264,7 +264,7 @@ int idpf_send_mb_msg_kfree(struct idpf_adapter *adapter,
 	int err = idpf_send_mb_msg(adapter, xn_params, send_buf, send_buf_size);
 
 	if (libie_cp_can_send_onstack(send_buf_size))
-		kfree(send_buf);
+		kfree_sensitive(send_buf);
 
 	return err;
 }
-- 
2.56.0.679.gc527c65306-goog

