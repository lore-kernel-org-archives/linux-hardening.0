Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665A315B9
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDIj7Ddz"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45691
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:24:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d815354ea7fso8162356276.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696973084; x=1697577884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MDV5AFh8umN8bQ6h2/MOjPGq8sl8c8sCGHuPzTkmxh8=;
        b=IDIj7Ddzda4+83aU0PkTht9LNRl+jUTwUW0RREBZHGylXYy+D6XrP8pLbk3e9fRXrW
         K+KZDp0Dk0iGis9lbIHlKi0Eb/nOQ8C7EYi/avbtMZCfplOPILR3HlU1rEj9FkpMOYT9
         XdSoByiqELx2J1l3kTaSdLcWCycqdNxfOXcmGjj3aVLxz/W7HTJWJyxnKUes15enI0mg
         XzTne2uDDJDr2KrrVWiVvyqlY+FF+LXFYnWTfxbC6VpGdr/7wC5jIyTV6zDw55bCaSMm
         O9P1mWtLt7KMzlsTQzPungcbP/MwyPt1UQwUv+xzTIniUd5tCSCdCM7w5QYNf1oOkTMq
         P5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973084; x=1697577884;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDV5AFh8umN8bQ6h2/MOjPGq8sl8c8sCGHuPzTkmxh8=;
        b=It529yPubhqjYIcH/lZNaZzBWSITep9Vta9xL2aPFoMRGSlxFwYMFN8nfs4re8BRn2
         YGd5euMWNfWochTftRIphB6Hh7bwYz7De992hI1dSMjmwW0cicoivXm7iUtU/038BBhg
         3UyCDf3TllTd8Yfc5GP27+OkCt7mIqiyFrw6uk8HD/cRZBM8032jfUqy8Y297w01HIH4
         ioXP8p64whVsHj2tiXsA80b+AzkVxFFEm4ZrGCBMv9VgWYemRIxLcWsZGiPmYiMmG7Ba
         cyLTMrOEqoDQX3u9v2IteFDk89g+UFX2t2vyQJe1ELHjAmxp2bDK8G7e/B0gVR5neoNr
         aqbA==
X-Gm-Message-State: AOJu0YyhIHd5ftsHVhTLhXV1xQHjW4V2CnbMnkx4fQ2QMC1ARd/kOTRK
	/tkv3/RJVv8E+jCiDQADwLSl9VR7u16CLFjSiA==
X-Google-Smtp-Source: AGHT+IELzkq7lrFBlOSPXGIIWh8YEgmE+8ORM+TWaF0HPow2n1TkGqkPdw1XyejRBXjIeMUGOI+vVx/m6KOcKotg8A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4d45:0:b0:c78:c530:6345 with SMTP
 id a66-20020a254d45000000b00c78c5306345mr278663ybb.7.1696973083763; Tue, 10
 Oct 2023 14:24:43 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:24:42 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABnBJWUC/yWNywrCMBBFf6XM2oEkFXz8ikgJ04kdaGKYhKCU/
 rtRN4d7NvdsUFiFC1yHDZSbFHmmLvYwAC0+PRhl7g7OuNEaa7BUTZTfOKs01oKJK3JdWL8jem2 8rhhbzu7PKXpJSMiX03GkYCmcA/T3rBzk9Svf7vv+AYQ2UsSJAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696973082; l=2215;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=CSoT1kieiSbChFcFcvh9dHJInopCbsLzGtEWqjj1yLE=; b=3ywEvfgWmiMy0QLDM7svFMz2ZM1hoQo7JNuVhO3w/dKt/FOTx8g8Ys2j+qCaZxeUmltd8AeF3
 G5h0tn2qzj8AJJVKVR/VHx3ZZ1NrEKuHP+IAUTyUGdAH5uNVpCmXusg
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-v1-1-51be96ad0324@google.com>
Subject: [PATCH] net: mvpp2: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Marcin Wojtas <mw@semihalf.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `irqname` to be NUL-terminated based on its use with
of_irq_get_byname() -> of_property_match_string() wherein it is used
with a format string and a `strcmp`:
|       pr_debug("comparing %s with %s\n", string, p);
|       if (strcmp(string, p) == 0)
|               return i; /* Found it; return index */

NUL-padding is not required as is evident by other assignments to
`irqname` which do not NUL-pad:
|       if (port->flags & MVPP2_F_DT_COMPAT)
|               snprintf(irqname, sizeof(irqname), "tx-cpu%d", i);
|       else
|               snprintf(irqname, sizeof(irqname), "hif%d", i);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 21c3f9b015c8..331dba2ae13d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5831,7 +5831,7 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
 			v->type = MVPP2_QUEUE_VECTOR_SHARED;
 
 			if (port->flags & MVPP2_F_DT_COMPAT)
-				strncpy(irqname, "rx-shared", sizeof(irqname));
+				strscpy(irqname, "rx-shared", sizeof(irqname));
 		}
 
 		if (port_node)

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-marvell-mvpp2-mvpp2_main-c-e9743cf1cf8f

Best regards,
--
Justin Stitt <justinstitt@google.com>

