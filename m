Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81593C0A08;
	Mon, 10 Aug 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361020; cv=none; b=IT3NnRPdjQFqlI3C4exNWU5OiEiH29tUdIHVMUf+aHz0gnaCwnkDbzjPyINMgPzkd0V9O0tSyZ0+WHXpjMi8pjeDmzOfoAsY2NxxyOuD0LyL1r0R9iGnJ+Di4XSLOZOo/jefcv6NPd/z4RvKXBoH32O7TUz9PUGnhdknHCRj9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361020; c=relaxed/simple;
	bh=UEBKhPLj4vaZS8jmT4jd1oXm76SCoBbS2+XegK3wRw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UslSKNmX6FHD3uB61rRivnD35+PqLi+u63L4gng2eMNk7y8GhzilQNoPW74/PBa2UF2p6PjUgU6IAvuM9vCJUIQpaTeXEZMHhiZ/Yyjzy4xoh+jpvVapVcWQJdOXbn/yjrEySJ8hOrwLLJzGzV9b7VGrXcbE+ALtnAJooEA/mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D9xMlBrt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D9xMlBrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786361018; x=1817897018;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UEBKhPLj4vaZS8jmT4jd1oXm76SCoBbS2+XegK3wRw0=;
  b=D9xMlBrtKuLYe9LSV1hg8h4iwvuwwQLeZpDxn68tTnPVwsDf4LxX7gWx
   bgw3TaRInnHxdFjOYIo9G2Gm/yvEFe48SN0HCCypO35y/VfH8Pb541qqL
   x6JnF55DRANT4KiBV21ZMldhIrkBHUFhZfxUHRq/nQnBrfvK1V0eLs/5D
   wqmesAoz6BPiQi2s9ANZQ90cqTrvL9+elYWbm39UZrsSHlH0mAylgVQWw
   CGXX7OsAVqBE4oowyFzTLEh6U2IdO2I8bxA8//HKbK3y9QHNs03MPVpcx
   47+Y7TK5LbGd5Pv4CuQ0JI9084N1rkXDu+bmdXIrBOThMFF9GoTA/D/R5
   Q==;
X-CSE-ConnectionGUID: +ulS59dURhKHkZc36is/1A==
X-CSE-MsgGUID: 7FC7tIixQv2VrPkWLKi7Pw==
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="62209111"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2026 04:23:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 10 Aug 2026 04:23:37 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 10 Aug 2026 04:23:34 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 10 Aug 2026 13:20:48 +0200
Subject: [PATCH net-next v2 3/9] net: microchip: vcap: make vcap actionset
 decoding type_id aware
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260810-sparx5_l3_routing-v2-3-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-0-59e68cc8c8ca@microchip.com>
In-Reply-To: <20260810-sparx5_l3_routing-v2-0-59e68cc8c8ca@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

When reading a rule back from hardware, decoding has to identify which
actionset the rule was written as. The existing logic was only aware of
the actionset subword length, which cannot distinguish actionsets that
share a subword length but differ in their type_id field. The LPM VCAP
added in a following patch introduces this case: ARP_PTR, L3MC_PTR and
ARP_ENTRY all occupy one subword and differ only by type_id.

A helper is introduced to extract the type_id bits directly from
stream[0]. This is valid by construction: the VCAP model places the
type_id field (when present) immediately after the typegroup bits in
the first subword.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 75c2ca54fddd..6e1ee15b82b7 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -216,6 +216,13 @@ static void vcap_decode_field(u32 *stream, struct vcap_stream_iter *itr,
 	}
 }
 
+/* The type_id field is always right after the typegroup bits, if it exists */
+static u8 vcap_find_stream_type_id(u32 *stream, u16 tg_width,
+				   u16 typefld_width)
+{
+	return (stream[0] >> tg_width) & GENMASK(typefld_width - 1, 0);
+}
+
 /* Verify that the type id in the stream matches the type id of the keyset */
 static bool vcap_verify_keystream_keyset(struct vcap_control *vctrl,
 					 enum vcap_type vt,
@@ -1341,8 +1348,10 @@ vcap_verify_actionstream_actionset(struct vcap_control *vctrl,
 				   enum vcap_actionfield_set actionset)
 {
 	const struct vcap_typegroup *tgt;
+	const struct vcap_field *typefld;
 	const struct vcap_field *fields;
 	const struct vcap_set *info;
+	u8 value = 0;
 
 	if (vcap_actionfield_count(vctrl, vt, actionset) == 0)
 		return false;
@@ -1365,8 +1374,11 @@ vcap_verify_actionstream_actionset(struct vcap_control *vctrl,
 	if (!fields)
 		return false;
 
-	/* Later this will be expanded with a check of the type id */
-	return true;
+	typefld = &fields[VCAP_AF_TYPE];
+	value = vcap_find_stream_type_id(actionstream,
+					 tgt->width, typefld->width);
+
+	return value == info->type_id;
 }
 
 /* Find the subword width of the action typegroup that matches the stream data

-- 
2.52.0

