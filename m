Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E622EEC
	for <linux-hardening@vger.kernel.org>; Mon, 13 Nov 2023 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ1+KQXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA8EC433C7;
	Mon, 13 Nov 2023 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699904153;
	bh=JPhKLghvGw7StGSXf9vQqvISbNEZ2A3Ksd7jEA2P43c=;
	h=Date:From:To:Cc:Subject:From;
	b=EJ1+KQXzxNB13oEzr4f1dnR5SV6Q3UTECdIxoz9WkICpSJpIgrKPkhzr2IlCYHnrl
	 ls21xmpHW6HgBsgZ6vsn/hIuWP8E2abKEU7PXKZTWPONhiUMIxTHVmU0fHTsdIIdz4
	 ZG4kN5xOngj/ORNWaxeM7KqfBDDB4XusRxMNntI6JxAyxLnQXen8W4uz5o20SEgKhu
	 IzHB3IJaezfn8C+b1EeNgEcs2Lrs1a2i+P9zkC0ZaPDyjv6lGQobg9idKCMYHr+mJZ
	 11COhrXciddhSaH69A5JSSfpNzUvtTCma09sbn+669i7+aelA/kMEmcbuhF71Cfk5I
	 M0nqlCewMnUzw==
Date: Mon, 13 Nov 2023 13:35:49 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings in
 _append_tdma()
Message-ID: <ZVJ6lRCRaywGktxJ@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Copy a couple of structures directly, instead of using `memcpy()`.

This addesses the following -Wstringop-overflow warnings:
drivers/net/wireless/realtek/rtw89/coex.c: In function ‘_append_tdma’:
./include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
  644 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/coex.c:1585:17: note: in expansion of macro ‘memcpy’
 1585 |                 memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
      |                 ^~~~~~
drivers/net/wireless/realtek/rtw89/core.h:2703:37: note: at offset [5714, 71249] into destination object ‘ver’ of size 8
 2703 |         const struct rtw89_btc_ver *ver;
      |                                     ^~~
./include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
  644 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/coex.c:1579:17: note: in expansion of macro ‘memcpy’
 1579 |                 memcpy(v, &dm->tdma, sizeof(*v));
      |                 ^~~~~~
drivers/net/wireless/realtek/rtw89/core.h:2703:37: note: at offset [5710, 71245] into destination object ‘ver’ of size 8
 2703 |         const struct rtw89_btc_ver *ver;
      |                                     ^~~

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bdcc172639e4..b842cd9a86f8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1576,13 +1576,13 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 	if (ver->fcxtdma == 1) {
 		v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
 		tlv->len = sizeof(*v);
-		memcpy(v, &dm->tdma, sizeof(*v));
+		*v = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v);
 	} else {
 		tlv->len = sizeof(*v3);
 		v3 = (struct rtw89_btc_fbtc_tdma_v3 *)&tlv->val[0];
 		v3->fver = ver->fcxtdma;
-		memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
+		v3->tdma = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v3);
 	}
 
-- 
2.34.1

