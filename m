Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6A4BDB6
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 18:11:18 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5EFA0C25
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:57:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c4103c26ccso10666795ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695319054; x=1695923854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Sd4hbhBemt6+PvRvK/BENUnRBVZPSiTQthHgyMmLUc=;
        b=EykVW3mrgHEmTQmR89P5ltqPBNG/rso4bDcbYllTclbvlBUBXb0YO+knKDWlbUPwSx
         WzfqQ41t2FvX41dB+EeE7rmKrVQVFPsN2e6LDPxd8PPwZoM6ZpBiKA9HQYNToVVy/TQa
         ATZmyq1nuHs9hICl8m+dvRN3BQrHFosrqU4o419dZ6PhdEfv+jk7PZMl3RQ99RsoQvGC
         oOBrOxAHgXZ5KKTAXu7EZ/NsUcEH/cHlil3uWTJSDpsXqBtkXdb2Og6ZB6CEqu4QiLFI
         DDN+ie2hizPfDHLpdp2MhazNQO7n373hdvZiqc0puVTvj+q2+ifuUne9xhJE7PwmlD0+
         1frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319054; x=1695923854;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Sd4hbhBemt6+PvRvK/BENUnRBVZPSiTQthHgyMmLUc=;
        b=JfUwpJFq6xX7U11YMqr7QbCrVgFAdt6qIUJg/EZ4OgZKTzGxN7C8x19bnUfuVJYAbs
         cqQdOxORqWpro06MbgaGKioz147DR8z4W91pc253yCAUZvOHi0wXFEgZYdg3kxBwNQMQ
         ft+oI1tigDVobCYUTLnYDeFv2S+zBJmGdCgUuDn8okoinp9AZnxPxrqsX/YIf88sRnWq
         AMB9qJvkI4KGzObty4fhYarpF1E/So35B9+K9jZQnbqxgNT4henc5EQTN+idpNbtv3J1
         emA3eFQ6lOKbrHWR2rPdsBBObdWNi9h4g+GGfQQRRCSZXnzIWu7d2Ubth1STcbTzY6oP
         49qg==
X-Gm-Message-State: AOJu0Yy1ZpPFyUS9gWp6cwXj2Lo2EhJd8Rwb01nm7rPBM5IIdsegg0aN
	zWKNylH5Fus+A66Anyc15IHCOGxh8hdF3EYDPQ==
X-Google-Smtp-Source: AGHT+IFWNDtLo6T7hYyWkvIRT0T2ceJhA1446eNRT+1I3X5gzOavUskQ6j/Bys+UNNJrmi11oEd2CYMw2JNr7ecfxQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b149:0:b0:59b:ebe0:9fd6 with SMTP
 id p70-20020a81b149000000b0059bebe09fd6mr74612ywh.6.1695281787226; Thu, 21
 Sep 2023 00:36:27 -0700 (PDT)
Date: Thu, 21 Sep 2023 07:36:26 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHnyC2UC/x3NywrCMBBG4VcpWTswbbygryIiuUzsv3AsE2mV0
 nc3uPw256yuikGqu3SrM5lR8dKGfte5NAZ9CCE3u4EHz+ehp/o2TdOXsmEWqwQtUMSgmcaFYPk ZCHvGckehREfvuUQ+8ClH16KTScHnP7zetu0HJ/831YAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695281786; l=1647;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=azwE+ZmdRI6O/nQsHa387F2VcNjnWz4bpJZWNz8mYqI=; b=4HCFbh7ZqzydD1p5IcPfSFx7e/laNJU8kusftwlxw5oJi2KxF9BHvAMRI3p7BtcLKVqzigrTX
 NHT8RDtFa++CJFD7cM80Ms7NYhx6XCn7cRz+AXha7ug2OLfrzDgoGS5
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-infiniband-hw-irdma-i40iw_if-c-v1-1-22d87aef7186@google.com>
Subject: [PATCH] RDMA/irdma: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Mustafa Ismail <mustafa.ismail@intel.com>, Shiraz Saleem <shiraz.saleem@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1]
and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees NUL-termination on the destination buffer.

It is unclear to me whether `i40iw_client.name` requires NUL-padding but
have opted to keep the NUL-padding behavior that strncpy provides to
ensure no functional change.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index 4053ead32416..adbea33bf5b7 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -186,7 +186,7 @@ static int i40iw_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 							       aux_dev);
 	struct i40e_info *cdev_info = i40e_adev->ldev;
 
-	strncpy(i40iw_client.name, "irdma", I40E_CLIENT_STR_LENGTH);
+	strscpy_pad(i40iw_client.name, "irdma", I40E_CLIENT_STR_LENGTH);
 	i40e_client_device_register(cdev_info, &i40iw_client);
 
 	return 0;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-infiniband-hw-irdma-i40iw_if-c-6330fb0507db

Best regards,
--
Justin Stitt <justinstitt@google.com>

