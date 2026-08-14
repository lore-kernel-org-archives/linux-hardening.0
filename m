Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FB3F2109
	for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749098; cv=none; b=YFZOXWWAgCxFHNyXy2KykXcZhydzEWIJNoPAypxSzQR9/AFd7MF3itYhXlISLxFbIjH5UYFZWX7mOsiAH2vPCn2OldwIMjzn/Nk+iOb1NotqJvnlcNdyXLWNtrtk4v3R3tXRSgoRYmQslP57hPE24nnnX9teHVcHNfKJdNWCO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749098; c=relaxed/simple;
	bh=YlvvGTa9EnahPCY2nskii4xpnenwqPbUOJnmp8L6yUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hf8D+7KZd2ssYzGOFQwAFZlrGTududSI1O8iwwVHcF6gYJ4I71pwU4DHahMoeYxYZmJJKb4ZYJmVjm6Erx04DUUFmO2r12yYK7pTV3ex0J9koeVU+eO909HNUka9nRL+r008VLMnPZucXvASuUG10exWERg/5944AWVHeWbzJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/uhdm/q; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/uhdm/q"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1108877a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786749096; x=1787353896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03zKDu7qMZtz3mj6zlwpsyLOBqCiVsWKdbf7HTBPFNI=;
        b=k/uhdm/qUK9inlscuCWlPyDjQCcfwr8MFrK+9AUFaNM1WbgP9BEX3liTpexR3BJAxF
         atAcrdZbiorzu4cVtI19Ryahz8Mc8tL5ukrXJXypW8I+ByBXNZrO8GO2jt5Jrk8JxYcs
         Ow1WN1JuQWn81rVeNqqxA1lYxvoKEeuiFdff+LNvQsQ6CQncUQJN1nrCP37MNbPtTdsP
         dxTRyk0t3hhMfwG3AmRoa1dA9w5AbZBQNWL9Ld6fGo98hX6v3gzVTsh39m8YxV6lr19m
         PaEwDauXUKCxOvqaVXPpvL3v5FQKVuN3bxdGCogEJvC94pIMuT9PEH0ZUiI+MRkehcj1
         AvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786749096; x=1787353896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=03zKDu7qMZtz3mj6zlwpsyLOBqCiVsWKdbf7HTBPFNI=;
        b=SFJdBk9BWoOexJiE7RMoYYk//aks8tMrCnS+AyMutbgCbAVkofn86T+qs0Cm8oqEyO
         tiAtpBx0fKIb8JoygIl2PYpTr0Xvm2wPwChvDtVSbwz3danDKopXOzRf3LN3eN+ZPaFK
         nDu9uE/j4V/E2pApwyUbcWnCyBCmypzqHLOgeshu0XQfCqFgKNGMpFfYCBWJR9rsAvV6
         nOklcYFbZihsPwSJqeUjXh94lapIiVqG6n+pDo7hFcrXVbaBjxRlgW4NQvgqWhpwiufm
         pjOyv1thfMdUT1OWHxmCHIVlVzkvn3UNvyH5FWPLy4+8QPgLJW6OEcCHRBUj2PPhDUXw
         Yprg==
X-Forwarded-Encrypted: i=1; AHgh+RqzLivnm6OXQjxvyLkWRxTjAoupTEXnQ221IIBvTYOMwU8F7I44Sqs7eaKckMs2wwoTth+U50ywcq2FQjDss1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bAt9NwbN6MM9DH8CG6RTyr6SOqTPH36aHzACVl7ARf44V/DA
	V4a+w+DWZOS0L1Tp9MpKYpouIuHaVCOt6H4DfLxtHPytLHZwhWDvIpWd
X-Gm-Gg: AR+sD11R0qJqVd2dcRiYBasTUaoympwZ4OycZAYttVK9Fbi5cxk+9Wa7RRNfcYNqZqz
	KOIWilcGm0E9tvSsc7KYWVkPg3MoefjNwfvJ37HcXQcFRme4RrrhEzeZWKmKfq8O6FfgAb6gl2F
	EM/8w4Z7IpjuRZfnqzhcxQrq3Q7gl1tXGu1pDse0QxJGkldXNL0YhBIRuAgUc1ffYUUac9oDvl2
	JiZEB6MdRxNtKx0d8rhAsxssbPtDLjluB8Yy9olH6b5UCX+MPd2agtJXfujyH7F+kGrxzaWHsgY
	KYDGnKZzOkIzo4bxpIf16Nrba115WdMZP/yndGcuKemav+YFlCOvekrsTpd9Uq6ESIBNKzTs+0g
	umlH4Vtp3ZOFgCgmMi21MP8KWvJQgn0sVIliGsuWxpqb1wMZyM24Hv+nQx7VnNP0c/p0Tj7gPMO
	zx8etb8FXMHKwAJj2KhiOUzLtRu6Jm+RVyqgYjT/p7AvhLXOpzUDsp0aSC2xN9l8Oabel7SdoTn
	a0XaA==
X-Received: by 2002:a05:6a20:3ca3:b0:3c3:b226:f165 with SMTP id adf61e73a8af0-3cc71fb5d5bmr11525983637.35.1786749095785;
        Fri, 14 Aug 2026 16:11:35 -0700 (PDT)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d61e1568sm8563607eec.11.2026.08.14.16.11.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 16:11:35 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Nam Tran <trannamatk@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v5 7/7] ptp: ocp: Add Time Card V9 I2C peripheral topology
