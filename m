Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633363;
	b=Q3blLuiqZ1t+137D18PyuWLjYyRHTy4zZaGkX/jtSmznaBBM0wPj1uyLToEkKAazJdxQ
	 K4RmImW/pGIE0gxf6RGFf098H3VHFrqiIbU5WPgwGG2VVsLOGPBFetTwQ2UEsW0fLNv+x
	 4a200DJ3wQbnPb7mElJe7EUuifmV9PxCzPeR0k3JpV8VflhlAsRu4Y7obetDyB2hwtFYO
	 AB4Y5P4XkoSrYLt7ZBTHX63H9GX3MXtN3jNb0QuA8sV28XauH2Huj9o5BLEpilWdvtdf9
	 Z+bNSrgZQ+TosqqabRM8p2s0ZWfzFuMx9e/OHxoXpjOotLMLxnHSJGC+9teGkxpo7Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633363;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SYfr/zPrMJuFW99fIND5ARlpQPIk0eMxu9GKUIqxcIE=;
	b=m7FmrJzQNWlrvtdd9ttcNX4RqrA6XM0L/0daOxUN4X9LS4B4LlN/+wDYrXi5Tz8VSFAa
	 PVr2Kjq9LKzew4+cbWNetxKIIsZGI+XfyGjxHPlKSWBBoZaHJ6IANDwxu5r+IMErSTfxV
	 VJbedUi7h+fBdBK6PrSo7IokFPYFG5TPnZge5ZKWVDnEfxCSVM6Wuxeb2tX6GU0cnB3s7
	 fHmxnUSV3WdjGwjj226jMjXRuzrnyMial/RWhQIJMTq48SDsCw03/JL1HYGCLmMihIo6o
	 4+KQBcWzVU2uWamNJmuGZ7FyN7kgpmTVOsY+LKjGa2ciJ5WK7WQGzts2Jd+3edxLRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRGDcvaF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B+XYQ2Fg;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D684606A326
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 19:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D684606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRGDcvaF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B+XYQ2Fg
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGQBXh715305
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 19:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SYfr/zPrMJuFW99fIND5AR
	lpQPIk0eMxu9GKUIqxcIE=; b=oRGDcvaFvGx6RAaboDq/dPZwyriYwiCWk1dp9E
	sF8xCXoUavwahYh65aY7jVnhzzwS/9tA3ASB2ppfa+14yB/4VWJpQEASyh2EGtXb
	7gcjek7Cq9J0E7+FkCoPX+CN8xu+u4zFEYE8XbV3yi2Ix4GqBNLHbuUWA/2Cii3B
	zTYnDeJ/08uFedescaLy1QnVUPtDVQCNXl8TQaynRKdUNDHVIrgPLbCIDY5fzONA
	thlaF/DJzPZrvxevzLgy8h80elC/vi69YtiQnip4Ad4EfNrx/M3b9yNatLZt5Bt7
	LORufeE5gyBWVLGzrlIq0OaU+X0ApL/5rVQUU7WYCXYH36kQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbmafp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 19:02:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386177b0516so15526841eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Nov 2026 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795633361; x=1796238161; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SYfr/zPrMJuFW99fIND5ARlpQPIk0eMxu9GKUIqxcIE=;
        b=B+XYQ2Fgt0B87UlvaHfc11cLVVKzGwcBNVJctfPANvPUxmQDL9TPiGeL7VOhvZIXOZ
         MQzc1Fr5XalzSJxA6w3KexHug8DBrRi8dgKEnWVqSi1e+uE4v5OTW/IPJPZRDTjObrXE
         ihfYWrdOppLguy7LADliLUhGBXAYHihXZsH328OHrV1Kq7HrAjOBO63BBOcu3eHHcKAz
         y7WaWMQzwsSsKl4wwd6ETfxgWnA0fhPLOkycRPFEbH+h1gUoos4Oim4v5OqjfguLAaiw
         hJQk8MvrP20qkagnluuKwt02oiedzByokH08xQttiI9Cu6pW55XmwSCleS8gea0XhfCT
         hlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633361; x=1796238161;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SYfr/zPrMJuFW99fIND5ARlpQPIk0eMxu9GKUIqxcIE=;
        b=e8hbnhNLCcAoUSrTUWvdHPSaxpgXxwSMaAOa1/b8vnudMNccr7QnWEA7MXszoj7pS6
         fSjHYbkx1kajHaM5aj8KCk+y5PrqU/0fldsYCw14+0EKl3PKrDzROK3K8tNEartRt9Yx
         faPmB4D/miLZNYlsF/7seORlX+eRgO501pBflC6L60QLiXRxKSM518jzai/VZgilVdSH
         +Jsdnd/1kTuR4bSPjDOlfGCeVQFT2HMrnWDikca3EHxjyIOvEW2S1S/XEKDN6X3QYCU/
         xsWmoE2XLb8s7S/vK1bLJom2mTnGayheAsDwd3lfQrOSrclvB2sLSaI+adksKfFaFN8f
         dN5w==
