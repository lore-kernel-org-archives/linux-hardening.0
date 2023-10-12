Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E03B28A
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBlYxber"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3466C9
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 15:25:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81cd8d267so626057b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149515; x=1697754315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4cW7wFWvnFRZJ8ywKO4YSs7fPF7BTc9LFrtaZSrdIDc=;
        b=MBlYxberzusxJ3c/QS12vHfR2P2xraSd0tr179NcFgrWQUwWpbzoSIWSuQIfyV/qcM
         +STqKyyBcA1F/Ero3F4X1cqB/dEHUS95F+blljG8Fs5zggeiTkPvLCTGBeiZh9OHCwp6
         pJkLpTWGcfdG1fEPXUEar7zTf5YE2mJmRkNjyFh4msqV5pAeRsCXBpoaIxvFZkbTRg5G
         a29PfL8pMRWPlZdONRX9kJcDnoc2XK/WJQZLEDF04M6ZUN9uky39bVRcXUG03VL/hAe5
         3J6eQNG1ndhcoEgqy/AwzNayf+OnB2VnCQcNV/i09IKUo/MnlEz/1iy0ns0NW8ttlBL2
         wAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149515; x=1697754315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cW7wFWvnFRZJ8ywKO4YSs7fPF7BTc9LFrtaZSrdIDc=;
        b=nbzUFiwu/d6yKs0fr9aagwsEAJgIteRAwQEqg8r+H/NXIiAiRzznXJ+Ufkkwsxg8cb
         Yy6W3PR7/CLw0dkW56nmpN208Uj9ZwinWQ++rkiiZel3po1o5maq8qZ0u1kRQgPAkXnw
         emsAfZu/gwJlgpWMiPOuXUMuj8HnMpjp/y0uZNE9zWDBQlydLUWkm2GVDMrOKlXH+kMc
         KvUJpmKCmq7DtGCynAnwPcOuTcbLA8ueTOBJxo3WhncmKGP4BtpbAe4EWO/NxXrBXcJu
         KXjquOZ+yowhPEbxmnq/i+owXg0fvgFlIypjG4rrytMS44LKOwOL2fpIqLm2f8+b5dfw
         ailg==
X-Gm-Message-State: AOJu0Ywiqw8JLqzmJnn4LpBGu2+uZeR72KUIaWm5KSKvRZz/QVrJcnKq
	AteHxg9Xz9WPac5+p46Wk/hJEKSAuTFRU5vsXA==
X-Google-Smtp-Source: AGHT+IGBAbIIcoW0CqLfhN7DK13ZkiVJSw8iVxGlivsbecvejC2H92bx+d5WdZOaPJzjelOAlzToduoOuE7EQf7FuQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:d444:0:b0:59b:ebe0:9fcd with SMTP
 id g4-20020a81d444000000b0059bebe09fcdmr542887ywl.7.1697149515012; Thu, 12
 Oct 2023 15:25:15 -0700 (PDT)
Date: Thu, 12 Oct 2023 22:25:12 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEdyKGUC/x3NMQ7CMAxA0atUnrFkBwbCVRBDSQw1Q4jsqEpV9
 e5EjG/5fwcXU3G4TTuYrOr6LQN8miAtc3kLah6GQOHMxAG9WUl1w2y6ijkWaViXDUuv2D4zc++ YMEbiSFd6cr7AaFWTl/b/5/44jh9NOHRxdwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697149514; l=1614;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=++HwxaEbHmOYVMN+LAm7g1M8JgRA8xefB8jT1C9ZOnM=; b=ze8sDKCjWG59fZljQnv44JBnL9EeMTQjI7aP0ag/CneGCWxrrlELOiVc5Y4ZRsDDwIQy0qlw1
 dd/v50D7pV7Af+Kr5HJ0RA5X6YoyFLaIKVSBeMLSlJjQ3dsgRe3RsFm
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
Subject: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this dedicated helper function.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/phy/nxp-tja11xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index b13e15310feb..a71399965142 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -414,10 +414,8 @@ static void tja11xx_get_strings(struct phy_device *phydev, u8 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
-		strncpy(data + i * ETH_GSTRING_LEN,
-			tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
-	}
+	for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
+		ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
 }
 
 static void tja11xx_get_stats(struct phy_device *phydev,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-99019080b1d4

Best regards,
--
Justin Stitt <justinstitt@google.com>

