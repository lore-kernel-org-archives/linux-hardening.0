Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E543443A8A
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675558; cv=none; b=HX7qyt3Ou0frYQ00Qs8EjxWBY7Ff4WWMUe8fP6pEjLTI1xaAZNu+3E85K5n/is62LveP9Irk7DHrlvtx0kg8wBBkuOvmAYm7qFmkfd6fe9RK6ogWVLiImfHX8wPxkaXFWLdiEpVXRxnTl1iTRz2Q3N4vemThHy3LYGPF/bs9NyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675558; c=relaxed/simple;
	bh=E1xUp544mD8hGvP00uo8LYF6vpui1oe6A/h2MQI3tcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foRr6aLrrvC8lERbig1EnK+lTVZxjcbmFuN+ZU880iMbtNryKQNiRkFKzL3wbo71H9T3pbVwxXtCdtxolnydXmlmUBP33wmNSdQsRPAP9rG/XhFP0NzCq356M05NBIAw26Xtikmf6km5g+JD5m3VZstHX+yorZO2NXBrW9+kmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TyjhpNuQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W0y4p1tv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyjhpNuQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W0y4p1tv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZTWw3311611
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IF+4fh1OWmacQfGFecoHPZmQhHgE3MzLCqCvWU+XHF4=; b=TyjhpNuQp9BpmM/V
	hfQs5MsNOrBW1VnKtfA0geUyje2hqOzgCxZOTVB14J8kQp2pNW0lnHztMhjd0miZ
	WUV0rQLcB2+sOlmqMFqUgOlXTKVtdWO+28SbCedt24QqSUtxq+Y9zQclgnwh+/Lk
	ZTysoWbUNMJpkiV4aMXq+5a8NYnx6S4vk+8blIndxvy9Lr/NnADPPRIPPewNHLCf
	0+EWoShyXWhhCpCCuXE1h2QYuCVcZvJ6ugfBE2ofp/zGdYVNY2/d97wstKGHK8+k
	COMstR8LkOw7eaBhk8wgzgfabf788U2GzvuUEYubL0TlKoVPzntmaILtLebPUmDJ
	YH/4lw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3kbpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:12:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0f0a0760so286630051cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675554; x=1785280354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IF+4fh1OWmacQfGFecoHPZmQhHgE3MzLCqCvWU+XHF4=;
        b=W0y4p1tvCdLiHlMpOtF94Vz1djN9Y1oR2/mN3vg4fcikGpKe7/tYtBmSFuwWpyKlF4
         TxdEMhjEJ7Ft5XU9T2JWBL8FH9OSiHvYUvJ3dXSqmn26t2uYsHgWpGx4H2ZUysAnu1Na
         sZL4DJ072NvragGKitHMK/yJkxxTxIZYR0fJT3u3rGpvRLblitsVh3MlH5mWsKyr5Yzu
         ZfNkizEcflsevv4A52316G8Tpn7sJrNm7CUdPQjv+6m84b+0uQsIi/w7Qv0h9BllLO/C
         HfX40TWQX25wASW1Z0C1Yj6hhUnOBFeoqczUXZxPbahNVmUyyT+LUEdoAKMdx9sB5pS4
         qMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675554; x=1785280354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IF+4fh1OWmacQfGFecoHPZmQhHgE3MzLCqCvWU+XHF4=;
        b=DtMcXxp9/twIHWp332zTO0nDANpDcOv62V2tKZrCj6+Y2X0t0bxYFW8iXX2Rj38tGC
         3oNkC5SqbFwSH90BRbvvfz7qZTUN8dBy8vw11jBjYFyvfIEjG1Y59HzVQWiXDhyqbmeJ
         hRqsn4YquQ+kRXoj22qTaHS+T4dat52Xz/uZmvB1EAVhi2qxz8flhku8XVGyjL7HYg5H
         gL3JVfrc9ecpcUHeSzY21DyMuz47HXVFTl4ONM9f6pSBfY4xhY+hqyzTBnUDBeyetCJo
         uAfVC/oMsWp5hRW46CEjzkvrXLk3dSvZZLUNheZ7Nqg/vogRUtczRUtSaZDUDh9H2aFd
         Lybw==
