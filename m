Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FD12D754
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559437; cv=none; b=TvGhZBT1Z3ZRf8BEV1AutNsA4Y8LC3a+g1YlFCDBjYI64F955cNDT2oC2IRCGIR/M4IcpAagdmai/0CAgHM8OOH5hcamHDkiLmcYnkY6AdA9I7+5mjjSmSWOqTMsuiayZ77kPD86z3epsfr8sA/UxkNP9CRVA1D4JzM+0CSlP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559437; c=relaxed/simple;
	bh=nCnAH6swIp2emDmvgeIyHlmnszZXY52TNqt+AplJKBU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n1yhDErkGoScSjsHeoIm03+HAmY68lO6yWzU2gNEa/5eJp50EF2RAGxC8vfru/Si/i/Wd5XhwoEBuygYVPIGiKo1cmLxzHuAIyjSW8Uoy/kTyMeqpWeeWZW72757+eR7KU7XzRieMIdCbiObdXL4UoCypQXR17BPRTW76B8MreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KrP1JFmG; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KrP1JFmG"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7bad62322f0so663456339f.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708559433; x=1709164233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ssJhSw8IGwkaMJQVHXTzvwEqUpaKWRubYumbO3rYIY=;
        b=KrP1JFmGDzB6sYKRBjS2UDmFA+IO3Y/u1eRKNJvGNeMdIrgNRM8TN6+Y8zp75bzVhj
         B1ifaVUKk26IyQ70/QrmlpXekFFbyBLSUz9EtCsKrWH/1y9RdvP4OXKzgKqK36xdXDUP
         hEFD3mB4GNyve3kGNWS6VPEjyI2aQYhFmdH/S+L2VGRR3X/dbRfvvXGSYA2+gBZn9/bh
         WOZIBKAzLeHY9stIwuqywNqbF9jAt4cFRwf6XK2jAC4vYlLLhFpUTCeUXoNsegfEZMQa
         fs3GsNMGnmkxPKU2PSzrPzH0HIol1cplUgL2T/Hd6i8SJpQBBxnjIIuB/soW0Q3tVTpY
         iOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559433; x=1709164233;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ssJhSw8IGwkaMJQVHXTzvwEqUpaKWRubYumbO3rYIY=;
        b=qSbb1yGviWLusZk2z6MUJTl3LoZ30RKUCLHZqJRSoBPrEmV37C9+sYynp3COZcJIHJ
         yGhqI4u7u5o/kDp3g7IVyowED+9PXm1tJEwbsqGW4J+fLQ9lWYiraImLpE+2GbhZvWg2
         gmoBNXZfleVXmLm1fOW++NmFjhL0ZMOPVnVETkCz7qG7IdHI1W4k6QFS4nynI/FhjxZY
         11UTw35cM35XEUy14yarUR5sU2LCb2yoR5wQtTjqfc2Szms44r/t84qcz4hUZmYHeM2Q
         Fb12STCUE4YFnNEwevWZyyDOptcdF5sAegVHk2UongK68fx54mleJJJcesAfv3QwqDVc
         QuvA==
X-Forwarded-Encrypted: i=1; AJvYcCWWE2uh8wiygW8HzWDXkWGfdwwZJdppljsDiKa6etKaKiL9i9hqw40cQ6+v70NPJbEd3g0DUp4yhgMzr7cONlljWZxa3BE/GYSe7Ov521/Y
X-Gm-Message-State: AOJu0YwRsIDmPFKrdyoYZLCcmVDzUYfIbBiPj37lwmXDw4ZyHJPTy3/+
	MK6vtDBwIC61o509gh/kyxuSDJ3YaN45i4qSuqkFjHSGXumd3icdqmIEFF7rESrMb834lN5BDHg
	9gBA+0WIZVytWxaivDrzJSA==
X-Google-Smtp-Source: AGHT+IG5ImoOOYrjTV0m32TYWgADsPNmLYkMxOSs1mejSOYPrWlYHpAKSaT8TD6C8T1PZlMxpmL7/QPdxp6muuzRAw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:4816:b0:473:db4c:6fee with
 SMTP id cp22-20020a056638481600b00473db4c6feemr258770jab.2.1708559433547;
 Wed, 21 Feb 2024 15:50:33 -0800 (PST)
