Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708193D96B
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gipt48wU"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D6BE
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 13:38:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a21c283542so21685237b3.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697143100; x=1697747900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vkRRCsI/UwHQQmmo5KL43KULw8Vizy5iw3kqwb3wxqY=;
        b=Gipt48wU2saI/+vlKbzHGN/GbS0ktN7g3Vg0WO2YSSNys2sAhEr550/4EK3jltBsfK
         p542h05mHHbGQY1EENOr4RGxeK6GkiJAbS00f6021mibNJZQHY2g7A+V8HBBMKrv395H
         H2dlzif2Q7WGDD/XRCql/NYFEcz2VAPs60gJmCCh5jcv6Uz2f1DJBZP2XUDwtTM8KaFi
         vfYWxji0Fpv+84SwQBjeedg4XvLtpF/sqykeVvQ3fPHulIE1nRGE/ptk/ff4p4Ceh68z
         xdB0EkFp/gAS/v2AmqJPVyfdCzRmxjTAmR2qj29YdOa6+JFsFxP2by5WiwvjDKlBDLF3
         RSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697143100; x=1697747900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkRRCsI/UwHQQmmo5KL43KULw8Vizy5iw3kqwb3wxqY=;
        b=nrgaIgwhowD6PsIC5dL77QBsTG0Wz7xqqaM6pMkHWNFfk6vpST2KjrlbUFvgFsCbPx
         YV1qxe4m2Pb4hdtuW7+fwQRdsOfVS7E+p0LnexJLofg8awQamWYq9L1m4a5cybauTks5
         ph7+yRHOX3BaCroJWqLdjWktSmR+7AJMzr9R8c18gfyUlUeqBdAwGki4NC1pXlccZMYZ
         5I3YWxcREFkxtJzWUb4vA/eUR8rxCYYFUGo6OM9fM1ixbL8OwMwBf1p3qDIymUqwwXQu
         X3vNgbcbfQNZebKNCx/4d/OinHXa2Wk0Q4UWd7sN4rogwI2lAsyuM4UrxhpRJh8D41Pu
         gevQ==
X-Gm-Message-State: AOJu0YzG5ZqJuxZn/mW2mQGZudVTk/LRhbCCfWOmEA/GHM0wy3HA+1fE
	jrwtKMogWpJ7R6I1s0cGooRN5791MeUMQu32pw==
X-Google-Smtp-Source: AGHT+IH6fK0jdjrOcCh9xpN6XNh6sbwURaH8+qP3r5RAkooqVXWoMnv/RmWQpaUdgz5h1xxICrCb0iKZE/extwMbTg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:bd4e:0:b0:586:a8ab:f8fe with SMTP
 id n14-20020a81bd4e000000b00586a8abf8femr547640ywk.10.1697143100303; Thu, 12
 Oct 2023 13:38:20 -0700 (PDT)
Date: Thu, 12 Oct 2023 20:38:19 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADpZKGUC/x2NMQ6DMAwAv4I811KSSiD6laoDOA54aIrsCIEQf
 29gu1vuDjBWYYNXc4DyKia/XMU/GqB5yBOjxOoQXHh65wNa0UzLjlFlZTXMXJDLzHqBJcIvRUF CSn3nhn7sYuug1hblJNt9en/O8w89nvjxeQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697143099; l=2068;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=SYQ386LfpERfZ3lAzcZX/YAwnnnGrHNeB4TXtCbYLmg=; b=n1NXT6xjh6pep0SH9qrhUbLfcrStBVTsGrgW+BWG7zmsTks6Pv86l3/lpg9r+aoLoIDADkeHU
 vgcPJT55Ku7CqV9Y37+k3puJZ7yrxNOfwizdyqmEZ6uWfNyunJEaclV
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
Subject: [PATCH] sfc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`desc` is expected to be NUL-terminated as evident by the manual
NUL-byte assignment. Moreover, NUL-padding does not seem to be
necessary.

The only caller of efx_mcdi_nvram_metadata() is
efx_devlink_info_nvram_partition() which provides a NULL for `desc`:
|       rc = efx_mcdi_nvram_metadata(efx, partition_type, NULL, version, NULL, 0);

Due to this, I am not sure this code is even reached but we should still
favor something other than strncpy.

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

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/sfc/mcdi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index d23da9627338..76578502226e 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -2205,10 +2205,9 @@ int efx_mcdi_nvram_metadata(struct efx_nic *efx, unsigned int type,
 				goto out_free;
 			}
 
-			strncpy(desc,
+			strscpy(desc,
 				MCDI_PTR(outbuf, NVRAM_METADATA_OUT_DESCRIPTION),
 				MC_CMD_NVRAM_METADATA_OUT_DESCRIPTION_NUM(outlen));
-			desc[MC_CMD_NVRAM_METADATA_OUT_DESCRIPTION_NUM(outlen)] = '\0';
 		} else {
 			desc[0] = '\0';
 		}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-cf970a9b7d60

Best regards,
--
Justin Stitt <justinstitt@google.com>

