Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B6225C6
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nA/teSCb"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C393D91
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:12:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ac9c1522so27238177b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696972321; x=1697577121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hw4yLVcWfwcyHBWiL12H1p9pecjvnDh7ltJR9rI3BWk=;
        b=nA/teSCbf8g6xSZW1SxheJx8Xs3cO7jmKjy5gN21VKtp8GmofGDP3uP2pMcmdFLM2+
         fUclvlV/Ypt4v3FR+w+dHv7258vecIU0UodCUsm19iB87dciRsU8Dg4V09rg3hHD3cfa
         5lDN0j8uzKE5BK2djtz7FZSXdDyCNWweuQNmPvpdG83vJtbtHAS0Q8XbPAVdSE8RngfA
         fXIqHKXu/hFSRd+4Ze3yc8bCdq7l5JYMN6KCzUB54N3VYZ6WYEiTeFTwng1w12cBl+Ff
         9sCEdcdSCZFOCcK2kIh+fN4Kmyfp0Q006nJvfbzFagSHOJxqF8Mqta9r1ytQUeV4T7KT
         lMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972321; x=1697577121;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw4yLVcWfwcyHBWiL12H1p9pecjvnDh7ltJR9rI3BWk=;
        b=SdA2Q4euLSX7L6mRDOB9CgROVeoSf3Jgz/JK3KJbrTRQYNztUTKV0QcfJw+toBf/gi
         uvx8cpAfiP6edUrZbAEvax6TOnJbrW2PDrX8Kg8gk0LvbEsndQhJHsyDq8RzaE3+pZm0
         q3gr1ysZ3Y4Y+D0KnMSmKmoBAujOtKyGWwK23qmFnr9AmEGWjT59v1rj5JuH+bHLSvpI
         QACFvlnxnREAA89j/bBRorpPasZTsLfomClZPuorqpgbjaeCso7UZCTVNPWX/5Ag0LGh
         3AgTOdqlcsHfJPvmC4mbVFmSHfFthaDZqQWn3GtetfJocXuQf/xh+o5plPIMmU76dgee
         tO7Q==
X-Gm-Message-State: AOJu0YwMlc2F8qylrliqprmQ0TTteQvW05+GMpil5UaFi21V51XEnDwD
	U+tIBU4p0rCjpthc9KDO0f/zVcW6bn8PNoyfaw==
X-Google-Smtp-Source: AGHT+IHlIactwvDZJurG0TKMKze9eW1XbBtIBn1Z1/ozRqw8zUN1Z0OKHm1ZUyRro7UtUldo9q2dVqNFfl5FSONE7w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2a0f:b0:5a7:aa51:c08e with
 SMTP id ei15-20020a05690c2a0f00b005a7aa51c08emr94672ywb.1.1696972320943; Tue,
 10 Oct 2023 14:12:00 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:12:00 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB++JWUC/x2N0QrCMBAEf6XcswdJrCD+ivhwJtv2QGK5hKCU/
 rupbzMM7G5UYIpCt2EjQ9Oi79zFnwaKi+QZrKk7BRfO3nnHpVqO65eTaYMVzqiMusAO0FzxYp2 fbTpCQuPIAhkvo/irhER9dzVM+vl/3h/7/gPAZza6gwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696972320; l=2145;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=oGaWK4GP1PQLCGPw7gir9mj5QFry1WylDMUmi7PoCMI=; b=AlIp0TwJFUsw0WGPci9gswgAfJCtFnHNLhXeagjOm+3FqL5bLrOm+uMa5Gg99nXKXa7/Ix9On
 NnZjUs9WY8mCHt2dUpsIxoumeQaXVg1wJ6aTUJb96SAVeKft4Gof5nT
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
Subject: [PATCH] igbvf: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
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

We expect netdev->name to be NUL-terminated based on its usage with
`strlen` and format strings:
|       if (strlen(netdev->name) < (IFNAMSIZ - 5)) {
|               sprintf(adapter->tx_ring->name, "%s-tx-0", netdev->name);

Moreover, we do not need NUL-padding as netdev is already
zero-allocated:
|       netdev = alloc_etherdev(sizeof(struct igbvf_adapter));
...
alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

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
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 7ff2752dd763..fd712585af27 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2785,7 +2785,7 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	igbvf_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	adapter->bd_number = cards_found++;
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-aea454a18a2d

Best regards,
--
Justin Stitt <justinstitt@google.com>

