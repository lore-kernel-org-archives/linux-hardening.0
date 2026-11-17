Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927341;
	b=ukqWcY8qJJSDqGTZLcbmilVkN8AY2/62UDo2g/nqvjKUwxQgxVMGLmVoLeB2SIhMBp+S
	 jsotq1xW866FsG4Bp7dkqOttjFiOTk2HqVqVK3Ni9OK7Os0LauQOhjReKAA1ejSGR9fdh
	 n2kCKxCx8gM2FrD1JDYLh7BooRxyf9cdlGo5rldarl0qfJRBF7dXexr2ZU+I8iiUB3Qf/
	 5Q+IN6Zn681YqKtiNOzhV3SA1xtqu4IGaujN5MLDwM2s5v9b4ddxMA9fROynKfKj3qus6
	 C2QLbc5rRF6f4Du7dWurkApO0nu+q4hAq6uCgD/FRjisTlb3AuhImB/SvaWbo9EpUzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
	b=JgwuppP4howPdr5y29hF3sxR1qol8+G+3qfH9V7aXZ8JwNzaHCW6S6/OrGOKs11y4ycx
	 lfLAr5RdHKWu8t0MhlbrwxfQkHtIROhN1upa1/IKwXXYp3dddgHr7SH9Mo9/qJlssIu/l
	 ulXQnueoMuTpYPg3fsHPAF9SskbPV6gMoi3qPNH8UL0DdOFwFJNdTgGzpC/68XrCe4PPw
	 IBJbDmIf/V6qFV/ZqRf/yWF9DtX+6mxmgsLFtkiITAwUxTxodxTznxkm7fdEEESByovpe
	 wxQKJtx4fFMd8Kbj28A2PexcQEqeLBpLzGv5KJkL2heI9fhU01PPl1QN4rQj0Jf51rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CGd7BfaT;
	arc=none smtp.remote-ip=209.85.219.70
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A54606A88A
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A54606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CGd7BfaT
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9210ce8dfc0so5853546d6.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927340; x=1795532140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
        b=CGd7BfaTKcEZnmBpM3ZHO6Gng5nLM/htKmuPUXYUy2XlFK/IjORTCW5sZ6VU65q5Ju
         9rzj7guEyL8KAEzE02TWHyPaTuH12UK5m7PSAM0vKSkR7C2AkOK52wIMZ0DlAH3uA1pN
         7zNcbFMMwkrbNqH7J3HXBHBeMNMTBoAy1LYa+zYr5GNia5l7yjgpIthClr49LfbKL2Pb
         opYYpEf2QxJhCEn2uJsvEqX0pvavX/+UHvkk1mIIqsASsdYPo964LdRekAO18KihJnZU
         iuOPWTHoAZS9RfpgsAvkD4axvBHUBAdGFy1NeHZtqRM1G+S3HMEy7maZwzl8uZLpvGvR
         1R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927340; x=1795532140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3DwMEGrZ57pkqE3y7BJjL3MnOYoEVHYkRTWJRAevnQ=;
        b=2TyvzIsxu+MrSVMcWazlUPGqaUuxADl9c9k0FvpjVwGMvJe04scJqthX7p8mi8iLBq
         Uk6TWzqvRimWYuQLQdZlSSPG8HUmWrqSPzpZwC4W0CX+5iULK9WvuAXbVmglE1hmP+pD
         N3ntK+HoMrGrvVSlP6htQENK+b3FYTQvGM0/mJ7abqqorJxz1NS1ffkXopn1ILYPv16X
         46P0jKsBQn8tY3IaoiPmftlpILvuxi3kJ8pPm4CeilFjeST6QmaqPFrfmcTeXpBGNi0x
         5t1JH9ZzlT0q6/ihYXfB+5yN5S0OcjAyGJs+fV4u+AIf8D3DcvDiXjBNPyKrcFeGf0fq
         8iDA==
