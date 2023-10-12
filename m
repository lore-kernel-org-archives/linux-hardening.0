Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB813F4CB
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPCU1tNM"
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6ECC
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 15:21:48 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c6373a4aa7so2082361a34.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149308; x=1697754108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bh+hSER4C1DvDn14bvbdLI9ZreonMjP5eqcJAKaJwbM=;
        b=iPCU1tNMlM8fq/StWad5u6JvS3cquovX1dQ7Ea1IymTdRFRRl3iexFyr+HCQsfIZMk
         fMyFSeVt13lcPo13BgTMCSay3qxOVPO4BRz3Efv/32kyxlrtuUFgXpPX1DfFnn3x/sud
         SZI4QUUxlfN5/tNTpuFgXKtoJKoRBLQpvc8HqQbRTPHYvC+cHp9lLndPflejkNXt7PHn
         GImWL/NnTWUEEspM3WuUaOEQ8EsKOR8BfQD/Dk22ARmfDOfJQnuvT/EFVF5TqBpVApRL
         lpVtdt3jACxeAligAklDGCwlmUZWrsEp26q1riBtzpk8UqKEZExAlb5Rdejs9OCiacCd
         zgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149308; x=1697754108;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bh+hSER4C1DvDn14bvbdLI9ZreonMjP5eqcJAKaJwbM=;
        b=hQgS1bf/fLg/5oqySKctjOubqFfiB+PQhi7doL7FQsXPRT8kUynT5hA4DNWK5pUTJP
         asSANUm9ChwSVrqwYXWFBg9OTT8IUhETr8J+DCquN5QPA5h2pkdqGQ1fugsWCLJoBPGT
         1B7O8CygttR1R7vwH84RVgsYmYs2V0oS0oUBk4tsN6/6BUVnLZY4827LB/MUZQJHu4Vt
         jchIIlBamN5O4EWbN9HufJZtE/pvsbXZDGhATe+lGFswjV40+JGlQLbKwjlzMx7ixY+X
         N/KNua1W1XUlHOZmYftqWv9aJvE6VAtTnhyCU347pCHS+i0P0WZf61MIr2+DVZ5h9wdf
         oz2g==
X-Gm-Message-State: AOJu0Yx0tcsthG69+O07g37Dplvophh2TgDm9GGUPKLG5DcXvKBl79nx
	xP2B3/C7+g2jh5Eg2zK6QhXBRU7U9XDV6CBwag==
X-Google-Smtp-Source: AGHT+IELO7CCmKHbSitPZT/rHAYitcviBaNNPJqex7iyGwcatZBSy7jQpznkIdE6Pj+2ay58t+4cDPaWIZTXb3umGw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:6656:0:b0:6bc:e2b0:7446 with SMTP
 id q22-20020a9d6656000000b006bce2b07446mr7467981otm.1.1697149307832; Thu, 12
 Oct 2023 15:21:47 -0700 (PDT)
Date: Thu, 12 Oct 2023 22:21:40 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHNxKGUC/x3NwQ6CMAyA4VchPduElTDRVzEedFTppS7tQkYI7
 87i8bv8/w7OJuxw73YwXsXlpw3h0kFaXvpllLkZqKch9IHQi2nKG84mK5ujcsG8bKg1Y3qXigk pRprGONF1vEELZeOP1P/k8TyOE0WheCx0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697149306; l=1461;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zDm0tM3C96zS13DwXvkwxj+OZciNm9xmIb8vZS7nYHY=; b=jaA6cIlF3bF8PEtTlY+0c10ULOr8mzf5f1MLSNvU6GhIHm6sizPmiWvq3MVNeND9xeoYnl19y
 ETVPyKnbhIwAw97CRcGjpx3d4lEbCCtDsTHw38ivP6HbK7bYoYycjkv
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-nxp-cbtx-c-v1-1-4510f20aa0e6@google.com>
Subject: [PATCH] net: phy: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
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
 drivers/net/phy/nxp-cbtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-cbtx.c b/drivers/net/phy/nxp-cbtx.c
index 145703f0a406..6a2c0c193255 100644
--- a/drivers/net/phy/nxp-cbtx.c
+++ b/drivers/net/phy/nxp-cbtx.c
@@ -182,7 +182,7 @@ static int cbtx_get_sset_count(struct phy_device *phydev)
 
 static void cbtx_get_strings(struct phy_device *phydev, u8 *data)
 {
-	strncpy(data, "100btx_rx_err", ETH_GSTRING_LEN);
+	ethtool_sprintf(&data, "100btx_rx_err");
 }
 
 static void cbtx_get_stats(struct phy_device *phydev,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-nxp-cbtx-c-266285682759

Best regards,
--
Justin Stitt <justinstitt@google.com>

