Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC24322E7
	for <linux-hardening@vger.kernel.org>; Mon,  3 Aug 2026 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790235; cv=none; b=Zi0cLsg0r/9PMJjDaq23S3y7MwD1UfM7aV780X0SEa4o2ofY01328fZEVcZNbuuSEli8rG7Cbs4cUhFR8aAquY07+erecsGfQr4KofKkBl/WblxDx4VQTXKA5jJfPY5/kUrNKZv9oSDOMrIewtByYngp/OiwEp/02AxxUJL3ea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790235; c=relaxed/simple;
	bh=PuTxehw/+oG0R+AUeP1S0jJfWF/Fu/L6ssD+zcOM2zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrvj0WkUqykNYDMXxN1cT3+l/ZL0zaeiegGHePSNkinVfEqH37zvc06fWQUIMVBZsfkAvS9G7GHazwQu1bayEWXQZjtacvou20FHwfYZ4dRRJyvIpNM57MSRPoEfXulVbwKEI5RtXbayhi1PthghJeyxc7Ekr1KaW2O+t1/7mYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VblUMTIK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VblUMTIK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso339094a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 03 Aug 2026 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785790233; x=1786395033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcnfcYJ16OlC/FCeHSIUYdGv8WlSuwcbHtR9yqY3EXk=;
        b=VblUMTIKXDgt/FYOzdKV8CxFYreBf1imFvjbTciNdXpEVoYT6evIVDoFVcVa8TxNLb
         Os8VC7HNGV1zToIQuTx38zg3bOGGdUhbdKsMYiNdGYbRVnRDq/nzrVieSr4WAhB5a62j
         WGUBH9SnpdQRu2JTsrIK0oKeqb+uC6im13PGHNusT1nuDdvF6KOi/Hx4aZmTc9uJHGjF
         wWNXpBTWY2OtEnigx80RLf4xXLV56ZHuIhgWKiY/v7RXoLlhuxj1yiKuMrxF289M5gEs
         P/qWGkkxnVh8BNrMWlwHUrfNy4+4Z+nkfbKvCh6NTv7J6gbvtGh3KzKhscZluPuKuDmA
         Wc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785790233; x=1786395033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcnfcYJ16OlC/FCeHSIUYdGv8WlSuwcbHtR9yqY3EXk=;
        b=rZo2L+J4MFZGjRTdmxJEHLZfNwnZ6YpgEW0O1kjWIy59jaaLP465Eeq2XaAR4YWfoZ
         GuMeLw1xBg/CGDwoBDRFwOrd1AGAEStjnKBHfS3nrcx2g+zjNYoHzjHjoChY25I1TTZ9
         1nUffrI/ZGq7Thiwh4aVKpN9Z5C1/8n05YSdHm/RIwKJkYijutYdkbXK+OywlI9aG161
         sND9qNk5MXe/VCQWnqVCqscjsZyMcrcwMU3qSGL49vb1iWqgAHxlDsA19QPI3u5fmiUV
         FGgEpllvTJIWl4JHIVWWkvo8OsuhE91+hL8fDiY94wXRYaGbm/aCEZzn5t8ppziBwuYP
         RDeg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5skH+gQQiI6GQrjyBTrBUwEuY12cO5M86pVgqd+H3oc3sgLjYvvsLF+u5NA5jzeqxRtzrYi0dwKL384Kq0PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9nQ5CBOBuq8qskiB+EPwcPTWIU4CMakZhKhnGL1RsQwVawc9
	FKicTzeAiouVi2A22KUqGXsEIw5MrjToWfhUQ42vO4bZEXv1jGS97rcM
X-Gm-Gg: AR+sD13q752kQvENYMMNgl5V4c7JI1ZyaWZDBtpCRQ4X0BnvMa2r3/qRf7cBXaJ6Rr3
	J3OLKnTYsU15Euit8lxwt2CHoIksAfshM4jFNUI6uAC/tGatg2TpPVUo15YQwcWRWllirzCQS5f
	WhZNIABa13ejCYCcrrserSbVw5IHR5my7KKnOyR+Pe1QAdlR+NIyFNBxEj1VXpZdWcQi8Eq8UA6
	n4auNOXGJTpPW+Wu22JY5zAW00XB4CaQ2jecKhMN/8mCZ6OEEh6unqBowzpVwd0kwVxq8wu4CPU
	5urX4Mu8owVH+74UuOud9X1wp8XEwv0ZyFjbj6sEyPiZkHYzp7kcmONvuOJkVFrSG6ZHLEA1377
	5PBtTwjjBMYW3WpwTv+zrL3Nd+m4rQEwZmDwmA+9EH0zOwsjU0iVK8QJ8gVJiXIOuWL6EtwWTOt
	b3ZkJDXpBiUPEssow67OL2uvsrlm4aeyx5n6skWrIqGl0GHv9TbqljRP3Lxlg922gBL9g=
X-Received: by 2002:a17:90a:d885:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-38febf7117amr885915a91.1.1785790233222;
        Mon, 03 Aug 2026 13:50:33 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm33112324c88.11.2026.08.03.13.50.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 13:50:32 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC net-next v2 4/6] ptp: ocp: Validate EEPROM board IDs
