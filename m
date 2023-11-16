Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A846424
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMUVa2AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB93C433C7;
	Thu, 16 Nov 2023 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700168248;
	bh=EjMKx5nsjR7WnKWGm9tsxjc3r1t11YJJEx0o24R8FgU=;
	h=Date:From:To:Cc:Subject:From;
	b=PMUVa2AIRiGi8EJ9pjFjU+974IoHgg3yEfJ31Q9eTjA5HYvoe/4QP4QL2J9Tenblg
	 5FJZRhqYP3RWZ47tL7qcdk86sP+MG/N68JJSpgBITaZCaL4u2XJD3hoyQ8OmoUFH3V
	 PfBT1Z4KSpHLm75VCOe7WRYrDcFtVAimRoIy3l7MqTJR+ZygB6jkZl3egpJ0iD1O2M
	 LIGs67TT1sWFvI9fzCfybzPrXyytxkGjPQnYIO0qiXtkBNS5Uo3FfSIBSWoig8xcJ9
	 wWRMUUL/LbjCZS/zA53qqnm+OsCno8mT/vBa1PQu13Q+yLWPTMzAp+izmKxXO9XRfO
	 zmU8iEHtVjnxw==
Date: Thu, 16 Nov 2023 14:57:24 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix
 -Warray-bounds warnings
Message-ID: <ZVaCNAohuieMmdq9@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
flexible-array members in anonymous union in `struct
mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
helper; and fix multiple -Warray-bounds warnings:

drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]

This results in no differences in binary output, helps with the ongoing
efforts to globally enable -Warray-bounds.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index a88f6af323da..9f516f796d63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -163,19 +163,19 @@ struct mt7996_mcu_all_sta_info_event {
 	u8 rsv3[2];
 
 	union {
-		struct {
+		DECLARE_FLEX_ARRAY(struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_bytes[IEEE80211_NUM_ACS];
 			__le32 rx_bytes[IEEE80211_NUM_ACS];
-		} adm_stat[0];
+		}, adm_stat);
 
-		struct {
+		DECLARE_FLEX_ARRAY(struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
 			__le32 tx_msdu_cnt;
 			__le32 rx_msdu_cnt;
-		} msdu_cnt[0];
+		}, msdu_cnt);
 	};
 } __packed;
 
-- 
2.34.1