X-Forwarded-Encrypted: i=1; AHgh+RpGz5ggjOyv4MkBRGEeXPcY7sJO0V2vBCM/xAGoavt/MbK2L/rBH/OhPAJL9fAigq5Ii+6olzNdiM+XADCB8LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LQby01qTJ0N7fd2BjXAgTH+U+ZUteJ55Hk7nnp/GyyjoREAQ
	MmrlI99plehJGoP+EZttCdIRZDPBqyAVLni/8n1ESwl/alwISZS6yp5ebPQi/CF78yhShG+6RhF
	eOWmca0WbP0jEtyTj2F5G0SMeAKpidUr0akwVEbd5ccR+RuL2qy6EH5Pf02tHx9yDqGsbBEs=
X-Gm-Gg: AfdE7cmVs/cCRZm4z8V13WeOIK0EWszbQVmAA2Vnyx/O3vMrMRVbhyHbh5lnhchyktE
	sLLOglP7EBPP0V5Oj/jecgLPQClsk1ShX/QaGVm42RwCyOqNecw2DAWhWqpm3kRshQgfL5gN1Ug
	rIlm8LFJfuqK4nDuag5wJjv+KqTmglC88NwXZgYfqNzGueeTPyF5Rv1hUudTxcTCqo0dLmXwq09
	FtwEKL0fn5EjI7g1k7TP02u2kgvb9mLj94uhIjvOGQKjujlDFVIstFcv/RdfBqP8FlqGexTH+A8
	mh0Gw+OOLjk6/bwm1Z7kEWlM+5wsmESSfOZgFzhy2GWOQ1yKCGCVZqM0QdLKpEAPjdZu2tYNBU0
	fSwdA4SCIUOG3ZByR69lrJe0n7W+nMt8TAQY9lEGHuAKUmG3nqQpdLn89duLbllJO3er/H2TeCI
	jSKX9giaoFrN7FZA==
X-Received: by 2002:a05:622a:1e0d:b0:51c:7b11:41a8 with SMTP id d75a77b69052e-5213f959c7amr204205881cf.85.1784675554621;
        Tue, 21 Jul 2026 16:12:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0d:b0:51c:7b11:41a8 with SMTP id d75a77b69052e-5213f959c7amr204205581cf.85.1784675554256;
        Tue, 21 Jul 2026 16:12:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9bafdf5sm155867e87.35.2026.07.21.16.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:12:32 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:12:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
Message-ID: <wskpf27kmooybswypyzt2vcadh347rfzrd5mpjwrczjlxnsczb@hjlaoqbscupy>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-7-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-7-99620e07f505@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfXxtkIpdx504GZ
 tADe4f02+Jc7m2x/Bxjzw8XU1iM98IH3sQ2iNF8HY0Ekl54SMj/uhH0kGj3wYJUb5/CKbUILg7t
 YMIuCxf8v0LSmlyFvER0g2Skxgv7kYFakYCZbRdisVZnrXgwLyUTH8Cq+cg3nbo/ZZvB/C8urL6
 gPqX+tjVgP0rMsGBQG73RwLcEAswQDS2x/WRMFKjXQFCDkYgw2mIEMxyRWDHQvA71HBUbhOKMXX
 0w9eRQ6LFUxxcqnkEzAbicmHzsJDHccyMESL598Ds0mz91t/pYo314DNr8UpQ/AK8C/qhrgeYSX
 lzcjuaeaoK/Po6BFxU4CXSuc/gVu62GEUbDcg4Y/GQsfZctNiyf9ShkF4ZicU+vkZIHupoD+0Ij
 cwtWOA1XdZt5P7S4EZstri/9QFYSglD9sZMIlEwFbzPJ28fdEW2VhZpIc9lAniH3LdsDqyZR45z
 Emd7ToPi1wZzrz+tRgQ==
X-Proofpoint-ORIG-GUID: LkUkus4juaoUqQuBEFqKzqjnLCPCnuUL
X-Proofpoint-GUID: LkUkus4juaoUqQuBEFqKzqjnLCPCnuUL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX6xefgNxBSpse
 PvzagJE1RkX1CLV3iqqKlC7y2oOcnxt/3xOPDj6oixG9SwSIPRqOggV9Zfl6dkM1hAxuCUkjDbe
 Tk/p9OTawOmZK+RKMu+p4sdH3b0aczI=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5ffce3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:04AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in talos.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 105°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
