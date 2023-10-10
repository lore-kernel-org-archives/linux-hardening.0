Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841331593
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBu9xCCy"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10FB99
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:32:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d84acda47aeso8279565276.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977157; x=1697581957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QMExOtpQpyaeNVwjX7qYEE2Es2bm8MztU54xvZii8ok=;
        b=aBu9xCCy0KGbLSmP0rx9JAA/1xA1BuzXUn1OjjKEfZ2TJWCWQN/3Wtc3dCnWVkapx+
         gq1CMO7d+JhiJfNzfWglrzbWedKGYz4xj4lpG6QxePX2BYMo3H+53rAEIDqKbxcg4pio
         lD8FEoX7bwxXEe84cQzKSjOgvngAyKhUQU3f8k0QblEqh1gbrSuEQ32rC+MD4Fd4ckN8
         USycg4Ly7eO7KTGfeUbawYsMxDQ5b+PVgR/R/6rBEKJ8S7s/q99iecyUwAMVAxDkhEh3
         0GZRgaYdAZLoarGi7s/qC/8e6SkmyYjqOsMXpKuKWNTYepGB+uyq7m1fwmCzdLpxSATI
         4jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977157; x=1697581957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMExOtpQpyaeNVwjX7qYEE2Es2bm8MztU54xvZii8ok=;
        b=wufHKG46qgghi6vyfBOZN+TrqOVE1vx7eqL9Tn6wUKcH6zrSgCocbD4zepCrUqyGqo
         nsgQ42MPI+x82dSZh4JawoSRSQDPrsHmFPvj7tPIZk2QV0z34atk41nXxOuml7IrgugN
         xlw1kEG7WdGoBtDU1IraaJMQDGUZKit3aYQsga8AiTTDsXlxOpqtalPbE7eWf7Lxwm5c
         9dgMtWtUUEYl/twCw5GbZd98MRNzVcRMwU7fFZV2F6Hvjr3NtqyhZsypP1d/nxb9fPf2
         J5GhELX2aYCuC506XKW6LhP4o4SeB0VhehlyP8EJLeNqRDoP/UHk3maZBpyX0SQdPjPA
         uIjA==
X-Gm-Message-State: AOJu0YzZCsIrIFbY0G0ZA6K6xsBkBollcO5/QFedjM8afMbdNCU/3shD
	ZyF/6T7gdtkONan0/DRe2fbhKPgioz6K7yhGKQ==
X-Google-Smtp-Source: AGHT+IE8Wk+fk8uw+nreBsHxt/srT1XykuRciYE1sMvqalGkwlWraFu+e3zuYobA/WX483e3cbvxST0qMC0I+vK6GQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:fc16:0:b0:d89:fc03:60ab with SMTP
 id v22-20020a25fc16000000b00d89fc0360abmr301988ybd.7.1696977156885; Tue, 10
 Oct 2023 15:32:36 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:32:35 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAALRJWUC/53NQQ6CMBCF4auQrh3TFhPQlfcwLGo7wCTampmmg
 RDubuUILv+3eN+mBJlQ1K3ZFGMhoRRr2FOj/OzihEChtrLatkbrK0jm6D8rBKaCLBAxQxAHhTK
 KIBTxXbss4BMjeDB+DNp5G3rzVPX0wzjScoCPofZMkhOvh1/Mb/2bKgYMoL3YDnXfjS7cp5SmF 559eqth3/cv+vEqlO0AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696977155; l=3185;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dy00Q/eHnNspNlp/8P9LCpOdW8TznhvIFS4XT0CmDbE=; b=GEGccPLv6B2Me/6Y16oiC/8KDaQ42fS2f4C7XzQ2ZVLmrSPSmM9qfBVvQPm1iAcLkoAUt2jEA
 Xi1fKm48WSZCCIjGLtjmQUqzy6dP2EKdn7i+Symuu7dCaKyKQZ6RR5j
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
Subject: [PATCH v2] net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

This change could result in misaligned strings when if(cnt) fails. To
combat this, use ternary to place empty string in buffer and properly
increment pointer to next string slot.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Prevent misaligned string assignments (thanks Vladimir)
- Link to v1: https://lore.kernel.org/r/20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com
---
Note: build-tested only.
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4f09e7438f3b..56dc3e7884fd 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -928,7 +928,8 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	const struct vsc73xx_counter *cnt;
 	struct vsc73xx *vsc = ds->priv;
 	u8 indices[6];
-	int i, j;
+	u8 *buf = data;
+	int i;
 	u32 val;
 	int ret;
 
@@ -948,10 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	indices[5] = ((val >> 26) & 0x1f); /* TX counter 2 */
 
 	/* The first counters is the RX octets */
-	j = 0;
-	strncpy(data + j * ETH_GSTRING_LEN,
-		"RxEtherStatsOctets", ETH_GSTRING_LEN);
-	j++;
+	ethtool_sprintf(&buf, "RxEtherStatsOctets");
 
 	/* Each port supports recording 3 RX counters and 3 TX counters,
 	 * figure out what counters we use in this set-up and return the
@@ -961,23 +959,16 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	 */
 	for (i = 0; i < 3; i++) {
 		cnt = vsc73xx_find_counter(vsc, indices[i], false);
-		if (cnt)
-			strncpy(data + j * ETH_GSTRING_LEN,
-				cnt->name, ETH_GSTRING_LEN);
-		j++;
+		ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
 	}
 
 	/* TX stats begins with the number of TX octets */
-	strncpy(data + j * ETH_GSTRING_LEN,
-		"TxEtherStatsOctets", ETH_GSTRING_LEN);
-	j++;
+	ethtool_sprintf(&buf, "TxEtherStatsOctets");
 
 	for (i = 3; i < 6; i++) {
 		cnt = vsc73xx_find_counter(vsc, indices[i], true);
-		if (cnt)
-			strncpy(data + j * ETH_GSTRING_LEN,
-				cnt->name, ETH_GSTRING_LEN);
-		j++;
+		ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
+
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-1cfd0ac2d81b

Best regards,
--
Justin Stitt <justinstitt@google.com>