Date: Mon,  3 Aug 2026 13:50:09 -0700
Message-ID: <20260803205011.1249-5-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803205011.1249-1-ahmadexp@gmail.com>
References: <20260803205011.1249-1-ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EEPROM board ID is a fixed 13-byte field. It is stored without room
for a terminator and passed to devlink as a C string. An erased EEPROM
therefore exposes 0xff bytes and can make devlink read beyond the field
while formatting board.id.

Reserve a trailing byte, classify erased and malformed contents, and
publish board.id only when the field contains printable text with valid
padding. Continue reporting the serial number when the board ID is
absent.

Fixes: 0cfcdd1ebcfe1a9b262f6ad8419580720dc843c4 ("ptp: ocp: add nvmem interface for accessing eeprom")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 35e911f1a..cec936bd1 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -347,6 +347,13 @@ struct ptp_ocp_serial_port {
 #define OCP_SIGNAL_NUM			4
 #define OCP_FREQ_NUM			4
 
+enum ptp_ocp_board_id_state {
+	OCP_BOARD_ID_UNREAD,
+	OCP_BOARD_ID_VALID,
+	OCP_BOARD_ID_ERASED,
+	OCP_BOARD_ID_INVALID,
+};
+
 enum {
 	PORT_GNSS,
 	PORT_GNSS2,
@@ -401,8 +408,9 @@ struct ptp_ocp {
 	bool			fw_loader;
 	u8			fw_tag;
 	u16			fw_version;
-	u8			board_id[OCP_BOARD_ID_LEN];
+	char			board_id[OCP_BOARD_ID_LEN + 1];
 	u8			serial[OCP_SERIAL_LEN];
+	enum ptp_ocp_board_id_state board_id_state;
 	bool			has_eeprom_data;
 	u32			pps_req_map;
 	int			flash_start;
@@ -472,18 +480,23 @@ struct ptp_ocp_eeprom_map {
 	.len = sizeof_field(struct ptp_ocp, member),		\
 	.bp_offset = offsetof(struct ptp_ocp, member)
 
+#define EEPROM_ENTRY_LEN(addr, member, entry_len)		\
+	.off = addr,						\
+	.len = entry_len,					\
+	.bp_offset = offsetof(struct ptp_ocp, member)
+
 #define BP_MAP_ENTRY_ADDR(bp, map) ({				\
 	(void *)((uintptr_t)(bp) + (map)->bp_offset);		\
 })
 
 static struct ptp_ocp_eeprom_map fb_eeprom_map[] = {
-	{ EEPROM_ENTRY(0x43, board_id) },
+	{ EEPROM_ENTRY_LEN(0x43, board_id, OCP_BOARD_ID_LEN) },
 	{ EEPROM_ENTRY(0x00, serial), .tag = "mac" },
 	{ }
 };
 
 static struct ptp_ocp_eeprom_map art_eeprom_map[] = {
-	{ EEPROM_ENTRY(0x200 + 0x43, board_id) },
+	{ EEPROM_ENTRY_LEN(0x200 + 0x43, board_id, OCP_BOARD_ID_LEN) },
 	{ EEPROM_ENTRY(0x200 + 0x63, serial) },
 	{ }
 };
@@ -1969,6 +1982,52 @@ ptp_ocp_nvmem_device_put(struct nvmem_device **nvmemp)
 	*nvmemp = NULL;
 }
 
+static enum ptp_ocp_board_id_state
+ptp_ocp_classify_board_id(char *board_id)
+{
+	bool all_zero = true;
+	bool all_ones = true;
+	bool terminated = false;
+	unsigned int i;
+
+	board_id[OCP_BOARD_ID_LEN] = '\0';
+	for (i = 0; i < OCP_BOARD_ID_LEN; i++) {
+		u8 value = board_id[i];
+
+		all_zero &= value == 0;
+		all_ones &= value == 0xff;
+	}
+
+	if (all_zero || all_ones) {
+		board_id[0] = '\0';
+		return OCP_BOARD_ID_ERASED;
+	}
+
+	for (i = 0; i < OCP_BOARD_ID_LEN; i++) {
+		u8 value = board_id[i];
+
+		if (terminated) {
+			if (value)
+				goto invalid;
+			continue;
+		}
+
+		if (!value) {
+			terminated = true;
+			continue;
+		}
+		if (value < 0x20 || value > 0x7e)
+			goto invalid;
+	}
+
+	if (board_id[0])
+		return OCP_BOARD_ID_VALID;
+
+invalid:
+	board_id[0] = '\0';
+	return OCP_BOARD_ID_INVALID;
+}
+
 static void
 ptp_ocp_read_eeprom(struct ptp_ocp *bp)
 {
@@ -2001,6 +2060,7 @@ ptp_ocp_read_eeprom(struct ptp_ocp *bp)
 			goto fail;
 	}
 
+	bp->board_id_state = ptp_ocp_classify_board_id(bp->board_id);
 	bp->has_eeprom_data = true;
 
 out:
@@ -2177,6 +2237,9 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	if (err)
 		return err;
 
+	if (bp->board_id_state != OCP_BOARD_ID_VALID)
+		return 0;
+
 	err = devlink_info_version_fixed_put(req,
 			DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
 			bp->board_id);
-- 
2.50.1 (Apple Git-155)