Date: Fri, 14 Aug 2026 16:10:55 -0700
Message-ID: <1b0ad989c6290a400bd642f9fb2d26d965bc02c8.1786747084.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1786746757.git.ahmadexp@gmail.com>
References: <cover.1786746757.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Time Card V9 boards use the same mux infrastructure with a BME280,
a BNO055, and an IS32FL3207 at a different address.

Describe six RGB groups. The first two expose the GNSS1 and GNSS2
status LEDs on outputs 0 through 5; the remaining four expose the SMA
indicator LEDs on outputs 6 through 17.

Select the profile only when the fixed-width board ID exactly matches
TIMECARD-V9 with zero or erased-byte padding. Older revisions share the
detectable I2C devices but not the V9 LED wiring.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 87 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 5ae50ad83bda..5100278f164d 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -643,6 +643,73 @@ static const struct ptp_ocp_i2c_profile ptp_ocp_r4006_profile = {
 	.led_max_microamp = 8150,
 };
 
+static const struct ptp_ocp_i2c_device ptp_ocp_v9_sensors[] = {
+	{ "pressure@76", "bosch,bme280", "bme280", 1, 0x76 },
+	{ "imu@29", "bosch,bno055", "bno055", 1, 0x29 },
+};
+
+static const struct ptp_ocp_led ptp_ocp_v9_leds[] = {
+	{
+		.node_name = "multi-led@0",
+		.function = LED_FUNCTION_STATUS,
+		.function_enumerator = 1,
+		.has_function_enumerator = true,
+		.channel = { 0, 1, 2 },
+	},
+	{
+		.node_name = "multi-led@3",
+		.function = LED_FUNCTION_STATUS,
+		.function_enumerator = 2,
+		.has_function_enumerator = true,
+		.channel = { 3, 4, 5 },
+	},
+	{
+		.node_name = "multi-led@6",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 1,
+		.has_function_enumerator = true,
+		.channel = { 6, 7, 8 },
+	},
+	{
+		.node_name = "multi-led@9",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 2,
+		.has_function_enumerator = true,
+		.channel = { 9, 10, 11 },
+	},
+	{
+		.node_name = "multi-led@c",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 3,
+		.has_function_enumerator = true,
+		.channel = { 12, 13, 14 },
+	},
+	{
+		.node_name = "multi-led@f",
+		.function = LED_FUNCTION_INDICATOR,
+		.function_enumerator = 4,
+		.has_function_enumerator = true,
+		.channel = { 15, 16, 17 },
+	},
+};
+
+static_assert(ARRAY_SIZE(ptp_ocp_v9_sensors) <=
+	      OCP_I2C_MAX_SENSOR_COUNT);
+static_assert(ARRAY_SIZE(ptp_ocp_v9_leds) <= OCP_I2C_MAX_LED_COUNT);
+
+static const struct ptp_ocp_i2c_profile ptp_ocp_v9_profile = {
+	.name = "v9",
+	.sensors = ptp_ocp_v9_sensors,
+	.sensor_count = ARRAY_SIZE(ptp_ocp_v9_sensors),
+	.leds = ptp_ocp_v9_leds,
+	.led_count = ARRAY_SIZE(ptp_ocp_v9_leds),
+	.led_node_name = "led-controller@37",
+	.led_mux_channel = 1,
+	.led_address = 0x37,
+	.led_riset_ohms = 4700,
+	.led_max_microamp = 8100,
+};
+
 #define bp_assign_entry(bp, res, val) ({				\
 	uintptr_t addr = (uintptr_t)(bp) + (res)->bp_offset;		\
 	*(typeof(val) *)addr = val;					\
@@ -2243,6 +2310,22 @@ ptp_ocp_i2c_supported(struct ptp_ocp *bp)
 		bp->pdev->device == PCI_DEVICE_ID_CELESTICA_TIMECARD);
 }
 
+static bool
+ptp_ocp_board_id_matches(const u8 *board_id, const char *id)
+{
+	size_t len = strlen(id);
+	unsigned int i;
+
+	if (len > OCP_BOARD_ID_LEN || memcmp(board_id, id, len))
+		return false;
+
+	for (i = len; i < OCP_BOARD_ID_LEN; i++)
+		if (board_id[i] != 0 && board_id[i] != 0xff)
+			return false;
+
+	return true;
+}
+
 static const struct ptp_ocp_i2c_profile *
 ptp_ocp_i2c_select_profile(struct ptp_ocp *bp)
 {
@@ -2254,6 +2337,10 @@ ptp_ocp_i2c_select_profile(struct ptp_ocp *bp)
 	if (!memcmp(bp->board_id, "R4006", 5))
 		return &ptp_ocp_r4006_profile;
 
+	/* Older revisions share V9's I2C devices but not its LED wiring. */
+	if (ptp_ocp_board_id_matches(bp->board_id, "TIMECARD-V9"))
+		return &ptp_ocp_v9_profile;
+
 	return NULL;
 }
 
-- 
2.50.1 (Apple Git-155)

