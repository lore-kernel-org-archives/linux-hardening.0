Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46923DBD5E
	for <linux-hardening@vger.kernel.org>; Mon,  1 Jun 2026 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333233; cv=none; b=fRAjtRELxuBgqkUmTQqQ8k/iOvXPeghu5mb+uFoNKglCEWWKtNRsNKpxNZeGwSxiYxW7B5Gz4nC3PGhnejn+37SLkA7RpO2Ht2cbnDDr7CNEiST4+ypgFV/bgSTjnS1PgK3VCc1Jd7j2AIetGemuJY/8UtxKEIMqvx5qLw44cq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333233; c=relaxed/simple;
	bh=eg1UU1KEh8t7kDMy5vM/QAHILoSKEsKqMsLiDeAbP6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e813E0Xrggc+5aGLDjxjtpxv3VDPzwk++BmXlRjJLe5T+ZG+JiyVP6XXlwUod/7UGzGe6k8hLlVNrMfufPt4IsJT+BAFotsuLAhUWP5nptg6NzNXXWB8wtPkpOm8eK5bRLgcFYXq1Xw8sFCAYdtKEVPZVb1Gt3UM40eBERlow64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9xurB/R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LQUOuLXW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9xurB/R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LQUOuLXW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651BM9nc622614
	for <linux-hardening@vger.kernel.org>; Mon, 1 Jun 2026 17:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5dk2+hefe94O+p0bhIxq1q58iVSITjTtWcV4dDmn5XA=; b=e9xurB/Rr1XHzdIm
	IC/uvZJfFW0pFtFb1/hN3si1ieMr6A/h1DO4tWOFFKjvj3AT2woJkS4rXG/iWAKv
	rIyiM0IVbn9pKVeCxRCFN1ILo99H0JAWFsyvBfD1al3Hf5D/Dmci0sQaAzuvYK86
	cz6191SSIhu1eKKiILOce6i7rgkjiaHgpZ6ltvuSFyIifym/3UMxqTeYvFboL1uA
	vqFCO6lDWCd4t0ybjM6adW7VZ2sl0EnAN5WDly3fRKRzlz0dP0jp4D7DZ3kqSgkF
	vCn6j3tDIdofohWbJpzZE6BikUb/51U7dy+IU1viawB5MGy5hUiRLMpOTo1hbry5
	E/WqUw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh954heuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 01 Jun 2026 17:00:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-13709ab38a8so10458175c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 01 Jun 2026 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333230; x=1780938030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dk2+hefe94O+p0bhIxq1q58iVSITjTtWcV4dDmn5XA=;
        b=LQUOuLXW/RL4Fz+1f48YxSUDryk0/RGNXzX8cdsc71NNND7q5d+ikdhx8B7h3wOGDI
         dXnuwryzzFFbImmiI0wqhxSuxHcMK14wumvfDpZgMPw7oEPgTND+J+eQmbB/Us0c3Brg
         BWP5J6x9L9FttWe/MZDeT0sz+xgOsTF9S0/8cpfy6f9AM8qMgXgiONpPL34ZSBM4Qzrh
         TUIR+fLjwAGK+jwOhdodDmu8kN2+MelkMkRB2EWkH5xDD+JMidlATLoq1JPdJZ2ipy+h
         BuxA7EIew77mYjdghDCL9+Mg7e80I5w8sPrULaSbXXPAvOXSogB1F//GJUhAlQN+HP8I
         Bc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333230; x=1780938030;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dk2+hefe94O+p0bhIxq1q58iVSITjTtWcV4dDmn5XA=;
        b=LRmSzPYfEFr547LQdav9UEFDFlApsQPbiYdc0IVfIdKfQgt4PKVM0Ywg/3J6sm4+n/
         rxvXlrhMUFIm9LeyZJuJMpCWAuwmYTwSqhofn32EQ0M3GCQYyESlVR1F8xMVw8pxbUcC
         in9P2oI3pHF9waAC9ZFv/79MjIA1DodUchG9H9oI+lJ1gnUtsf3EAumdmD7JM6yDR8cj
         7l7aWw7kU4NF8Ma0mQhScQiN5/ip2BiCOi3WAGG2At6Ib8c6J4j/l6NVGkJoVcThhTxn
         tEGO40SrMTwW2FK5vDp0ybrfNFHAdIhGrdR19kbg/2H0zYRoQcV6cgJ3SPmWs4pDzedf
         A89A==