X-Forwarded-Encrypted: i=1; AL+hErESVRFfAgo/+p++RrzrWCb5m7aMqRQcMAON/aLvnxGjDfvzNatzr3XvL1WhGlXa0376QJPH3iC7hxVhcTNk00M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qVtq9Be+1OTZ7rsJ1u0wwk/IrqCqwFwOYF+08TrlahwaV9XP4
	/zlIfB3CzK/s0YJ4DwBA0gbumPVuxxwh2Ht6hcVFDYAgr5pK2aimjnu3vgEv0NN9SkJfUSVpI9j
	dBg==
X-Received: from qknrh21.prod.google.com ([2002:a05:620a:8f15:b0:945:e9b7:7c18])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:870e:20b0:949:8a03:c35e
 with SMTP id af79cd13be357-9498a03c384mr411244985a.54.1794927339421; Tue, 17
 Nov 2026 06:55:39 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:07 +0000
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
Message-ID: <20261117145522.1910636-2-stani@google.com>
Subject: [PATCH iwl-next 01/15] libie: wipe copied small send buffers on release
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

libie_ctlq_xn_send() copies the messages that fit in LIBIE_CP_TX_COPYBREAK
bytes into a DMA buffer of their transaction, which is reused for later
messages but never cleared. The messages can hold secrets, e.g. the PSP
TX keys that idpf inserts into the SADB of the device.

Wipe the copy once the message was sent, when its send queue entry is
cleaned, and when it couldn't be sent. The transaction can be reused as
soon as that entry is cleared, see libie_ctlq_xn_pop_free(): order the
wipe before it with smp_wmb(), paired with smp_acquire__after_ctrl_dep()
after the check of the entry, so that the wipe can't overwrite the next
message on weakly ordered architectures.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/libie/controlq.c | 28 ++++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 6214fc036ce5..c31d3c9e792a 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -694,9 +694,16 @@ libie_ctlq_xn_pop_free(struct libie_ctlq_xn_manager *xnm)
 		 * address is dirty in any way, reuse is already safe.
 		 */
 		if (xn->tx_msg &&
-		    data_race(xn->tx_msg->send_mem.pa) == xn->small_dma_mem.pa)
+		    /* READ_ONCE() for the control dependency below */
+		    data_race(READ_ONCE(xn->tx_msg->send_mem.pa)) ==
+		    xn->small_dma_mem.pa)
 			continue;
 
+		/* The small buffer is wiped before the message is cleared,
+		 * pairs with the smp_wmb() of libie_ctlq_xn_rel_tx_buf()
+		 */
+		smp_acquire__after_ctrl_dep();
+
 		clear_bit(free_idx, xnm->free_xns_bm);
 
 		return xn;
@@ -998,6 +1005,8 @@ int libie_ctlq_xn_process_send(struct libie_ctlq_xn_send_params *params,
 		if (!libie_ctlq_send_desc_avail(ctlq)) {
 			if (!libie_cp_can_send_onstack(buf_len))
 				libie_cp_unmap_dma_mem(dev, dma_mem);
+			else
+				memzero_explicit(dma_mem->va, buf_len);
 
 			return -EBUSY;
 		}
@@ -1132,10 +1141,21 @@ static void libie_ctlq_xn_rel_tx_buf(const void *ctx,
 {
 	const struct libie_ctlq_xn_rel_tx_ctx *rel_ctx = ctx;
 
-	if (!libie_cp_can_send_onstack(dma_mem->size)) {
-		libie_cp_unmap_dma_mem(rel_ctx->dev, dma_mem);
-		rel_ctx->rel_tx_buf(dma_mem->va);
+	/* Small messages are copied into the buffer of their transaction,
+	 * which is reused: wipe the copy, the message may hold secrets, e.g.
+	 * crypto keys
+	 */
+	if (libie_cp_can_send_onstack(dma_mem->size)) {
+		memzero_explicit(dma_mem->va, dma_mem->size);
+		/* libie_ctlq_send_clean() clears the message next, which lets
+		 * libie_ctlq_xn_pop_free() reuse the buffer
+		 */
+		smp_wmb();
+		return;
 	}
+
+	libie_cp_unmap_dma_mem(rel_ctx->dev, dma_mem);
+	rel_ctx->rel_tx_buf(dma_mem->va);
 }
 
 /**
-- 
2.56.0.679.gc527c65306-goog