X-Forwarded-Encrypted: i=1; AL+hErHK+Y2dtus6DvLGb9Ma7uJ/xXkuyY4uotVa6RL/liKrjrxxcUAW91nF5B+vlwxzYXcUaSB1kR1AsQBO0n2vY9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FLgNoHdQ56j6zQvKGn7s9Ux//4udPtSiKwSF39fhcc3BkzsGh
	CpJ5ggvYOKqP2K9mesAAmDp5ADh77PnQL0rGYcW0JsYFyvbC85xVFMgmtJXIiicUKkyLrXyf5tX
	luH1zSDrzrOn0mmzFSc450kE7mE9UF60CwnCMV8HIoIgUTBHm3ljYZMzgtftQUZ9gm8SNuSY=
X-Gm-Gg: AZFdTZcGp0zPNeRtmuPh9AoYTrm7hwqimOwxqjdYWgWI/b42dMxIRTksgYNeD3+faCL
	N9J6ZNlGxIenIGQHHEcp5AxEXsrG/chZev91WdOiwaqDAq2eTs3bXLN0A5xzN7DmNnX5riOc6b+
	zcd4//2ckU0gpwyCpD8l8OvCbKl7dH122Lu7mH5AhWNKv+rXKE8CzlVu1EjZAuh2e5uQrdAvT9Y
	Fa7JS4svVA3YBC4AzYsGPmFzjnVpHvbY3LduHRppw1SdAUSn0dEhvMZQ3DnIPonROPenU5PH8TX
	v8urTIWg9Ou7zDuQIhoYjsI7iRrJh2U2HvLnAClqpj5+GGbF6W9RvGWV/2pQiZf2rNLY4o1Wi/9
	QSt/Ouj3GaTXRo+t0pfPX3B88Q/W+qRDxxx2XbQ7MnBIt9/+FZfbwBWfXsiAiK76olfp0EXGAIa
	JMgiz3g60NYSUOlgwxzrIj+4T3lZHh
X-Received: by 2002:a05:7300:ce11:b0:385:774:fb23 with SMTP id 5a478bee46e88-3856e63b5cdmr20538782eec.6.1795633360961;
        Wed, 25 Nov 2026 11:02:40 -0800 (PST)
X-Received: by 2002:a05:7300:ce11:b0:385:774:fb23 with SMTP id 5a478bee46e88-3856e63b5cdmr20538743eec.6.1795633360093;
        Wed, 25 Nov 2026 11:02:40 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm58856227eec.22.2026.11.25.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:02:39 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:02:25 -0800
Subject: [PATCH wireless-next] wifi: mac80211: allow EMA beacon retrieval
 without MBSSID elements
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-ema-v1-1-27706545a94e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMAwB2sC/1WNTQ6CMBCFr2JmbQltAjSuvIdhAdNBxgDVDiCGc
 HcLrty85Mv7W0EoMAlcTisEmlnYDxH0+QTYVsOdFLvIYFKT6zQ1ivpKWWOLokGH1mUQk89ADS/
 Hyg3eHKgjETXQMkL5s2WqH4TjvrQXWpbRh8/xOudH7e9gzpVWGo2xjmrbZHj1Islrqjr0fZ9Eg
 XLbti+j2FP/vgAAAA==
