Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3B440A06
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429269; cv=none; b=UZ6uBpH66+N2wmRyoeueKJ2uG2EygpRfpgI1qP14I3Ym9AJ75QJACruwoXnTSTPkF+3ufwvOoEwvm1g9n9CcinLYYF8dh/8XElQEr2h8lElyp29O7PZ7QVDs0f01evc094a6vbtq1gXDlzCnRet6dkRcdgTzNVyLvIsLPibtKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429269; c=relaxed/simple;
	bh=gXRfC2VjDT+XZheOHTbKbVXeBbM9bMyYA1/mdxx+YNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8Y9WiFLyi/Yd1xI+l4KKrDUNWn1X1yhlVr16RShghTChnbtlMZkchgZ3opZSEc1vU4zjUNV8LGSD0QE6vaE9isKyvcluGLD2VpZsiUinKGPcJEyFx35L6Ib12O1b+UWyDnJCP8/d6Gd3syWzAfnybDUyv5ds3KhXu1EH4m7dpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OPWTosx7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hoXwg1RF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPWTosx7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoXwg1RF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWm5L1302670
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XnjmdFxiHJbplHqHTRM7ARcmcbr5wAPPkXRM+q1ZZUI=; b=OPWTosx7xtooPdQV
	yHjJ9jqz2rPsoV/aQcdBbj2WYdVyYFc3+pR9Nj95skiup16r1SX477S/gIEdiIQy
	2OZEZ4XGs2PThTrpQbjBzqNmXguKyQeXssRrTg51tZX3w2mgPXK32H7Q8vSxU6Ok
	ifoB596Q+i+aNlqiXKsQsDi8o3DC//Vc2KJkYYa8Dod+TQo7jJ9yhBveMG7RG/Dx
	N+oJEj9oVl5z/Oj59WwKiHGgT2V2orrdjlxLrb6lnnfZRm5zgEVQFdJndVAgofKv
	aKW9LxFMjuoBN0DMBkUc08CI1upgaOBUUR/9PQ8EsLq3kb21g65hRauxd6QRRu89
	mOhP7g==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8k60pd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:34:26 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66898cc78f7so3471190d50.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785429265; x=1786034065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnjmdFxiHJbplHqHTRM7ARcmcbr5wAPPkXRM+q1ZZUI=;
        b=hoXwg1RFG0f6ihOF8Nm6IKR5MVmyknRS1dlLi9BlqQxjoFyfA6MeoR2rtZxh+BC8wW
         r05xB+6lMcUgmdcZ5TjiIwqULlTgBlNfV7Td8AlSolFAatGxnLqTj3YyHsIxE89GVkrR
         aNiCRX7Op4qhr/UcCHrM1cJyqK4A6icFLOB+e2Icld99++Yxg+dGLPJBaVhMEBJ96QIQ
         d/Bkj8WSRj0dDaYX2uCAF9pFusvLKMbwi+u9/SniqC4AGpgJigbhEtoQJmmr5XIgNUNF
         h40DGkO1BWh//27k6pucvDZiVaPTU+NlUSpX2fyjFxvQOMzmJ2LE+R0MeSAwWxzuaWtH
         /HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429265; x=1786034065;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnjmdFxiHJbplHqHTRM7ARcmcbr5wAPPkXRM+q1ZZUI=;
        b=U6vQLf3YC0GNB410wWSPt1ov+Uf2Atk93StEMop4YvDIIWp+VOHUYxuaIMSZrEACbm
         C8PfnD6rBCeDNGqhBkeo56SwYntY4KY/tjKntb8sGamvWDpzmNDixHzCDVZIr945psMJ
         AOZJ0yQZ6yifBq4/GjTkCrbKeHGqVpHn88rVExNTTbjtw6ixUHqk1tpioqZQEgH/Dx2n
         Al6MgUjbJwIlN1R9h8ShIkmE04Pf/KcBzlOCuyVnZ4vkOWEFwOIg7gvuZbVbPTLLVCq/
         GuPNrAtdn1mGgF6QnVHfE8InCGtRnvEybhxlevg8pxqkEmbm20TgXD2vxiE/t5MjTuvS
         ootA==