X-Forwarded-Encrypted: i=1; AFNElJ+p1wg1CSuSCHYYm8T2DULqhzkDRMddr3plkiZPuJigtmyuhPXoFlWC/xBpvxz6mTQZ725NM+OvXSY3Z/nduE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nBhxMoIA2qQktWIED2kGZzChx87YpdL3D1FzTaRKX2CGgqW1
	UDNwctUPzFqj+OrW6VILg5cJue+e7NSj0KZuaw3BgslECcw7ri7QquVUqYQk4ce7iY6cNQMPJic
	Wg7RZDXN5DXPzEz12J/K9q/cyq9m2KSZ2dcnM0ifCwNw6LLroDRIRPoXFOfWw2xFsSLSo+7E=
X-Gm-Gg: Acq92OFNpGgmzivkn+9eEKWk9VBP5BoyYn4SjwpC2pRRUFjfoZlIERrtcw+/V0R2cC3
	Uo/dZPMvR4B1bvawY6v6jkID7tm3/ocjtbkbFKvTMp73WDZp1xjUPOqYZ57/R38DhIVQDbqSUJU
	Y0V9XtthUuoo0VZ+h57CLWFlpg8bQMu61d3sD/P5AF1JRxULxGFMG1ouHIJTJd0eXDb/V0jFZ40
	gkLXT85u4C3sYIedf21iMKST6nrYNwhkZcs4DkPHruWYmgqm0L9+ue3d19didBF4wXjMeeNyqbe
	MToEXwSPqpWhtW6meHsqozL3xMBDgO28keKltkTnFE5sO+lRmgdoIyi8CXEM3GpelZN7XmxrL1j
	dEtoBrPh5VZjix6+83/q2of5meDlVtIzi419QQ8AAgUl9PaW2UEC4iFr9fTT3IFAkJOdFh0obX2
	14illteIz0P7g=
X-Received: by 2002:a05:7022:ec88:b0:132:5d96:3e48 with SMTP id a92af1059eb24-137d42beeb9mr4823625c88.38.1780333230054;
        Mon, 01 Jun 2026 10:00:30 -0700 (PDT)
X-Received: by 2002:a05:7022:ec88:b0:132:5d96:3e48 with SMTP id a92af1059eb24-137d42beeb9mr4823602c88.38.1780333229302;
        Mon, 01 Jun 2026 10:00:29 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20260428205017.26288-1-rosenp@gmail.com>
References: <20260428205017.26288-1-rosenp@gmail.com>
Subject: Re: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
Message-Id: <178033322855.2045173.15165164858522474928.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:28 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: stIHi9NBAZeokXqkgiE_Y1ZXuJyt3K86
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfXxff6n7v0P/il
 IxHZb91QGoRnxlDu3Tv7oPRBSYOK4MQ0x2/atNCy3TI/QmGdbCKH0yvgeeVTajXJ/BOQpOfd4JD
 SMK+sjgba8tWXCPR8N3j9d8nLEcnrdDUzm+kQzylggI87zVDAjLfq3zNu8C6S1XXlF1BfvV62sX
 9YPmdI/2upQ9h+kKpQsidBurULxyhrq2ADmNCRw/hPadlT8FNAjQlKMNFE0gZNPV/My4U27ydGb
 mR2ZD+dyg7hzFmJ2WXBJIHoH8K39AE5gEAdHnCh3eAiJ5xzc8c5yBoulaAr/mKH1tKJKxT828fJ
 X+pYzwwEL3yS74YfIwuntvbMb5jjLMFHGCDyL1CYAycYYutJR2/BeVLdMBP5dLa1UZ3eqZOSTdC
 zfiEwbVPn34eOuhdm47TtD3iIQlYuy9XEHLWU1sN4hq8usGPe9uaslgdp9W74M5DSKMthnJiMGT
 OdpB0knUQOnkRPmBKLg==
X-Proofpoint-GUID: stIHi9NBAZeokXqkgiE_Y1ZXuJyt3K86
X-Authority-Analysis: v=2.4 cv=VpcTxe2n c=1 sm=1 tr=0 ts=6a1dbaaf cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010168


On Tue, 28 Apr 2026 13:50:17 -0700, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: use kzalloc_flex
      commit: c7427f297ddb01f593217c21b2416f1093b80194

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