X-Change-ID: 20261002-ema-82877fcdc8d5
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3NSBTYWx0ZWRfXwAGcd8pOgpF7
 W2KXAogetw6/FhzVCRBXZzdHSs6XHt2u4uDCWVpIO6iVSicVU8J5iQvWY2BSkQIlJTlvBRE5p8W
 Nk70ttGNdshblZdQc+NPYhlIn2whb4A=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b0730d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ydX5o1CC2oNq7ZdhnVkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3NSBTYWx0ZWRfXxPx/ljM9eYPb
 YmhGcWINuCu2/RrKtiBPPzUT61xke3lbfiU7X4lm+CE0Cbtb6Dm0YiEaxuyC05FirLaJAg8qauj
 GpRzApV6i6Dbidk4y3RfYzOO92drKjos7ABUdVqmnbALq33y4kfbS14b/IpScUzPAlUVnVlJqYO
 0ioNl8Wtwc4i687etjpR6Yyh6FwgGqoLnUdfjWJ0XaRuF08ewdql6TVGLKHhjSiVTXu4cq3yCvn
 ldDgSupNOGLnCuRc5XkP79hJKhSrCOSL5ESLyAobIO9KpHY50a153nEIs2rq/sOY46CK6b9/sxd
 sjtuP+G35dxyI9rL/mcrBV0owLE3MsUOr6qxpTlXM0eifcZfUy1CW79yJbSyx21iQ2qVZoRQE47
 CYtMGiF203GO4p6qdhWkoDft9r1d1UL3a3JaMKlaktSKT25riI6pLnJM9dOgbyEKZJV30IbZ8+9
 Rj+BYFxRdEojgt/CJOg==
X-Proofpoint-ORIG-GUID: cIcwnx9QCBU7Gjn-fcN2C8agkGvP-ROk
X-Proofpoint-GUID: cIcwnx9QCBU7Gjn-fcN2C8agkGvP-ROk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250075

EMA beacon template retrieval fails when all non-transmitted
profiles are removed because ieee80211_beacon_get_ap_ema_list()
returns an error when 'beacon->mbssid_ies == NULL'.

Modify the function to retrieve the default template even
when no MBSSID elements are present.

Use a separate iterator 'i' for the bcn[] loop and assign
ema->cnt once after allocation, before any bcn[] access.
This ensures correctness if bcn[] is ever annotated
__counted_by(cnt), as the compiler would then require cnt
to reflect the valid array bounds at every point of access.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 include/net/mac80211.h |  3 ++-
 net/mac80211/tx.c      | 28 +++++++++++++++++-----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f768ef9184eb..a825801fda50 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5886,7 +5886,8 @@ struct ieee80211_ema_beacons {
  * This function follows the same rules as ieee80211_beacon_get_template()
  * but allocates and returns a pointer to list of all beacon templates required
  * to cover all profiles in the multiple BSSID set. Each template includes only
- * one multiple BSSID element.
+ * one multiple BSSID element. If no MBSSID elements are present, this function
+ * will return the single default template.
  *
  * Driver must call ieee80211_beacon_free_ema_list() to free the memory.
  *
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index cb9ecac25a9c..50de2802f451 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5843,27 +5843,33 @@ ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
 				 struct ieee80211_chanctx_conf *chanctx_conf)
 {
 	struct ieee80211_ema_beacons *ema = NULL;
+	u8 cnt, i;
 
-	if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt)
-		return NULL;
+	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt)
+		cnt = beacon->mbssid_ies->cnt;
+	else
+		cnt = 1;
 
-	ema = kzalloc_flex(*ema, bcn, beacon->mbssid_ies->cnt, GFP_ATOMIC);
+	ema = kzalloc_flex(*ema, bcn, cnt, GFP_ATOMIC);
 	if (!ema)
 		return NULL;
 
-	for (ema->cnt = 0; ema->cnt < beacon->mbssid_ies->cnt; ema->cnt++) {
-		ema->bcn[ema->cnt].skb =
+	/* Set cnt before bcn[] access in case bcn[] gains __counted_by(cnt) */
+	ema->cnt = cnt;
+
+	for (i = 0; i < cnt; i++) {
+		ema->bcn[i].skb =
 			ieee80211_beacon_get_ap(hw, vif, link,
-						&ema->bcn[ema->cnt].offs,
+						&ema->bcn[i].offs,
 						is_template, beacon,
-						chanctx_conf, ema->cnt, NULL);
-		if (!ema->bcn[ema->cnt].skb)
-			break;
+						chanctx_conf, i, NULL);
+		if (!ema->bcn[i].skb)
+			goto free;
 	}
 
-	if (ema->cnt == beacon->mbssid_ies->cnt)
-		return ema;
+	return ema;
 
+free:
 	ieee80211_beacon_free_ema_list(ema);
 	return NULL;
 }

---
base-commit: 18d0bedbb5f0538396cb7f763ed9cd1dd69c5b23
change-id: 20261002-ema-82877fcdc8d5

Best regards,
--  
Aloka Dixit <aloka.dixit@oss.qualcomm.com>