Date: Wed, 21 Feb 2024 23:50:26 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEKM1mUC/5XNQQ6CMBCF4auYrh3TlkjElfcwxMB0CpNgSzqkk
 RDubuUGLv+3eN+mhBKTqPtpU4kyC8dQwp5PCscuDATsSiurbWV0pUGWFHBewSXOlAQEhWHi3iN
 4fFHA6AhGuHauto2vHTWoytmcyPPngJ5t6ZFliWk93Gx+699ENmAA9Q1tT3VPvnsMMQ4TXTC+V bvv+xdwNLBk3QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708559432; l=3137;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=nCnAH6swIp2emDmvgeIyHlmnszZXY52TNqt+AplJKBU=; b=bjMp/bqaxulF7lV6pQWdDcIpAYH60nRPQcPkZG4591ITeaNSRX3DtgWjl3k2UaEs+KaDivfR7
 EcPs9LYT7eEDFnxN6eg3DcMXbgVbATIzxG+6ZUP+fKcJsahijSMAmo7
X-Mailer: b4 0.12.3
Message-ID: <20240221-strncpy-drivers-scsi-libfc-fc_encode-h-v2-1-019a0889c5ca@google.com>
Subject: [PATCH v2] scsi: libfc: replace deprecated strncpy with memcpy
From: Justin Stitt <justinstitt@google.com>
To: Hannes Reinecke <hare@suse.de>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated [1] and as such we should use different apis to
copy string data.

We can see that ct is NUL-initialized with fc_ct_hdr_fill:
|       ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
...

In fc_ct_hdr_fill():
|       memset(ct, 0, ct_plen);

We also calculate the length of the source string:
|       len = strnlen(fc_host_symbolic_name(lport->host), 255);

...then this argument is used in strncpy(), which is bad because the
pattern of (dest, src, strlen(src)) usually leaves the destination
buffer without NUL-termination. However, it looks as though we do not
require NUL-termination since fr_name is part of a seq_buf-like
structure wherein its length is monitored:
|       struct fc_ns_rspn {
|       	struct fc_ns_fid fr_fid;	/* port ID object */
|       	__u8		fr_name_len;
|       	char		fr_name[];
|       } __attribute__((__packed__));

So, this is really just a byte copy into a length-bounded buffer. Let's
use memcpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Don't mark fields with __nonstring
- Link to v1: https://lore.kernel.org/r/20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa@google.com
---
 drivers/scsi/libfc/fc_encode.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libfc/fc_encode.h b/drivers/scsi/libfc/fc_encode.h
index 7dcac3b6baa7..6b7e4ca6b7b5 100644
--- a/drivers/scsi/libfc/fc_encode.h
+++ b/drivers/scsi/libfc/fc_encode.h
@@ -136,22 +136,24 @@ static inline int fc_ct_ns_fill(struct fc_lport *lport,
 		break;
 
 	case FC_NS_RSPN_ID:
-		len = strnlen(fc_host_symbolic_name(lport->host), 255);
+		len = strnlen(fc_host_symbolic_name(lport->host),
+			      FC_SYMBOLIC_NAME_SIZE);
 		ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rspn) + len,
 				    FC_FST_DIR, FC_NS_SUBTYPE);
 		hton24(ct->payload.spn.fr_fid.fp_fid, lport->port_id);
-		strncpy(ct->payload.spn.fr_name,
-			fc_host_symbolic_name(lport->host), len);
+		memcpy(ct->payload.spn.fr_name,
+		       fc_host_symbolic_name(lport->host), len);
 		ct->payload.spn.fr_name_len = len;
 		break;
 
 	case FC_NS_RSNN_NN:
-		len = strnlen(fc_host_symbolic_name(lport->host), 255);
+		len = strnlen(fc_host_symbolic_name(lport->host),
+			      FC_SYMBOLIC_NAME_SIZE);
 		ct = fc_ct_hdr_fill(fp, op, sizeof(struct fc_ns_rsnn) + len,
 				    FC_FST_DIR, FC_NS_SUBTYPE);
 		put_unaligned_be64(lport->wwnn, &ct->payload.snn.fr_wwn);
-		strncpy(ct->payload.snn.fr_name,
-			fc_host_symbolic_name(lport->host), len);
+		memcpy(ct->payload.snn.fr_name,
+		       fc_host_symbolic_name(lport->host), len);
 		ct->payload.snn.fr_name_len = len;
 		break;
 

---
base-commit: 517bc069e3eaad84d879101e0351ca7783243b32
change-id: 20231030-strncpy-drivers-scsi-libfc-fc_encode-h-5ad629f6de9c

Best regards,
--
Justin Stitt <justinstitt@google.com>

