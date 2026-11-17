Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927342;
	b=1OwoDvWUDJcK6ZNldxr6EQvqFD5v83cVuaPaBuPzrCmIMHGYD5eNJj0cRHL0pKT8sl6i
	 Ml7EA2Y9X358YUoVliRK0508zGbv4ABmlerAwIMmmsKnNOEF7GscRSvrMh3D7MCgRt1+K
	 Tf9ioV/7nVfsTwVNha2plVt0trHGjcolvhb5hTodYs+zox2IWBOjVAR4zroReRJvSltfL
	 Xtj5NWEFCbZAVRlWHXHydp29pukGTi7ygv3tvECvQlQpDHGoq33gGxrKhyXXlS381q7Rt
	 vVicPZ4ygEUOaweemPV929+dUoCBd8ypHyMCxM37FzRxrzr6KZQlcXbx68WY6W8nCXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
	b=tsXWTWwRdnt8xL0U2WDEu6uQJvCx1BV/xYcfrJ51pv2jG+S9HnxMJZ3Prfnj+NmhoL06
	 yoSPEQaJ3O8DuNEgQwMOf5fuiYs5zRj4oa9T8PjisB6tkT2o8qtd7NgE3PnK4Jdy3hYVb
	 6GQBQV/ZFvJoZ28/Ju6390IQBfG8wTnB67Tp8KdSEneeG27u1YEL7jwbvpiWoXkwKZwRj
	 VkhCAA8m0MuRaJefSXc2JxBFHHZuUeWYF4YsNNB29sl7Lx4uMBuWXKYR3fmRGmXthW/Hy
	 yLKdtb6D/4jl2AVe8OAVJy41YkviwFH8oVlKUmxF+SD9k07es5ztWcgLu881EgTx3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NvdE1A0h;
	arc=none smtp.remote-ip=209.85.222.200
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FD606A893
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976FD606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NvdE1A0h
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-946038e22f5so648061085a.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927342; x=1795532142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
        b=NvdE1A0hxlUkz6GJhAxddDB40AtROW+rNaSpm/1Bf+iC67LrFamdjIgMurLaP1pOLb
         QUANGGF7o/pvk8tuIHbLsNjpP+G/aGHAWb/1bBZ/ocg+69WIP5fuIobG5Y5WChPDTmV+
         XUXX+C9ObvQY3s9Xj+FH13NdOg+uvXpJbzLdsdVhPcHurDgZw/jsCZqAGpLUao75Dt/8
         /EVVaO9avdpREJX7Ti4kyitwcyLe95+z4wNGyxupNPwpEIz3StA65jrBX0AbsnPlQlfc
         maw0Gnv+ENPMzDvWUinYtG2Im2yeB2QFAE6nrc368MdGpMv+6/AYtHCa2WV31fQgzcc7
         NDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927342; x=1795532142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLnUN4SFxuLePJET60hqALFh8R854ScCCjNPuZCVkMs=;
        b=bJOewM5YMMs/dj8cAOTh1WDKMUdWI3W9u8bd91YtDV5hF7PgyBQ2glILm6ippxpmy0
         FxwNhU8XfhmSt8n/7d4xqC0FtMXH/ELsaf/mU5puSLkaaqcfHY1VbEfdkmW5oLcl2Ieu
         Pcny1Fk7iKPIv5LA8xgv6mXgrTy+TMzPnC+I5CmmicS12+XGS0MRMBYm2y/hZbx3Eomk
         WlhnxcM7TF2HPeSXv0gtg10FhkNUWolpIG5TbkSaGyv2qCSysa9D06rWlzxwH9cT3RPL
         YGMRja2ocywqP4uotZ6CL4kALSnFt13zFJMtqjOnjKvTVzXByKd8YZB5cAQMYiHFbhuI
         DbAg==
X-Forwarded-Encrypted: i=1; AL+hErFFJUcR98BlSvI7A+AnkAHLsb8xRZt2NWPluuDYk3Ko8t8pFLgZniP53enPcuAwn06AuHiDpJrzdS98gQ3QQKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p6q0CIborr8Kax3av7U5+QItIOPYHRE2XYEp9qOQ5S8ooe6D8
	v+WKG+2wtpILmL6aPgfDHHK4siaDHEwb6jUj3gQXW5PZeAbiDov+1MNfDK2j9TfM3gGRx+sPNK9
	yLg==
X-Received: from qknvm11.prod.google.com ([2002:a05:620a:718b:b0:93f:43a4:a480])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:bc7:b0:944:1291:6cd9
 with SMTP id af79cd13be357-9494bbeb488mr2333610585a.68.1794927341308; Tue, 17
 Nov 2026 06:55:41 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:09 +0000
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
Message-ID: <20261117145522.1910636-4-stani@google.com>
Subject: [PATCH iwl-next 03/15] idpf: make the mailbox workqueue visible in sysfs
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

Add WQ_SYSFS to the mailbox workqueue: the workqueue attributes are then
exported in /sys/devices/virtual/workqueue/, e.g. to inspect or change
the CPU mask and the nice level of the mailbox workqueue while debugging
mailbox latency. This is one of those cases where, when the need arises,
we wish we had that flag enabled, see https://lwn.net/Articles/967016/.
The PSP workqueue added later in this series sets it too.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index c855572c5315..566d5804c8c1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -319,7 +319,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
+					  WQ_UNBOUND | WQ_HIGHPRI | WQ_SYSFS,
 					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
-- 
2.56.0.679.gc527c65306-goog

