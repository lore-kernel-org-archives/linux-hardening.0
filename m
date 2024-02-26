Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC046135A43
	for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991634; cv=none; b=N9GsJ2zv6mzNULC/EGFoiYf/u6Bf7zUVJaldbuIpesXTqCtzhC7rbHn5+qQgaP4FsJHTdgJwuUCEFXy/1lckGxtLbfg4RR5/2jT8OYVkZByawSMnTMaO2kmolQpypLFqpTaY9R6PtrjdFGWxv5xpuDCDDgbUuvMtqMIO0Vf+sNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991634; c=relaxed/simple;
	bh=JeCxx3c4ppdgFDh3lp6P1rqNUJwDxT9JEo9Mm+GfI38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sZxKFxQZpEN6f87UymYnQSayErcVACybQGsDwIXVK2WHdagYyMc5jvzXirDEyZUmtXE+SzUqaqFUDKkV2tsOo+lOvvkarT8hRq9fjVnLXIGZU7Dl1gRrYb8Fe74LhrqtkhndhW3l6pVlHy12KaE+Y+qYKLH2OGzTVV8VwXvi2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fy1d2mYM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fy1d2mYM"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso63319337b3.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 15:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708991632; x=1709596432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S39j559seDHpHoyUT6gNBve2pYTlYnQB3wRYpD7F2CQ=;
        b=Fy1d2mYM9bV1lszCzKF98Q2nCdK/94vBoLQjkpBqgs7WL0pb83HxuWjXTTz6vxRp6E
         NQYYO4PIfEeSJ8bfzWG5u/Yc/Wtqix4gYedQOzAEp+0Yj1/YIuDKrrHNimbIPid9DVJi
         zJw6/pPPofKVeRvZYOFIgLIfuZBI1d1k479azNx3HBndxJi1DH+AituoPfikWgMdWAfY
         Xsb0S3EdK+OZjOrIesBv0/3QIV15xaY6wA/hPeTsm31ylWbuLvkGFi3ThEtXchmXwxjD
         /PrAoR9j+KlwSPC90FU5IDCD8sctiVJOzS/SHtnPp8FGyrj+rZSdx6rqB74WiOCYlbmG
         A4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991632; x=1709596432;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S39j559seDHpHoyUT6gNBve2pYTlYnQB3wRYpD7F2CQ=;
        b=UyWnprkLwlTwufcMY0339SlqqDT+W2MDJmlxWpnyT1JLY71d/sxHgYRdkWyro1JFQd
         hrD9Gq/mfNoMWM5021e6wBNw2IYonyrox2OrxLxAVccUy2uNsWclu8fECAs5fvfmKGZn
         8jY5V0Ahx0BYX2J7BD37lNJ6CeohvSfQmTEqhGguDzPoD5o9PbBQn2Mvh/PUcmsfYjQk
         pFgPVpptYxDsQsoB4gIxHSIpUo9cBWYaBq950hKn2SdCMiC6u408ZWtpc3s1+nCGRw7Y
         12J8iGJ3nEAQVyZDkKXg9mgoYVvzlfzXwc4HHDAvGJtucR7MjOv70eZtzmgpks4D+FCo
         OdJA==
X-Forwarded-Encrypted: i=1; AJvYcCU2SL9gG08lNtnT2/zYH5iJxotW04nJR6do54v/iCtN15ZcmRDb8ontrU/RHLUEUkyFN4k5dmjVoKAgxtrIeuOCXj7ntyLLCupX7BvaRMSU
X-Gm-Message-State: AOJu0YxIeM0fHqO5tj7050VBEyAwShhEDZjqnoM14z+iKjg+fvIFeRFV
	9X3EQv8rvxzV9Ramm5BIxDKTUWzPm6To6RyKsrCfVRDZX3sPSMJfRFgwlZUYDTfXIbnmXykp1Gd
	cgyhIzKOZMalFb9qEM5Y3gw==
X-Google-Smtp-Source: AGHT+IH54DJnpJg9iPluQxwsW66Wg0QACJLoVbFpM8JyEIz57ZeMOw8tfs/bwhBt9SCw4HWibOH+XXlMWWCOk7NznQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1887:b0:dcc:e1a6:aca9 with
 SMTP id cj7-20020a056902188700b00dcce1a6aca9mr189067ybb.9.1708991631843; Mon,
 26 Feb 2024 15:53:51 -0800 (PST)
Date: Mon, 26 Feb 2024 23:53:44 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIck3WUC/42NQQqDMBBFryJZd4qG1GpXvUeRYsaJDlgjGQkV8
 e5Nhe67+fD+4r1NCQUmUbdsU4EiC/spgT5lCod26gm4S6x0rk2utQZZwoTzCl3gSEFAUBjG2eE
 xT1wAwV2MLa9EZMtKJdMcyPH7qDyaxAPL4sN6RGPxfX/+8i9/LKCAyhpTt1Q7h3jvve9HOqN/q Wbf9w8CtWNb1wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708991630; l=2521;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=JeCxx3c4ppdgFDh3lp6P1rqNUJwDxT9JEo9Mm+GfI38=; b=aI8lYYQTCTWr5poJcPKK8qGIaYaUXNNsUPhPuHz8s+B2GXWwyabkAt5Y93G5bTZHu1TS6wyRB
 e1Z6lu+bX0RDep2Xlb7/pIjK9b5aqj9hCE2PQ1b3XxtRQKpfxD3hgt3
X-Mailer: b4 0.12.3
Message-ID: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>
Subject: [PATCH v2] scsi: lpfc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect ae->value_string to be NUL-terminated because there's a
comment that says as much; these attr strings are also used with other
string APIs, further cementing the fact.

Now, the question of whether or not to NUL-pad the destination buffer:
lpfc_fdmi_rprt_defer() initializes vports (all zero-initialized), then
we call lpfc_fdmi_cmd() with each vport and a mask. Then, inside of
lpfc_fdmi_cmd() we check each bit in the mask to invoke the proper
callback. Importantly, the zero-initialized vport is passed in as the
"attr" parameter. Seeing this:
|	struct lpfc_fdmi_attr_string *ae = attr;
... we can tell that ae->value_string is entirely zero-initialized. Due
to this, NUL-padding is _not_ required as it would be redundant.

Considering the above, a suitable replacement is `strscpy` [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- keep strnlen (thanks Kees)
- Link to v1: https://lore.kernel.org/all/20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v1-1-20c685bd1b43@google.com/
---
 drivers/scsi/lpfc/lpfc_ct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index baae1f8279e0..296d2d4796cb 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2569,9 +2569,9 @@ lpfc_fdmi_set_attr_string(void *attr, uint16_t attrtype, char *attrstring)
 	 * 64 bytes or less.
 	 */
 
-	strncpy(ae->value_string, attrstring, sizeof(ae->value_string));
+	strscpy(ae->value_string, attrstring, sizeof(ae->value_string));
 	len = strnlen(ae->value_string, sizeof(ae->value_string));
-	/* round string length to a 32bit boundary. Ensure there's a NULL */
+	/* round string length to a 32bit boundary */
 	len += (len & 3) ? (4 - (len & 3)) : 4;
 	/* size is Type/Len (4 bytes) plus string length */
 	size = FOURBYTES + len;

---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-f54b67eeeb68

Best regards,
--
Justin Stitt <justinstitt@google.com>