X-Forwarded-Encrypted: i=1; AHgh+Rqz3k+b+lAyZhTF5GL3vz5tPItIh/5xTif6vqZ6L3/ukqdBS9i6DFalDVeZjzIFAGXQrH3jObiC/lq1PtBSJDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9kpfB4LKePr8fYZKZ14spaWnBRcIKYwBFbqu0apIAMLCZIha
	nuSFlE+gaRzhMhlKCI49CNyrctP10ODA6W12x8/Hz3sQ/5m60hqKLsemE0ucTzufG3KUNFlWVmS
	643b50GtLH+K0QoCWgQXvTBbLmZyyNo7EQN1vMlMrDQjq5sd9FGpX43LgPQx8vlERxgcH7ms=
X-Gm-Gg: AR+sD139hFrnYuUvvinEOsCPhVIIxcv9h3LsxUIGTNab6Efcn+hnqp+Rq3iYg6FTcwh
	rWiyaE/YsPlquFTTrhZB2OE5SEjIndYZsJ8qooVvzf01qh0Lk7b24Ng8J1Q8Jh4mTdf2DK994Ha
	rle6kSUcmLWW+QgPJnHwuDQs0/7/eA+gq+60PAxZS5EzsY4p9WuGdFeZYVWnMnY1lcr598v+kJs
	e3FUQ1iVCgzdVqgst+TFsJRSnCx0+nymWw52oTIPMfnfx7Bo/RY0rCrRyrQ2ntAYAC8bDlsQ38y
	2Fc/7KHEzEdDvN4AxGSDA5fVkiUobUhpRHZBGR8Tz/12tLpsDKsSXHXMzqjsPWukY33kmvvPkaU
	PPvTsZfNaUDErr8Z7t+WAr1xouGYEXeXG6QzyVsai+XwJsZ4FwSjQ1J0Pz49fdDB5fw==
X-Received: by 2002:a05:690e:d4b:b0:668:8986:83a4 with SMTP id 956f58d0204a3-6692f83a99bmr1913831d50.98.1785429265559;
        Thu, 30 Jul 2026 09:34:25 -0700 (PDT)
X-Received: by 2002:a05:690e:d4b:b0:668:8986:83a4 with SMTP id 956f58d0204a3-6692f83a99bmr1913793d50.98.1785429265109;
        Thu, 30 Jul 2026 09:34:25 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c9315ddsm1608848d50.16.2026.07.30.09.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:34:24 -0700 (PDT)
Message-ID: <9d14fbef-43db-4463-b7d7-e5daee1368e6@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-5-973cd3a226af@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-5-973cd3a226af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 00_CVGcapYYu8KYjHkWVfVhbBo7jJOeo
X-Proofpoint-ORIG-GUID: 00_CVGcapYYu8KYjHkWVfVhbBo7jJOeo
X-Authority-Analysis: v=2.4 cv=Wqgb99fv c=1 sm=1 tr=0 ts=6a6b7d12 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=oKFihCAVH3oSEhwhxOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX5At62zRcYfLz
 KsdVZ2cBym4iKthlpD7zTAC6bUrci4YtZMmowvQ6IjaaFo9tSjucHREQJumgME5tJpSIBDO9P6v
 DCa5EoUdH9DQwLtC0Ef3V0XFBepkI/RaFWplvqUGc/hfO6ntoqn3i6kZe4ocyNaj85hubAXN6WE
 Zzfiy90W85tDc/GqxP5zCwbfBn6dpGA2prUfKQyPk1Xqf0/0mQ4BRat2RqGjvN9xLPYpQibNWZC
 umx2hKY2POkY1kdG4NG3DNCND4Gr/LEXBp6IeBeao/1SaBTqA9nAdPZe7z46Dhb7mR6nQSEhPAj
 w5zlagkMhIhpi2UdreDMw6ALQRFM6FDqRCNM4yjHy9uxWfQ14v8Cxf1dCzz6vAUlNz4iV5F0+Z+
 l6ZwJhdQzo52NjpUZ9fZ6K39nkaLMptVp3RRbJqmmpYP0X5PQ4iOx1kPq66bSgjHCfdO2CnlP71
 zYUA4ui4JjcwpUas+wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX7wpkMJLulK8r
 XY/NF/6C4w7zyaQkTduPj8UmG1qaAOP34EPM52VqKznU2VzG7VBNiCAyIfZm3v+5DJmMwGhLSI7
 o9YtGjmVe1KwGP3niNPkuCV/j0zjaR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300124

On 7/27/26 16:22, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
> when it reaches high temperatures in kodiak.
> 
> Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
> for modem when it reaches to 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Since the remoteproc_mpss node doesn't exist on non modem boards, the
> cooling-maps that reference it cause DT compilation errors. To fix that
> remove inherited mdmss cooling-map nodes.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
