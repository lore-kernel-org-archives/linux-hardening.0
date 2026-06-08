Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0D3B7763;
	Mon,  8 Jun 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912544; cv=none; b=jbYr6deMQY4CItdJjim3WZjJVvZxfAHhqi+BejTmMVFPkDwF2RuyPGJelqaVwmE87k2Uiww2ZUIMc8XDqQ7XlBmjaR+6RYjkQck/TRHzNVv2jj9s22NPM/0ubj7Aq9JLfwT/njWw/q+Ggm/670fC233KBbJYRBK+yOAIuS/jrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912544; c=relaxed/simple;
	bh=H9faC3CC3+kGPgIZUWF1KuGRrkkTHR9uw13swy8lrP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ut3j2d6tzqGCPH+ME7N9W11VTJ38Eq9cq+Iq3iCI4QlHforeR11YhajgfDQHU5WDbOgU2xpS4jyBV+5zKCtUwGih7v5rxF3E3ZQEeEfZv9N4T9SbGLnjCLtJ5vwgV435eLhyIQ0y62p4xqGoH6YC33LzIfAe5iumto1qp6UjLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=OsdmXmB1; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="OsdmXmB1"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhk-00BRvU-P1; Mon, 08 Jun 2026 11:55:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=gDH7HwJrRgzOzbq2PKDR9N7cSTO28B1wI4/RAsxwyGc=; b=OsdmXm
	B1VI6VL0vcC7JTLbc90dz9Lv0KuYQnNHOSuAmwxaN9uVxHqzHK7isO4/0eHizo44RArA+cumV7z1G
	19v4iV1bDoqInjsyoJiwGydKU41vXbCvNw8/Glp5CieRL0RTSH0oX73bsAIOspMMdBPSk5FXqReNd
	3kOHjByQBm2CYu8Yt+VZxth8fIgSn/TiAt3E7NQHGkRwZL8vxzH5DuwV+sa2QGfiL7OqlySCNGbqV
	xYM4EG1MunruW3z16iO0WbI2euVoThwONPia2tdYVaW6dF8Wb4YjCp0O6uAwk8Mpv9XMziuyo1PmK
	8Knq3VaTuSgutKfoZ+isFpMAn5vw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhk-0003ac-75; Mon, 08 Jun 2026 11:55:36 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhi-00Ag6G-Us;
	Mon, 08 Jun 2026 11:55:35 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <mchan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] Rewrite tg3_bus_string() to avoid temporary string
Date: Mon,  8 Jun 2026 10:55:07 +0100
Message-Id: <20260608095523.2606-23-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Rather than build (eg) "PCIX:33MHz:32-bit" in a temporary buffer,
return the addresses of the three constituent components to be used
in the final snprintf() call.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/ethernet/broadcom/tg3.c | 38 +++++++++++++++--------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..08bd5a074be8 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17610,40 +17610,41 @@ static char *tg3_phy_string(struct tg3 *tp)
 	}
 }
 
-static char *tg3_bus_string(struct tg3 *tp, char *str)
+static void tg3_bus_string(struct tg3 *tp, const char **str_a, const char **str_b, const char **str_c)
 {
 	if (tg3_flag(tp, PCI_EXPRESS)) {
-		strcpy(str, "PCI Express");
-		return str;
+		*str_a =  "PCI Express";
+		*str_b = "";
+		*str_c = "";
+		return;
 	} else if (tg3_flag(tp, PCIX_MODE)) {
 		u32 clock_ctrl = tr32(TG3PCI_CLOCK_CTRL) & 0x1f;
 
-		strcpy(str, "PCIX:");
+		*str_a =  "PCIX:";
 
 		if ((clock_ctrl == 7) ||
 		    ((tr32(GRC_MISC_CFG) & GRC_MISC_CFG_BOARD_ID_MASK) ==
 		     GRC_MISC_CFG_BOARD_ID_5704CIOBE))
-			strcat(str, "133MHz");
+			*str_b = "133MHz";
 		else if (clock_ctrl == 0)
-			strcat(str, "33MHz");
+			*str_b = "33MHz";
 		else if (clock_ctrl == 2)
-			strcat(str, "50MHz");
+			*str_b = "50MHz";
 		else if (clock_ctrl == 4)
-			strcat(str, "66MHz");
+			*str_b = "66MHz";
 		else if (clock_ctrl == 6)
-			strcat(str, "100MHz");
+			*str_b = "100MHz";
 	} else {
-		strcpy(str, "PCI:");
+		*str_a =  "PCI:";
 		if (tg3_flag(tp, PCI_HIGH_SPEED))
-			strcat(str, "66MHz");
+			*str_b = "66MHz";
 		else
-			strcat(str, "33MHz");
+			*str_b = "33MHz";
 	}
 	if (tg3_flag(tp, PCI_32BIT))
-		strcat(str, ":32-bit");
+		*str_c = ":32-bit";
 	else
-		strcat(str, ":64-bit");
-	return str;
+		*str_c = ":64-bit";
 }
 
 static void tg3_init_coal(struct tg3 *tp)
@@ -17684,7 +17685,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	struct tg3 *tp;
 	int i, err;
 	u32 sndmbx, rcvmbx, intmbx;
-	char str[40];
+	const char *str_a, *str_b, *str_c;
 	u64 dma_mask, persist_dma_mask;
 	netdev_features_t features = 0;
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -18008,10 +18009,11 @@ static int tg3_init_one(struct pci_dev *pdev,
 			tp->ptp_clock = NULL;
 	}
 
-	netdev_info(dev, "Tigon3 [partno(%s) rev %04x] (%s) MAC address %pM\n",
+	tg3_bus_string(tp, &str_a, &str_b, &str_c);
+	netdev_info(dev, "Tigon3 [partno(%s) rev %04x] (%s%s%s) MAC address %pM\n",
 		    tp->board_part_number,
 		    tg3_chip_rev_id(tp),
-		    tg3_bus_string(tp, str),
+		    str_a, str_b, str_c,
 		    dev->dev_addr);
 
 	if (!(tp->phy_flags & TG3_PHYFLG_IS_CONNECTED)) {
-- 
2.39.5

